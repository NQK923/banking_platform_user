// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../history/domain/wallet_transaction.dart';

part 'transfer_models.freezed.dart';
part 'transfer_models.g.dart';

enum AccountKind { USER, SYSTEM }

enum AccountStatus { ACTIVE, SUSPENDED, CLOSED }

@freezed
class AccountRecord with _$AccountRecord {
  const factory AccountRecord({
    required String id,
    required String userId,
    @Default('') String code,
    required String currency,
    required AccountKind kind,
    required AccountStatus status,
    required int version,
    required String createdAt,
  }) = _AccountRecord;

  factory AccountRecord.fromJson(Map<String, dynamic> json) =>
      _$AccountRecordFromJson(json);
}

@freezed
class TransferRequest with _$TransferRequest {
  const factory TransferRequest({
    String? senderAccountId,
    String? recipientEmail,
    String? recipientPhone,
    required String amount,
    required String idempotencyKey,
    required String pin,
    String? note,
    String? riskEvaluationId,
    bool? riskAcknowledged,
    String? stepUpPin,
  }) = _TransferRequest;

  factory TransferRequest.fromJson(Map<String, dynamic> json) =>
      _$TransferRequestFromJson(json);
}

@freezed
class RiskReasonView with _$RiskReasonView {
  const factory RiskReasonView({
    required String code,
    required int weight,
    required String message,
    @Default(<String, String>{}) Map<String, String> evidence,
  }) = _RiskReasonView;

  factory RiskReasonView.fromJson(Map<String, dynamic> json) =>
      _$RiskReasonViewFromJson(json);
}

@freezed
class TransferRiskResponse with _$TransferRiskResponse {
  const factory TransferRiskResponse({
    required String result,
    required String riskEvaluationId,
    required int riskScore,
    required String riskLevel,
    required String recommendedAction,
    @Default(<RiskReasonView>[]) List<RiskReasonView> reasons,
    required String modelVersion,
    required String policyVersion,
    required String evaluatedAt,
    required String traceId,
    String? transactionId,
    required String message,
  }) = _TransferRiskResponse;

  factory TransferRiskResponse.fromJson(Map<String, dynamic> json) =>
      _$TransferRiskResponseFromJson(json);
}

sealed class TransferSubmissionResult {
  const TransferSubmissionResult();
}

class TransferSubmitted extends TransferSubmissionResult {
  final WalletTransaction transaction;

  const TransferSubmitted(this.transaction);
}

class TransferRiskRequired extends TransferSubmissionResult {
  final TransferRiskResponse risk;

  const TransferRiskRequired(this.risk);
}
