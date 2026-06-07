// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function(String? errorMessage) unauthenticated,
    required TResult Function() authenticating,
    required TResult Function(String userId, String? accountId) authenticated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializing,
    TResult? Function(String? errorMessage)? unauthenticated,
    TResult? Function()? authenticating,
    TResult? Function(String userId, String? accountId)? authenticated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(String? errorMessage)? unauthenticated,
    TResult Function()? authenticating,
    TResult Function(String userId, String? accountId)? authenticated,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitializing value) initializing,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateAuthenticating value) authenticating,
    required TResult Function(AuthStateAuthenticated value) authenticated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitializing value)? initializing,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateAuthenticating value)? authenticating,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitializing value)? initializing,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateAuthenticating value)? authenticating,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthStateInitializingImplCopyWith<$Res> {
  factory _$$AuthStateInitializingImplCopyWith(
    _$AuthStateInitializingImpl value,
    $Res Function(_$AuthStateInitializingImpl) then,
  ) = __$$AuthStateInitializingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthStateInitializingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateInitializingImpl>
    implements _$$AuthStateInitializingImplCopyWith<$Res> {
  __$$AuthStateInitializingImplCopyWithImpl(
    _$AuthStateInitializingImpl _value,
    $Res Function(_$AuthStateInitializingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthStateInitializingImpl implements AuthStateInitializing {
  const _$AuthStateInitializingImpl();

  @override
  String toString() {
    return 'AuthState.initializing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateInitializingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function(String? errorMessage) unauthenticated,
    required TResult Function() authenticating,
    required TResult Function(String userId, String? accountId) authenticated,
  }) {
    return initializing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializing,
    TResult? Function(String? errorMessage)? unauthenticated,
    TResult? Function()? authenticating,
    TResult? Function(String userId, String? accountId)? authenticated,
  }) {
    return initializing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(String? errorMessage)? unauthenticated,
    TResult Function()? authenticating,
    TResult Function(String userId, String? accountId)? authenticated,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitializing value) initializing,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateAuthenticating value) authenticating,
    required TResult Function(AuthStateAuthenticated value) authenticated,
  }) {
    return initializing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitializing value)? initializing,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateAuthenticating value)? authenticating,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
  }) {
    return initializing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitializing value)? initializing,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateAuthenticating value)? authenticating,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (initializing != null) {
      return initializing(this);
    }
    return orElse();
  }
}

abstract class AuthStateInitializing implements AuthState {
  const factory AuthStateInitializing() = _$AuthStateInitializingImpl;
}

/// @nodoc
abstract class _$$AuthStateUnauthenticatedImplCopyWith<$Res> {
  factory _$$AuthStateUnauthenticatedImplCopyWith(
    _$AuthStateUnauthenticatedImpl value,
    $Res Function(_$AuthStateUnauthenticatedImpl) then,
  ) = __$$AuthStateUnauthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? errorMessage});
}

