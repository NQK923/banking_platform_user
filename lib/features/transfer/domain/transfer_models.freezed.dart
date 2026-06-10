// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AccountRecord _$AccountRecordFromJson(Map<String, dynamic> json) {
  return _AccountRecord.fromJson(json);
}

/// @nodoc
mixin _$AccountRecord {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  AccountKind get kind => throw _privateConstructorUsedError;
  AccountStatus get status => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AccountRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccountRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountRecordCopyWith<AccountRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountRecordCopyWith<$Res> {
  factory $AccountRecordCopyWith(
    AccountRecord value,
    $Res Function(AccountRecord) then,
  ) = _$AccountRecordCopyWithImpl<$Res, AccountRecord>;
  @useResult
  $Res call({
    String id,
    String userId,
    String code,
    String currency,
    AccountKind kind,
    AccountStatus status,
    int version,
    String createdAt,
  });
}

/// @nodoc
class _$AccountRecordCopyWithImpl<$Res, $Val extends AccountRecord>
    implements $AccountRecordCopyWith<$Res> {
  _$AccountRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? code = null,
    Object? currency = null,
    Object? kind = null,
    Object? status = null,
    Object? version = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            kind: null == kind
                ? _value.kind
                : kind // ignore: cast_nullable_to_non_nullable
                      as AccountKind,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as AccountStatus,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AccountRecordImplCopyWith<$Res>
    implements $AccountRecordCopyWith<$Res> {
  factory _$$AccountRecordImplCopyWith(
    _$AccountRecordImpl value,
    $Res Function(_$AccountRecordImpl) then,
  ) = __$$AccountRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String code,
    String currency,
    AccountKind kind,
    AccountStatus status,
    int version,
    String createdAt,
  });
}

