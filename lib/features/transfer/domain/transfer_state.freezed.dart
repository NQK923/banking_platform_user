// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TransferState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage) idle,
    required TResult Function() recipientChecking,
    required TResult Function(AccountRecord recipient) recipientChecked,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )
    review,
    required TResult Function() submitting,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    riskWarningRequired,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    stepUpRequired,
    required TResult Function(TransferRiskResponse risk) manualReviewRequired,
    required TResult Function(TransferRiskResponse risk) riskBlocked,
    required TResult Function(WalletTransaction transaction, int pollCount)
    processing,
    required TResult Function(WalletTransaction transaction) completed,
    required TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )
    failed,
    required TResult Function(WalletTransaction transaction) timeout,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage)? idle,
    TResult? Function()? recipientChecking,
    TResult? Function(AccountRecord recipient)? recipientChecked,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult? Function()? submitting,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult? Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult? Function(TransferRiskResponse risk)? riskBlocked,
    TResult? Function(WalletTransaction transaction, int pollCount)? processing,
    TResult? Function(WalletTransaction transaction)? completed,
    TResult? Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult? Function(WalletTransaction transaction)? timeout,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage)? idle,
    TResult Function()? recipientChecking,
    TResult Function(AccountRecord recipient)? recipientChecked,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult Function()? submitting,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult Function(TransferRiskResponse risk)? riskBlocked,
    TResult Function(WalletTransaction transaction, int pollCount)? processing,
    TResult Function(WalletTransaction transaction)? completed,
    TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult Function(WalletTransaction transaction)? timeout,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferStateIdle value) idle,
    required TResult Function(TransferStateRecipientChecking value)
    recipientChecking,
    required TResult Function(TransferStateRecipientChecked value)
    recipientChecked,
    required TResult Function(TransferStateReview value) review,
    required TResult Function(TransferStateSubmitting value) submitting,
    required TResult Function(TransferStateRiskWarningRequired value)
    riskWarningRequired,
    required TResult Function(TransferStateStepUpRequired value) stepUpRequired,
    required TResult Function(TransferStateManualReviewRequired value)
    manualReviewRequired,
    required TResult Function(TransferStateRiskBlocked value) riskBlocked,
    required TResult Function(TransferStateProcessing value) processing,
    required TResult Function(TransferStateCompleted value) completed,
    required TResult Function(TransferStateFailed value) failed,
    required TResult Function(TransferStateTimeout value) timeout,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransferStateIdle value)? idle,
    TResult? Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult? Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult? Function(TransferStateReview value)? review,
    TResult? Function(TransferStateSubmitting value)? submitting,
    TResult? Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult? Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult? Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult? Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult? Function(TransferStateProcessing value)? processing,
    TResult? Function(TransferStateCompleted value)? completed,
    TResult? Function(TransferStateFailed value)? failed,
    TResult? Function(TransferStateTimeout value)? timeout,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferStateIdle value)? idle,
    TResult Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult Function(TransferStateReview value)? review,
    TResult Function(TransferStateSubmitting value)? submitting,
    TResult Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult Function(TransferStateProcessing value)? processing,
    TResult Function(TransferStateCompleted value)? completed,
    TResult Function(TransferStateFailed value)? failed,
    TResult Function(TransferStateTimeout value)? timeout,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferStateCopyWith<$Res> {
  factory $TransferStateCopyWith(
    TransferState value,
    $Res Function(TransferState) then,
  ) = _$TransferStateCopyWithImpl<$Res, TransferState>;
}

/// @nodoc
class _$TransferStateCopyWithImpl<$Res, $Val extends TransferState>
    implements $TransferStateCopyWith<$Res> {
  _$TransferStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TransferStateIdleImplCopyWith<$Res> {
  factory _$$TransferStateIdleImplCopyWith(
    _$TransferStateIdleImpl value,
    $Res Function(_$TransferStateIdleImpl) then,
  ) = __$$TransferStateIdleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? errorMessage});
}

/// @nodoc
class __$$TransferStateIdleImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$TransferStateIdleImpl>
    implements _$$TransferStateIdleImplCopyWith<$Res> {
  __$$TransferStateIdleImplCopyWithImpl(
    _$TransferStateIdleImpl _value,
    $Res Function(_$TransferStateIdleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? errorMessage = freezed}) {
    return _then(
      _$TransferStateIdleImpl(
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$TransferStateIdleImpl implements _TransferStateIdle {
  const _$TransferStateIdleImpl({this.errorMessage});

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'TransferState.idle(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateIdleImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStateIdleImplCopyWith<_$TransferStateIdleImpl> get copyWith =>
      __$$TransferStateIdleImplCopyWithImpl<_$TransferStateIdleImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage) idle,
    required TResult Function() recipientChecking,
    required TResult Function(AccountRecord recipient) recipientChecked,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )
    review,
    required TResult Function() submitting,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    riskWarningRequired,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    stepUpRequired,
    required TResult Function(TransferRiskResponse risk) manualReviewRequired,
    required TResult Function(TransferRiskResponse risk) riskBlocked,
    required TResult Function(WalletTransaction transaction, int pollCount)
    processing,
    required TResult Function(WalletTransaction transaction) completed,
    required TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )
    failed,
    required TResult Function(WalletTransaction transaction) timeout,
  }) {
    return idle(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage)? idle,
    TResult? Function()? recipientChecking,
    TResult? Function(AccountRecord recipient)? recipientChecked,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult? Function()? submitting,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult? Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult? Function(TransferRiskResponse risk)? riskBlocked,
    TResult? Function(WalletTransaction transaction, int pollCount)? processing,
    TResult? Function(WalletTransaction transaction)? completed,
    TResult? Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult? Function(WalletTransaction transaction)? timeout,
  }) {
    return idle?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage)? idle,
    TResult Function()? recipientChecking,
    TResult Function(AccountRecord recipient)? recipientChecked,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult Function()? submitting,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult Function(TransferRiskResponse risk)? riskBlocked,
    TResult Function(WalletTransaction transaction, int pollCount)? processing,
    TResult Function(WalletTransaction transaction)? completed,
    TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult Function(WalletTransaction transaction)? timeout,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferStateIdle value) idle,
    required TResult Function(TransferStateRecipientChecking value)
    recipientChecking,
    required TResult Function(TransferStateRecipientChecked value)
    recipientChecked,
    required TResult Function(TransferStateReview value) review,
    required TResult Function(TransferStateSubmitting value) submitting,
    required TResult Function(TransferStateRiskWarningRequired value)
    riskWarningRequired,
    required TResult Function(TransferStateStepUpRequired value) stepUpRequired,
    required TResult Function(TransferStateManualReviewRequired value)
    manualReviewRequired,
    required TResult Function(TransferStateRiskBlocked value) riskBlocked,
    required TResult Function(TransferStateProcessing value) processing,
    required TResult Function(TransferStateCompleted value) completed,
    required TResult Function(TransferStateFailed value) failed,
    required TResult Function(TransferStateTimeout value) timeout,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransferStateIdle value)? idle,
    TResult? Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult? Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult? Function(TransferStateReview value)? review,
    TResult? Function(TransferStateSubmitting value)? submitting,
    TResult? Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult? Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult? Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult? Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult? Function(TransferStateProcessing value)? processing,
    TResult? Function(TransferStateCompleted value)? completed,
    TResult? Function(TransferStateFailed value)? failed,
    TResult? Function(TransferStateTimeout value)? timeout,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferStateIdle value)? idle,
    TResult Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult Function(TransferStateReview value)? review,
    TResult Function(TransferStateSubmitting value)? submitting,
    TResult Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult Function(TransferStateProcessing value)? processing,
    TResult Function(TransferStateCompleted value)? completed,
    TResult Function(TransferStateFailed value)? failed,
    TResult Function(TransferStateTimeout value)? timeout,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _TransferStateIdle implements TransferState {
  const factory _TransferStateIdle({final String? errorMessage}) =
      _$TransferStateIdleImpl;

  String? get errorMessage;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStateIdleImplCopyWith<_$TransferStateIdleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransferStateRecipientCheckingImplCopyWith<$Res> {
  factory _$$TransferStateRecipientCheckingImplCopyWith(
    _$TransferStateRecipientCheckingImpl value,
    $Res Function(_$TransferStateRecipientCheckingImpl) then,
  ) = __$$TransferStateRecipientCheckingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransferStateRecipientCheckingImplCopyWithImpl<$Res>
    extends
        _$TransferStateCopyWithImpl<$Res, _$TransferStateRecipientCheckingImpl>
    implements _$$TransferStateRecipientCheckingImplCopyWith<$Res> {
  __$$TransferStateRecipientCheckingImplCopyWithImpl(
    _$TransferStateRecipientCheckingImpl _value,
    $Res Function(_$TransferStateRecipientCheckingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransferStateRecipientCheckingImpl
    implements TransferStateRecipientChecking {
  const _$TransferStateRecipientCheckingImpl();

  @override
  String toString() {
    return 'TransferState.recipientChecking()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateRecipientCheckingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage) idle,
    required TResult Function() recipientChecking,
    required TResult Function(AccountRecord recipient) recipientChecked,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )
    review,
    required TResult Function() submitting,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    riskWarningRequired,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    stepUpRequired,
    required TResult Function(TransferRiskResponse risk) manualReviewRequired,
    required TResult Function(TransferRiskResponse risk) riskBlocked,
    required TResult Function(WalletTransaction transaction, int pollCount)
    processing,
    required TResult Function(WalletTransaction transaction) completed,
    required TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )
    failed,
    required TResult Function(WalletTransaction transaction) timeout,
  }) {
    return recipientChecking();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage)? idle,
    TResult? Function()? recipientChecking,
    TResult? Function(AccountRecord recipient)? recipientChecked,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult? Function()? submitting,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult? Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult? Function(TransferRiskResponse risk)? riskBlocked,
    TResult? Function(WalletTransaction transaction, int pollCount)? processing,
    TResult? Function(WalletTransaction transaction)? completed,
    TResult? Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult? Function(WalletTransaction transaction)? timeout,
  }) {
    return recipientChecking?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage)? idle,
    TResult Function()? recipientChecking,
    TResult Function(AccountRecord recipient)? recipientChecked,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult Function()? submitting,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult Function(TransferRiskResponse risk)? riskBlocked,
    TResult Function(WalletTransaction transaction, int pollCount)? processing,
    TResult Function(WalletTransaction transaction)? completed,
    TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult Function(WalletTransaction transaction)? timeout,
    required TResult orElse(),
  }) {
    if (recipientChecking != null) {
      return recipientChecking();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferStateIdle value) idle,
    required TResult Function(TransferStateRecipientChecking value)
    recipientChecking,
    required TResult Function(TransferStateRecipientChecked value)
    recipientChecked,
    required TResult Function(TransferStateReview value) review,
    required TResult Function(TransferStateSubmitting value) submitting,
    required TResult Function(TransferStateRiskWarningRequired value)
    riskWarningRequired,
    required TResult Function(TransferStateStepUpRequired value) stepUpRequired,
    required TResult Function(TransferStateManualReviewRequired value)
    manualReviewRequired,
    required TResult Function(TransferStateRiskBlocked value) riskBlocked,
    required TResult Function(TransferStateProcessing value) processing,
    required TResult Function(TransferStateCompleted value) completed,
    required TResult Function(TransferStateFailed value) failed,
    required TResult Function(TransferStateTimeout value) timeout,
  }) {
    return recipientChecking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransferStateIdle value)? idle,
    TResult? Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult? Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult? Function(TransferStateReview value)? review,
    TResult? Function(TransferStateSubmitting value)? submitting,
    TResult? Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult? Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult? Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult? Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult? Function(TransferStateProcessing value)? processing,
    TResult? Function(TransferStateCompleted value)? completed,
    TResult? Function(TransferStateFailed value)? failed,
    TResult? Function(TransferStateTimeout value)? timeout,
  }) {
    return recipientChecking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferStateIdle value)? idle,
    TResult Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult Function(TransferStateReview value)? review,
    TResult Function(TransferStateSubmitting value)? submitting,
    TResult Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult Function(TransferStateProcessing value)? processing,
    TResult Function(TransferStateCompleted value)? completed,
    TResult Function(TransferStateFailed value)? failed,
    TResult Function(TransferStateTimeout value)? timeout,
    required TResult orElse(),
  }) {
    if (recipientChecking != null) {
      return recipientChecking(this);
    }
    return orElse();
  }
}

