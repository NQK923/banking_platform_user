import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../domain/support_models.dart';

final supportRepositoryProvider = Provider<SupportRepository>((ref) {
  return SupportRepository(ref.watch(apiClientProvider));
});

class SupportRepository {
  final ApiClient _apiClient;

  SupportRepository(this._apiClient);

  Future<CreateSupportSessionResult> createSession({
    required String initialMessage,
    SupportContext? context,
  }) async {
    final response = await _apiClient.post(
      '/api/support/chat/sessions',
      data: {
        'initialMessage': initialMessage,
        if (context != null) 'context': context.toJson(),
      },
    );
    return CreateSupportSessionResult.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<SendSupportMessageResult> sendMessage({
    required String sessionId,
    required String message,
    SupportContext? context,
  }) async {
    final response = await _apiClient.post(
      '/api/support/chat/sessions/$sessionId/messages',
      data: {
        'message': message,
        if (context != null) 'context': context.toJson(),
      },
    );
    return SendSupportMessageResult.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<SupportSessionDetail> getSession(String sessionId) async {
    final response = await _apiClient.get(
      '/api/support/chat/sessions/$sessionId',
    );
    return SupportSessionDetail.fromJson(response.data as Map<String, dynamic>);
  }

  Future<SupportHandoffResult> requestHandoff({
    required String sessionId,
    String reason = 'USER_REQUESTED_HUMAN',
  }) async {
    final response = await _apiClient.post(
      '/api/support/chat/sessions/$sessionId/handoff',
      data: {'reason': reason},
    );
    return SupportHandoffResult.fromJson(response.data as Map<String, dynamic>);
  }
}
