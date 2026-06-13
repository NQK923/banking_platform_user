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
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
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
    String? email,
    String? phone,
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
    Object? email = freezed,
    Object? phone = freezed,
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
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
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
    String? email,
    String? phone,
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
    Object? email = freezed,
    Object? phone = freezed,
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
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
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
    this.email,
    this.phone,
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
  final String? email;
  @override
  final String? phone;
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
    return 'AccountRecord(id: $id, userId: $userId, email: $email, phone: $phone, code: $code, currency: $currency, kind: $kind, status: $status, version: $version, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
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
    email,
    phone,
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
    final String? email,
    final String? phone,
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
  String? get email;
  @override
  String? get phone;
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
  String? get note => throw _privateConstructorUsedError;
  String? get riskEvaluationId => throw _privateConstructorUsedError;
  bool? get riskAcknowledged => throw _privateConstructorUsedError;
  String? get stepUpPin => throw _privateConstructorUsedError;

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
    String? note,
    String? riskEvaluationId,
    bool? riskAcknowledged,
    String? stepUpPin,
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
    Object? note = freezed,
    Object? riskEvaluationId = freezed,
    Object? riskAcknowledged = freezed,
    Object? stepUpPin = freezed,
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
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            riskEvaluationId: freezed == riskEvaluationId
                ? _value.riskEvaluationId
                : riskEvaluationId // ignore: cast_nullable_to_non_nullable
                      as String?,
            riskAcknowledged: freezed == riskAcknowledged
                ? _value.riskAcknowledged
                : riskAcknowledged // ignore: cast_nullable_to_non_nullable
                      as bool?,
            stepUpPin: freezed == stepUpPin
                ? _value.stepUpPin
                : stepUpPin // ignore: cast_nullable_to_non_nullable
                      as String?,
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
    String? note,
    String? riskEvaluationId,
    bool? riskAcknowledged,
    String? stepUpPin,
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
    Object? note = freezed,
    Object? riskEvaluationId = freezed,
    Object? riskAcknowledged = freezed,
    Object? stepUpPin = freezed,
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
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        riskEvaluationId: freezed == riskEvaluationId
            ? _value.riskEvaluationId
            : riskEvaluationId // ignore: cast_nullable_to_non_nullable
                  as String?,
        riskAcknowledged: freezed == riskAcknowledged
            ? _value.riskAcknowledged
            : riskAcknowledged // ignore: cast_nullable_to_non_nullable
                  as bool?,
        stepUpPin: freezed == stepUpPin
            ? _value.stepUpPin
            : stepUpPin // ignore: cast_nullable_to_non_nullable
                  as String?,
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
    this.note,
    this.riskEvaluationId,
    this.riskAcknowledged,
    this.stepUpPin,
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
  final String? note;
  @override
  final String? riskEvaluationId;
  @override
  final bool? riskAcknowledged;
  @override
  final String? stepUpPin;

  @override
  String toString() {
    return 'TransferRequest(senderAccountId: $senderAccountId, recipientEmail: $recipientEmail, recipientPhone: $recipientPhone, amount: $amount, idempotencyKey: $idempotencyKey, pin: $pin, note: $note, riskEvaluationId: $riskEvaluationId, riskAcknowledged: $riskAcknowledged, stepUpPin: $stepUpPin)';
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
            (identical(other.pin, pin) || other.pin == pin) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.riskEvaluationId, riskEvaluationId) ||
                other.riskEvaluationId == riskEvaluationId) &&
            (identical(other.riskAcknowledged, riskAcknowledged) ||
                other.riskAcknowledged == riskAcknowledged) &&
            (identical(other.stepUpPin, stepUpPin) ||
                other.stepUpPin == stepUpPin));
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
    note,
    riskEvaluationId,
    riskAcknowledged,
    stepUpPin,
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
    final String? note,
    final String? riskEvaluationId,
    final bool? riskAcknowledged,
    final String? stepUpPin,
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
  @override
  String? get note;
  @override
  String? get riskEvaluationId;
  @override
  bool? get riskAcknowledged;
  @override
  String? get stepUpPin;

  /// Create a copy of TransferRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferRequestImplCopyWith<_$TransferRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RiskReasonView _$RiskReasonViewFromJson(Map<String, dynamic> json) {
  return _RiskReasonView.fromJson(json);
}