abstract class TransferStateRecipientChecking implements TransferState {
  const factory TransferStateRecipientChecking() =
      _$TransferStateRecipientCheckingImpl;
}

/// @nodoc
abstract class _$$TransferStateRecipientCheckedImplCopyWith<$Res> {
  factory _$$TransferStateRecipientCheckedImplCopyWith(
    _$TransferStateRecipientCheckedImpl value,
    $Res Function(_$TransferStateRecipientCheckedImpl) then,
  ) = __$$TransferStateRecipientCheckedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AccountRecord recipient});

  $AccountRecordCopyWith<$Res> get recipient;
}

/// @nodoc
class __$$TransferStateRecipientCheckedImplCopyWithImpl<$Res>
    extends
        _$TransferStateCopyWithImpl<$Res, _$TransferStateRecipientCheckedImpl>
    implements _$$TransferStateRecipientCheckedImplCopyWith<$Res> {
  __$$TransferStateRecipientCheckedImplCopyWithImpl(
    _$TransferStateRecipientCheckedImpl _value,
    $Res Function(_$TransferStateRecipientCheckedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? recipient = null}) {
    return _then(
      _$TransferStateRecipientCheckedImpl(
        recipient: null == recipient
            ? _value.recipient
            : recipient // ignore: cast_nullable_to_non_nullable
                  as AccountRecord,
      ),
    );
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountRecordCopyWith<$Res> get recipient {
    return $AccountRecordCopyWith<$Res>(_value.recipient, (value) {
      return _then(_value.copyWith(recipient: value));
    });
  }
}

/// @nodoc

class _$TransferStateRecipientCheckedImpl
    implements TransferStateRecipientChecked {
  const _$TransferStateRecipientCheckedImpl({required this.recipient});

  @override
  final AccountRecord recipient;

  @override
  String toString() {
    return 'TransferState.recipientChecked(recipient: $recipient)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateRecipientCheckedImpl &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient));
  }

  @override
  int get hashCode => Object.hash(runtimeType, recipient);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStateRecipientCheckedImplCopyWith<
    _$TransferStateRecipientCheckedImpl
  >
  get copyWith =>
      __$$TransferStateRecipientCheckedImplCopyWithImpl<
        _$TransferStateRecipientCheckedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage) idle,
    required TResult Function() recipientChecking,
    required TResult Function(AccountRecord recipient) recipientChecked,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )
    review,
    required TResult Function() submitting,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    riskWarningRequired,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    stepUpRequired,
    required TResult Function(TransferRiskResponse risk) manualReviewRequired,
    required TResult Function(TransferRiskResponse risk) riskBlocked,
    required TResult Function(WalletTransaction transaction, int pollCount)
    processing,
    required TResult Function(WalletTransaction transaction) completed,
    required TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )
    failed,
    required TResult Function(WalletTransaction transaction) timeout,
  }) {
    return recipientChecked(recipient);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage)? idle,
    TResult? Function()? recipientChecking,
    TResult? Function(AccountRecord recipient)? recipientChecked,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult? Function()? submitting,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult? Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult? Function(TransferRiskResponse risk)? riskBlocked,
    TResult? Function(WalletTransaction transaction, int pollCount)? processing,
    TResult? Function(WalletTransaction transaction)? completed,
    TResult? Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult? Function(WalletTransaction transaction)? timeout,
  }) {
    return recipientChecked?.call(recipient);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage)? idle,
    TResult Function()? recipientChecking,
    TResult Function(AccountRecord recipient)? recipientChecked,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult Function()? submitting,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult Function(TransferRiskResponse risk)? riskBlocked,
    TResult Function(WalletTransaction transaction, int pollCount)? processing,
    TResult Function(WalletTransaction transaction)? completed,
    TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult Function(WalletTransaction transaction)? timeout,
    required TResult orElse(),
  }) {
    if (recipientChecked != null) {
      return recipientChecked(recipient);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferStateIdle value) idle,
    required TResult Function(TransferStateRecipientChecking value)
    recipientChecking,
    required TResult Function(TransferStateRecipientChecked value)
    recipientChecked,
    required TResult Function(TransferStateReview value) review,
    required TResult Function(TransferStateSubmitting value) submitting,
    required TResult Function(TransferStateRiskWarningRequired value)
    riskWarningRequired,
    required TResult Function(TransferStateStepUpRequired value) stepUpRequired,
    required TResult Function(TransferStateManualReviewRequired value)
    manualReviewRequired,
    required TResult Function(TransferStateRiskBlocked value) riskBlocked,
    required TResult Function(TransferStateProcessing value) processing,
    required TResult Function(TransferStateCompleted value) completed,
    required TResult Function(TransferStateFailed value) failed,
    required TResult Function(TransferStateTimeout value) timeout,
  }) {
    return recipientChecked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransferStateIdle value)? idle,
    TResult? Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult? Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult? Function(TransferStateReview value)? review,
    TResult? Function(TransferStateSubmitting value)? submitting,
    TResult? Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult? Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult? Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult? Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult? Function(TransferStateProcessing value)? processing,
    TResult? Function(TransferStateCompleted value)? completed,
    TResult? Function(TransferStateFailed value)? failed,
    TResult? Function(TransferStateTimeout value)? timeout,
  }) {
    return recipientChecked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferStateIdle value)? idle,
    TResult Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult Function(TransferStateReview value)? review,
    TResult Function(TransferStateSubmitting value)? submitting,
    TResult Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult Function(TransferStateProcessing value)? processing,
    TResult Function(TransferStateCompleted value)? completed,
    TResult Function(TransferStateFailed value)? failed,
    TResult Function(TransferStateTimeout value)? timeout,
    required TResult orElse(),
  }) {
    if (recipientChecked != null) {
      return recipientChecked(this);
    }
    return orElse();
  }
}

abstract class TransferStateRecipientChecked implements TransferState {
  const factory TransferStateRecipientChecked({
    required final AccountRecord recipient,
  }) = _$TransferStateRecipientCheckedImpl;

  AccountRecord get recipient;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStateRecipientCheckedImplCopyWith<
    _$TransferStateRecipientCheckedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransferStateReviewImplCopyWith<$Res> {
  factory _$$TransferStateReviewImplCopyWith(
    _$TransferStateReviewImpl value,
    $Res Function(_$TransferStateReviewImpl) then,
  ) = __$$TransferStateReviewImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    AccountRecord recipient,
    String amount,
    String? note,
    String idempotencyKey,
  });

  $AccountRecordCopyWith<$Res> get recipient;
}

