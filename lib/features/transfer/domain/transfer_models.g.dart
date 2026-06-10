// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountRecordImpl _$$AccountRecordImplFromJson(Map<String, dynamic> json) =>
    _$AccountRecordImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      code: json['code'] as String? ?? '',
      currency: json['currency'] as String,
      kind: $enumDecode(_$AccountKindEnumMap, json['kind']),
      status: $enumDecode(_$AccountStatusEnumMap, json['status']),
      version: (json['version'] as num).toInt(),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$AccountRecordImplToJson(_$AccountRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'code': instance.code,
      'currency': instance.currency,
      'kind': _$AccountKindEnumMap[instance.kind]!,
      'status': _$AccountStatusEnumMap[instance.status]!,
      'version': instance.version,
      'createdAt': instance.createdAt,
    };

const _$AccountKindEnumMap = {
  AccountKind.USER: 'USER',
  AccountKind.SYSTEM: 'SYSTEM',
};

const _$AccountStatusEnumMap = {
  AccountStatus.ACTIVE: 'ACTIVE',
  AccountStatus.SUSPENDED: 'SUSPENDED',
  AccountStatus.CLOSED: 'CLOSED',
};

_$TransferRequestImpl _$$TransferRequestImplFromJson(
  Map<String, dynamic> json,
) => _$TransferRequestImpl(
  senderAccountId: json['senderAccountId'] as String?,
  recipientEmail: json['recipientEmail'] as String?,
  recipientPhone: json['recipientPhone'] as String?,
  amount: json['amount'] as String,
  idempotencyKey: json['idempotencyKey'] as String,
  pin: json['pin'] as String,
);

Map<String, dynamic> _$$TransferRequestImplToJson(
  _$TransferRequestImpl instance,
) => <String, dynamic>{
  'senderAccountId': instance.senderAccountId,
  'recipientEmail': instance.recipientEmail,
  'recipientPhone': instance.recipientPhone,
  'amount': instance.amount,
  'idempotencyKey': instance.idempotencyKey,
  'pin': instance.pin,
};
