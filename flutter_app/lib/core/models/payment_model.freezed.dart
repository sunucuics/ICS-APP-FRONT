// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PaymentStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() processing,
    required TResult Function() completed,
    required TResult Function() failed,
    required TResult Function() cancelled,
    required TResult Function() refunded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? processing,
    TResult? Function()? completed,
    TResult? Function()? failed,
    TResult? Function()? cancelled,
    TResult? Function()? refunded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? processing,
    TResult Function()? completed,
    TResult Function()? failed,
    TResult Function()? cancelled,
    TResult Function()? refunded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Pending value) pending,
    required TResult Function(_Processing value) processing,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Refunded value) refunded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Pending value)? pending,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Refunded value)? refunded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Pending value)? pending,
    TResult Function(_Processing value)? processing,
    TResult Function(_Completed value)? completed,
    TResult Function(_Failed value)? failed,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Refunded value)? refunded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentStatusCopyWith<$Res> {
  factory $PaymentStatusCopyWith(
          PaymentStatus value, $Res Function(PaymentStatus) then) =
      _$PaymentStatusCopyWithImpl<$Res, PaymentStatus>;
}

/// @nodoc
class _$PaymentStatusCopyWithImpl<$Res, $Val extends PaymentStatus>
    implements $PaymentStatusCopyWith<$Res> {
  _$PaymentStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PendingImplCopyWith<$Res> {
  factory _$$PendingImplCopyWith(
          _$PendingImpl value, $Res Function(_$PendingImpl) then) =
      __$$PendingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PendingImplCopyWithImpl<$Res>
    extends _$PaymentStatusCopyWithImpl<$Res, _$PendingImpl>
    implements _$$PendingImplCopyWith<$Res> {
  __$$PendingImplCopyWithImpl(
      _$PendingImpl _value, $Res Function(_$PendingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PendingImpl extends _Pending {
  const _$PendingImpl() : super._();

  @override
  String toString() {
    return 'PaymentStatus.pending()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PendingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() processing,
    required TResult Function() completed,
    required TResult Function() failed,
    required TResult Function() cancelled,
    required TResult Function() refunded,
  }) {
    return pending();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? processing,
    TResult? Function()? completed,
    TResult? Function()? failed,
    TResult? Function()? cancelled,
    TResult? Function()? refunded,
  }) {
    return pending?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? processing,
    TResult Function()? completed,
    TResult Function()? failed,
    TResult Function()? cancelled,
    TResult Function()? refunded,
    required TResult orElse(),
  }) {
    if (pending != null) {
      return pending();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Pending value) pending,
    required TResult Function(_Processing value) processing,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Refunded value) refunded,
  }) {
    return pending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Pending value)? pending,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Refunded value)? refunded,
  }) {
    return pending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Pending value)? pending,
    TResult Function(_Processing value)? processing,
    TResult Function(_Completed value)? completed,
    TResult Function(_Failed value)? failed,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Refunded value)? refunded,
    required TResult orElse(),
  }) {
    if (pending != null) {
      return pending(this);
    }
    return orElse();
  }
}

abstract class _Pending extends PaymentStatus {
  const factory _Pending() = _$PendingImpl;
  const _Pending._() : super._();
}

/// @nodoc
abstract class _$$ProcessingImplCopyWith<$Res> {
  factory _$$ProcessingImplCopyWith(
          _$ProcessingImpl value, $Res Function(_$ProcessingImpl) then) =
      __$$ProcessingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProcessingImplCopyWithImpl<$Res>
    extends _$PaymentStatusCopyWithImpl<$Res, _$ProcessingImpl>
    implements _$$ProcessingImplCopyWith<$Res> {
  __$$ProcessingImplCopyWithImpl(
      _$ProcessingImpl _value, $Res Function(_$ProcessingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProcessingImpl extends _Processing {
  const _$ProcessingImpl() : super._();

  @override
  String toString() {
    return 'PaymentStatus.processing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProcessingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() processing,
    required TResult Function() completed,
    required TResult Function() failed,
    required TResult Function() cancelled,
    required TResult Function() refunded,
  }) {
    return processing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? processing,
    TResult? Function()? completed,
    TResult? Function()? failed,
    TResult? Function()? cancelled,
    TResult? Function()? refunded,
  }) {
    return processing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? processing,
    TResult Function()? completed,
    TResult Function()? failed,
    TResult Function()? cancelled,
    TResult Function()? refunded,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Pending value) pending,
    required TResult Function(_Processing value) processing,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Refunded value) refunded,
  }) {
    return processing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Pending value)? pending,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Refunded value)? refunded,
  }) {
    return processing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Pending value)? pending,
    TResult Function(_Processing value)? processing,
    TResult Function(_Completed value)? completed,
    TResult Function(_Failed value)? failed,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Refunded value)? refunded,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(this);
    }
    return orElse();
  }
}

abstract class _Processing extends PaymentStatus {
  const factory _Processing() = _$ProcessingImpl;
  const _Processing._() : super._();
}