/// @nodoc
class __$$TransferStateReviewImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$TransferStateReviewImpl>
    implements _$$TransferStateReviewImplCopyWith<$Res> {
  __$$TransferStateReviewImplCopyWithImpl(
    _$TransferStateReviewImpl _value,
    $Res Function(_$TransferStateReviewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipient = null,
    Object? amount = null,
    Object? note = freezed,
    Object? idempotencyKey = null,
  }) {
    return _then(
      _$TransferStateReviewImpl(
        recipient: null == recipient
            ? _value.recipient
            : recipient // ignore: cast_nullable_to_non_nullable
                  as AccountRecord,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        idempotencyKey: null == idempotencyKey
            ? _value.idempotencyKey
            : idempotencyKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountRecordCopyWith<$Res> get recipient {
    return $AccountRecordCopyWith<$Res>(_value.recipient, (value) {
      return _then(_value.copyWith(recipient: value));
    });
  }
}

/// @nodoc

class _$TransferStateReviewImpl implements TransferStateReview {
  const _$TransferStateReviewImpl({
    required this.recipient,
    required this.amount,
    this.note,
    required this.idempotencyKey,
  });

  @override
  final AccountRecord recipient;
  @override
  final String amount;
  @override
  final String? note;
  @override
  final String idempotencyKey;

  @override
  String toString() {
    return 'TransferState.review(recipient: $recipient, amount: $amount, note: $note, idempotencyKey: $idempotencyKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateReviewImpl &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.idempotencyKey, idempotencyKey) ||
                other.idempotencyKey == idempotencyKey));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, recipient, amount, note, idempotencyKey);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStateReviewImplCopyWith<_$TransferStateReviewImpl> get copyWith =>
      __$$TransferStateReviewImplCopyWithImpl<_$TransferStateReviewImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage) idle,
    required TResult Function() recipientChecking,
    required TResult Function(AccountRecord recipient) recipientChecked,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )
    review,
    required TResult Function() submitting,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    riskWarningRequired,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    stepUpRequired,
    required TResult Function(TransferRiskResponse risk) manualReviewRequired,
    required TResult Function(TransferRiskResponse risk) riskBlocked,
    required TResult Function(WalletTransaction transaction, int pollCount)
    processing,
    required TResult Function(WalletTransaction transaction) completed,
    required TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )
    failed,
    required TResult Function(WalletTransaction transaction) timeout,
  }) {
    return review(recipient, amount, note, idempotencyKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage)? idle,
    TResult? Function()? recipientChecking,
    TResult? Function(AccountRecord recipient)? recipientChecked,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult? Function()? submitting,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult? Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult? Function(TransferRiskResponse risk)? riskBlocked,
    TResult? Function(WalletTransaction transaction, int pollCount)? processing,
    TResult? Function(WalletTransaction transaction)? completed,
    TResult? Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult? Function(WalletTransaction transaction)? timeout,
  }) {
    return review?.call(recipient, amount, note, idempotencyKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage)? idle,
    TResult Function()? recipientChecking,
    TResult Function(AccountRecord recipient)? recipientChecked,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult Function()? submitting,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult Function(TransferRiskResponse risk)? riskBlocked,
    TResult Function(WalletTransaction transaction, int pollCount)? processing,
    TResult Function(WalletTransaction transaction)? completed,
    TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult Function(WalletTransaction transaction)? timeout,
    required TResult orElse(),
  }) {
    if (review != null) {
      return review(recipient, amount, note, idempotencyKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferStateIdle value) idle,
    required TResult Function(TransferStateRecipientChecking value)
    recipientChecking,
    required TResult Function(TransferStateRecipientChecked value)
    recipientChecked,
    required TResult Function(TransferStateReview value) review,
    required TResult Function(TransferStateSubmitting value) submitting,
    required TResult Function(TransferStateRiskWarningRequired value)
    riskWarningRequired,
    required TResult Function(TransferStateStepUpRequired value) stepUpRequired,
    required TResult Function(TransferStateManualReviewRequired value)
    manualReviewRequired,
    required TResult Function(TransferStateRiskBlocked value) riskBlocked,
    required TResult Function(TransferStateProcessing value) processing,
    required TResult Function(TransferStateCompleted value) completed,
    required TResult Function(TransferStateFailed value) failed,
    required TResult Function(TransferStateTimeout value) timeout,
  }) {
    return review(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransferStateIdle value)? idle,
    TResult? Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult? Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult? Function(TransferStateReview value)? review,
    TResult? Function(TransferStateSubmitting value)? submitting,
    TResult? Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult? Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult? Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult? Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult? Function(TransferStateProcessing value)? processing,
    TResult? Function(TransferStateCompleted value)? completed,
    TResult? Function(TransferStateFailed value)? failed,
    TResult? Function(TransferStateTimeout value)? timeout,
  }) {
    return review?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferStateIdle value)? idle,
    TResult Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult Function(TransferStateReview value)? review,
    TResult Function(TransferStateSubmitting value)? submitting,
    TResult Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult Function(TransferStateProcessing value)? processing,
    TResult Function(TransferStateCompleted value)? completed,
    TResult Function(TransferStateFailed value)? failed,
    TResult Function(TransferStateTimeout value)? timeout,
    required TResult orElse(),
  }) {
    if (review != null) {
      return review(this);
    }
    return orElse();
  }
}

abstract class TransferStateReview implements TransferState {
  const factory TransferStateReview({
    required final AccountRecord recipient,
    required final String amount,
    final String? note,
    required final String idempotencyKey,
  }) = _$TransferStateReviewImpl;

  AccountRecord get recipient;
  String get amount;
  String? get note;
  String get idempotencyKey;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStateReviewImplCopyWith<_$TransferStateReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransferStateSubmittingImplCopyWith<$Res> {
  factory _$$TransferStateSubmittingImplCopyWith(
    _$TransferStateSubmittingImpl value,
    $Res Function(_$TransferStateSubmittingImpl) then,
  ) = __$$TransferStateSubmittingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransferStateSubmittingImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$TransferStateSubmittingImpl>
    implements _$$TransferStateSubmittingImplCopyWith<$Res> {
  __$$TransferStateSubmittingImplCopyWithImpl(
    _$TransferStateSubmittingImpl _value,
    $Res Function(_$TransferStateSubmittingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransferStateSubmittingImpl implements TransferStateSubmitting {
  const _$TransferStateSubmittingImpl();

  @override
  String toString() {
    return 'TransferState.submitting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateSubmittingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage) idle,
    required TResult Function() recipientChecking,
    required TResult Function(AccountRecord recipient) recipientChecked,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )
    review,
    required TResult Function() submitting,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    riskWarningRequired,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    stepUpRequired,
    required TResult Function(TransferRiskResponse risk) manualReviewRequired,
    required TResult Function(TransferRiskResponse risk) riskBlocked,
    required TResult Function(WalletTransaction transaction, int pollCount)
    processing,
    required TResult Function(WalletTransaction transaction) completed,
    required TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )
    failed,
    required TResult Function(WalletTransaction transaction) timeout,
  }) {
    return submitting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage)? idle,
    TResult? Function()? recipientChecking,
    TResult? Function(AccountRecord recipient)? recipientChecked,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult? Function()? submitting,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult? Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult? Function(TransferRiskResponse risk)? riskBlocked,
    TResult? Function(WalletTransaction transaction, int pollCount)? processing,
    TResult? Function(WalletTransaction transaction)? completed,
    TResult? Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult? Function(WalletTransaction transaction)? timeout,
  }) {
    return submitting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage)? idle,
    TResult Function()? recipientChecking,
    TResult Function(AccountRecord recipient)? recipientChecked,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult Function()? submitting,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult Function(TransferRiskResponse risk)? riskBlocked,
    TResult Function(WalletTransaction transaction, int pollCount)? processing,
    TResult Function(WalletTransaction transaction)? completed,
    TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult Function(WalletTransaction transaction)? timeout,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferStateIdle value) idle,
    required TResult Function(TransferStateRecipientChecking value)
    recipientChecking,
    required TResult Function(TransferStateRecipientChecked value)
    recipientChecked,
    required TResult Function(TransferStateReview value) review,
    required TResult Function(TransferStateSubmitting value) submitting,
    required TResult Function(TransferStateRiskWarningRequired value)
    riskWarningRequired,
    required TResult Function(TransferStateStepUpRequired value) stepUpRequired,
    required TResult Function(TransferStateManualReviewRequired value)
    manualReviewRequired,
    required TResult Function(TransferStateRiskBlocked value) riskBlocked,
    required TResult Function(TransferStateProcessing value) processing,
    required TResult Function(TransferStateCompleted value) completed,
    required TResult Function(TransferStateFailed value) failed,
    required TResult Function(TransferStateTimeout value) timeout,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransferStateIdle value)? idle,
    TResult? Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult? Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult? Function(TransferStateReview value)? review,
    TResult? Function(TransferStateSubmitting value)? submitting,
    TResult? Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult? Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult? Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult? Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult? Function(TransferStateProcessing value)? processing,
    TResult? Function(TransferStateCompleted value)? completed,
    TResult? Function(TransferStateFailed value)? failed,
    TResult? Function(TransferStateTimeout value)? timeout,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferStateIdle value)? idle,
    TResult Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult Function(TransferStateReview value)? review,
    TResult Function(TransferStateSubmitting value)? submitting,
    TResult Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult Function(TransferStateProcessing value)? processing,
    TResult Function(TransferStateCompleted value)? completed,
    TResult Function(TransferStateFailed value)? failed,
    TResult Function(TransferStateTimeout value)? timeout,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class TransferStateSubmitting implements TransferState {
  const factory TransferStateSubmitting() = _$TransferStateSubmittingImpl;
}

/// @nodoc
abstract class _$$TransferStateRiskWarningRequiredImplCopyWith<$Res> {
  factory _$$TransferStateRiskWarningRequiredImplCopyWith(
    _$TransferStateRiskWarningRequiredImpl value,
    $Res Function(_$TransferStateRiskWarningRequiredImpl) then,
  ) = __$$TransferStateRiskWarningRequiredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    AccountRecord recipient,
    String amount,
    String? note,
    String idempotencyKey,
    TransferRiskResponse risk,
  });

  $AccountRecordCopyWith<$Res> get recipient;
  $TransferRiskResponseCopyWith<$Res> get risk;
}

