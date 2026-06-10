// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_models.freezed.dart';
part 'transfer_models.g.dart';

enum AccountKind { USER, SYSTEM }

enum AccountStatus { ACTIVE, SUSPENDED, CLOSED }

@freezed
class AccountRecord with _$AccountRecord {
  const factory AccountRecord({
    required String id,
    required String userId,
    required String code,
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
  }) = _TransferRequest;

  factory TransferRequest.fromJson(Map<String, dynamic> json) =>
      _$TransferRequestFromJson(json);
}