/// @nodoc
abstract class _$$CompletedImplCopyWith<$Res> {
  factory _$$CompletedImplCopyWith(
          _$CompletedImpl value, $Res Function(_$CompletedImpl) then) =
      __$$CompletedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CompletedImplCopyWithImpl<$Res>
    extends _$PaymentStatusCopyWithImpl<$Res, _$CompletedImpl>
    implements _$$CompletedImplCopyWith<$Res> {
  __$$CompletedImplCopyWithImpl(
      _$CompletedImpl _value, $Res Function(_$CompletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CompletedImpl extends _Completed {
  const _$CompletedImpl() : super._();

  @override
  String toString() {
    return 'PaymentStatus.completed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CompletedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() processing,
    required TResult Function() completed,
    required TResult Function() failed,
    required TResult Function() cancelled,
    required TResult Function() refunded,
  }) {
    return completed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? processing,
    TResult? Function()? completed,
    TResult? Function()? failed,
    TResult? Function()? cancelled,
    TResult? Function()? refunded,
  }) {
    return completed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? processing,
    TResult Function()? completed,
    TResult Function()? failed,
    TResult Function()? cancelled,
    TResult Function()? refunded,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Pending value) pending,
    required TResult Function(_Processing value) processing,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Refunded value) refunded,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Pending value)? pending,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Refunded value)? refunded,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Pending value)? pending,
    TResult Function(_Processing value)? processing,
    TResult Function(_Completed value)? completed,
    TResult Function(_Failed value)? failed,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Refunded value)? refunded,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class _Completed extends PaymentStatus {
  const factory _Completed() = _$CompletedImpl;
  const _Completed._() : super._();
}

/// @nodoc
abstract class _$$FailedImplCopyWith<$Res> {
  factory _$$FailedImplCopyWith(
          _$FailedImpl value, $Res Function(_$FailedImpl) then) =
      __$$FailedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FailedImplCopyWithImpl<$Res>
    extends _$PaymentStatusCopyWithImpl<$Res, _$FailedImpl>
    implements _$$FailedImplCopyWith<$Res> {
  __$$FailedImplCopyWithImpl(
      _$FailedImpl _value, $Res Function(_$FailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FailedImpl extends _Failed {
  const _$FailedImpl() : super._();

  @override
  String toString() {
    return 'PaymentStatus.failed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FailedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() processing,
    required TResult Function() completed,
    required TResult Function() failed,
    required TResult Function() cancelled,
    required TResult Function() refunded,
  }) {
    return failed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? processing,
    TResult? Function()? completed,
    TResult? Function()? failed,
    TResult? Function()? cancelled,
    TResult? Function()? refunded,
  }) {
    return failed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? processing,
    TResult Function()? completed,
    TResult Function()? failed,
    TResult Function()? cancelled,
    TResult Function()? refunded,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Pending value) pending,
    required TResult Function(_Processing value) processing,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Refunded value) refunded,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Pending value)? pending,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Refunded value)? refunded,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Pending value)? pending,
    TResult Function(_Processing value)? processing,
    TResult Function(_Completed value)? completed,
    TResult Function(_Failed value)? failed,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Refunded value)? refunded,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _Failed extends PaymentStatus {
  const factory _Failed() = _$FailedImpl;
  const _Failed._() : super._();
}

/// @nodoc
abstract class _$$CancelledImplCopyWith<$Res> {
  factory _$$CancelledImplCopyWith(
          _$CancelledImpl value, $Res Function(_$CancelledImpl) then) =
      __$$CancelledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CancelledImplCopyWithImpl<$Res>
    extends _$PaymentStatusCopyWithImpl<$Res, _$CancelledImpl>
    implements _$$CancelledImplCopyWith<$Res> {
  __$$CancelledImplCopyWithImpl(
      _$CancelledImpl _value, $Res Function(_$CancelledImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CancelledImpl extends _Cancelled {
  const _$CancelledImpl() : super._();

  @override
  String toString() {
    return 'PaymentStatus.cancelled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CancelledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() processing,
    required TResult Function() completed,
    required TResult Function() failed,
    required TResult Function() cancelled,
    required TResult Function() refunded,
  }) {
    return cancelled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? processing,
    TResult? Function()? completed,
    TResult? Function()? failed,
    TResult? Function()? cancelled,
    TResult? Function()? refunded,
  }) {
    return cancelled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? processing,
    TResult Function()? completed,
    TResult Function()? failed,
    TResult Function()? cancelled,
    TResult Function()? refunded,
    required TResult orElse(),
  }) {
    if (cancelled != null) {
      return cancelled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Pending value) pending,
    required TResult Function(_Processing value) processing,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Refunded value) refunded,
  }) {
    return cancelled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Pending value)? pending,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Refunded value)? refunded,
  }) {
    return cancelled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Pending value)? pending,
    TResult Function(_Processing value)? processing,
    TResult Function(_Completed value)? completed,
    TResult Function(_Failed value)? failed,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Refunded value)? refunded,
    required TResult orElse(),
  }) {
    if (cancelled != null) {
      return cancelled(this);
    }
    return orElse();
  }
}

abstract class _Cancelled extends PaymentStatus {
  const factory _Cancelled() = _$CancelledImpl;
  const _Cancelled._() : super._();
}