/// @nodoc
class __$$TransferStateRiskWarningRequiredImplCopyWithImpl<$Res>
    extends
        _$TransferStateCopyWithImpl<
          $Res,
          _$TransferStateRiskWarningRequiredImpl
        >
    implements _$$TransferStateRiskWarningRequiredImplCopyWith<$Res> {
  __$$TransferStateRiskWarningRequiredImplCopyWithImpl(
    _$TransferStateRiskWarningRequiredImpl _value,
    $Res Function(_$TransferStateRiskWarningRequiredImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipient = null,
    Object? amount = null,
    Object? note = freezed,
    Object? idempotencyKey = null,
    Object? risk = null,
  }) {
    return _then(
      _$TransferStateRiskWarningRequiredImpl(
        recipient: null == recipient
            ? _value.recipient
            : recipient // ignore: cast_nullable_to_non_nullable
                  as AccountRecord,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        idempotencyKey: null == idempotencyKey
            ? _value.idempotencyKey
            : idempotencyKey // ignore: cast_nullable_to_non_nullable
                  as String,
        risk: null == risk
            ? _value.risk
            : risk // ignore: cast_nullable_to_non_nullable
                  as TransferRiskResponse,
      ),
    );
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountRecordCopyWith<$Res> get recipient {
    return $AccountRecordCopyWith<$Res>(_value.recipient, (value) {
      return _then(_value.copyWith(recipient: value));
    });
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransferRiskResponseCopyWith<$Res> get risk {
    return $TransferRiskResponseCopyWith<$Res>(_value.risk, (value) {
      return _then(_value.copyWith(risk: value));
    });
  }
}

/// @nodoc

class _$TransferStateRiskWarningRequiredImpl
    implements TransferStateRiskWarningRequired {
  const _$TransferStateRiskWarningRequiredImpl({
    required this.recipient,
    required this.amount,
    this.note,
    required this.idempotencyKey,
    required this.risk,
  });

  @override
  final AccountRecord recipient;
  @override
  final String amount;
  @override
  final String? note;
  @override
  final String idempotencyKey;
  @override
  final TransferRiskResponse risk;

  @override
  String toString() {
    return 'TransferState.riskWarningRequired(recipient: $recipient, amount: $amount, note: $note, idempotencyKey: $idempotencyKey, risk: $risk)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateRiskWarningRequiredImpl &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.idempotencyKey, idempotencyKey) ||
                other.idempotencyKey == idempotencyKey) &&
            (identical(other.risk, risk) || other.risk == risk));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, recipient, amount, note, idempotencyKey, risk);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStateRiskWarningRequiredImplCopyWith<
    _$TransferStateRiskWarningRequiredImpl
  >
  get copyWith =>
      __$$TransferStateRiskWarningRequiredImplCopyWithImpl<
        _$TransferStateRiskWarningRequiredImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage) idle,
    required TResult Function() recipientChecking,
    required TResult Function(AccountRecord recipient) recipientChecked,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )
    review,
    required TResult Function() submitting,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    riskWarningRequired,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    stepUpRequired,
    required TResult Function(TransferRiskResponse risk) manualReviewRequired,
    required TResult Function(TransferRiskResponse risk) riskBlocked,
    required TResult Function(WalletTransaction transaction, int pollCount)
    processing,
    required TResult Function(WalletTransaction transaction) completed,
    required TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )
    failed,
    required TResult Function(WalletTransaction transaction) timeout,
  }) {
    return riskWarningRequired(recipient, amount, note, idempotencyKey, risk);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage)? idle,
    TResult? Function()? recipientChecking,
    TResult? Function(AccountRecord recipient)? recipientChecked,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult? Function()? submitting,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult? Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult? Function(TransferRiskResponse risk)? riskBlocked,
    TResult? Function(WalletTransaction transaction, int pollCount)? processing,
    TResult? Function(WalletTransaction transaction)? completed,
    TResult? Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult? Function(WalletTransaction transaction)? timeout,
  }) {
    return riskWarningRequired?.call(
      recipient,
      amount,
      note,
      idempotencyKey,
      risk,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage)? idle,
    TResult Function()? recipientChecking,
    TResult Function(AccountRecord recipient)? recipientChecked,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult Function()? submitting,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult Function(TransferRiskResponse risk)? riskBlocked,
    TResult Function(WalletTransaction transaction, int pollCount)? processing,
    TResult Function(WalletTransaction transaction)? completed,
    TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult Function(WalletTransaction transaction)? timeout,
    required TResult orElse(),
  }) {
    if (riskWarningRequired != null) {
      return riskWarningRequired(recipient, amount, note, idempotencyKey, risk);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferStateIdle value) idle,
    required TResult Function(TransferStateRecipientChecking value)
    recipientChecking,
    required TResult Function(TransferStateRecipientChecked value)
    recipientChecked,
    required TResult Function(TransferStateReview value) review,
    required TResult Function(TransferStateSubmitting value) submitting,
    required TResult Function(TransferStateRiskWarningRequired value)
    riskWarningRequired,
    required TResult Function(TransferStateStepUpRequired value) stepUpRequired,
    required TResult Function(TransferStateManualReviewRequired value)
    manualReviewRequired,
    required TResult Function(TransferStateRiskBlocked value) riskBlocked,
    required TResult Function(TransferStateProcessing value) processing,
    required TResult Function(TransferStateCompleted value) completed,
    required TResult Function(TransferStateFailed value) failed,
    required TResult Function(TransferStateTimeout value) timeout,
  }) {
    return riskWarningRequired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransferStateIdle value)? idle,
    TResult? Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult? Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult? Function(TransferStateReview value)? review,
    TResult? Function(TransferStateSubmitting value)? submitting,
    TResult? Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult? Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult? Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult? Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult? Function(TransferStateProcessing value)? processing,
    TResult? Function(TransferStateCompleted value)? completed,
    TResult? Function(TransferStateFailed value)? failed,
    TResult? Function(TransferStateTimeout value)? timeout,
  }) {
    return riskWarningRequired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferStateIdle value)? idle,
    TResult Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult Function(TransferStateReview value)? review,
    TResult Function(TransferStateSubmitting value)? submitting,
    TResult Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult Function(TransferStateProcessing value)? processing,
    TResult Function(TransferStateCompleted value)? completed,
    TResult Function(TransferStateFailed value)? failed,
    TResult Function(TransferStateTimeout value)? timeout,
    required TResult orElse(),
  }) {
    if (riskWarningRequired != null) {
      return riskWarningRequired(this);
    }
    return orElse();
  }
}

abstract class TransferStateRiskWarningRequired implements TransferState {
  const factory TransferStateRiskWarningRequired({
    required final AccountRecord recipient,
    required final String amount,
    final String? note,
    required final String idempotencyKey,
    required final TransferRiskResponse risk,
  }) = _$TransferStateRiskWarningRequiredImpl;

  AccountRecord get recipient;
  String get amount;
  String? get note;
  String get idempotencyKey;
  TransferRiskResponse get risk;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStateRiskWarningRequiredImplCopyWith<
    _$TransferStateRiskWarningRequiredImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransferStateStepUpRequiredImplCopyWith<$Res> {
  factory _$$TransferStateStepUpRequiredImplCopyWith(
    _$TransferStateStepUpRequiredImpl value,
    $Res Function(_$TransferStateStepUpRequiredImpl) then,
  ) = __$$TransferStateStepUpRequiredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    AccountRecord recipient,
    String amount,
    String? note,
    String idempotencyKey,
    TransferRiskResponse risk,
  });

  $AccountRecordCopyWith<$Res> get recipient;
  $TransferRiskResponseCopyWith<$Res> get risk;
}

/// @nodoc
class __$$TransferStateStepUpRequiredImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$TransferStateStepUpRequiredImpl>
    implements _$$TransferStateStepUpRequiredImplCopyWith<$Res> {
  __$$TransferStateStepUpRequiredImplCopyWithImpl(
    _$TransferStateStepUpRequiredImpl _value,
    $Res Function(_$TransferStateStepUpRequiredImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipient = null,
    Object? amount = null,
    Object? note = freezed,
    Object? idempotencyKey = null,
    Object? risk = null,
  }) {
    return _then(
      _$TransferStateStepUpRequiredImpl(
        recipient: null == recipient
            ? _value.recipient
            : recipient // ignore: cast_nullable_to_non_nullable
                  as AccountRecord,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        idempotencyKey: null == idempotencyKey
            ? _value.idempotencyKey
            : idempotencyKey // ignore: cast_nullable_to_non_nullable
                  as String,
        risk: null == risk
            ? _value.risk
            : risk // ignore: cast_nullable_to_non_nullable
                  as TransferRiskResponse,
      ),
    );
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountRecordCopyWith<$Res> get recipient {
    return $AccountRecordCopyWith<$Res>(_value.recipient, (value) {
      return _then(_value.copyWith(recipient: value));
    });
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransferRiskResponseCopyWith<$Res> get risk {
    return $TransferRiskResponseCopyWith<$Res>(_value.risk, (value) {
      return _then(_value.copyWith(risk: value));
    });
  }
}

/// @nodoc

class _$TransferStateStepUpRequiredImpl implements TransferStateStepUpRequired {
  const _$TransferStateStepUpRequiredImpl({
    required this.recipient,
    required this.amount,
    this.note,
    required this.idempotencyKey,
    required this.risk,
  });

  @override
  final AccountRecord recipient;
  @override
  final String amount;
  @override
  final String? note;
  @override
  final String idempotencyKey;
  @override
  final TransferRiskResponse risk;

  @override
  String toString() {
    return 'TransferState.stepUpRequired(recipient: $recipient, amount: $amount, note: $note, idempotencyKey: $idempotencyKey, risk: $risk)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateStepUpRequiredImpl &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.idempotencyKey, idempotencyKey) ||
                other.idempotencyKey == idempotencyKey) &&
            (identical(other.risk, risk) || other.risk == risk));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, recipient, amount, note, idempotencyKey, risk);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStateStepUpRequiredImplCopyWith<_$TransferStateStepUpRequiredImpl>
  get copyWith =>
      __$$TransferStateStepUpRequiredImplCopyWithImpl<
        _$TransferStateStepUpRequiredImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage) idle,
    required TResult Function() recipientChecking,
    required TResult Function(AccountRecord recipient) recipientChecked,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )
    review,
    required TResult Function() submitting,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    riskWarningRequired,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    stepUpRequired,
    required TResult Function(TransferRiskResponse risk) manualReviewRequired,
    required TResult Function(TransferRiskResponse risk) riskBlocked,
    required TResult Function(WalletTransaction transaction, int pollCount)
    processing,
    required TResult Function(WalletTransaction transaction) completed,
    required TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )
    failed,
    required TResult Function(WalletTransaction transaction) timeout,
  }) {
    return stepUpRequired(recipient, amount, note, idempotencyKey, risk);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage)? idle,
    TResult? Function()? recipientChecking,
    TResult? Function(AccountRecord recipient)? recipientChecked,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult? Function()? submitting,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult? Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult? Function(TransferRiskResponse risk)? riskBlocked,
    TResult? Function(WalletTransaction transaction, int pollCount)? processing,
    TResult? Function(WalletTransaction transaction)? completed,
    TResult? Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult? Function(WalletTransaction transaction)? timeout,
  }) {
    return stepUpRequired?.call(recipient, amount, note, idempotencyKey, risk);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage)? idle,
    TResult Function()? recipientChecking,
    TResult Function(AccountRecord recipient)? recipientChecked,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult Function()? submitting,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult Function(TransferRiskResponse risk)? riskBlocked,
    TResult Function(WalletTransaction transaction, int pollCount)? processing,
    TResult Function(WalletTransaction transaction)? completed,
    TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult Function(WalletTransaction transaction)? timeout,
    required TResult orElse(),
  }) {
    if (stepUpRequired != null) {
      return stepUpRequired(recipient, amount, note, idempotencyKey, risk);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferStateIdle value) idle,
    required TResult Function(TransferStateRecipientChecking value)
    recipientChecking,
    required TResult Function(TransferStateRecipientChecked value)
    recipientChecked,
    required TResult Function(TransferStateReview value) review,
    required TResult Function(TransferStateSubmitting value) submitting,
    required TResult Function(TransferStateRiskWarningRequired value)
    riskWarningRequired,
    required TResult Function(TransferStateStepUpRequired value) stepUpRequired,
    required TResult Function(TransferStateManualReviewRequired value)
    manualReviewRequired,
    required TResult Function(TransferStateRiskBlocked value) riskBlocked,
    required TResult Function(TransferStateProcessing value) processing,
    required TResult Function(TransferStateCompleted value) completed,
    required TResult Function(TransferStateFailed value) failed,
    required TResult Function(TransferStateTimeout value) timeout,
  }) {
    return stepUpRequired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransferStateIdle value)? idle,
    TResult? Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult? Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult? Function(TransferStateReview value)? review,
    TResult? Function(TransferStateSubmitting value)? submitting,
    TResult? Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult? Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult? Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult? Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult? Function(TransferStateProcessing value)? processing,
    TResult? Function(TransferStateCompleted value)? completed,
    TResult? Function(TransferStateFailed value)? failed,
    TResult? Function(TransferStateTimeout value)? timeout,
  }) {
    return stepUpRequired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferStateIdle value)? idle,
    TResult Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult Function(TransferStateReview value)? review,
    TResult Function(TransferStateSubmitting value)? submitting,
    TResult Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult Function(TransferStateProcessing value)? processing,
    TResult Function(TransferStateCompleted value)? completed,
    TResult Function(TransferStateFailed value)? failed,
    TResult Function(TransferStateTimeout value)? timeout,
    required TResult orElse(),
  }) {
    if (stepUpRequired != null) {
      return stepUpRequired(this);
    }
    return orElse();
  }
}

