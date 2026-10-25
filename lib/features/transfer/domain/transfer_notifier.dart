import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/error/app_exception.dart';
import '../../auth/data/auth_repository.dart';
import '../../wallet/domain/balance_provider.dart';
import '../../history/data/history_repository.dart';
import '../../history/domain/history_provider.dart';
import '../../history/domain/wallet_transaction.dart';
import '../data/transfer_repository.dart';
import 'transfer_models.dart';
import 'transfer_state.dart';

part 'transfer_notifier.g.dart';

@riverpod
class Transfer extends _$Transfer {
  late TransferRepository _transferRepository;
  late AuthRepository _authRepository;
  int _revision = 0;
  Timer? _pollTimer;
  bool _disposed = false;

  @override
  TransferState build() {
    _transferRepository = ref.watch(transferRepositoryProvider);
    _authRepository = ref.watch(authRepositoryProvider);
    _disposed = false;
    ref.onDispose(() {
      _disposed = true;
      _revision++;
      _pollTimer?.cancel();
    });
    return const TransferState.idle();
  }

  void reset() {
    _revision++;
    _pollTimer?.cancel();
    state = const TransferState.idle();
  }

  Future<void> lookupRecipient(String identifier) async {
    final revision = ++_revision;
    _pollTimer?.cancel();
    if (identifier.trim().isEmpty) {
      state = const TransferState.idle(
        errorMessage: 'Vui lòng nhập Email hoặc Số điện thoại.',
      );
      return;
    }

    state = const TransferState.recipientChecking();

    try {
      final isEmail = identifier.contains('@');
      final recipient = await _transferRepository.lookupRecipient(
        email: isEmail ? identifier.trim() : null,
        phone: !isEmail ? identifier.trim() : null,
      );

      if (!_isCurrent(revision)) return;

      final currentUserAccountId = await _authRepository.getAccountId();
      if (!_isCurrent(revision)) return;
      if (recipient.id == currentUserAccountId) {
        state = const TransferState.idle(
          errorMessage:
              'Không thể chuyển tiền cho tài khoản ví của chính mình.',
        );
        return;
      }

      if (recipient.status != AccountStatus.ACTIVE) {
        state = const TransferState.idle(
          errorMessage:
              'Tài khoản người nhận đang bị khóa hoặc không hoạt động.',
        );
        return;
      }

      state = TransferState.recipientChecked(recipient: recipient);
    } on AppException catch (e) {
      if (!_isCurrent(revision)) return;
      state = TransferState.idle(errorMessage: e.userFriendlyMessage);
    } catch (e) {
      if (!_isCurrent(revision)) return;
      state = const TransferState.idle(
        errorMessage: 'Không tìm thấy người nhận.',
      );
    }
  }

  void setAmountAndNote(String amount, String? note) {
    final currentState = state;
    if (currentState is! TransferStateRecipientChecked) return;

    final idempotencyKey = const Uuid().v4();
    state = TransferState.review(
      recipient: currentState.recipient,
      amount: amount,
      note: note,
      idempotencyKey: idempotencyKey,
    );
  }

  Future<void> submitTransfer(String pin) async {
    final currentState = state;
    if (currentState is! TransferStateReview) return;
    final revision = ++_revision;

    final recipient = currentState.recipient;
    final amount = currentState.amount;
    final note = currentState.note;
    final idempotencyKey = currentState.idempotencyKey;

    state = const TransferState.submitting();

    try {
      final tx = await _transferRepository.initiateTransfer(
        TransferRequest(
          recipientEmail: _recipientEmail(recipient),
          recipientPhone: _recipientPhone(recipient),
          amount: amount,
          idempotencyKey: idempotencyKey,
          pin: pin,
          note: note,
        ),
      );

      if (!_isCurrent(revision)) return;
      _handleSubmissionResult(tx, recipient, amount, note, idempotencyKey);
    } on AppException catch (e) {
      if (!_isCurrent(revision)) return;
      state = TransferState.failed(
        reason: e.userFriendlyMessage,
        recipient: recipient,
        amount: amount,
        note: note,
        idempotencyKey: idempotencyKey,
      );
    } catch (e) {
      if (!_isCurrent(revision)) return;
      state = TransferState.failed(
        reason: e.toString(),
        recipient: recipient,
        amount: amount,
        note: note,
        idempotencyKey: idempotencyKey,
      );
    }
  }