/// @nodoc
abstract class _$$RefundedImplCopyWith<$Res> {
  factory _$$RefundedImplCopyWith(
          _$RefundedImpl value, $Res Function(_$RefundedImpl) then) =
      __$$RefundedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefundedImplCopyWithImpl<$Res>
    extends _$PaymentStatusCopyWithImpl<$Res, _$RefundedImpl>
    implements _$$RefundedImplCopyWith<$Res> {
  __$$RefundedImplCopyWithImpl(
      _$RefundedImpl _value, $Res Function(_$RefundedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefundedImpl extends _Refunded {
  const _$RefundedImpl() : super._();

  @override
  String toString() {
    return 'PaymentStatus.refunded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefundedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pending,
    required TResult Function() processing,
    required TResult Function() completed,
    required TResult Function() failed,
    required TResult Function() cancelled,
    required TResult Function() refunded,
  }) {
    return refunded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pending,
    TResult? Function()? processing,
    TResult? Function()? completed,
    TResult? Function()? failed,
    TResult? Function()? cancelled,
    TResult? Function()? refunded,
  }) {
    return refunded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pending,
    TResult Function()? processing,
    TResult Function()? completed,
    TResult Function()? failed,
    TResult Function()? cancelled,
    TResult Function()? refunded,
    required TResult orElse(),
  }) {
    if (refunded != null) {
      return refunded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Pending value) pending,
    required TResult Function(_Processing value) processing,
    required TResult Function(_Completed value) completed,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Cancelled value) cancelled,
    required TResult Function(_Refunded value) refunded,
  }) {
    return refunded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Pending value)? pending,
    TResult? Function(_Processing value)? processing,
    TResult? Function(_Completed value)? completed,
    TResult? Function(_Failed value)? failed,
    TResult? Function(_Cancelled value)? cancelled,
    TResult? Function(_Refunded value)? refunded,
  }) {
    return refunded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Pending value)? pending,
    TResult Function(_Processing value)? processing,
    TResult Function(_Completed value)? completed,
    TResult Function(_Failed value)? failed,
    TResult Function(_Cancelled value)? cancelled,
    TResult Function(_Refunded value)? refunded,
    required TResult orElse(),
  }) {
    if (refunded != null) {
      return refunded(this);
    }
    return orElse();
  }
}

abstract class _Refunded extends PaymentStatus {
  const factory _Refunded() = _$RefundedImpl;
  const _Refunded._() : super._();
}

/// @nodoc
mixin _$PaymentMethod {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() creditCard,
    required TResult Function() debitCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? creditCard,
    TResult? Function()? debitCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? creditCard,
    TResult Function()? debitCard,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreditCard value) creditCard,
    required TResult Function(_DebitCard value) debitCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreditCard value)? creditCard,
    TResult? Function(_DebitCard value)? debitCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreditCard value)? creditCard,
    TResult Function(_DebitCard value)? debitCard,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentMethodCopyWith<$Res> {
  factory $PaymentMethodCopyWith(
          PaymentMethod value, $Res Function(PaymentMethod) then) =
      _$PaymentMethodCopyWithImpl<$Res, PaymentMethod>;
}

/// @nodoc
class _$PaymentMethodCopyWithImpl<$Res, $Val extends PaymentMethod>
    implements $PaymentMethodCopyWith<$Res> {
  _$PaymentMethodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CreditCardImplCopyWith<$Res> {
  factory _$$CreditCardImplCopyWith(
          _$CreditCardImpl value, $Res Function(_$CreditCardImpl) then) =
      __$$CreditCardImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreditCardImplCopyWithImpl<$Res>
    extends _$PaymentMethodCopyWithImpl<$Res, _$CreditCardImpl>
    implements _$$CreditCardImplCopyWith<$Res> {
  __$$CreditCardImplCopyWithImpl(
      _$CreditCardImpl _value, $Res Function(_$CreditCardImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CreditCardImpl extends _CreditCard {
  const _$CreditCardImpl() : super._();

  @override
  String toString() {
    return 'PaymentMethod.creditCard()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CreditCardImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() creditCard,
    required TResult Function() debitCard,
  }) {
    return creditCard();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? creditCard,
    TResult? Function()? debitCard,
  }) {
    return creditCard?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? creditCard,
    TResult Function()? debitCard,
    required TResult orElse(),
  }) {
    if (creditCard != null) {
      return creditCard();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreditCard value) creditCard,
    required TResult Function(_DebitCard value) debitCard,
  }) {
    return creditCard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreditCard value)? creditCard,
    TResult? Function(_DebitCard value)? debitCard,
  }) {
    return creditCard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreditCard value)? creditCard,
    TResult Function(_DebitCard value)? debitCard,
    required TResult orElse(),
  }) {
    if (creditCard != null) {
      return creditCard(this);
    }
    return orElse();
  }
}

abstract class _CreditCard extends PaymentMethod {
  const factory _CreditCard() = _$CreditCardImpl;
  const _CreditCard._() : super._();
}