abstract class TransferStateStepUpRequired implements TransferState {
  const factory TransferStateStepUpRequired({
    required final AccountRecord recipient,
    required final String amount,
    final String? note,
    required final String idempotencyKey,
    required final TransferRiskResponse risk,
  }) = _$TransferStateStepUpRequiredImpl;

  AccountRecord get recipient;
  String get amount;
  String? get note;
  String get idempotencyKey;
  TransferRiskResponse get risk;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStateStepUpRequiredImplCopyWith<_$TransferStateStepUpRequiredImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransferStateManualReviewRequiredImplCopyWith<$Res> {
  factory _$$TransferStateManualReviewRequiredImplCopyWith(
    _$TransferStateManualReviewRequiredImpl value,
    $Res Function(_$TransferStateManualReviewRequiredImpl) then,
  ) = __$$TransferStateManualReviewRequiredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TransferRiskResponse risk});

  $TransferRiskResponseCopyWith<$Res> get risk;
}

/// @nodoc
class __$$TransferStateManualReviewRequiredImplCopyWithImpl<$Res>
    extends
        _$TransferStateCopyWithImpl<
          $Res,
          _$TransferStateManualReviewRequiredImpl
        >
    implements _$$TransferStateManualReviewRequiredImplCopyWith<$Res> {
  __$$TransferStateManualReviewRequiredImplCopyWithImpl(
    _$TransferStateManualReviewRequiredImpl _value,
    $Res Function(_$TransferStateManualReviewRequiredImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? risk = null}) {
    return _then(
      _$TransferStateManualReviewRequiredImpl(
        risk: null == risk
            ? _value.risk
            : risk // ignore: cast_nullable_to_non_nullable
                  as TransferRiskResponse,
      ),
    );
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransferRiskResponseCopyWith<$Res> get risk {
    return $TransferRiskResponseCopyWith<$Res>(_value.risk, (value) {
      return _then(_value.copyWith(risk: value));
    });
  }
}

/// @nodoc

class _$TransferStateManualReviewRequiredImpl
    implements TransferStateManualReviewRequired {
  const _$TransferStateManualReviewRequiredImpl({required this.risk});

  @override
  final TransferRiskResponse risk;

  @override
  String toString() {
    return 'TransferState.manualReviewRequired(risk: $risk)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateManualReviewRequiredImpl &&
            (identical(other.risk, risk) || other.risk == risk));
  }

  @override
  int get hashCode => Object.hash(runtimeType, risk);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStateManualReviewRequiredImplCopyWith<
    _$TransferStateManualReviewRequiredImpl
  >
  get copyWith =>
      __$$TransferStateManualReviewRequiredImplCopyWithImpl<
        _$TransferStateManualReviewRequiredImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage) idle,
    required TResult Function() recipientChecking,
    required TResult Function(AccountRecord recipient) recipientChecked,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )
    review,
    required TResult Function() submitting,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    riskWarningRequired,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    stepUpRequired,
    required TResult Function(TransferRiskResponse risk) manualReviewRequired,
    required TResult Function(TransferRiskResponse risk) riskBlocked,
    required TResult Function(WalletTransaction transaction, int pollCount)
    processing,
    required TResult Function(WalletTransaction transaction) completed,
    required TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )
    failed,
    required TResult Function(WalletTransaction transaction) timeout,
  }) {
    return manualReviewRequired(risk);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage)? idle,
    TResult? Function()? recipientChecking,
    TResult? Function(AccountRecord recipient)? recipientChecked,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult? Function()? submitting,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult? Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult? Function(TransferRiskResponse risk)? riskBlocked,
    TResult? Function(WalletTransaction transaction, int pollCount)? processing,
    TResult? Function(WalletTransaction transaction)? completed,
    TResult? Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult? Function(WalletTransaction transaction)? timeout,
  }) {
    return manualReviewRequired?.call(risk);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage)? idle,
    TResult Function()? recipientChecking,
    TResult Function(AccountRecord recipient)? recipientChecked,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult Function()? submitting,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult Function(TransferRiskResponse risk)? riskBlocked,
    TResult Function(WalletTransaction transaction, int pollCount)? processing,
    TResult Function(WalletTransaction transaction)? completed,
    TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult Function(WalletTransaction transaction)? timeout,
    required TResult orElse(),
  }) {
    if (manualReviewRequired != null) {
      return manualReviewRequired(risk);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferStateIdle value) idle,
    required TResult Function(TransferStateRecipientChecking value)
    recipientChecking,
    required TResult Function(TransferStateRecipientChecked value)
    recipientChecked,
    required TResult Function(TransferStateReview value) review,
    required TResult Function(TransferStateSubmitting value) submitting,
    required TResult Function(TransferStateRiskWarningRequired value)
    riskWarningRequired,
    required TResult Function(TransferStateStepUpRequired value) stepUpRequired,
    required TResult Function(TransferStateManualReviewRequired value)
    manualReviewRequired,
    required TResult Function(TransferStateRiskBlocked value) riskBlocked,
    required TResult Function(TransferStateProcessing value) processing,
    required TResult Function(TransferStateCompleted value) completed,
    required TResult Function(TransferStateFailed value) failed,
    required TResult Function(TransferStateTimeout value) timeout,
  }) {
    return manualReviewRequired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransferStateIdle value)? idle,
    TResult? Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult? Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult? Function(TransferStateReview value)? review,
    TResult? Function(TransferStateSubmitting value)? submitting,
    TResult? Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult? Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult? Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult? Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult? Function(TransferStateProcessing value)? processing,
    TResult? Function(TransferStateCompleted value)? completed,
    TResult? Function(TransferStateFailed value)? failed,
    TResult? Function(TransferStateTimeout value)? timeout,
  }) {
    return manualReviewRequired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferStateIdle value)? idle,
    TResult Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult Function(TransferStateReview value)? review,
    TResult Function(TransferStateSubmitting value)? submitting,
    TResult Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult Function(TransferStateProcessing value)? processing,
    TResult Function(TransferStateCompleted value)? completed,
    TResult Function(TransferStateFailed value)? failed,
    TResult Function(TransferStateTimeout value)? timeout,
    required TResult orElse(),
  }) {
    if (manualReviewRequired != null) {
      return manualReviewRequired(this);
    }
    return orElse();
  }
}

abstract class TransferStateManualReviewRequired implements TransferState {
  const factory TransferStateManualReviewRequired({
    required final TransferRiskResponse risk,
  }) = _$TransferStateManualReviewRequiredImpl;

  TransferRiskResponse get risk;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStateManualReviewRequiredImplCopyWith<
    _$TransferStateManualReviewRequiredImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransferStateRiskBlockedImplCopyWith<$Res> {
  factory _$$TransferStateRiskBlockedImplCopyWith(
    _$TransferStateRiskBlockedImpl value,
    $Res Function(_$TransferStateRiskBlockedImpl) then,
  ) = __$$TransferStateRiskBlockedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TransferRiskResponse risk});

  $TransferRiskResponseCopyWith<$Res> get risk;
}

