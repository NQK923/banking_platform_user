// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BalanceResponse _$BalanceResponseFromJson(Map<String, dynamic> json) {
  return _BalanceResponse.fromJson(json);
}

/// @nodoc
mixin _$BalanceResponse {
  String get accountId => throw _privateConstructorUsedError;
  @DecimalConverter()
  Decimal get balance => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;

  /// Serializes this BalanceResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BalanceResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BalanceResponseCopyWith<BalanceResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceResponseCopyWith<$Res> {
  factory $BalanceResponseCopyWith(
    BalanceResponse value,
    $Res Function(BalanceResponse) then,
  ) = _$BalanceResponseCopyWithImpl<$Res, BalanceResponse>;
  @useResult
  $Res call({
    String accountId,
    @DecimalConverter() Decimal balance,
    String currency,
  });
}

/// @nodoc
class _$BalanceResponseCopyWithImpl<$Res, $Val extends BalanceResponse>
    implements $BalanceResponseCopyWith<$Res> {
  _$BalanceResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BalanceResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? balance = null,
    Object? currency = null,
  }) {
    return _then(
      _value.copyWith(
            accountId: null == accountId
                ? _value.accountId
                : accountId // ignore: cast_nullable_to_non_nullable
                      as String,
            balance: null == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as Decimal,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BalanceResponseImplCopyWith<$Res>
    implements $BalanceResponseCopyWith<$Res> {
  factory _$$BalanceResponseImplCopyWith(
    _$BalanceResponseImpl value,
    $Res Function(_$BalanceResponseImpl) then,
  ) = __$$BalanceResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String accountId,
    @DecimalConverter() Decimal balance,
    String currency,
  });
}

/// @nodoc
class __$$BalanceResponseImplCopyWithImpl<$Res>
    extends _$BalanceResponseCopyWithImpl<$Res, _$BalanceResponseImpl>
    implements _$$BalanceResponseImplCopyWith<$Res> {
  __$$BalanceResponseImplCopyWithImpl(
    _$BalanceResponseImpl _value,
    $Res Function(_$BalanceResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BalanceResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? balance = null,
    Object? currency = null,
  }) {
    return _then(
      _$BalanceResponseImpl(
        accountId: null == accountId
            ? _value.accountId
            : accountId // ignore: cast_nullable_to_non_nullable
                  as String,
        balance: null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as Decimal,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BalanceResponseImpl implements _BalanceResponse {
  const _$BalanceResponseImpl({
    required this.accountId,
    @DecimalConverter() required this.balance,
    required this.currency,
  });

  factory _$BalanceResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BalanceResponseImplFromJson(json);

  @override
  final String accountId;
  @override
  @DecimalConverter()
  final Decimal balance;
  @override
  final String currency;

  @override
  String toString() {
    return 'BalanceResponse(accountId: $accountId, balance: $balance, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BalanceResponseImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accountId, balance, currency);

  /// Create a copy of BalanceResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BalanceResponseImplCopyWith<_$BalanceResponseImpl> get copyWith =>
      __$$BalanceResponseImplCopyWithImpl<_$BalanceResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BalanceResponseImplToJson(this);
  }
}

abstract class _BalanceResponse implements BalanceResponse {
  const factory _BalanceResponse({
    required final String accountId,
    @DecimalConverter() required final Decimal balance,
    required final String currency,
  }) = _$BalanceResponseImpl;

  factory _BalanceResponse.fromJson(Map<String, dynamic> json) =
      _$BalanceResponseImpl.fromJson;

  @override
  String get accountId;
  @override
  @DecimalConverter()
  Decimal get balance;
  @override
  String get currency;

  /// Create a copy of BalanceResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BalanceResponseImplCopyWith<_$BalanceResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MovementResponse _$MovementResponseFromJson(Map<String, dynamic> json) {
  return _MovementResponse.fromJson(json);
}

/// @nodoc
mixin _$MovementResponse {
  String get journalId => throw _privateConstructorUsedError;
  BalanceResponse get balance => throw _privateConstructorUsedError;

  /// Serializes this MovementResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MovementResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovementResponseCopyWith<MovementResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovementResponseCopyWith<$Res> {
  factory $MovementResponseCopyWith(
    MovementResponse value,
    $Res Function(MovementResponse) then,
  ) = _$MovementResponseCopyWithImpl<$Res, MovementResponse>;
  @useResult
  $Res call({String journalId, BalanceResponse balance});

  $BalanceResponseCopyWith<$Res> get balance;
}

/// @nodoc
class _$MovementResponseCopyWithImpl<$Res, $Val extends MovementResponse>
    implements $MovementResponseCopyWith<$Res> {
  _$MovementResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovementResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? journalId = null, Object? balance = null}) {
    return _then(
      _value.copyWith(
            journalId: null == journalId
                ? _value.journalId
                : journalId // ignore: cast_nullable_to_non_nullable
                      as String,
            balance: null == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as BalanceResponse,
          )
          as $Val,
    );
  }

  /// Create a copy of MovementResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BalanceResponseCopyWith<$Res> get balance {
    return $BalanceResponseCopyWith<$Res>(_value.balance, (value) {
      return _then(_value.copyWith(balance: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MovementResponseImplCopyWith<$Res>
    implements $MovementResponseCopyWith<$Res> {
  factory _$$MovementResponseImplCopyWith(
    _$MovementResponseImpl value,
    $Res Function(_$MovementResponseImpl) then,
  ) = __$$MovementResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String journalId, BalanceResponse balance});

  @override
  $BalanceResponseCopyWith<$Res> get balance;
}

/// @nodoc
class __$$MovementResponseImplCopyWithImpl<$Res>
    extends _$MovementResponseCopyWithImpl<$Res, _$MovementResponseImpl>
    implements _$$MovementResponseImplCopyWith<$Res> {
  __$$MovementResponseImplCopyWithImpl(
    _$MovementResponseImpl _value,
    $Res Function(_$MovementResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MovementResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? journalId = null, Object? balance = null}) {
    return _then(
      _$MovementResponseImpl(
        journalId: null == journalId
            ? _value.journalId
            : journalId // ignore: cast_nullable_to_non_nullable
                  as String,
        balance: null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as BalanceResponse,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MovementResponseImpl implements _MovementResponse {
  const _$MovementResponseImpl({
    required this.journalId,
    required this.balance,
  });

  factory _$MovementResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovementResponseImplFromJson(json);

  @override
  final String journalId;
  @override
  final BalanceResponse balance;

  @override
  String toString() {
    return 'MovementResponse(journalId: $journalId, balance: $balance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovementResponseImpl &&
            (identical(other.journalId, journalId) ||
                other.journalId == journalId) &&
            (identical(other.balance, balance) || other.balance == balance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, journalId, balance);

  /// Create a copy of MovementResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovementResponseImplCopyWith<_$MovementResponseImpl> get copyWith =>
      __$$MovementResponseImplCopyWithImpl<_$MovementResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MovementResponseImplToJson(this);
  }
}

abstract class _MovementResponse implements MovementResponse {
  const factory _MovementResponse({
    required final String journalId,
    required final BalanceResponse balance,
  }) = _$MovementResponseImpl;

  factory _MovementResponse.fromJson(Map<String, dynamic> json) =
      _$MovementResponseImpl.fromJson;

  @override
  String get journalId;
  @override
  BalanceResponse get balance;

  /// Create a copy of MovementResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovementResponseImplCopyWith<_$MovementResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