/// @nodoc
class __$$AuthStateUnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateUnauthenticatedImpl>
    implements _$$AuthStateUnauthenticatedImplCopyWith<$Res> {
  __$$AuthStateUnauthenticatedImplCopyWithImpl(
    _$AuthStateUnauthenticatedImpl _value,
    $Res Function(_$AuthStateUnauthenticatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? errorMessage = freezed}) {
    return _then(
      _$AuthStateUnauthenticatedImpl(
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AuthStateUnauthenticatedImpl implements AuthStateUnauthenticated {
  const _$AuthStateUnauthenticatedImpl({this.errorMessage});

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AuthState.unauthenticated(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateUnauthenticatedImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateUnauthenticatedImplCopyWith<_$AuthStateUnauthenticatedImpl>
  get copyWith =>
      __$$AuthStateUnauthenticatedImplCopyWithImpl<
        _$AuthStateUnauthenticatedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function(String? errorMessage) unauthenticated,
    required TResult Function() authenticating,
    required TResult Function(String userId, String? accountId) authenticated,
  }) {
    return unauthenticated(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializing,
    TResult? Function(String? errorMessage)? unauthenticated,
    TResult? Function()? authenticating,
    TResult? Function(String userId, String? accountId)? authenticated,
  }) {
    return unauthenticated?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(String? errorMessage)? unauthenticated,
    TResult Function()? authenticating,
    TResult Function(String userId, String? accountId)? authenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitializing value) initializing,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateAuthenticating value) authenticating,
    required TResult Function(AuthStateAuthenticated value) authenticated,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitializing value)? initializing,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateAuthenticating value)? authenticating,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitializing value)? initializing,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateAuthenticating value)? authenticating,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class AuthStateUnauthenticated implements AuthState {
  const factory AuthStateUnauthenticated({final String? errorMessage}) =
      _$AuthStateUnauthenticatedImpl;

  String? get errorMessage;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateUnauthenticatedImplCopyWith<_$AuthStateUnauthenticatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthStateAuthenticatingImplCopyWith<$Res> {
  factory _$$AuthStateAuthenticatingImplCopyWith(
    _$AuthStateAuthenticatingImpl value,
    $Res Function(_$AuthStateAuthenticatingImpl) then,
  ) = __$$AuthStateAuthenticatingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthStateAuthenticatingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateAuthenticatingImpl>
    implements _$$AuthStateAuthenticatingImplCopyWith<$Res> {
  __$$AuthStateAuthenticatingImplCopyWithImpl(
    _$AuthStateAuthenticatingImpl _value,
    $Res Function(_$AuthStateAuthenticatingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthStateAuthenticatingImpl implements AuthStateAuthenticating {
  const _$AuthStateAuthenticatingImpl();

  @override
  String toString() {
    return 'AuthState.authenticating()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateAuthenticatingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function(String? errorMessage) unauthenticated,
    required TResult Function() authenticating,
    required TResult Function(String userId, String? accountId) authenticated,
  }) {
    return authenticating();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializing,
    TResult? Function(String? errorMessage)? unauthenticated,
    TResult? Function()? authenticating,
    TResult? Function(String userId, String? accountId)? authenticated,
  }) {
    return authenticating?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(String? errorMessage)? unauthenticated,
    TResult Function()? authenticating,
    TResult Function(String userId, String? accountId)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticating != null) {
      return authenticating();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitializing value) initializing,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateAuthenticating value) authenticating,
    required TResult Function(AuthStateAuthenticated value) authenticated,
  }) {
    return authenticating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitializing value)? initializing,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateAuthenticating value)? authenticating,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
  }) {
    return authenticating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitializing value)? initializing,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateAuthenticating value)? authenticating,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticating != null) {
      return authenticating(this);
    }
    return orElse();
  }
}

abstract class AuthStateAuthenticating implements AuthState {
  const factory AuthStateAuthenticating() = _$AuthStateAuthenticatingImpl;
}

/// @nodoc
abstract class _$$AuthStateAuthenticatedImplCopyWith<$Res> {
  factory _$$AuthStateAuthenticatedImplCopyWith(
    _$AuthStateAuthenticatedImpl value,
    $Res Function(_$AuthStateAuthenticatedImpl) then,
  ) = __$$AuthStateAuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId, String? accountId});
}

/// @nodoc
class __$$AuthStateAuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateAuthenticatedImpl>
    implements _$$AuthStateAuthenticatedImplCopyWith<$Res> {
  __$$AuthStateAuthenticatedImplCopyWithImpl(
    _$AuthStateAuthenticatedImpl _value,
    $Res Function(_$AuthStateAuthenticatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null, Object? accountId = freezed}) {
    return _then(
      _$AuthStateAuthenticatedImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        accountId: freezed == accountId
            ? _value.accountId
            : accountId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AuthStateAuthenticatedImpl implements AuthStateAuthenticated {
  const _$AuthStateAuthenticatedImpl({required this.userId, this.accountId});

  @override
  final String userId;
  @override
  final String? accountId;

  @override
  String toString() {
    return 'AuthState.authenticated(userId: $userId, accountId: $accountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateAuthenticatedImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, accountId);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateAuthenticatedImplCopyWith<_$AuthStateAuthenticatedImpl>
  get copyWith =>
      __$$AuthStateAuthenticatedImplCopyWithImpl<_$AuthStateAuthenticatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initializing,
    required TResult Function(String? errorMessage) unauthenticated,
    required TResult Function() authenticating,
    required TResult Function(String userId, String? accountId) authenticated,
  }) {
    return authenticated(userId, accountId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initializing,
    TResult? Function(String? errorMessage)? unauthenticated,
    TResult? Function()? authenticating,
    TResult? Function(String userId, String? accountId)? authenticated,
  }) {
    return authenticated?.call(userId, accountId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initializing,
    TResult Function(String? errorMessage)? unauthenticated,
    TResult Function()? authenticating,
    TResult Function(String userId, String? accountId)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(userId, accountId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitializing value) initializing,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateAuthenticating value) authenticating,
    required TResult Function(AuthStateAuthenticated value) authenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitializing value)? initializing,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateAuthenticating value)? authenticating,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitializing value)? initializing,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateAuthenticating value)? authenticating,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthStateAuthenticated implements AuthState {
  const factory AuthStateAuthenticated({
    required final String userId,
    final String? accountId,
  }) = _$AuthStateAuthenticatedImpl;

  String get userId;
  String? get accountId;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateAuthenticatedImplCopyWith<_$AuthStateAuthenticatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}