/// @nodoc
class __$$TransferStateRiskBlockedImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$TransferStateRiskBlockedImpl>
    implements _$$TransferStateRiskBlockedImplCopyWith<$Res> {
  __$$TransferStateRiskBlockedImplCopyWithImpl(
    _$TransferStateRiskBlockedImpl _value,
    $Res Function(_$TransferStateRiskBlockedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? risk = null}) {
    return _then(
      _$TransferStateRiskBlockedImpl(
        risk: null == risk
            ? _value.risk
            : risk // ignore: cast_nullable_to_non_nullable
                  as TransferRiskResponse,
      ),
    );
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransferRiskResponseCopyWith<$Res> get risk {
    return $TransferRiskResponseCopyWith<$Res>(_value.risk, (value) {
      return _then(_value.copyWith(risk: value));
    });
  }
}

/// @nodoc

class _$TransferStateRiskBlockedImpl implements TransferStateRiskBlocked {
  const _$TransferStateRiskBlockedImpl({required this.risk});

  @override
  final TransferRiskResponse risk;

  @override
  String toString() {
    return 'TransferState.riskBlocked(risk: $risk)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateRiskBlockedImpl &&
            (identical(other.risk, risk) || other.risk == risk));
  }

  @override
  int get hashCode => Object.hash(runtimeType, risk);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStateRiskBlockedImplCopyWith<_$TransferStateRiskBlockedImpl>
  get copyWith =>
      __$$TransferStateRiskBlockedImplCopyWithImpl<
        _$TransferStateRiskBlockedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage) idle,
    required TResult Function() recipientChecking,
    required TResult Function(AccountRecord recipient) recipientChecked,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )
    review,
    required TResult Function() submitting,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    riskWarningRequired,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    stepUpRequired,
    required TResult Function(TransferRiskResponse risk) manualReviewRequired,
    required TResult Function(TransferRiskResponse risk) riskBlocked,
    required TResult Function(WalletTransaction transaction, int pollCount)
    processing,
    required TResult Function(WalletTransaction transaction) completed,
    required TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )
    failed,
    required TResult Function(WalletTransaction transaction) timeout,
  }) {
    return riskBlocked(risk);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage)? idle,
    TResult? Function()? recipientChecking,
    TResult? Function(AccountRecord recipient)? recipientChecked,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult? Function()? submitting,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult? Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult? Function(TransferRiskResponse risk)? riskBlocked,
    TResult? Function(WalletTransaction transaction, int pollCount)? processing,
    TResult? Function(WalletTransaction transaction)? completed,
    TResult? Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult? Function(WalletTransaction transaction)? timeout,
  }) {
    return riskBlocked?.call(risk);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage)? idle,
    TResult Function()? recipientChecking,
    TResult Function(AccountRecord recipient)? recipientChecked,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult Function()? submitting,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult Function(TransferRiskResponse risk)? riskBlocked,
    TResult Function(WalletTransaction transaction, int pollCount)? processing,
    TResult Function(WalletTransaction transaction)? completed,
    TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult Function(WalletTransaction transaction)? timeout,
    required TResult orElse(),
  }) {
    if (riskBlocked != null) {
      return riskBlocked(risk);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferStateIdle value) idle,
    required TResult Function(TransferStateRecipientChecking value)
    recipientChecking,
    required TResult Function(TransferStateRecipientChecked value)
    recipientChecked,
    required TResult Function(TransferStateReview value) review,
    required TResult Function(TransferStateSubmitting value) submitting,
    required TResult Function(TransferStateRiskWarningRequired value)
    riskWarningRequired,
    required TResult Function(TransferStateStepUpRequired value) stepUpRequired,
    required TResult Function(TransferStateManualReviewRequired value)
    manualReviewRequired,
    required TResult Function(TransferStateRiskBlocked value) riskBlocked,
    required TResult Function(TransferStateProcessing value) processing,
    required TResult Function(TransferStateCompleted value) completed,
    required TResult Function(TransferStateFailed value) failed,
    required TResult Function(TransferStateTimeout value) timeout,
  }) {
    return riskBlocked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransferStateIdle value)? idle,
    TResult? Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult? Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult? Function(TransferStateReview value)? review,
    TResult? Function(TransferStateSubmitting value)? submitting,
    TResult? Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult? Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult? Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult? Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult? Function(TransferStateProcessing value)? processing,
    TResult? Function(TransferStateCompleted value)? completed,
    TResult? Function(TransferStateFailed value)? failed,
    TResult? Function(TransferStateTimeout value)? timeout,
  }) {
    return riskBlocked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferStateIdle value)? idle,
    TResult Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult Function(TransferStateReview value)? review,
    TResult Function(TransferStateSubmitting value)? submitting,
    TResult Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult Function(TransferStateProcessing value)? processing,
    TResult Function(TransferStateCompleted value)? completed,
    TResult Function(TransferStateFailed value)? failed,
    TResult Function(TransferStateTimeout value)? timeout,
    required TResult orElse(),
  }) {
    if (riskBlocked != null) {
      return riskBlocked(this);
    }
    return orElse();
  }
}

abstract class TransferStateRiskBlocked implements TransferState {
  const factory TransferStateRiskBlocked({
    required final TransferRiskResponse risk,
  }) = _$TransferStateRiskBlockedImpl;

  TransferRiskResponse get risk;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStateRiskBlockedImplCopyWith<_$TransferStateRiskBlockedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransferStateProcessingImplCopyWith<$Res> {
  factory _$$TransferStateProcessingImplCopyWith(
    _$TransferStateProcessingImpl value,
    $Res Function(_$TransferStateProcessingImpl) then,
  ) = __$$TransferStateProcessingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({WalletTransaction transaction, int pollCount});

  $WalletTransactionCopyWith<$Res> get transaction;
}

/// @nodoc
class __$$TransferStateProcessingImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$TransferStateProcessingImpl>
    implements _$$TransferStateProcessingImplCopyWith<$Res> {
  __$$TransferStateProcessingImplCopyWithImpl(
    _$TransferStateProcessingImpl _value,
    $Res Function(_$TransferStateProcessingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transaction = null, Object? pollCount = null}) {
    return _then(
      _$TransferStateProcessingImpl(
        transaction: null == transaction
            ? _value.transaction
            : transaction // ignore: cast_nullable_to_non_nullable
                  as WalletTransaction,
        pollCount: null == pollCount
            ? _value.pollCount
            : pollCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletTransactionCopyWith<$Res> get transaction {
    return $WalletTransactionCopyWith<$Res>(_value.transaction, (value) {
      return _then(_value.copyWith(transaction: value));
    });
  }
}

/// @nodoc

class _$TransferStateProcessingImpl implements TransferStateProcessing {
  const _$TransferStateProcessingImpl({
    required this.transaction,
    this.pollCount = 0,
  });

  @override
  final WalletTransaction transaction;
  @override
  @JsonKey()
  final int pollCount;

  @override
  String toString() {
    return 'TransferState.processing(transaction: $transaction, pollCount: $pollCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateProcessingImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            (identical(other.pollCount, pollCount) ||
                other.pollCount == pollCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction, pollCount);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStateProcessingImplCopyWith<_$TransferStateProcessingImpl>
  get copyWith =>
      __$$TransferStateProcessingImplCopyWithImpl<
        _$TransferStateProcessingImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage) idle,
    required TResult Function() recipientChecking,
    required TResult Function(AccountRecord recipient) recipientChecked,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )
    review,
    required TResult Function() submitting,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    riskWarningRequired,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    stepUpRequired,
    required TResult Function(TransferRiskResponse risk) manualReviewRequired,
    required TResult Function(TransferRiskResponse risk) riskBlocked,
    required TResult Function(WalletTransaction transaction, int pollCount)
    processing,
    required TResult Function(WalletTransaction transaction) completed,
    required TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )
    failed,
    required TResult Function(WalletTransaction transaction) timeout,
  }) {
    return processing(transaction, pollCount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage)? idle,
    TResult? Function()? recipientChecking,
    TResult? Function(AccountRecord recipient)? recipientChecked,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult? Function()? submitting,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult? Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult? Function(TransferRiskResponse risk)? riskBlocked,
    TResult? Function(WalletTransaction transaction, int pollCount)? processing,
    TResult? Function(WalletTransaction transaction)? completed,
    TResult? Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult? Function(WalletTransaction transaction)? timeout,
  }) {
    return processing?.call(transaction, pollCount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage)? idle,
    TResult Function()? recipientChecking,
    TResult Function(AccountRecord recipient)? recipientChecked,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult Function()? submitting,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult Function(TransferRiskResponse risk)? riskBlocked,
    TResult Function(WalletTransaction transaction, int pollCount)? processing,
    TResult Function(WalletTransaction transaction)? completed,
    TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult Function(WalletTransaction transaction)? timeout,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(transaction, pollCount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferStateIdle value) idle,
    required TResult Function(TransferStateRecipientChecking value)
    recipientChecking,
    required TResult Function(TransferStateRecipientChecked value)
    recipientChecked,
    required TResult Function(TransferStateReview value) review,
    required TResult Function(TransferStateSubmitting value) submitting,
    required TResult Function(TransferStateRiskWarningRequired value)
    riskWarningRequired,
    required TResult Function(TransferStateStepUpRequired value) stepUpRequired,
    required TResult Function(TransferStateManualReviewRequired value)
    manualReviewRequired,
    required TResult Function(TransferStateRiskBlocked value) riskBlocked,
    required TResult Function(TransferStateProcessing value) processing,
    required TResult Function(TransferStateCompleted value) completed,
    required TResult Function(TransferStateFailed value) failed,
    required TResult Function(TransferStateTimeout value) timeout,
  }) {
    return processing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransferStateIdle value)? idle,
    TResult? Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult? Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult? Function(TransferStateReview value)? review,
    TResult? Function(TransferStateSubmitting value)? submitting,
    TResult? Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult? Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult? Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult? Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult? Function(TransferStateProcessing value)? processing,
    TResult? Function(TransferStateCompleted value)? completed,
    TResult? Function(TransferStateFailed value)? failed,
    TResult? Function(TransferStateTimeout value)? timeout,
  }) {
    return processing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferStateIdle value)? idle,
    TResult Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult Function(TransferStateReview value)? review,
    TResult Function(TransferStateSubmitting value)? submitting,
    TResult Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult Function(TransferStateProcessing value)? processing,
    TResult Function(TransferStateCompleted value)? completed,
    TResult Function(TransferStateFailed value)? failed,
    TResult Function(TransferStateTimeout value)? timeout,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(this);
    }
    return orElse();
  }
}

