// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountRecordImpl _$$AccountRecordImplFromJson(Map<String, dynamic> json) =>
    _$AccountRecordImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
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
      'email': instance.email,
      'phone': instance.phone,
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
  note: json['note'] as String?,
  riskEvaluationId: json['riskEvaluationId'] as String?,
  riskAcknowledged: json['riskAcknowledged'] as bool?,
  stepUpPin: json['stepUpPin'] as String?,
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
  'note': instance.note,
  'riskEvaluationId': instance.riskEvaluationId,
  'riskAcknowledged': instance.riskAcknowledged,
  'stepUpPin': instance.stepUpPin,
};

_$RiskReasonViewImpl _$$RiskReasonViewImplFromJson(Map<String, dynamic> json) =>
    _$RiskReasonViewImpl(
      code: json['code'] as String,
      weight: (json['weight'] as num).toInt(),
      message: json['message'] as String,
      evidence:
          (json['evidence'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{},
    );

Map<String, dynamic> _$$RiskReasonViewImplToJson(
  _$RiskReasonViewImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'weight': instance.weight,
  'message': instance.message,
  'evidence': instance.evidence,
};

_$TransferRiskResponseImpl _$$TransferRiskResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TransferRiskResponseImpl(
  result: json['result'] as String,
  riskEvaluationId: json['riskEvaluationId'] as String,
  riskScore: (json['riskScore'] as num).toInt(),
  riskLevel: json['riskLevel'] as String,
  recommendedAction: json['recommendedAction'] as String,
  reasons:
      (json['reasons'] as List<dynamic>?)
          ?.map((e) => RiskReasonView.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <RiskReasonView>[],
  modelVersion: json['modelVersion'] as String,
  policyVersion: json['policyVersion'] as String,
  evaluatedAt: json['evaluatedAt'] as String,
  traceId: json['traceId'] as String,
  transactionId: json['transactionId'] as String?,
  message: json['message'] as String,
);

Map<String, dynamic> _$$TransferRiskResponseImplToJson(
  _$TransferRiskResponseImpl instance,
) => <String, dynamic>{
  'result': instance.result,
  'riskEvaluationId': instance.riskEvaluationId,
  'riskScore': instance.riskScore,
  'riskLevel': instance.riskLevel,
  'recommendedAction': instance.recommendedAction,
  'reasons': instance.reasons,
  'modelVersion': instance.modelVersion,
  'policyVersion': instance.policyVersion,
  'evaluatedAt': instance.evaluatedAt,
  'traceId': instance.traceId,
  'transactionId': instance.transactionId,
  'message': instance.message,
};