/// @nodoc
abstract class _$$DebitCardImplCopyWith<$Res> {
  factory _$$DebitCardImplCopyWith(
          _$DebitCardImpl value, $Res Function(_$DebitCardImpl) then) =
      __$$DebitCardImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DebitCardImplCopyWithImpl<$Res>
    extends _$PaymentMethodCopyWithImpl<$Res, _$DebitCardImpl>
    implements _$$DebitCardImplCopyWith<$Res> {
  __$$DebitCardImplCopyWithImpl(
      _$DebitCardImpl _value, $Res Function(_$DebitCardImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DebitCardImpl extends _DebitCard {
  const _$DebitCardImpl() : super._();

  @override
  String toString() {
    return 'PaymentMethod.debitCard()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DebitCardImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() creditCard,
    required TResult Function() debitCard,
  }) {
    return debitCard();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? creditCard,
    TResult? Function()? debitCard,
  }) {
    return debitCard?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? creditCard,
    TResult Function()? debitCard,
    required TResult orElse(),
  }) {
    if (debitCard != null) {
      return debitCard();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CreditCard value) creditCard,
    required TResult Function(_DebitCard value) debitCard,
  }) {
    return debitCard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CreditCard value)? creditCard,
    TResult? Function(_DebitCard value)? debitCard,
  }) {
    return debitCard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreditCard value)? creditCard,
    TResult Function(_DebitCard value)? debitCard,
    required TResult orElse(),
  }) {
    if (debitCard != null) {
      return debitCard(this);
    }
    return orElse();
  }
}

abstract class _DebitCard extends PaymentMethod {
  const factory _DebitCard() = _$DebitCardImpl;
  const _DebitCard._() : super._();
}

PaymentRequest _$PaymentRequestFromJson(Map<String, dynamic> json) {
  return _PaymentRequest.fromJson(json);
}

/// @nodoc
mixin _$PaymentRequest {
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
  PaymentMethod get method => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  bool get simulate => throw _privateConstructorUsedError;

  /// Serializes this PaymentRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentRequestCopyWith<PaymentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentRequestCopyWith<$Res> {
  factory $PaymentRequestCopyWith(
          PaymentRequest value, $Res Function(PaymentRequest) then) =
      _$PaymentRequestCopyWithImpl<$Res, PaymentRequest>;
  @useResult
  $Res call(
      {double amount,
      String currency,
      @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
      PaymentMethod method,
      String? description,
      Map<String, dynamic>? metadata,
      bool simulate});

  $PaymentMethodCopyWith<$Res> get method;
}