abstract class TransferStateProcessing implements TransferState {
  const factory TransferStateProcessing({
    required final WalletTransaction transaction,
    final int pollCount,
  }) = _$TransferStateProcessingImpl;

  WalletTransaction get transaction;
  int get pollCount;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStateProcessingImplCopyWith<_$TransferStateProcessingImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransferStateCompletedImplCopyWith<$Res> {
  factory _$$TransferStateCompletedImplCopyWith(
    _$TransferStateCompletedImpl value,
    $Res Function(_$TransferStateCompletedImpl) then,
  ) = __$$TransferStateCompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({WalletTransaction transaction});

  $WalletTransactionCopyWith<$Res> get transaction;
}

/// @nodoc
class __$$TransferStateCompletedImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$TransferStateCompletedImpl>
    implements _$$TransferStateCompletedImplCopyWith<$Res> {
  __$$TransferStateCompletedImplCopyWithImpl(
    _$TransferStateCompletedImpl _value,
    $Res Function(_$TransferStateCompletedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transaction = null}) {
    return _then(
      _$TransferStateCompletedImpl(
        transaction: null == transaction
            ? _value.transaction
            : transaction // ignore: cast_nullable_to_non_nullable
                  as WalletTransaction,
      ),
    );
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletTransactionCopyWith<$Res> get transaction {
    return $WalletTransactionCopyWith<$Res>(_value.transaction, (value) {
      return _then(_value.copyWith(transaction: value));
    });
  }
}

/// @nodoc

class _$TransferStateCompletedImpl implements TransferStateCompleted {
  const _$TransferStateCompletedImpl({required this.transaction});

  @override
  final WalletTransaction transaction;

  @override
  String toString() {
    return 'TransferState.completed(transaction: $transaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateCompletedImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStateCompletedImplCopyWith<_$TransferStateCompletedImpl>
  get copyWith =>
      __$$TransferStateCompletedImplCopyWithImpl<_$TransferStateCompletedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage) idle,
    required TResult Function() recipientChecking,
    required TResult Function(AccountRecord recipient) recipientChecked,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )
    review,
    required TResult Function() submitting,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    riskWarningRequired,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    stepUpRequired,
    required TResult Function(TransferRiskResponse risk) manualReviewRequired,
    required TResult Function(TransferRiskResponse risk) riskBlocked,
    required TResult Function(WalletTransaction transaction, int pollCount)
    processing,
    required TResult Function(WalletTransaction transaction) completed,
    required TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )
    failed,
    required TResult Function(WalletTransaction transaction) timeout,
  }) {
    return completed(transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage)? idle,
    TResult? Function()? recipientChecking,
    TResult? Function(AccountRecord recipient)? recipientChecked,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult? Function()? submitting,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult? Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult? Function(TransferRiskResponse risk)? riskBlocked,
    TResult? Function(WalletTransaction transaction, int pollCount)? processing,
    TResult? Function(WalletTransaction transaction)? completed,
    TResult? Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult? Function(WalletTransaction transaction)? timeout,
  }) {
    return completed?.call(transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage)? idle,
    TResult Function()? recipientChecking,
    TResult Function(AccountRecord recipient)? recipientChecked,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult Function()? submitting,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult Function(TransferRiskResponse risk)? riskBlocked,
    TResult Function(WalletTransaction transaction, int pollCount)? processing,
    TResult Function(WalletTransaction transaction)? completed,
    TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult Function(WalletTransaction transaction)? timeout,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(transaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferStateIdle value) idle,
    required TResult Function(TransferStateRecipientChecking value)
    recipientChecking,
    required TResult Function(TransferStateRecipientChecked value)
    recipientChecked,
    required TResult Function(TransferStateReview value) review,
    required TResult Function(TransferStateSubmitting value) submitting,
    required TResult Function(TransferStateRiskWarningRequired value)
    riskWarningRequired,
    required TResult Function(TransferStateStepUpRequired value) stepUpRequired,
    required TResult Function(TransferStateManualReviewRequired value)
    manualReviewRequired,
    required TResult Function(TransferStateRiskBlocked value) riskBlocked,
    required TResult Function(TransferStateProcessing value) processing,
    required TResult Function(TransferStateCompleted value) completed,
    required TResult Function(TransferStateFailed value) failed,
    required TResult Function(TransferStateTimeout value) timeout,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransferStateIdle value)? idle,
    TResult? Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult? Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult? Function(TransferStateReview value)? review,
    TResult? Function(TransferStateSubmitting value)? submitting,
    TResult? Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult? Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult? Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult? Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult? Function(TransferStateProcessing value)? processing,
    TResult? Function(TransferStateCompleted value)? completed,
    TResult? Function(TransferStateFailed value)? failed,
    TResult? Function(TransferStateTimeout value)? timeout,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferStateIdle value)? idle,
    TResult Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult Function(TransferStateReview value)? review,
    TResult Function(TransferStateSubmitting value)? submitting,
    TResult Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult Function(TransferStateProcessing value)? processing,
    TResult Function(TransferStateCompleted value)? completed,
    TResult Function(TransferStateFailed value)? failed,
    TResult Function(TransferStateTimeout value)? timeout,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class TransferStateCompleted implements TransferState {
  const factory TransferStateCompleted({
    required final WalletTransaction transaction,
  }) = _$TransferStateCompletedImpl;

  WalletTransaction get transaction;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStateCompletedImplCopyWith<_$TransferStateCompletedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransferStateFailedImplCopyWith<$Res> {
  factory _$$TransferStateFailedImplCopyWith(
    _$TransferStateFailedImpl value,
    $Res Function(_$TransferStateFailedImpl) then,
  ) = __$$TransferStateFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String reason,
    bool wasRefunded,
    WalletTransaction? transaction,
    AccountRecord? recipient,
    String? amount,
    String? note,
    String? idempotencyKey,
  });

  $WalletTransactionCopyWith<$Res>? get transaction;
  $AccountRecordCopyWith<$Res>? get recipient;
}

