// ignore_for_file: constant_identifier_names

import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_transaction.freezed.dart';
part 'wallet_transaction.g.dart';

enum TransactionStatus { PENDING, COMPLETED, FAILED, COMPENSATING, CANCELLED }

class DecimalConverter implements JsonConverter<Decimal, dynamic> {
  const DecimalConverter();

  @override
  Decimal fromJson(dynamic json) {
    if (json == null) return Decimal.zero;
    return Decimal.parse(json.toString());
  }

  @override
  dynamic toJson(Decimal object) => object.toString();
}

@freezed
class WalletTransaction with _$WalletTransaction {
  const factory WalletTransaction({
    required String id,
    required String senderId,
    required String receiverId,
    @DecimalConverter() required Decimal amount,
    required String currency,
    required TransactionStatus status,
    required String idempotencyKey,
    String? correlationId,
    required String createdAt,
    required String updatedAt,
    required bool debitApplied,
    String? note,
    String? failureReason,
    bool? compensated,
  }) = _WalletTransaction;

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionFromJson(json);
}
