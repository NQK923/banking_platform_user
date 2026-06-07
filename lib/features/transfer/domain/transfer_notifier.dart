import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/error/app_exception.dart';
import '../../auth/data/auth_repository.dart';
import '../../wallet/domain/balance_provider.dart';
import '../../history/data/history_repository.dart';
import '../../history/domain/wallet_transaction.dart';
import '../data/transfer_repository.dart';
import 'transfer_models.dart';
import 'transfer_state.dart';

part 'transfer_notifier.g.dart';

@riverpod
class Transfer extends _$Transfer {
  late final TransferRepository _transferRepository;
  late final AuthRepository _authRepository;

  @override
  TransferState build() {
    _transferRepository = ref.watch(transferRepositoryProvider);
    _authRepository = ref.watch(authRepositoryProvider);
    return const TransferState.idle();
  }

  void reset() {
    state = const TransferState.idle();
  }

  Future<void> lookupRecipient(String identifier) async {
    if (identifier.trim().isEmpty) {
      state = const TransferState.idle(errorMessage: 'Vui lòng nhập Email hoặc Số điện thoại.');
      return;
    }

    state = const TransferState.recipientChecking();

    try {
      final isEmail = identifier.contains('@');
      final recipient = await _transferRepository.lookupRecipient(
        email: isEmail ? identifier.trim() : null,
        phone: !isEmail ? identifier.trim() : null,
      );

      final currentUserAccountId = await _authRepository.getAccountId();
      if (recipient.id == currentUserAccountId) {
        state = const TransferState.idle(
          errorMessage: 'Không thể chuyển tiền cho tài khoản ví của chính mình.',
        );
        return;
      }

      if (recipient.status != AccountStatus.ACTIVE) {
        state = const TransferState.idle(
          errorMessage: 'Tài khoản người nhận đang bị khóa hoặc không hoạt động.',
        );
        return;
      }

      state = TransferState.recipientChecked(recipient: recipient);
    } on AppException catch (e) {
      state = TransferState.idle(errorMessage: e.userFriendlyMessage);
    } catch (e) {
      state = TransferState.idle(errorMessage: 'Không tìm thấy người nhận.');
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

    final recipient = currentState.recipient;
    final amount = currentState.amount;
    final note = currentState.note;
    final idempotencyKey = currentState.idempotencyKey;

    state = const TransferState.submitting();

    try {
      final isEmail = recipient.code.contains('@');
      final backendPin = await _authRepository.getOriginalPin() ?? pin;
      final tx = await _transferRepository.initiateTransfer(
        TransferRequest(
          recipientEmail: isEmail ? recipient.code : null,
          recipientPhone: !isEmail ? recipient.code : null,
          amount: amount,
          idempotencyKey: idempotencyKey,
          pin: backendPin,
        ),
      );

      state = TransferState.processing(transaction: tx, pollCount: 0);
      _pollStatus(tx.id);
    } on AppException catch (e) {
      state = TransferState.failed(reason: e.userFriendlyMessage);
    } catch (e) {
      state = TransferState.failed(reason: e.toString());
    }
  }

  void retryPolling(WalletTransaction transaction) {
    state = TransferState.processing(transaction: transaction, pollCount: 0);
    _pollStatus(transaction.id);
  }

  Future<void> _pollStatus(String txId) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    final currentState = state;
    if (currentState is! TransferStateProcessing || currentState.transaction.id != txId) {
      return;
    }

    final count = currentState.pollCount + 1;

    try {
      final tx = await ref.read(historyRepositoryProvider).getTransactionDetail(txId);

      if (tx.status == TransactionStatus.COMPLETED) {
        state = TransferState.completed(transaction: tx);
        // Refresh balance and history on completion
        ref.read(balanceProvider.notifier).refreshBalance();
      } else if (tx.status == TransactionStatus.FAILED) {
        state = TransferState.failed(
          reason: 'Chuyển tiền thất bại. Giao dịch đã được hủy bỏ và bồi hoàn.',
          wasRefunded: tx.debitApplied,
          transaction: tx,
        );
        ref.read(balanceProvider.notifier).refreshBalance();
      } else if (tx.status == TransactionStatus.CANCELLED) {
        state = TransferState.failed(
          reason: 'Giao dịch chuyển tiền đã bị hủy.',
          wasRefunded: tx.debitApplied,
          transaction: tx,
        );
      } else {
        // Still PENDING or COMPENSATING
        if (count >= 10) {
          state = TransferState.timeout(transaction: tx);
        } else {
          state = currentState.copyWith(transaction: tx, pollCount: count);
          _pollStatus(txId); // Recurse
        }
      }
    } catch (e) {
      if (count >= 10) {
        state = TransferState.timeout(transaction: currentState.transaction);
      } else {
        state = currentState.copyWith(pollCount: count);
        _pollStatus(txId); // Recurse
      }
    }
  }
}