  Future<void> retryTransfer(String pin) async {
    final currentState = state;
    if (currentState is! TransferStateFailed) return;

    final recipient = currentState.recipient;
    final amount = currentState.amount;
    final note = currentState.note;
    final idempotencyKey = currentState.idempotencyKey;
    if (recipient == null || amount == null || idempotencyKey == null) return;
    final revision = ++_revision;

    state = const TransferState.submitting();

    try {
      final tx = await _transferRepository.initiateTransfer(
        TransferRequest(
          recipientEmail: _recipientEmail(recipient),
          recipientPhone: _recipientPhone(recipient),
          amount: amount,
          idempotencyKey: idempotencyKey,
          pin: pin,
          note: note,
        ),
      );

      if (!_isCurrent(revision)) return;
      _handleSubmissionResult(tx, recipient, amount, note, idempotencyKey);
    } on AppException catch (e) {
      if (!_isCurrent(revision)) return;
      state = TransferState.failed(
        reason: e.userFriendlyMessage,
        recipient: recipient,
        amount: amount,
        note: note,
        idempotencyKey: idempotencyKey,
      );
    } catch (e) {
      if (!_isCurrent(revision)) return;
      state = TransferState.failed(
        reason: e.toString(),
        recipient: recipient,
        amount: amount,
        note: note,
        idempotencyKey: idempotencyKey,
      );
    }
  }

  void retryPolling(WalletTransaction transaction) {
    _revision++;
    state = TransferState.processing(transaction: transaction, pollCount: 0);
    _schedulePoll(transaction.id);
  }

  Future<void> acknowledgeRiskWarning(String pin) async {
    final currentState = state;
    if (currentState is! TransferStateRiskWarningRequired) return;
    await _continueRiskTransfer(
      recipient: currentState.recipient,
      amount: currentState.amount,
      note: currentState.note,
      idempotencyKey: currentState.idempotencyKey,
      pin: pin,
      risk: currentState.risk,
      riskAcknowledged: true,
    );
  }

  Future<void> submitStepUp(String pin, String stepUpPin) async {
    final currentState = state;
    if (currentState is! TransferStateStepUpRequired) return;
    await _continueRiskTransfer(
      recipient: currentState.recipient,
      amount: currentState.amount,
      note: currentState.note,
      idempotencyKey: currentState.idempotencyKey,
      pin: pin,
      risk: currentState.risk,
      stepUpPin: stepUpPin,
    );
  }

  Future<void> _continueRiskTransfer({
    required AccountRecord recipient,
    required String amount,
    required String idempotencyKey,
    required String pin,
    required TransferRiskResponse risk,
    String? note,
    bool? riskAcknowledged,
    String? stepUpPin,
  }) async {
    final revision = ++_revision;
    state = const TransferState.submitting();
    try {
      final result = await _transferRepository.initiateTransfer(
        TransferRequest(
          recipientEmail: _recipientEmail(recipient),
          recipientPhone: _recipientPhone(recipient),
          amount: amount,
          idempotencyKey: idempotencyKey,
          pin: pin,
          note: note,
          riskEvaluationId: risk.riskEvaluationId,
          riskAcknowledged: riskAcknowledged,
          stepUpPin: stepUpPin,
        ),
      );
      if (!_isCurrent(revision)) return;
      _handleSubmissionResult(result, recipient, amount, note, idempotencyKey);
    } on AppException catch (e) {
      if (!_isCurrent(revision)) return;
      state = TransferState.failed(
        reason: e.userFriendlyMessage,
        recipient: recipient,
        amount: amount,
        note: note,
        idempotencyKey: idempotencyKey,
      );
    } catch (e) {
      if (!_isCurrent(revision)) return;
      state = TransferState.failed(
        reason: e.toString(),
        recipient: recipient,
        amount: amount,
        note: note,
        idempotencyKey: idempotencyKey,
      );
    }
  }

