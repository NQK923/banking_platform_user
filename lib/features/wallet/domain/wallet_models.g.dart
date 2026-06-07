// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BalanceResponseImpl _$$BalanceResponseImplFromJson(
  Map<String, dynamic> json,
) => _$BalanceResponseImpl(
  accountId: json['accountId'] as String,
  balance: const DecimalConverter().fromJson(json['balance']),
  currency: json['currency'] as String,
);

Map<String, dynamic> _$$BalanceResponseImplToJson(
  _$BalanceResponseImpl instance,
) => <String, dynamic>{
  'accountId': instance.accountId,
  'balance': const DecimalConverter().toJson(instance.balance),
  'currency': instance.currency,
};

_$MovementResponseImpl _$$MovementResponseImplFromJson(
  Map<String, dynamic> json,
) => _$MovementResponseImpl(
  journalId: json['journalId'] as String,
  balance: BalanceResponse.fromJson(json['balance'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$MovementResponseImplToJson(
  _$MovementResponseImpl instance,
) => <String, dynamic>{
  'journalId': instance.journalId,
  'balance': instance.balance,
};