/// @nodoc
class _$PaymentRequestCopyWithImpl<$Res, $Val extends PaymentRequest>
    implements $PaymentRequestCopyWith<$Res> {
  _$PaymentRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? currency = null,
    Object? method = null,
    Object? description = freezed,
    Object? metadata = freezed,
    Object? simulate = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      simulate: null == simulate
          ? _value.simulate
          : simulate // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of PaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentMethodCopyWith<$Res> get method {
    return $PaymentMethodCopyWith<$Res>(_value.method, (value) {
      return _then(_value.copyWith(method: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PaymentRequestImplCopyWith<$Res>
    implements $PaymentRequestCopyWith<$Res> {
  factory _$$PaymentRequestImplCopyWith(_$PaymentRequestImpl value,
          $Res Function(_$PaymentRequestImpl) then) =
      __$$PaymentRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double amount,
      String currency,
      @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
      PaymentMethod method,
      String? description,
      Map<String, dynamic>? metadata,
      bool simulate});

  @override
  $PaymentMethodCopyWith<$Res> get method;
}

/// @nodoc
class __$$PaymentRequestImplCopyWithImpl<$Res>
    extends _$PaymentRequestCopyWithImpl<$Res, _$PaymentRequestImpl>
    implements _$$PaymentRequestImplCopyWith<$Res> {
  __$$PaymentRequestImplCopyWithImpl(
      _$PaymentRequestImpl _value, $Res Function(_$PaymentRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? currency = null,
    Object? method = null,
    Object? description = freezed,
    Object? metadata = freezed,
    Object? simulate = null,
  }) {
    return _then(_$PaymentRequestImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      simulate: null == simulate
          ? _value.simulate
          : simulate // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentRequestImpl implements _PaymentRequest {
  const _$PaymentRequestImpl(
      {required this.amount,
      required this.currency,
      @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
      required this.method,
      this.description,
      final Map<String, dynamic>? metadata,
      this.simulate = true})
      : _metadata = metadata;

  factory _$PaymentRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentRequestImplFromJson(json);

  @override
  final double amount;
  @override
  final String currency;
  @override
  @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
  final PaymentMethod method;
  @override
  final String? description;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final bool simulate;

  @override
  String toString() {
    return 'PaymentRequest(amount: $amount, currency: $currency, method: $method, description: $description, metadata: $metadata, simulate: $simulate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentRequestImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.simulate, simulate) ||
                other.simulate == simulate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, currency, method,
      description, const DeepCollectionEquality().hash(_metadata), simulate);

  /// Create a copy of PaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentRequestImplCopyWith<_$PaymentRequestImpl> get copyWith =>
      __$$PaymentRequestImplCopyWithImpl<_$PaymentRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentRequestImplToJson(
      this,
    );
  }
}

abstract class _PaymentRequest implements PaymentRequest {
  const factory _PaymentRequest(
      {required final double amount,
      required final String currency,
      @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
      required final PaymentMethod method,
      final String? description,
      final Map<String, dynamic>? metadata,
      final bool simulate}) = _$PaymentRequestImpl;

  factory _PaymentRequest.fromJson(Map<String, dynamic> json) =
      _$PaymentRequestImpl.fromJson;

  @override
  double get amount;
  @override
  String get currency;
  @override
  @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
  PaymentMethod get method;
  @override
  String? get description;
  @override
  Map<String, dynamic>? get metadata;
  @override
  bool get simulate;

  /// Create a copy of PaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentRequestImplCopyWith<_$PaymentRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentResponse _$PaymentResponseFromJson(Map<String, dynamic> json) {
  return _PaymentResponse.fromJson(json);
}

/// @nodoc
mixin _$PaymentResponse {
  String get id => throw _privateConstructorUsedError;
  String get orderId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  PaymentStatus get status => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
  PaymentMethod get method => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  String? get referenceNumber => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get errorCode => throw _privateConstructorUsedError;

  /// Serializes this PaymentResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentResponseCopyWith<PaymentResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentResponseCopyWith<$Res> {
  factory $PaymentResponseCopyWith(
          PaymentResponse value, $Res Function(PaymentResponse) then) =
      _$PaymentResponseCopyWithImpl<$Res, PaymentResponse>;
  @useResult
  $Res call(
      {String id,
      String orderId,
      double amount,
      String currency,
      @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
      PaymentStatus status,
      @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
      PaymentMethod method,
      String? transactionId,
      String? referenceNumber,
      String? description,
      Map<String, dynamic>? metadata,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? errorMessage,
      String? errorCode});

  $PaymentStatusCopyWith<$Res> get status;
  $PaymentMethodCopyWith<$Res> get method;
}

/// @nodoc
class _$PaymentResponseCopyWithImpl<$Res, $Val extends PaymentResponse>
    implements $PaymentResponseCopyWith<$Res> {
  _$PaymentResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? method = null,
    Object? transactionId = freezed,
    Object? referenceNumber = freezed,
    Object? description = freezed,
    Object? metadata = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? errorMessage = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceNumber: freezed == referenceNumber
          ? _value.referenceNumber
          : referenceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of PaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentStatusCopyWith<$Res> get status {
    return $PaymentStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  /// Create a copy of PaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentMethodCopyWith<$Res> get method {
    return $PaymentMethodCopyWith<$Res>(_value.method, (value) {
      return _then(_value.copyWith(method: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PaymentResponseImplCopyWith<$Res>
    implements $PaymentResponseCopyWith<$Res> {
  factory _$$PaymentResponseImplCopyWith(_$PaymentResponseImpl value,
          $Res Function(_$PaymentResponseImpl) then) =
      __$$PaymentResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String orderId,
      double amount,
      String currency,
      @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
      PaymentStatus status,
      @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
      PaymentMethod method,
      String? transactionId,
      String? referenceNumber,
      String? description,
      Map<String, dynamic>? metadata,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? errorMessage,
      String? errorCode});

  @override
  $PaymentStatusCopyWith<$Res> get status;
  @override
  $PaymentMethodCopyWith<$Res> get method;
}

/// @nodoc
class __$$PaymentResponseImplCopyWithImpl<$Res>
    extends _$PaymentResponseCopyWithImpl<$Res, _$PaymentResponseImpl>
    implements _$$PaymentResponseImplCopyWith<$Res> {
  __$$PaymentResponseImplCopyWithImpl(
      _$PaymentResponseImpl _value, $Res Function(_$PaymentResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? method = null,
    Object? transactionId = freezed,
    Object? referenceNumber = freezed,
    Object? description = freezed,
    Object? metadata = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? errorMessage = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(_$PaymentResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceNumber: freezed == referenceNumber
          ? _value.referenceNumber
          : referenceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentResponseImpl implements _PaymentResponse {
  const _$PaymentResponseImpl(
      {required this.id,
      required this.orderId,
      required this.amount,
      required this.currency,
      @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
      required this.status,
      @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
      required this.method,
      this.transactionId,
      this.referenceNumber,
      this.description,
      final Map<String, dynamic>? metadata,
      this.createdAt,
      this.updatedAt,
      this.errorMessage,
      this.errorCode})
      : _metadata = metadata;

  factory _$PaymentResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String orderId;
  @override
  final double amount;
  @override
  final String currency;
  @override
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  final PaymentStatus status;
  @override
  @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
  final PaymentMethod method;
  @override
  final String? transactionId;
  @override
  final String? referenceNumber;
  @override
  final String? description;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? errorMessage;
  @override
  final String? errorCode;

  @override
  String toString() {
    return 'PaymentResponse(id: $id, orderId: $orderId, amount: $amount, currency: $currency, status: $status, method: $method, transactionId: $transactionId, referenceNumber: $referenceNumber, description: $description, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt, errorMessage: $errorMessage, errorCode: $errorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.referenceNumber, referenceNumber) ||
                other.referenceNumber == referenceNumber) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      orderId,
      amount,
      currency,
      status,
      method,
      transactionId,
      referenceNumber,
      description,
      const DeepCollectionEquality().hash(_metadata),
      createdAt,
      updatedAt,
      errorMessage,
      errorCode);

  /// Create a copy of PaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentResponseImplCopyWith<_$PaymentResponseImpl> get copyWith =>
      __$$PaymentResponseImplCopyWithImpl<_$PaymentResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentResponseImplToJson(
      this,
    );
  }
}

abstract class _PaymentResponse implements PaymentResponse {
  const factory _PaymentResponse(
      {required final String id,
      required final String orderId,
      required final double amount,
      required final String currency,
      @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
      required final PaymentStatus status,
      @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
      required final PaymentMethod method,
      final String? transactionId,
      final String? referenceNumber,
      final String? description,
      final Map<String, dynamic>? metadata,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final String? errorMessage,
      final String? errorCode}) = _$PaymentResponseImpl;

  factory _PaymentResponse.fromJson(Map<String, dynamic> json) =
      _$PaymentResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get orderId;
  @override
  double get amount;
  @override
  String get currency;
  @override
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  PaymentStatus get status;
  @override
  @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
  PaymentMethod get method;
  @override
  String? get transactionId;
  @override
  String? get referenceNumber;
  @override
  String? get description;
  @override
  Map<String, dynamic>? get metadata;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String? get errorMessage;
  @override
  String? get errorCode;

  /// Create a copy of PaymentResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentResponseImplCopyWith<_$PaymentResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MockPaymentResult _$MockPaymentResultFromJson(Map<String, dynamic> json) {
  return _MockPaymentResult.fromJson(json);
}

/// @nodoc
mixin _$MockPaymentResult {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  String? get referenceNumber => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _nullableStatusFromJson, toJson: _nullableStatusToJson)
  PaymentStatus? get status => throw _privateConstructorUsedError;
  String? get errorCode => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Serializes this MockPaymentResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MockPaymentResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MockPaymentResultCopyWith<MockPaymentResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MockPaymentResultCopyWith<$Res> {
  factory $MockPaymentResultCopyWith(
          MockPaymentResult value, $Res Function(MockPaymentResult) then) =
      _$MockPaymentResultCopyWithImpl<$Res, MockPaymentResult>;
  @useResult
  $Res call(
      {bool success,
      String message,
      String? transactionId,
      String? referenceNumber,
      @JsonKey(fromJson: _nullableStatusFromJson, toJson: _nullableStatusToJson)
      PaymentStatus? status,
      String? errorCode,
      String? errorMessage});

  $PaymentStatusCopyWith<$Res>? get status;
}

/// @nodoc
class _$MockPaymentResultCopyWithImpl<$Res, $Val extends MockPaymentResult>
    implements $MockPaymentResultCopyWith<$Res> {
  _$MockPaymentResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MockPaymentResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? transactionId = freezed,
    Object? referenceNumber = freezed,
    Object? status = freezed,
    Object? errorCode = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceNumber: freezed == referenceNumber
          ? _value.referenceNumber
          : referenceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus?,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of MockPaymentResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentStatusCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $PaymentStatusCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MockPaymentResultImplCopyWith<$Res>
    implements $MockPaymentResultCopyWith<$Res> {
  factory _$$MockPaymentResultImplCopyWith(_$MockPaymentResultImpl value,
          $Res Function(_$MockPaymentResultImpl) then) =
      __$$MockPaymentResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String message,
      String? transactionId,
      String? referenceNumber,
      @JsonKey(fromJson: _nullableStatusFromJson, toJson: _nullableStatusToJson)
      PaymentStatus? status,
      String? errorCode,
      String? errorMessage});

  @override
  $PaymentStatusCopyWith<$Res>? get status;
}

/// @nodoc
class __$$MockPaymentResultImplCopyWithImpl<$Res>
    extends _$MockPaymentResultCopyWithImpl<$Res, _$MockPaymentResultImpl>
    implements _$$MockPaymentResultImplCopyWith<$Res> {
  __$$MockPaymentResultImplCopyWithImpl(_$MockPaymentResultImpl _value,
      $Res Function(_$MockPaymentResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of MockPaymentResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? transactionId = freezed,
    Object? referenceNumber = freezed,
    Object? status = freezed,
    Object? errorCode = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$MockPaymentResultImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceNumber: freezed == referenceNumber
          ? _value.referenceNumber
          : referenceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus?,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MockPaymentResultImpl implements _MockPaymentResult {
  const _$MockPaymentResultImpl(
      {required this.success,
      required this.message,
      this.transactionId,
      this.referenceNumber,
      @JsonKey(fromJson: _nullableStatusFromJson, toJson: _nullableStatusToJson)
      this.status,
      this.errorCode,
      this.errorMessage});

  factory _$MockPaymentResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$MockPaymentResultImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final String? transactionId;
  @override
  final String? referenceNumber;
  @override
  @JsonKey(fromJson: _nullableStatusFromJson, toJson: _nullableStatusToJson)
  final PaymentStatus? status;
  @override
  final String? errorCode;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'MockPaymentResult(success: $success, message: $message, transactionId: $transactionId, referenceNumber: $referenceNumber, status: $status, errorCode: $errorCode, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MockPaymentResultImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.referenceNumber, referenceNumber) ||
                other.referenceNumber == referenceNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, transactionId,
      referenceNumber, status, errorCode, errorMessage);

  /// Create a copy of MockPaymentResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MockPaymentResultImplCopyWith<_$MockPaymentResultImpl> get copyWith =>
      __$$MockPaymentResultImplCopyWithImpl<_$MockPaymentResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MockPaymentResultImplToJson(
      this,
    );
  }
}

abstract class _MockPaymentResult implements MockPaymentResult {
  const factory _MockPaymentResult(
      {required final bool success,
      required final String message,
      final String? transactionId,
      final String? referenceNumber,
      @JsonKey(fromJson: _nullableStatusFromJson, toJson: _nullableStatusToJson)
      final PaymentStatus? status,
      final String? errorCode,
      final String? errorMessage}) = _$MockPaymentResultImpl;

  factory _MockPaymentResult.fromJson(Map<String, dynamic> json) =
      _$MockPaymentResultImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  String? get transactionId;
  @override
  String? get referenceNumber;
  @override
  @JsonKey(fromJson: _nullableStatusFromJson, toJson: _nullableStatusToJson)
  PaymentStatus? get status;
  @override
  String? get errorCode;
  @override
  String? get errorMessage;

  /// Create a copy of MockPaymentResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MockPaymentResultImplCopyWith<_$MockPaymentResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentSummary _$PaymentSummaryFromJson(Map<String, dynamic> json) {
  return _PaymentSummary.fromJson(json);
}

/// @nodoc
mixin _$PaymentSummary {
  double get subtotal => throw _privateConstructorUsedError;
  double get shipping => throw _privateConstructorUsedError;
  double get tax => throw _privateConstructorUsedError;
  double get discount => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String? get couponCode => throw _privateConstructorUsedError;
  double? get couponDiscount => throw _privateConstructorUsedError;

  /// Serializes this PaymentSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentSummaryCopyWith<PaymentSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentSummaryCopyWith<$Res> {
  factory $PaymentSummaryCopyWith(
          PaymentSummary value, $Res Function(PaymentSummary) then) =
      _$PaymentSummaryCopyWithImpl<$Res, PaymentSummary>;
  @useResult
  $Res call(
      {double subtotal,
      double shipping,
      double tax,
      double discount,
      double total,
      String currency,
      String? couponCode,
      double? couponDiscount});
}

/// @nodoc
class _$PaymentSummaryCopyWithImpl<$Res, $Val extends PaymentSummary>
    implements $PaymentSummaryCopyWith<$Res> {
  _$PaymentSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subtotal = null,
    Object? shipping = null,
    Object? tax = null,
    Object? discount = null,
    Object? total = null,
    Object? currency = null,
    Object? couponCode = freezed,
    Object? couponDiscount = freezed,
  }) {
    return _then(_value.copyWith(
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      shipping: null == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as double,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      couponCode: freezed == couponCode
          ? _value.couponCode
          : couponCode // ignore: cast_nullable_to_non_nullable
              as String?,
      couponDiscount: freezed == couponDiscount
          ? _value.couponDiscount
          : couponDiscount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentSummaryImplCopyWith<$Res>
    implements $PaymentSummaryCopyWith<$Res> {
  factory _$$PaymentSummaryImplCopyWith(_$PaymentSummaryImpl value,
          $Res Function(_$PaymentSummaryImpl) then) =
      __$$PaymentSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double subtotal,
      double shipping,
      double tax,
      double discount,
      double total,
      String currency,
      String? couponCode,
      double? couponDiscount});
}

/// @nodoc
class __$$PaymentSummaryImplCopyWithImpl<$Res>
    extends _$PaymentSummaryCopyWithImpl<$Res, _$PaymentSummaryImpl>
    implements _$$PaymentSummaryImplCopyWith<$Res> {
  __$$PaymentSummaryImplCopyWithImpl(
      _$PaymentSummaryImpl _value, $Res Function(_$PaymentSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subtotal = null,
    Object? shipping = null,
    Object? tax = null,
    Object? discount = null,
    Object? total = null,
    Object? currency = null,
    Object? couponCode = freezed,
    Object? couponDiscount = freezed,
  }) {
    return _then(_$PaymentSummaryImpl(
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      shipping: null == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as double,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      couponCode: freezed == couponCode
          ? _value.couponCode
          : couponCode // ignore: cast_nullable_to_non_nullable
              as String?,
      couponDiscount: freezed == couponDiscount
          ? _value.couponDiscount
          : couponDiscount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentSummaryImpl implements _PaymentSummary {
  const _$PaymentSummaryImpl(
      {required this.subtotal,
      required this.shipping,
      required this.tax,
      required this.discount,
      required this.total,
      required this.currency,
      this.couponCode,
      this.couponDiscount});

  factory _$PaymentSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentSummaryImplFromJson(json);

  @override
  final double subtotal;
  @override
  final double shipping;
  @override
  final double tax;
  @override
  final double discount;
  @override
  final double total;
  @override
  final String currency;
  @override
  final String? couponCode;
  @override
  final double? couponDiscount;

  @override
  String toString() {
    return 'PaymentSummary(subtotal: $subtotal, shipping: $shipping, tax: $tax, discount: $discount, total: $total, currency: $currency, couponCode: $couponCode, couponDiscount: $couponDiscount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentSummaryImpl &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.shipping, shipping) ||
                other.shipping == shipping) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.couponCode, couponCode) ||
                other.couponCode == couponCode) &&
            (identical(other.couponDiscount, couponDiscount) ||
                other.couponDiscount == couponDiscount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, subtotal, shipping, tax,
      discount, total, currency, couponCode, couponDiscount);

  /// Create a copy of PaymentSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentSummaryImplCopyWith<_$PaymentSummaryImpl> get copyWith =>
      __$$PaymentSummaryImplCopyWithImpl<_$PaymentSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentSummaryImplToJson(
      this,
    );
  }
}

abstract class _PaymentSummary implements PaymentSummary {
  const factory _PaymentSummary(
      {required final double subtotal,
      required final double shipping,
      required final double tax,
      required final double discount,
      required final double total,
      required final String currency,
      final String? couponCode,
      final double? couponDiscount}) = _$PaymentSummaryImpl;

  factory _PaymentSummary.fromJson(Map<String, dynamic> json) =
      _$PaymentSummaryImpl.fromJson;

  @override
  double get subtotal;
  @override
  double get shipping;
  @override
  double get tax;
  @override
  double get discount;
  @override
  double get total;
  @override
  String get currency;
  @override
  String? get couponCode;
  @override
  double? get couponDiscount;

  /// Create a copy of PaymentSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentSummaryImplCopyWith<_$PaymentSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentHistory _$PaymentHistoryFromJson(Map<String, dynamic> json) {
  return _PaymentHistory.fromJson(json);
}

/// @nodoc
mixin _$PaymentHistory {
  String get id => throw _privateConstructorUsedError;
  String get orderId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  PaymentStatus get status => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
  PaymentMethod get method => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;

  /// Serializes this PaymentHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentHistoryCopyWith<PaymentHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentHistoryCopyWith<$Res> {
  factory $PaymentHistoryCopyWith(
          PaymentHistory value, $Res Function(PaymentHistory) then) =
      _$PaymentHistoryCopyWithImpl<$Res, PaymentHistory>;
  @useResult
  $Res call(
      {String id,
      String orderId,
      double amount,
      String currency,
      @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
      PaymentStatus status,
      @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
      PaymentMethod method,
      String? description,
      DateTime? createdAt,
      String? transactionId});

  $PaymentStatusCopyWith<$Res> get status;
  $PaymentMethodCopyWith<$Res> get method;
}

/// @nodoc
class _$PaymentHistoryCopyWithImpl<$Res, $Val extends PaymentHistory>
    implements $PaymentHistoryCopyWith<$Res> {
  _$PaymentHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? method = null,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? transactionId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentStatusCopyWith<$Res> get status {
    return $PaymentStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentMethodCopyWith<$Res> get method {
    return $PaymentMethodCopyWith<$Res>(_value.method, (value) {
      return _then(_value.copyWith(method: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PaymentHistoryImplCopyWith<$Res>
    implements $PaymentHistoryCopyWith<$Res> {
  factory _$$PaymentHistoryImplCopyWith(_$PaymentHistoryImpl value,
          $Res Function(_$PaymentHistoryImpl) then) =
      __$$PaymentHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String orderId,
      double amount,
      String currency,
      @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
      PaymentStatus status,
      @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
      PaymentMethod method,
      String? description,
      DateTime? createdAt,
      String? transactionId});

  @override
  $PaymentStatusCopyWith<$Res> get status;
  @override
  $PaymentMethodCopyWith<$Res> get method;
}

/// @nodoc
class __$$PaymentHistoryImplCopyWithImpl<$Res>
    extends _$PaymentHistoryCopyWithImpl<$Res, _$PaymentHistoryImpl>
    implements _$$PaymentHistoryImplCopyWith<$Res> {
  __$$PaymentHistoryImplCopyWithImpl(
      _$PaymentHistoryImpl _value, $Res Function(_$PaymentHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? method = null,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? transactionId = freezed,
  }) {
    return _then(_$PaymentHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentHistoryImpl implements _PaymentHistory {
  const _$PaymentHistoryImpl(
      {required this.id,
      required this.orderId,
      required this.amount,
      required this.currency,
      @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
      required this.status,
      @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
      required this.method,
      this.description,
      this.createdAt,
      this.transactionId});

  factory _$PaymentHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentHistoryImplFromJson(json);

  @override
  final String id;
  @override
  final String orderId;
  @override
  final double amount;
  @override
  final String currency;
  @override
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  final PaymentStatus status;
  @override
  @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
  final PaymentMethod method;
  @override
  final String? description;
  @override
  final DateTime? createdAt;
  @override
  final String? transactionId;

  @override
  String toString() {
    return 'PaymentHistory(id: $id, orderId: $orderId, amount: $amount, currency: $currency, status: $status, method: $method, description: $description, createdAt: $createdAt, transactionId: $transactionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, orderId, amount, currency,
      status, method, description, createdAt, transactionId);

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentHistoryImplCopyWith<_$PaymentHistoryImpl> get copyWith =>
      __$$PaymentHistoryImplCopyWithImpl<_$PaymentHistoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentHistoryImplToJson(
      this,
    );
  }
}

abstract class _PaymentHistory implements PaymentHistory {
  const factory _PaymentHistory(
      {required final String id,
      required final String orderId,
      required final double amount,
      required final String currency,
      @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
      required final PaymentStatus status,
      @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
      required final PaymentMethod method,
      final String? description,
      final DateTime? createdAt,
      final String? transactionId}) = _$PaymentHistoryImpl;

  factory _PaymentHistory.fromJson(Map<String, dynamic> json) =
      _$PaymentHistoryImpl.fromJson;

  @override
  String get id;
  @override
  String get orderId;
  @override
  double get amount;
  @override
  String get currency;
  @override
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  PaymentStatus get status;
  @override
  @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
  PaymentMethod get method;
  @override
  String? get description;
  @override
  DateTime? get createdAt;
  @override
  String? get transactionId;

  /// Create a copy of PaymentHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentHistoryImplCopyWith<_$PaymentHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