/// @nodoc
class __$$TransferStateFailedImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$TransferStateFailedImpl>
    implements _$$TransferStateFailedImplCopyWith<$Res> {
  __$$TransferStateFailedImplCopyWithImpl(
    _$TransferStateFailedImpl _value,
    $Res Function(_$TransferStateFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
    Object? wasRefunded = null,
    Object? transaction = freezed,
    Object? recipient = freezed,
    Object? amount = freezed,
    Object? note = freezed,
    Object? idempotencyKey = freezed,
  }) {
    return _then(
      _$TransferStateFailedImpl(
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        wasRefunded: null == wasRefunded
            ? _value.wasRefunded
            : wasRefunded // ignore: cast_nullable_to_non_nullable
                  as bool,
        transaction: freezed == transaction
            ? _value.transaction
            : transaction // ignore: cast_nullable_to_non_nullable
                  as WalletTransaction?,
        recipient: freezed == recipient
            ? _value.recipient
            : recipient // ignore: cast_nullable_to_non_nullable
                  as AccountRecord?,
        amount: freezed == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as String?,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        idempotencyKey: freezed == idempotencyKey
            ? _value.idempotencyKey
            : idempotencyKey // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletTransactionCopyWith<$Res>? get transaction {
    if (_value.transaction == null) {
      return null;
    }

    return $WalletTransactionCopyWith<$Res>(_value.transaction!, (value) {
      return _then(_value.copyWith(transaction: value));
    });
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountRecordCopyWith<$Res>? get recipient {
    if (_value.recipient == null) {
      return null;
    }

    return $AccountRecordCopyWith<$Res>(_value.recipient!, (value) {
      return _then(_value.copyWith(recipient: value));
    });
  }
}

/// @nodoc

class _$TransferStateFailedImpl implements TransferStateFailed {
  const _$TransferStateFailedImpl({
    required this.reason,
    this.wasRefunded = false,
    this.transaction,
    this.recipient,
    this.amount,
    this.note,
    this.idempotencyKey,
  });

  @override
  final String reason;
  @override
  @JsonKey()
  final bool wasRefunded;
  @override
  final WalletTransaction? transaction;
  @override
  final AccountRecord? recipient;
  @override
  final String? amount;
  @override
  final String? note;
  @override
  final String? idempotencyKey;

  @override
  String toString() {
    return 'TransferState.failed(reason: $reason, wasRefunded: $wasRefunded, transaction: $transaction, recipient: $recipient, amount: $amount, note: $note, idempotencyKey: $idempotencyKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateFailedImpl &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.wasRefunded, wasRefunded) ||
                other.wasRefunded == wasRefunded) &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.idempotencyKey, idempotencyKey) ||
                other.idempotencyKey == idempotencyKey));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    reason,
    wasRefunded,
    transaction,
    recipient,
    amount,
    note,
    idempotencyKey,
  );

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStateFailedImplCopyWith<_$TransferStateFailedImpl> get copyWith =>
      __$$TransferStateFailedImplCopyWithImpl<_$TransferStateFailedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage) idle,
    required TResult Function() recipientChecking,
    required TResult Function(AccountRecord recipient) recipientChecked,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )
    review,
    required TResult Function() submitting,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    riskWarningRequired,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    stepUpRequired,
    required TResult Function(TransferRiskResponse risk) manualReviewRequired,
    required TResult Function(TransferRiskResponse risk) riskBlocked,
    required TResult Function(WalletTransaction transaction, int pollCount)
    processing,
    required TResult Function(WalletTransaction transaction) completed,
    required TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )
    failed,
    required TResult Function(WalletTransaction transaction) timeout,
  }) {
    return failed(
      reason,
      wasRefunded,
      transaction,
      recipient,
      amount,
      note,
      idempotencyKey,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage)? idle,
    TResult? Function()? recipientChecking,
    TResult? Function(AccountRecord recipient)? recipientChecked,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult? Function()? submitting,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult? Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult? Function(TransferRiskResponse risk)? riskBlocked,
    TResult? Function(WalletTransaction transaction, int pollCount)? processing,
    TResult? Function(WalletTransaction transaction)? completed,
    TResult? Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult? Function(WalletTransaction transaction)? timeout,
  }) {
    return failed?.call(
      reason,
      wasRefunded,
      transaction,
      recipient,
      amount,
      note,
      idempotencyKey,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage)? idle,
    TResult Function()? recipientChecking,
    TResult Function(AccountRecord recipient)? recipientChecked,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult Function()? submitting,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult Function(TransferRiskResponse risk)? riskBlocked,
    TResult Function(WalletTransaction transaction, int pollCount)? processing,
    TResult Function(WalletTransaction transaction)? completed,
    TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult Function(WalletTransaction transaction)? timeout,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(
        reason,
        wasRefunded,
        transaction,
        recipient,
        amount,
        note,
        idempotencyKey,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferStateIdle value) idle,
    required TResult Function(TransferStateRecipientChecking value)
    recipientChecking,
    required TResult Function(TransferStateRecipientChecked value)
    recipientChecked,
    required TResult Function(TransferStateReview value) review,
    required TResult Function(TransferStateSubmitting value) submitting,
    required TResult Function(TransferStateRiskWarningRequired value)
    riskWarningRequired,
    required TResult Function(TransferStateStepUpRequired value) stepUpRequired,
    required TResult Function(TransferStateManualReviewRequired value)
    manualReviewRequired,
    required TResult Function(TransferStateRiskBlocked value) riskBlocked,
    required TResult Function(TransferStateProcessing value) processing,
    required TResult Function(TransferStateCompleted value) completed,
    required TResult Function(TransferStateFailed value) failed,
    required TResult Function(TransferStateTimeout value) timeout,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransferStateIdle value)? idle,
    TResult? Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult? Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult? Function(TransferStateReview value)? review,
    TResult? Function(TransferStateSubmitting value)? submitting,
    TResult? Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult? Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult? Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult? Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult? Function(TransferStateProcessing value)? processing,
    TResult? Function(TransferStateCompleted value)? completed,
    TResult? Function(TransferStateFailed value)? failed,
    TResult? Function(TransferStateTimeout value)? timeout,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferStateIdle value)? idle,
    TResult Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult Function(TransferStateReview value)? review,
    TResult Function(TransferStateSubmitting value)? submitting,
    TResult Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult Function(TransferStateProcessing value)? processing,
    TResult Function(TransferStateCompleted value)? completed,
    TResult Function(TransferStateFailed value)? failed,
    TResult Function(TransferStateTimeout value)? timeout,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class TransferStateFailed implements TransferState {
  const factory TransferStateFailed({
    required final String reason,
    final bool wasRefunded,
    final WalletTransaction? transaction,
    final AccountRecord? recipient,
    final String? amount,
    final String? note,
    final String? idempotencyKey,
  }) = _$TransferStateFailedImpl;

  String get reason;
  bool get wasRefunded;
  WalletTransaction? get transaction;
  AccountRecord? get recipient;
  String? get amount;
  String? get note;
  String? get idempotencyKey;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStateFailedImplCopyWith<_$TransferStateFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransferStateTimeoutImplCopyWith<$Res> {
  factory _$$TransferStateTimeoutImplCopyWith(
    _$TransferStateTimeoutImpl value,
    $Res Function(_$TransferStateTimeoutImpl) then,
  ) = __$$TransferStateTimeoutImplCopyWithImpl<$Res>;
  @useResult
  $Res call({WalletTransaction transaction});

  $WalletTransactionCopyWith<$Res> get transaction;
}

/// @nodoc
class __$$TransferStateTimeoutImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$TransferStateTimeoutImpl>
    implements _$$TransferStateTimeoutImplCopyWith<$Res> {
  __$$TransferStateTimeoutImplCopyWithImpl(
    _$TransferStateTimeoutImpl _value,
    $Res Function(_$TransferStateTimeoutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transaction = null}) {
    return _then(
      _$TransferStateTimeoutImpl(
        transaction: null == transaction
            ? _value.transaction
            : transaction // ignore: cast_nullable_to_non_nullable
                  as WalletTransaction,
      ),
    );
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletTransactionCopyWith<$Res> get transaction {
    return $WalletTransactionCopyWith<$Res>(_value.transaction, (value) {
      return _then(_value.copyWith(transaction: value));
    });
  }
}

/// @nodoc

class _$TransferStateTimeoutImpl implements TransferStateTimeout {
  const _$TransferStateTimeoutImpl({required this.transaction});

  @override
  final WalletTransaction transaction;

  @override
  String toString() {
    return 'TransferState.timeout(transaction: $transaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateTimeoutImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStateTimeoutImplCopyWith<_$TransferStateTimeoutImpl>
  get copyWith =>
      __$$TransferStateTimeoutImplCopyWithImpl<_$TransferStateTimeoutImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? errorMessage) idle,
    required TResult Function() recipientChecking,
    required TResult Function(AccountRecord recipient) recipientChecked,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )
    review,
    required TResult Function() submitting,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    riskWarningRequired,
    required TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )
    stepUpRequired,
    required TResult Function(TransferRiskResponse risk) manualReviewRequired,
    required TResult Function(TransferRiskResponse risk) riskBlocked,
    required TResult Function(WalletTransaction transaction, int pollCount)
    processing,
    required TResult Function(WalletTransaction transaction) completed,
    required TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )
    failed,
    required TResult Function(WalletTransaction transaction) timeout,
  }) {
    return timeout(transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? errorMessage)? idle,
    TResult? Function()? recipientChecking,
    TResult? Function(AccountRecord recipient)? recipientChecked,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult? Function()? submitting,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult? Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult? Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult? Function(TransferRiskResponse risk)? riskBlocked,
    TResult? Function(WalletTransaction transaction, int pollCount)? processing,
    TResult? Function(WalletTransaction transaction)? completed,
    TResult? Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult? Function(WalletTransaction transaction)? timeout,
  }) {
    return timeout?.call(transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? errorMessage)? idle,
    TResult Function()? recipientChecking,
    TResult Function(AccountRecord recipient)? recipientChecked,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
    )?
    review,
    TResult Function()? submitting,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    riskWarningRequired,
    TResult Function(
      AccountRecord recipient,
      String amount,
      String? note,
      String idempotencyKey,
      TransferRiskResponse risk,
    )?
    stepUpRequired,
    TResult Function(TransferRiskResponse risk)? manualReviewRequired,
    TResult Function(TransferRiskResponse risk)? riskBlocked,
    TResult Function(WalletTransaction transaction, int pollCount)? processing,
    TResult Function(WalletTransaction transaction)? completed,
    TResult Function(
      String reason,
      bool wasRefunded,
      WalletTransaction? transaction,
      AccountRecord? recipient,
      String? amount,
      String? note,
      String? idempotencyKey,
    )?
    failed,
    TResult Function(WalletTransaction transaction)? timeout,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(transaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferStateIdle value) idle,
    required TResult Function(TransferStateRecipientChecking value)
    recipientChecking,
    required TResult Function(TransferStateRecipientChecked value)
    recipientChecked,
    required TResult Function(TransferStateReview value) review,
    required TResult Function(TransferStateSubmitting value) submitting,
    required TResult Function(TransferStateRiskWarningRequired value)
    riskWarningRequired,
    required TResult Function(TransferStateStepUpRequired value) stepUpRequired,
    required TResult Function(TransferStateManualReviewRequired value)
    manualReviewRequired,
    required TResult Function(TransferStateRiskBlocked value) riskBlocked,
    required TResult Function(TransferStateProcessing value) processing,
    required TResult Function(TransferStateCompleted value) completed,
    required TResult Function(TransferStateFailed value) failed,
    required TResult Function(TransferStateTimeout value) timeout,
  }) {
    return timeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransferStateIdle value)? idle,
    TResult? Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult? Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult? Function(TransferStateReview value)? review,
    TResult? Function(TransferStateSubmitting value)? submitting,
    TResult? Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult? Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult? Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult? Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult? Function(TransferStateProcessing value)? processing,
    TResult? Function(TransferStateCompleted value)? completed,
    TResult? Function(TransferStateFailed value)? failed,
    TResult? Function(TransferStateTimeout value)? timeout,
  }) {
    return timeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferStateIdle value)? idle,
    TResult Function(TransferStateRecipientChecking value)? recipientChecking,
    TResult Function(TransferStateRecipientChecked value)? recipientChecked,
    TResult Function(TransferStateReview value)? review,
    TResult Function(TransferStateSubmitting value)? submitting,
    TResult Function(TransferStateRiskWarningRequired value)?
    riskWarningRequired,
    TResult Function(TransferStateStepUpRequired value)? stepUpRequired,
    TResult Function(TransferStateManualReviewRequired value)?
    manualReviewRequired,
    TResult Function(TransferStateRiskBlocked value)? riskBlocked,
    TResult Function(TransferStateProcessing value)? processing,
    TResult Function(TransferStateCompleted value)? completed,
    TResult Function(TransferStateFailed value)? failed,
    TResult Function(TransferStateTimeout value)? timeout,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(this);
    }
    return orElse();
  }
}

abstract class TransferStateTimeout implements TransferState {
  const factory TransferStateTimeout({
    required final WalletTransaction transaction,
  }) = _$TransferStateTimeoutImpl;

  WalletTransaction get transaction;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStateTimeoutImplCopyWith<_$TransferStateTimeoutImpl>
  get copyWith => throw _privateConstructorUsedError;
}