/// @nodoc
mixin _$RiskReasonView {
  String get code => throw _privateConstructorUsedError;
  int get weight => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Map<String, String> get evidence => throw _privateConstructorUsedError;

  /// Serializes this RiskReasonView to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RiskReasonView
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RiskReasonViewCopyWith<RiskReasonView> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskReasonViewCopyWith<$Res> {
  factory $RiskReasonViewCopyWith(
    RiskReasonView value,
    $Res Function(RiskReasonView) then,
  ) = _$RiskReasonViewCopyWithImpl<$Res, RiskReasonView>;
  @useResult
  $Res call({
    String code,
    int weight,
    String message,
    Map<String, String> evidence,
  });
}

/// @nodoc
class _$RiskReasonViewCopyWithImpl<$Res, $Val extends RiskReasonView>
    implements $RiskReasonViewCopyWith<$Res> {
  _$RiskReasonViewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RiskReasonView
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? weight = null,
    Object? message = null,
    Object? evidence = null,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            weight: null == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            evidence: null == evidence
                ? _value.evidence
                : evidence // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RiskReasonViewImplCopyWith<$Res>
    implements $RiskReasonViewCopyWith<$Res> {
  factory _$$RiskReasonViewImplCopyWith(
    _$RiskReasonViewImpl value,
    $Res Function(_$RiskReasonViewImpl) then,
  ) = __$$RiskReasonViewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String code,
    int weight,
    String message,
    Map<String, String> evidence,
  });
}

/// @nodoc
class __$$RiskReasonViewImplCopyWithImpl<$Res>
    extends _$RiskReasonViewCopyWithImpl<$Res, _$RiskReasonViewImpl>
    implements _$$RiskReasonViewImplCopyWith<$Res> {
  __$$RiskReasonViewImplCopyWithImpl(
    _$RiskReasonViewImpl _value,
    $Res Function(_$RiskReasonViewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RiskReasonView
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? weight = null,
    Object? message = null,
    Object? evidence = null,
  }) {
    return _then(
      _$RiskReasonViewImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        weight: null == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        evidence: null == evidence
            ? _value._evidence
            : evidence // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RiskReasonViewImpl implements _RiskReasonView {
  const _$RiskReasonViewImpl({
    required this.code,
    required this.weight,
    required this.message,
    final Map<String, String> evidence = const <String, String>{},
  }) : _evidence = evidence;

  factory _$RiskReasonViewImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskReasonViewImplFromJson(json);

  @override
  final String code;
  @override
  final int weight;
  @override
  final String message;
  final Map<String, String> _evidence;
  @override
  @JsonKey()
  Map<String, String> get evidence {
    if (_evidence is EqualUnmodifiableMapView) return _evidence;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_evidence);
  }

  @override
  String toString() {
    return 'RiskReasonView(code: $code, weight: $weight, message: $message, evidence: $evidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskReasonViewImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._evidence, _evidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    weight,
    message,
    const DeepCollectionEquality().hash(_evidence),
  );

  /// Create a copy of RiskReasonView
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskReasonViewImplCopyWith<_$RiskReasonViewImpl> get copyWith =>
      __$$RiskReasonViewImplCopyWithImpl<_$RiskReasonViewImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskReasonViewImplToJson(this);
  }
}

abstract class _RiskReasonView implements RiskReasonView {
  const factory _RiskReasonView({
    required final String code,
    required final int weight,
    required final String message,
    final Map<String, String> evidence,
  }) = _$RiskReasonViewImpl;

  factory _RiskReasonView.fromJson(Map<String, dynamic> json) =
      _$RiskReasonViewImpl.fromJson;

  @override
  String get code;
  @override
  int get weight;
  @override
  String get message;
  @override
  Map<String, String> get evidence;