  void _handleSubmissionResult(
    TransferSubmissionResult result,
    AccountRecord recipient,
    String amount,
    String? note,
    String idempotencyKey,
  ) {
    switch (result) {
      case TransferSubmitted(:final transaction):
        state = TransferState.processing(
          transaction: transaction,
          pollCount: 0,
        );
        _schedulePoll(transaction.id);
      case TransferRiskRequired(:final risk):
        switch (risk.result) {
          case 'RISK_WARNING_REQUIRED':
            state = TransferState.riskWarningRequired(
              recipient: recipient,
              amount: amount,
              note: note,
              idempotencyKey: idempotencyKey,
              risk: risk,
            );
          case 'RISK_STEP_UP_REQUIRED':
            state = TransferState.stepUpRequired(
              recipient: recipient,
              amount: amount,
              note: note,
              idempotencyKey: idempotencyKey,
              risk: risk,
            );
          case 'RISK_MANUAL_REVIEW_REQUIRED':
            state = TransferState.manualReviewRequired(risk: risk);
          case 'RISK_BLOCKED':
            state = TransferState.riskBlocked(risk: risk);
          default:
            state = TransferState.failed(
              reason: risk.message,
              recipient: recipient,
              amount: amount,
              note: note,
              idempotencyKey: idempotencyKey,
            );
        }
    }
  }

  bool _isCurrent(int revision) => !_disposed && revision == _revision;

  void _schedulePoll(String txId) {
    final revision = _revision;
    _pollTimer?.cancel();
    _pollTimer = Timer(const Duration(milliseconds: 1500), () {
      _pollStatus(txId, revision);
    });
  }

  Future<void> _pollStatus(String txId, int revision) async {
    if (!_isCurrent(revision)) return;
    final currentState = state;
    if (currentState is! TransferStateProcessing ||
        currentState.transaction.id != txId) {
      return;
    }

    final count = currentState.pollCount + 1;

    try {
      final tx = await ref
          .read(historyRepositoryProvider)
          .getTransactionDetail(txId);
      if (!_isCurrent(revision)) return;

      if (tx.status == TransactionStatus.COMPLETED) {
        state = TransferState.completed(transaction: tx);
        // Refresh balance and history on completion
        ref.read(balanceProvider.notifier).refreshBalance();
        if (ref.exists(historyProvider)) ref.invalidate(historyProvider);
      } else if (tx.status == TransactionStatus.FAILED) {
        final failureReason = tx.failureReason ?? 'Chuyển tiền thất bại.';
        final wasRefunded = tx.compensated == true;
        state = TransferState.failed(
          reason: failureReason,
          wasRefunded: wasRefunded,
          transaction: tx,
        );
        ref.read(balanceProvider.notifier).refreshBalance();
        if (ref.exists(historyProvider)) ref.invalidate(historyProvider);
      } else if (tx.status == TransactionStatus.CANCELLED) {
        final failureReason =
            tx.failureReason ?? 'Giao dịch chuyển tiền đã bị hủy.';
        final wasRefunded = tx.compensated == true;
        state = TransferState.failed(
          reason: failureReason,
          wasRefunded: wasRefunded,
          transaction: tx,
        );
        ref.read(balanceProvider.notifier).refreshBalance();
        if (ref.exists(historyProvider)) ref.invalidate(historyProvider);
      } else {
        // Still PENDING or COMPENSATING
        if (count >= 10) {
          state = TransferState.timeout(transaction: tx);
        } else {
          state = currentState.copyWith(transaction: tx, pollCount: count);
          _schedulePoll(txId);
        }
      }
    } catch (e) {
      if (!_isCurrent(revision)) return;
      if (count >= 10) {
        state = TransferState.timeout(transaction: currentState.transaction);
      } else {
        state = currentState.copyWith(pollCount: count);
        _schedulePoll(txId);
      }
    }
  }

  String? _recipientEmail(AccountRecord recipient) {
    final email = recipient.email?.trim();
    if (email != null && email.isNotEmpty) {
      return email;
    }
    final code = recipient.code.trim();
    return code.contains('@') ? code : null;
  }

  String? _recipientPhone(AccountRecord recipient) {
    final phone = recipient.phone?.trim();
    if (phone != null && phone.isNotEmpty) {
      return phone;
    }
    final code = recipient.code.trim();
    return code.isNotEmpty && !code.contains('@') ? code : null;
  }
}