/// @nodoc
class __$$AccountRecordImplCopyWithImpl<$Res>
    extends _$AccountRecordCopyWithImpl<$Res, _$AccountRecordImpl>
    implements _$$AccountRecordImplCopyWith<$Res> {
  __$$AccountRecordImplCopyWithImpl(
    _$AccountRecordImpl _value,
    $Res Function(_$AccountRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? code = null,
    Object? currency = null,
    Object? kind = null,
    Object? status = null,
    Object? version = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$AccountRecordImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        kind: null == kind
            ? _value.kind
            : kind // ignore: cast_nullable_to_non_nullable
                  as AccountKind,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AccountStatus,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountRecordImpl implements _AccountRecord {
  const _$AccountRecordImpl({
    required this.id,
    required this.userId,
    this.code = '',
    required this.currency,
    required this.kind,
    required this.status,
    required this.version,
    required this.createdAt,
  });

  factory _$AccountRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountRecordImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  @JsonKey()
  final String code;
  @override
  final String currency;
  @override
  final AccountKind kind;
  @override
  final AccountStatus status;
  @override
  final int version;
  @override
  final String createdAt;

  @override
  String toString() {
    return 'AccountRecord(id: $id, userId: $userId, code: $code, currency: $currency, kind: $kind, status: $status, version: $version, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    code,
    currency,
    kind,
    status,
    version,
    createdAt,
  );

  /// Create a copy of AccountRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountRecordImplCopyWith<_$AccountRecordImpl> get copyWith =>
      __$$AccountRecordImplCopyWithImpl<_$AccountRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountRecordImplToJson(this);
  }
}

abstract class _AccountRecord implements AccountRecord {
  const factory _AccountRecord({
    required final String id,
    required final String userId,
    final String code,
    required final String currency,
    required final AccountKind kind,
    required final AccountStatus status,
    required final int version,
    required final String createdAt,
  }) = _$AccountRecordImpl;

  factory _AccountRecord.fromJson(Map<String, dynamic> json) =
      _$AccountRecordImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get code;
  @override
  String get currency;
  @override
  AccountKind get kind;
  @override
  AccountStatus get status;
  @override
  int get version;
  @override
  String get createdAt;

  /// Create a copy of AccountRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountRecordImplCopyWith<_$AccountRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TransferRequest _$TransferRequestFromJson(Map<String, dynamic> json) {
  return _TransferRequest.fromJson(json);
}

/// @nodoc
mixin _$TransferRequest {
  String? get senderAccountId => throw _privateConstructorUsedError;
  String? get recipientEmail => throw _privateConstructorUsedError;
  String? get recipientPhone => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get idempotencyKey => throw _privateConstructorUsedError;
  String get pin => throw _privateConstructorUsedError;

  /// Serializes this TransferRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransferRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransferRequestCopyWith<TransferRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferRequestCopyWith<$Res> {
  factory $TransferRequestCopyWith(
    TransferRequest value,
    $Res Function(TransferRequest) then,
  ) = _$TransferRequestCopyWithImpl<$Res, TransferRequest>;
  @useResult
  $Res call({
    String? senderAccountId,
    String? recipientEmail,
    String? recipientPhone,
    String amount,
    String idempotencyKey,
    String pin,
  });
}

/// @nodoc
class _$TransferRequestCopyWithImpl<$Res, $Val extends TransferRequest>
    implements $TransferRequestCopyWith<$Res> {
  _$TransferRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccountId = freezed,
    Object? recipientEmail = freezed,
    Object? recipientPhone = freezed,
    Object? amount = null,
    Object? idempotencyKey = null,
    Object? pin = null,
  }) {
    return _then(
      _value.copyWith(
            senderAccountId: freezed == senderAccountId
                ? _value.senderAccountId
                : senderAccountId // ignore: cast_nullable_to_non_nullable
                      as String?,
            recipientEmail: freezed == recipientEmail
                ? _value.recipientEmail
                : recipientEmail // ignore: cast_nullable_to_non_nullable
                      as String?,
            recipientPhone: freezed == recipientPhone
                ? _value.recipientPhone
                : recipientPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as String,
            idempotencyKey: null == idempotencyKey
                ? _value.idempotencyKey
                : idempotencyKey // ignore: cast_nullable_to_non_nullable
                      as String,
            pin: null == pin
                ? _value.pin
                : pin // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransferRequestImplCopyWith<$Res>
    implements $TransferRequestCopyWith<$Res> {
  factory _$$TransferRequestImplCopyWith(
    _$TransferRequestImpl value,
    $Res Function(_$TransferRequestImpl) then,
  ) = __$$TransferRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? senderAccountId,
    String? recipientEmail,
    String? recipientPhone,
    String amount,
    String idempotencyKey,
    String pin,
  });
}

/// @nodoc
class __$$TransferRequestImplCopyWithImpl<$Res>
    extends _$TransferRequestCopyWithImpl<$Res, _$TransferRequestImpl>
    implements _$$TransferRequestImplCopyWith<$Res> {
  __$$TransferRequestImplCopyWithImpl(
    _$TransferRequestImpl _value,
    $Res Function(_$TransferRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderAccountId = freezed,
    Object? recipientEmail = freezed,
    Object? recipientPhone = freezed,
    Object? amount = null,
    Object? idempotencyKey = null,
    Object? pin = null,
  }) {
    return _then(
      _$TransferRequestImpl(
        senderAccountId: freezed == senderAccountId
            ? _value.senderAccountId
            : senderAccountId // ignore: cast_nullable_to_non_nullable
                  as String?,
        recipientEmail: freezed == recipientEmail
            ? _value.recipientEmail
            : recipientEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        recipientPhone: freezed == recipientPhone
            ? _value.recipientPhone
            : recipientPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String,
        idempotencyKey: null == idempotencyKey
            ? _value.idempotencyKey
            : idempotencyKey // ignore: cast_nullable_to_non_nullable
                  as String,
        pin: null == pin
            ? _value.pin
            : pin // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferRequestImpl implements _TransferRequest {
  const _$TransferRequestImpl({
    this.senderAccountId,
    this.recipientEmail,
    this.recipientPhone,
    required this.amount,
    required this.idempotencyKey,
    required this.pin,
  });

  factory _$TransferRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferRequestImplFromJson(json);

  @override
  final String? senderAccountId;
  @override
  final String? recipientEmail;
  @override
  final String? recipientPhone;
  @override
  final String amount;
  @override
  final String idempotencyKey;
  @override
  final String pin;

  @override
  String toString() {
    return 'TransferRequest(senderAccountId: $senderAccountId, recipientEmail: $recipientEmail, recipientPhone: $recipientPhone, amount: $amount, idempotencyKey: $idempotencyKey, pin: $pin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferRequestImpl &&
            (identical(other.senderAccountId, senderAccountId) ||
                other.senderAccountId == senderAccountId) &&
            (identical(other.recipientEmail, recipientEmail) ||
                other.recipientEmail == recipientEmail) &&
            (identical(other.recipientPhone, recipientPhone) ||
                other.recipientPhone == recipientPhone) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.idempotencyKey, idempotencyKey) ||
                other.idempotencyKey == idempotencyKey) &&
            (identical(other.pin, pin) || other.pin == pin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    senderAccountId,
    recipientEmail,
    recipientPhone,
    amount,
    idempotencyKey,
    pin,
  );

  /// Create a copy of TransferRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferRequestImplCopyWith<_$TransferRequestImpl> get copyWith =>
      __$$TransferRequestImplCopyWithImpl<_$TransferRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferRequestImplToJson(this);
  }
}

abstract class _TransferRequest implements TransferRequest {
  const factory _TransferRequest({
    final String? senderAccountId,
    final String? recipientEmail,
    final String? recipientPhone,
    required final String amount,
    required final String idempotencyKey,
    required final String pin,
  }) = _$TransferRequestImpl;

  factory _TransferRequest.fromJson(Map<String, dynamic> json) =
      _$TransferRequestImpl.fromJson;

  @override
  String? get senderAccountId;
  @override
  String? get recipientEmail;
  @override
  String? get recipientPhone;
  @override
  String get amount;
  @override
  String get idempotencyKey;
  @override
  String get pin;

  /// Create a copy of TransferRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferRequestImplCopyWith<_$TransferRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
