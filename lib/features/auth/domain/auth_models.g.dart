// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
  Map<String, dynamic> json,
) => _$RegisterRequestImpl(
  email: json['email'] as String,
  phone: json['phone'] as String?,
  password: json['password'] as String,
  pin: json['pin'] as String,
  currency: json['currency'] as String?,
);

Map<String, dynamic> _$$RegisterRequestImplToJson(
  _$RegisterRequestImpl instance,
) => <String, dynamic>{
  'email': instance.email,
  'phone': instance.phone,
  'password': instance.password,
  'pin': instance.pin,
  'currency': instance.currency,
};

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      identifier: json['identifier'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'password': instance.password,
    };

_$RefreshRequestImpl _$$RefreshRequestImplFromJson(Map<String, dynamic> json) =>
    _$RefreshRequestImpl(refreshToken: json['refreshToken'] as String);

Map<String, dynamic> _$$RefreshRequestImplToJson(
  _$RefreshRequestImpl instance,
) => <String, dynamic>{'refreshToken': instance.refreshToken};

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      userId: json['userId'] as String,
      accountId: json['accountId'] as String?,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toSet(),
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'userId': instance.userId,
      'accountId': instance.accountId,
      'roles': instance.roles.toList(),
    };

_$PinVerifyRequestImpl _$$PinVerifyRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PinVerifyRequestImpl(pin: json['pin'] as String);

Map<String, dynamic> _$$PinVerifyRequestImplToJson(
  _$PinVerifyRequestImpl instance,
) => <String, dynamic>{'pin': instance.pin};
