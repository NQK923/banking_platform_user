// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletTransactionImpl _$$WalletTransactionImplFromJson(
  Map<String, dynamic> json,
) => _$WalletTransactionImpl(
  id: json['id'] as String,
  senderId: json['senderId'] as String,
  receiverId: json['receiverId'] as String,
  amount: const DecimalConverter().fromJson(json['amount']),
  currency: json['currency'] as String,
  status: $enumDecode(_$TransactionStatusEnumMap, json['status']),
  idempotencyKey: json['idempotencyKey'] as String,
  correlationId: json['correlationId'] as String?,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  debitApplied: json['debitApplied'] as bool,
  note: json['note'] as String?,
  failureReason: json['failureReason'] as String?,
);

Map<String, dynamic> _$$WalletTransactionImplToJson(
  _$WalletTransactionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'senderId': instance.senderId,
  'receiverId': instance.receiverId,
  'amount': const DecimalConverter().toJson(instance.amount),
  'currency': instance.currency,
  'status': _$TransactionStatusEnumMap[instance.status]!,
  'idempotencyKey': instance.idempotencyKey,
  'correlationId': instance.correlationId,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'debitApplied': instance.debitApplied,
  'note': instance.note,
  'failureReason': instance.failureReason,
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.PENDING: 'PENDING',
  TransactionStatus.COMPLETED: 'COMPLETED',
  TransactionStatus.FAILED: 'FAILED',
  TransactionStatus.COMPENSATING: 'COMPENSATING',
  TransactionStatus.CANCELLED: 'CANCELLED',
};
