import 'package:freezed_annotation/freezed_annotation.dart';
import 'transfer_models.dart';
import '../../history/domain/wallet_transaction.dart';

part 'transfer_state.freezed.dart';

@freezed
class TransferState with _$TransferState {
  const factory TransferState.idle({String? errorMessage}) = _TransferStateIdle;

  const factory TransferState.recipientChecking() =
      TransferStateRecipientChecking;

  const factory TransferState.recipientChecked({
    required AccountRecord recipient,
  }) = TransferStateRecipientChecked;

  const factory TransferState.review({
    required AccountRecord recipient,
    required String amount,
    String? note,
    required String idempotencyKey,
  }) = TransferStateReview;

  const factory TransferState.submitting() = TransferStateSubmitting;

  const factory TransferState.riskWarningRequired({
    required AccountRecord recipient,
    required String amount,
    String? note,
    required String idempotencyKey,
    required TransferRiskResponse risk,
  }) = TransferStateRiskWarningRequired;

  const factory TransferState.stepUpRequired({
    required AccountRecord recipient,
    required String amount,
    String? note,
    required String idempotencyKey,
    required TransferRiskResponse risk,
  }) = TransferStateStepUpRequired;

  const factory TransferState.manualReviewRequired({
    required TransferRiskResponse risk,
  }) = TransferStateManualReviewRequired;

  const factory TransferState.riskBlocked({
    required TransferRiskResponse risk,
  }) = TransferStateRiskBlocked;

  const factory TransferState.processing({
    required WalletTransaction transaction,
    @Default(0) int pollCount,
  }) = TransferStateProcessing;

  const factory TransferState.completed({
    required WalletTransaction transaction,
  }) = TransferStateCompleted;

  const factory TransferState.failed({
    required String reason,
    @Default(false) bool wasRefunded,
    WalletTransaction? transaction,
    AccountRecord? recipient,
    String? amount,
    String? note,
    String? idempotencyKey,
  }) = TransferStateFailed;

  const factory TransferState.timeout({
    required WalletTransaction transaction,
  }) = TransferStateTimeout;
}