  /// Create a copy of RiskReasonView
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RiskReasonViewImplCopyWith<_$RiskReasonViewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TransferRiskResponse _$TransferRiskResponseFromJson(Map<String, dynamic> json) {
  return _TransferRiskResponse.fromJson(json);
}

/// @nodoc
mixin _$TransferRiskResponse {
  String get result => throw _privateConstructorUsedError;
  String get riskEvaluationId => throw _privateConstructorUsedError;
  int get riskScore => throw _privateConstructorUsedError;
  String get riskLevel => throw _privateConstructorUsedError;
  String get recommendedAction => throw _privateConstructorUsedError;
  List<RiskReasonView> get reasons => throw _privateConstructorUsedError;
  String get modelVersion => throw _privateConstructorUsedError;
  String get policyVersion => throw _privateConstructorUsedError;
  String get evaluatedAt => throw _privateConstructorUsedError;
  String get traceId => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this TransferRiskResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransferRiskResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransferRiskResponseCopyWith<TransferRiskResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferRiskResponseCopyWith<$Res> {
  factory $TransferRiskResponseCopyWith(
    TransferRiskResponse value,
    $Res Function(TransferRiskResponse) then,
  ) = _$TransferRiskResponseCopyWithImpl<$Res, TransferRiskResponse>;
  @useResult
  $Res call({
    String result,
    String riskEvaluationId,
    int riskScore,
    String riskLevel,
    String recommendedAction,
    List<RiskReasonView> reasons,
    String modelVersion,
    String policyVersion,
    String evaluatedAt,
    String traceId,
    String? transactionId,
    String message,
  });
}

/// @nodoc
class _$TransferRiskResponseCopyWithImpl<
  $Res,
  $Val extends TransferRiskResponse
>
    implements $TransferRiskResponseCopyWith<$Res> {
  _$TransferRiskResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferRiskResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? riskEvaluationId = null,
    Object? riskScore = null,
    Object? riskLevel = null,
    Object? recommendedAction = null,
    Object? reasons = null,
    Object? modelVersion = null,
    Object? policyVersion = null,
    Object? evaluatedAt = null,
    Object? traceId = null,
    Object? transactionId = freezed,
    Object? message = null,
  }) {
    return _then(
      _value.copyWith(
            result: null == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as String,
            riskEvaluationId: null == riskEvaluationId
                ? _value.riskEvaluationId
                : riskEvaluationId // ignore: cast_nullable_to_non_nullable
                      as String,
            riskScore: null == riskScore
                ? _value.riskScore
                : riskScore // ignore: cast_nullable_to_non_nullable
                      as int,
            riskLevel: null == riskLevel
                ? _value.riskLevel
                : riskLevel // ignore: cast_nullable_to_non_nullable
                      as String,
            recommendedAction: null == recommendedAction
                ? _value.recommendedAction
                : recommendedAction // ignore: cast_nullable_to_non_nullable
                      as String,
            reasons: null == reasons
                ? _value.reasons
                : reasons // ignore: cast_nullable_to_non_nullable
                      as List<RiskReasonView>,
            modelVersion: null == modelVersion
                ? _value.modelVersion
                : modelVersion // ignore: cast_nullable_to_non_nullable
                      as String,
            policyVersion: null == policyVersion
                ? _value.policyVersion
                : policyVersion // ignore: cast_nullable_to_non_nullable
                      as String,
            evaluatedAt: null == evaluatedAt
                ? _value.evaluatedAt
                : evaluatedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            traceId: null == traceId
                ? _value.traceId
                : traceId // ignore: cast_nullable_to_non_nullable
                      as String,
            transactionId: freezed == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransferRiskResponseImplCopyWith<$Res>
    implements $TransferRiskResponseCopyWith<$Res> {
  factory _$$TransferRiskResponseImplCopyWith(
    _$TransferRiskResponseImpl value,
    $Res Function(_$TransferRiskResponseImpl) then,
  ) = __$$TransferRiskResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String result,
    String riskEvaluationId,
    int riskScore,
    String riskLevel,
    String recommendedAction,
    List<RiskReasonView> reasons,
    String modelVersion,
    String policyVersion,
    String evaluatedAt,
    String traceId,
    String? transactionId,
    String message,
  });
}

/// @nodoc
class __$$TransferRiskResponseImplCopyWithImpl<$Res>
    extends _$TransferRiskResponseCopyWithImpl<$Res, _$TransferRiskResponseImpl>
    implements _$$TransferRiskResponseImplCopyWith<$Res> {
  __$$TransferRiskResponseImplCopyWithImpl(
    _$TransferRiskResponseImpl _value,
    $Res Function(_$TransferRiskResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferRiskResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? riskEvaluationId = null,
    Object? riskScore = null,
    Object? riskLevel = null,
    Object? recommendedAction = null,
    Object? reasons = null,
    Object? modelVersion = null,
    Object? policyVersion = null,
    Object? evaluatedAt = null,
    Object? traceId = null,
    Object? transactionId = freezed,
    Object? message = null,
  }) {
    return _then(
      _$TransferRiskResponseImpl(
        result: null == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as String,
        riskEvaluationId: null == riskEvaluationId
            ? _value.riskEvaluationId
            : riskEvaluationId // ignore: cast_nullable_to_non_nullable
                  as String,
        riskScore: null == riskScore
            ? _value.riskScore
            : riskScore // ignore: cast_nullable_to_non_nullable
                  as int,
        riskLevel: null == riskLevel
            ? _value.riskLevel
            : riskLevel // ignore: cast_nullable_to_non_nullable
                  as String,
        recommendedAction: null == recommendedAction
            ? _value.recommendedAction
            : recommendedAction // ignore: cast_nullable_to_non_nullable
                  as String,
        reasons: null == reasons
            ? _value._reasons
            : reasons // ignore: cast_nullable_to_non_nullable
                  as List<RiskReasonView>,
        modelVersion: null == modelVersion
            ? _value.modelVersion
            : modelVersion // ignore: cast_nullable_to_non_nullable
                  as String,
        policyVersion: null == policyVersion
            ? _value.policyVersion
            : policyVersion // ignore: cast_nullable_to_non_nullable
                  as String,
        evaluatedAt: null == evaluatedAt
            ? _value.evaluatedAt
            : evaluatedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        traceId: null == traceId
            ? _value.traceId
            : traceId // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: freezed == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferRiskResponseImpl implements _TransferRiskResponse {
  const _$TransferRiskResponseImpl({
    required this.result,
    required this.riskEvaluationId,
    required this.riskScore,
    required this.riskLevel,
    required this.recommendedAction,
    final List<RiskReasonView> reasons = const <RiskReasonView>[],
    required this.modelVersion,
    required this.policyVersion,
    required this.evaluatedAt,
    required this.traceId,
    this.transactionId,
    required this.message,
  }) : _reasons = reasons;

  factory _$TransferRiskResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferRiskResponseImplFromJson(json);

  @override
  final String result;
  @override
  final String riskEvaluationId;
  @override
  final int riskScore;
  @override
  final String riskLevel;
  @override
  final String recommendedAction;
  final List<RiskReasonView> _reasons;
  @override
  @JsonKey()
  List<RiskReasonView> get reasons {
    if (_reasons is EqualUnmodifiableListView) return _reasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reasons);
  }

  @override
  final String modelVersion;
  @override
  final String policyVersion;
  @override
  final String evaluatedAt;
  @override
  final String traceId;
  @override
  final String? transactionId;
  @override
  final String message;

  @override
  String toString() {
    return 'TransferRiskResponse(result: $result, riskEvaluationId: $riskEvaluationId, riskScore: $riskScore, riskLevel: $riskLevel, recommendedAction: $recommendedAction, reasons: $reasons, modelVersion: $modelVersion, policyVersion: $policyVersion, evaluatedAt: $evaluatedAt, traceId: $traceId, transactionId: $transactionId, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferRiskResponseImpl &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.riskEvaluationId, riskEvaluationId) ||
                other.riskEvaluationId == riskEvaluationId) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.recommendedAction, recommendedAction) ||
                other.recommendedAction == recommendedAction) &&
            const DeepCollectionEquality().equals(other._reasons, _reasons) &&
            (identical(other.modelVersion, modelVersion) ||
                other.modelVersion == modelVersion) &&
            (identical(other.policyVersion, policyVersion) ||
                other.policyVersion == policyVersion) &&
            (identical(other.evaluatedAt, evaluatedAt) ||
                other.evaluatedAt == evaluatedAt) &&
            (identical(other.traceId, traceId) || other.traceId == traceId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    result,
    riskEvaluationId,
    riskScore,
    riskLevel,
    recommendedAction,
    const DeepCollectionEquality().hash(_reasons),
    modelVersion,
    policyVersion,
    evaluatedAt,
    traceId,
    transactionId,
    message,
  );

  /// Create a copy of TransferRiskResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferRiskResponseImplCopyWith<_$TransferRiskResponseImpl>
  get copyWith =>
      __$$TransferRiskResponseImplCopyWithImpl<_$TransferRiskResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferRiskResponseImplToJson(this);
  }
}

abstract class _TransferRiskResponse implements TransferRiskResponse {
  const factory _TransferRiskResponse({
    required final String result,
    required final String riskEvaluationId,
    required final int riskScore,
    required final String riskLevel,
    required final String recommendedAction,
    final List<RiskReasonView> reasons,
    required final String modelVersion,
    required final String policyVersion,
    required final String evaluatedAt,
    required final String traceId,
    final String? transactionId,
    required final String message,
  }) = _$TransferRiskResponseImpl;

  factory _TransferRiskResponse.fromJson(Map<String, dynamic> json) =
      _$TransferRiskResponseImpl.fromJson;

  @override
  String get result;
  @override
  String get riskEvaluationId;
  @override
  int get riskScore;
  @override
  String get riskLevel;
  @override
  String get recommendedAction;
  @override
  List<RiskReasonView> get reasons;
  @override
  String get modelVersion;
  @override
  String get policyVersion;
  @override
  String get evaluatedAt;
  @override
  String get traceId;
  @override
  String? get transactionId;
  @override
  String get message;

  /// Create a copy of TransferRiskResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferRiskResponseImplCopyWith<_$TransferRiskResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
