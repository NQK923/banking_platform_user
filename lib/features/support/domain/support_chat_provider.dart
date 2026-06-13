import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/support_repository.dart';
import 'support_models.dart';

class SupportChatArgs {
  final String? sessionId;
  final String? transactionId;

  const SupportChatArgs({this.sessionId, this.transactionId});

  @override
  bool operator ==(Object other) {
    return other is SupportChatArgs &&
        other.sessionId == sessionId &&
        other.transactionId == transactionId;
  }

  @override
  int get hashCode => Object.hash(sessionId, transactionId);
}

class SupportChatState {
  final String? sessionId;
  final String? transactionId;
  final String status;
  final String topic;
  final List<SupportChatMessage> messages;
  final List<SupportSuggestedAction> suggestedActions;
  final bool isLoading;
  final bool isSending;
  final bool isHandingOff;
  final String? errorMessage;
  final String? handoffMessage;

  const SupportChatState({
    this.sessionId,
    this.transactionId,
    this.status = 'OPEN',
    this.topic = 'GENERAL_FAQ',
    this.messages = const [],
    this.suggestedActions = const [],
    this.isLoading = false,
    this.isSending = false,
    this.isHandingOff = false,
    this.errorMessage,
    this.handoffMessage,
  });

  bool get hasSession => sessionId != null && sessionId!.isNotEmpty;

  SupportChatState copyWith({
    String? sessionId,
    String? transactionId,
    String? status,
    String? topic,
    List<SupportChatMessage>? messages,
    List<SupportSuggestedAction>? suggestedActions,
    bool? isLoading,
    bool? isSending,
    bool? isHandingOff,
    String? errorMessage,
    bool clearError = false,
    String? handoffMessage,
  }) {
    return SupportChatState(
      sessionId: sessionId ?? this.sessionId,
      transactionId: transactionId ?? this.transactionId,
      status: status ?? this.status,
      topic: topic ?? this.topic,
      messages: messages ?? this.messages,
      suggestedActions: suggestedActions ?? this.suggestedActions,
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      isHandingOff: isHandingOff ?? this.isHandingOff,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      handoffMessage: handoffMessage ?? this.handoffMessage,
    );
  }
}

final supportChatProvider =
    StateNotifierProvider.family<
      SupportChatNotifier,
      SupportChatState,
      SupportChatArgs
    >((ref, args) {
      return SupportChatNotifier(ref.watch(supportRepositoryProvider), args);
    });

class SupportChatNotifier extends StateNotifier<SupportChatState> {
  final SupportRepository _repository;

  SupportChatNotifier(this._repository, SupportChatArgs args)
    : super(
        SupportChatState(
          sessionId: args.sessionId,
          transactionId: args.transactionId,
          isLoading: args.sessionId != null,
        ),
      ) {
    if (args.sessionId != null) {
      loadSession();
    }
  }

  Future<void> loadSession() async {
    final sessionId = state.sessionId;
    if (sessionId == null || sessionId.isEmpty) return;
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final detail = await _repository.getSession(sessionId);
      state = state.copyWith(
        sessionId: detail.sessionId,
        transactionId: detail.relatedTransactionId,
        status: detail.status,
        topic: detail.topic,
        messages: detail.messages,
        isLoading: false,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: _cleanError(e));
    }
  }

  Future<void> send(String message) async {
    final text = message.trim();
    if (text.isEmpty || state.isSending) return;

    final pendingSessionId = state.sessionId ?? 'pending';
    final userMessage = SupportChatMessage.local(
      sessionId: pendingSessionId,
      senderType: SupportSenderType.USER,
      message: text,
    );
    state = state.copyWith(
      isSending: true,
      messages: [...state.messages, userMessage],
      suggestedActions: const [],
      clearError: true,
    );

    try {
      final context = state.transactionId == null
          ? null
          : SupportContext(transactionId: state.transactionId);
      if (!state.hasSession) {
        final created = await _repository.createSession(
          initialMessage: text,
          context: context,
        );
        state = state.copyWith(
          sessionId: created.sessionId,
          status: created.status,
          messages: [
            userMessage,
            SupportChatMessage.local(
              sessionId: created.sessionId,
              senderType: SupportSenderType.AI,
              message: created.answer,
            ),
          ],
          suggestedActions: created.suggestedActions,
          isSending: false,
          clearError: true,
        );
        return;
      }

      final response = await _repository.sendMessage(
        sessionId: state.sessionId!,
        message: text,
        context: context,
      );
      state = state.copyWith(
        messages: [
          ...state.messages,
          SupportChatMessage.local(
            sessionId: state.sessionId!,
            senderType: SupportSenderType.AI,
            message: response.answer,
          ),
        ],
        suggestedActions: response.suggestedActions,
        isSending: false,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(isSending: false, errorMessage: _cleanError(e));
    }
  }

  Future<void> requestHandoff() async {
    if (!state.hasSession || state.isHandingOff) return;
    state = state.copyWith(isHandingOff: true, clearError: true);
    try {
      final response = await _repository.requestHandoff(
        sessionId: state.sessionId!,
      );
      state = state.copyWith(
        status: response.status,
        isHandingOff: false,
        handoffMessage: response.message,
        suggestedActions: const [],
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(isHandingOff: false, errorMessage: _cleanError(e));
    }
  }

  String _cleanError(Object e) {
    return e
        .toString()
        .replaceAll('Exception: ', '')
        .replaceAll('AppException: ', '');
  }
}
