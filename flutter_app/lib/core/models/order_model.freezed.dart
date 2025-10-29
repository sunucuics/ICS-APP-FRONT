// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() preparing,
    required TResult Function() shipped,
    required TResult Function() delivered,
    required TResult Function() canceled,
    required TResult Function() paymentFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? preparing,
    TResult? Function()? shipped,
    TResult? Function()? delivered,
    TResult? Function()? canceled,
    TResult? Function()? paymentFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? preparing,
    TResult Function()? shipped,
    TResult Function()? delivered,
    TResult Function()? canceled,
    TResult Function()? paymentFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Preparing value) preparing,
    required TResult Function(_Shipped value) shipped,
    required TResult Function(_Delivered value) delivered,
    required TResult Function(_Canceled value) canceled,
    required TResult Function(_PaymentFailed value) paymentFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Preparing value)? preparing,
    TResult? Function(_Shipped value)? shipped,
    TResult? Function(_Delivered value)? delivered,
    TResult? Function(_Canceled value)? canceled,
    TResult? Function(_PaymentFailed value)? paymentFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Preparing value)? preparing,
    TResult Function(_Shipped value)? shipped,
    TResult Function(_Delivered value)? delivered,
    TResult Function(_Canceled value)? canceled,
    TResult Function(_PaymentFailed value)? paymentFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusCopyWith<$Res> {
  factory $OrderStatusCopyWith(
          OrderStatus value, $Res Function(OrderStatus) then) =
      _$OrderStatusCopyWithImpl<$Res, OrderStatus>;
}

/// @nodoc
class _$OrderStatusCopyWithImpl<$Res, $Val extends OrderStatus>
    implements $OrderStatusCopyWith<$Res> {
  _$OrderStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PreparingImplCopyWith<$Res> {
  factory _$$PreparingImplCopyWith(
          _$PreparingImpl value, $Res Function(_$PreparingImpl) then) =
      __$$PreparingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PreparingImplCopyWithImpl<$Res>
    extends _$OrderStatusCopyWithImpl<$Res, _$PreparingImpl>
    implements _$$PreparingImplCopyWith<$Res> {
  __$$PreparingImplCopyWithImpl(
      _$PreparingImpl _value, $Res Function(_$PreparingImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PreparingImpl extends _Preparing {
  const _$PreparingImpl() : super._();

  @override
  String toString() {
    return 'OrderStatus.preparing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PreparingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() preparing,
    required TResult Function() shipped,
    required TResult Function() delivered,
    required TResult Function() canceled,
    required TResult Function() paymentFailed,
  }) {
    return preparing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? preparing,
    TResult? Function()? shipped,
    TResult? Function()? delivered,
    TResult? Function()? canceled,
    TResult? Function()? paymentFailed,
  }) {
    return preparing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? preparing,
    TResult Function()? shipped,
    TResult Function()? delivered,
    TResult Function()? canceled,
    TResult Function()? paymentFailed,
    required TResult orElse(),
  }) {
    if (preparing != null) {
      return preparing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Preparing value) preparing,
    required TResult Function(_Shipped value) shipped,
    required TResult Function(_Delivered value) delivered,
    required TResult Function(_Canceled value) canceled,
    required TResult Function(_PaymentFailed value) paymentFailed,
  }) {
    return preparing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Preparing value)? preparing,
    TResult? Function(_Shipped value)? shipped,
    TResult? Function(_Delivered value)? delivered,
    TResult? Function(_Canceled value)? canceled,
    TResult? Function(_PaymentFailed value)? paymentFailed,
  }) {
    return preparing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Preparing value)? preparing,
    TResult Function(_Shipped value)? shipped,
    TResult Function(_Delivered value)? delivered,
    TResult Function(_Canceled value)? canceled,
    TResult Function(_PaymentFailed value)? paymentFailed,
    required TResult orElse(),
  }) {
    if (preparing != null) {
      return preparing(this);
    }
    return orElse();
  }
}

abstract class _Preparing extends OrderStatus {
  const factory _Preparing() = _$PreparingImpl;
  const _Preparing._() : super._();
}

/// @nodoc
abstract class _$$ShippedImplCopyWith<$Res> {
  factory _$$ShippedImplCopyWith(
          _$ShippedImpl value, $Res Function(_$ShippedImpl) then) =
      __$$ShippedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShippedImplCopyWithImpl<$Res>
    extends _$OrderStatusCopyWithImpl<$Res, _$ShippedImpl>
    implements _$$ShippedImplCopyWith<$Res> {
  __$$ShippedImplCopyWithImpl(
      _$ShippedImpl _value, $Res Function(_$ShippedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ShippedImpl extends _Shipped {
  const _$ShippedImpl() : super._();

  @override
  String toString() {
    return 'OrderStatus.shipped()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ShippedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() preparing,
    required TResult Function() shipped,
    required TResult Function() delivered,
    required TResult Function() canceled,
    required TResult Function() paymentFailed,
  }) {
    return shipped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? preparing,
    TResult? Function()? shipped,
    TResult? Function()? delivered,
    TResult? Function()? canceled,
    TResult? Function()? paymentFailed,
  }) {
    return shipped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? preparing,
    TResult Function()? shipped,
    TResult Function()? delivered,
    TResult Function()? canceled,
    TResult Function()? paymentFailed,
    required TResult orElse(),
  }) {
    if (shipped != null) {
      return shipped();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Preparing value) preparing,
    required TResult Function(_Shipped value) shipped,
    required TResult Function(_Delivered value) delivered,
    required TResult Function(_Canceled value) canceled,
    required TResult Function(_PaymentFailed value) paymentFailed,
  }) {
    return shipped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Preparing value)? preparing,
    TResult? Function(_Shipped value)? shipped,
    TResult? Function(_Delivered value)? delivered,
    TResult? Function(_Canceled value)? canceled,
    TResult? Function(_PaymentFailed value)? paymentFailed,
  }) {
    return shipped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Preparing value)? preparing,
    TResult Function(_Shipped value)? shipped,
    TResult Function(_Delivered value)? delivered,
    TResult Function(_Canceled value)? canceled,
    TResult Function(_PaymentFailed value)? paymentFailed,
    required TResult orElse(),
  }) {
    if (shipped != null) {
      return shipped(this);
    }
    return orElse();
  }
}

abstract class _Shipped extends OrderStatus {
  const factory _Shipped() = _$ShippedImpl;
  const _Shipped._() : super._();
}

/// @nodoc
abstract class _$$DeliveredImplCopyWith<$Res> {
  factory _$$DeliveredImplCopyWith(
          _$DeliveredImpl value, $Res Function(_$DeliveredImpl) then) =
      __$$DeliveredImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeliveredImplCopyWithImpl<$Res>
    extends _$OrderStatusCopyWithImpl<$Res, _$DeliveredImpl>
    implements _$$DeliveredImplCopyWith<$Res> {
  __$$DeliveredImplCopyWithImpl(
      _$DeliveredImpl _value, $Res Function(_$DeliveredImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DeliveredImpl extends _Delivered {
  const _$DeliveredImpl() : super._();

  @override
  String toString() {
    return 'OrderStatus.delivered()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DeliveredImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() preparing,
    required TResult Function() shipped,
    required TResult Function() delivered,
    required TResult Function() canceled,
    required TResult Function() paymentFailed,
  }) {
    return delivered();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? preparing,
    TResult? Function()? shipped,
    TResult? Function()? delivered,
    TResult? Function()? canceled,
    TResult? Function()? paymentFailed,
  }) {
    return delivered?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? preparing,
    TResult Function()? shipped,
    TResult Function()? delivered,
    TResult Function()? canceled,
    TResult Function()? paymentFailed,
    required TResult orElse(),
  }) {
    if (delivered != null) {
      return delivered();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Preparing value) preparing,
    required TResult Function(_Shipped value) shipped,
    required TResult Function(_Delivered value) delivered,
    required TResult Function(_Canceled value) canceled,
    required TResult Function(_PaymentFailed value) paymentFailed,
  }) {
    return delivered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Preparing value)? preparing,
    TResult? Function(_Shipped value)? shipped,
    TResult? Function(_Delivered value)? delivered,
    TResult? Function(_Canceled value)? canceled,
    TResult? Function(_PaymentFailed value)? paymentFailed,
  }) {
    return delivered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Preparing value)? preparing,
    TResult Function(_Shipped value)? shipped,
    TResult Function(_Delivered value)? delivered,
    TResult Function(_Canceled value)? canceled,
    TResult Function(_PaymentFailed value)? paymentFailed,
    required TResult orElse(),
  }) {
    if (delivered != null) {
      return delivered(this);
    }
    return orElse();
  }
}

abstract class _Delivered extends OrderStatus {
  const factory _Delivered() = _$DeliveredImpl;
  const _Delivered._() : super._();
}

/// @nodoc
abstract class _$$CanceledImplCopyWith<$Res> {
  factory _$$CanceledImplCopyWith(
          _$CanceledImpl value, $Res Function(_$CanceledImpl) then) =
      __$$CanceledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CanceledImplCopyWithImpl<$Res>
    extends _$OrderStatusCopyWithImpl<$Res, _$CanceledImpl>
    implements _$$CanceledImplCopyWith<$Res> {
  __$$CanceledImplCopyWithImpl(
      _$CanceledImpl _value, $Res Function(_$CanceledImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CanceledImpl extends _Canceled {
  const _$CanceledImpl() : super._();

  @override
  String toString() {
    return 'OrderStatus.canceled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CanceledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() preparing,
    required TResult Function() shipped,
    required TResult Function() delivered,
    required TResult Function() canceled,
    required TResult Function() paymentFailed,
  }) {
    return canceled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? preparing,
    TResult? Function()? shipped,
    TResult? Function()? delivered,
    TResult? Function()? canceled,
    TResult? Function()? paymentFailed,
  }) {
    return canceled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? preparing,
    TResult Function()? shipped,
    TResult Function()? delivered,
    TResult Function()? canceled,
    TResult Function()? paymentFailed,
    required TResult orElse(),
  }) {
    if (canceled != null) {
      return canceled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Preparing value) preparing,
    required TResult Function(_Shipped value) shipped,
    required TResult Function(_Delivered value) delivered,
    required TResult Function(_Canceled value) canceled,
    required TResult Function(_PaymentFailed value) paymentFailed,
  }) {
    return canceled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Preparing value)? preparing,
    TResult? Function(_Shipped value)? shipped,
    TResult? Function(_Delivered value)? delivered,
    TResult? Function(_Canceled value)? canceled,
    TResult? Function(_PaymentFailed value)? paymentFailed,
  }) {
    return canceled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Preparing value)? preparing,
    TResult Function(_Shipped value)? shipped,
    TResult Function(_Delivered value)? delivered,
    TResult Function(_Canceled value)? canceled,
    TResult Function(_PaymentFailed value)? paymentFailed,
    required TResult orElse(),
  }) {
    if (canceled != null) {
      return canceled(this);
    }
    return orElse();
  }
}

abstract class _Canceled extends OrderStatus {
  const factory _Canceled() = _$CanceledImpl;
  const _Canceled._() : super._();
}

/// @nodoc
abstract class _$$PaymentFailedImplCopyWith<$Res> {
  factory _$$PaymentFailedImplCopyWith(
          _$PaymentFailedImpl value, $Res Function(_$PaymentFailedImpl) then) =
      __$$PaymentFailedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PaymentFailedImplCopyWithImpl<$Res>
    extends _$OrderStatusCopyWithImpl<$Res, _$PaymentFailedImpl>
    implements _$$PaymentFailedImplCopyWith<$Res> {
  __$$PaymentFailedImplCopyWithImpl(
      _$PaymentFailedImpl _value, $Res Function(_$PaymentFailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PaymentFailedImpl extends _PaymentFailed {
  const _$PaymentFailedImpl() : super._();

  @override
  String toString() {
    return 'OrderStatus.paymentFailed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PaymentFailedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() preparing,
    required TResult Function() shipped,
    required TResult Function() delivered,
    required TResult Function() canceled,
    required TResult Function() paymentFailed,
  }) {
    return paymentFailed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? preparing,
    TResult? Function()? shipped,
    TResult? Function()? delivered,
    TResult? Function()? canceled,
    TResult? Function()? paymentFailed,
  }) {
    return paymentFailed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? preparing,
    TResult Function()? shipped,
    TResult Function()? delivered,
    TResult Function()? canceled,
    TResult Function()? paymentFailed,
    required TResult orElse(),
  }) {
    if (paymentFailed != null) {
      return paymentFailed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Preparing value) preparing,
    required TResult Function(_Shipped value) shipped,
    required TResult Function(_Delivered value) delivered,
    required TResult Function(_Canceled value) canceled,
    required TResult Function(_PaymentFailed value) paymentFailed,
  }) {
    return paymentFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Preparing value)? preparing,
    TResult? Function(_Shipped value)? shipped,
    TResult? Function(_Delivered value)? delivered,
    TResult? Function(_Canceled value)? canceled,
    TResult? Function(_PaymentFailed value)? paymentFailed,
  }) {
    return paymentFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Preparing value)? preparing,
    TResult Function(_Shipped value)? shipped,
    TResult Function(_Delivered value)? delivered,
    TResult Function(_Canceled value)? canceled,
    TResult Function(_PaymentFailed value)? paymentFailed,
    required TResult orElse(),
  }) {
    if (paymentFailed != null) {
      return paymentFailed(this);
    }
    return orElse();
  }
}

abstract class _PaymentFailed extends OrderStatus {
  const factory _PaymentFailed() = _$PaymentFailedImpl;
  const _PaymentFailed._() : super._();
}

Address _$AddressFromJson(Map<String, dynamic> json) {
  return _Address.fromJson(json);
}

/// @nodoc
mixin _$Address {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get district => throw _privateConstructorUsedError;
  String? get neighborhood => throw _privateConstructorUsedError;
  String? get street => throw _privateConstructorUsedError;
  String? get buildingNo => throw _privateConstructorUsedError;
  String? get apartment => throw _privateConstructorUsedError;
  String? get floor => throw _privateConstructorUsedError;
  String? get zipCode => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? label,
      String? city,
      String? district,
      String? neighborhood,
      String? street,
      String? buildingNo,
      String? apartment,
      String? floor,
      String? zipCode,
      String? note});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? label = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? neighborhood = freezed,
    Object? street = freezed,
    Object? buildingNo = freezed,
    Object? apartment = freezed,
    Object? floor = freezed,
    Object? zipCode = freezed,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      neighborhood: freezed == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      buildingNo: freezed == buildingNo
          ? _value.buildingNo
          : buildingNo // ignore: cast_nullable_to_non_nullable
              as String?,
      apartment: freezed == apartment
          ? _value.apartment
          : apartment // ignore: cast_nullable_to_non_nullable
              as String?,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String?,
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressImplCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$AddressImplCopyWith(
          _$AddressImpl value, $Res Function(_$AddressImpl) then) =
      __$$AddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? label,
      String? city,
      String? district,
      String? neighborhood,
      String? street,
      String? buildingNo,
      String? apartment,
      String? floor,
      String? zipCode,
      String? note});
}

/// @nodoc
class __$$AddressImplCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$AddressImpl>
    implements _$$AddressImplCopyWith<$Res> {
  __$$AddressImplCopyWithImpl(
      _$AddressImpl _value, $Res Function(_$AddressImpl) _then)
      : super(_value, _then);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? label = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? neighborhood = freezed,
    Object? street = freezed,
    Object? buildingNo = freezed,
    Object? apartment = freezed,
    Object? floor = freezed,
    Object? zipCode = freezed,
    Object? note = freezed,
  }) {
    return _then(_$AddressImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      neighborhood: freezed == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      buildingNo: freezed == buildingNo
          ? _value.buildingNo
          : buildingNo // ignore: cast_nullable_to_non_nullable
              as String?,
      apartment: freezed == apartment
          ? _value.apartment
          : apartment // ignore: cast_nullable_to_non_nullable
              as String?,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String?,
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressImpl implements _Address {
  const _$AddressImpl(
      {this.id,
      this.name,
      this.label,
      this.city,
      this.district,
      this.neighborhood,
      this.street,
      this.buildingNo,
      this.apartment,
      this.floor,
      this.zipCode,
      this.note});

  factory _$AddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? label;
  @override
  final String? city;
  @override
  final String? district;
  @override
  final String? neighborhood;
  @override
  final String? street;
  @override
  final String? buildingNo;
  @override
  final String? apartment;
  @override
  final String? floor;
  @override
  final String? zipCode;
  @override
  final String? note;

  @override
  String toString() {
    return 'Address(id: $id, name: $name, label: $label, city: $city, district: $district, neighborhood: $neighborhood, street: $street, buildingNo: $buildingNo, apartment: $apartment, floor: $floor, zipCode: $zipCode, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.neighborhood, neighborhood) ||
                other.neighborhood == neighborhood) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.buildingNo, buildingNo) ||
                other.buildingNo == buildingNo) &&
            (identical(other.apartment, apartment) ||
                other.apartment == apartment) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, label, city, district,
      neighborhood, street, buildingNo, apartment, floor, zipCode, note);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      __$$AddressImplCopyWithImpl<_$AddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressImplToJson(
      this,
    );
  }
}

abstract class _Address implements Address {
  const factory _Address(
      {final String? id,
      final String? name,
      final String? label,
      final String? city,
      final String? district,
      final String? neighborhood,
      final String? street,
      final String? buildingNo,
      final String? apartment,
      final String? floor,
      final String? zipCode,
      final String? note}) = _$AddressImpl;

  factory _Address.fromJson(Map<String, dynamic> json) = _$AddressImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get label;
  @override
  String? get city;
  @override
  String? get district;
  @override
  String? get neighborhood;
  @override
  String? get street;
  @override
  String? get buildingNo;
  @override
  String? get apartment;
  @override
  String? get floor;
  @override
  String? get zipCode;
  @override
  String? get note;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return _OrderItem.fromJson(json);
}

/// @nodoc
mixin _$OrderItem {
  @JsonKey(name: 'product_id')
  String? get productId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_price')
  double? get unitPrice => throw _privateConstructorUsedError;
  double? get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'line_total')
  double? get lineTotal => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  String? get sku => throw _privateConstructorUsedError;
  @JsonKey(name: 'variant_id')
  String? get variantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  Map<String, dynamic> get options => throw _privateConstructorUsedError;
  Map<String, dynamic>? get product => throw _privateConstructorUsedError;

  /// Serializes this OrderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemCopyWith<OrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemCopyWith<$Res> {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) then) =
      _$OrderItemCopyWithImpl<$Res, OrderItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') String? productId,
      String? name,
      @JsonKey(name: 'title') String? title,
      int? quantity,
      double? price,
      @JsonKey(name: 'unit_price') double? unitPrice,
      double? total,
      @JsonKey(name: 'line_total') double? lineTotal,
      String? currency,
      String? sku,
      @JsonKey(name: 'variant_id') String? variantId,
      @JsonKey(name: 'image_url') String? imageUrl,
      Map<String, dynamic> options,
      Map<String, dynamic>? product});
}

/// @nodoc
class _$OrderItemCopyWithImpl<$Res, $Val extends OrderItem>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? name = freezed,
    Object? title = freezed,
    Object? quantity = freezed,
    Object? price = freezed,
    Object? unitPrice = freezed,
    Object? total = freezed,
    Object? lineTotal = freezed,
    Object? currency = freezed,
    Object? sku = freezed,
    Object? variantId = freezed,
    Object? imageUrl = freezed,
    Object? options = null,
    Object? product = freezed,
  }) {
    return _then(_value.copyWith(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      unitPrice: freezed == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double?,
      lineTotal: freezed == lineTotal
          ? _value.lineTotal
          : lineTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      sku: freezed == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderItemImplCopyWith<$Res>
    implements $OrderItemCopyWith<$Res> {
  factory _$$OrderItemImplCopyWith(
          _$OrderItemImpl value, $Res Function(_$OrderItemImpl) then) =
      __$$OrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') String? productId,
      String? name,
      @JsonKey(name: 'title') String? title,
      int? quantity,
      double? price,
      @JsonKey(name: 'unit_price') double? unitPrice,
      double? total,
      @JsonKey(name: 'line_total') double? lineTotal,
      String? currency,
      String? sku,
      @JsonKey(name: 'variant_id') String? variantId,
      @JsonKey(name: 'image_url') String? imageUrl,
      Map<String, dynamic> options,
      Map<String, dynamic>? product});
}

/// @nodoc
class __$$OrderItemImplCopyWithImpl<$Res>
    extends _$OrderItemCopyWithImpl<$Res, _$OrderItemImpl>
    implements _$$OrderItemImplCopyWith<$Res> {
  __$$OrderItemImplCopyWithImpl(
      _$OrderItemImpl _value, $Res Function(_$OrderItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? name = freezed,
    Object? title = freezed,
    Object? quantity = freezed,
    Object? price = freezed,
    Object? unitPrice = freezed,
    Object? total = freezed,
    Object? lineTotal = freezed,
    Object? currency = freezed,
    Object? sku = freezed,
    Object? variantId = freezed,
    Object? imageUrl = freezed,
    Object? options = null,
    Object? product = freezed,
  }) {
    return _then(_$OrderItemImpl(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      unitPrice: freezed == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double?,
      lineTotal: freezed == lineTotal
          ? _value.lineTotal
          : lineTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      sku: freezed == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      product: freezed == product
          ? _value._product
          : product // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderItemImpl implements _OrderItem {
  const _$OrderItemImpl(
      {@JsonKey(name: 'product_id') this.productId,
      this.name,
      @JsonKey(name: 'title') this.title,
      this.quantity,
      this.price,
      @JsonKey(name: 'unit_price') this.unitPrice,
      this.total,
      @JsonKey(name: 'line_total') this.lineTotal,
      this.currency,
      this.sku,
      @JsonKey(name: 'variant_id') this.variantId,
      @JsonKey(name: 'image_url') this.imageUrl,
      final Map<String, dynamic> options = const {},
      final Map<String, dynamic>? product})
      : _options = options,
        _product = product;

  factory _$OrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemImplFromJson(json);

  @override
  @JsonKey(name: 'product_id')
  final String? productId;
  @override
  final String? name;
  @override
  @JsonKey(name: 'title')
  final String? title;
  @override
  final int? quantity;
  @override
  final double? price;
  @override
  @JsonKey(name: 'unit_price')
  final double? unitPrice;
  @override
  final double? total;
  @override
  @JsonKey(name: 'line_total')
  final double? lineTotal;
  @override
  final String? currency;
  @override
  final String? sku;
  @override
  @JsonKey(name: 'variant_id')
  final String? variantId;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final Map<String, dynamic> _options;
  @override
  @JsonKey()
  Map<String, dynamic> get options {
    if (_options is EqualUnmodifiableMapView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_options);
  }

  final Map<String, dynamic>? _product;
  @override
  Map<String, dynamic>? get product {
    final value = _product;
    if (value == null) return null;
    if (_product is EqualUnmodifiableMapView) return _product;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'OrderItem(productId: $productId, name: $name, title: $title, quantity: $quantity, price: $price, unitPrice: $unitPrice, total: $total, lineTotal: $lineTotal, currency: $currency, sku: $sku, variantId: $variantId, imageUrl: $imageUrl, options: $options, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.lineTotal, lineTotal) ||
                other.lineTotal == lineTotal) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality().equals(other._product, _product));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productId,
      name,
      title,
      quantity,
      price,
      unitPrice,
      total,
      lineTotal,
      currency,
      sku,
      variantId,
      imageUrl,
      const DeepCollectionEquality().hash(_options),
      const DeepCollectionEquality().hash(_product));

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      __$$OrderItemImplCopyWithImpl<_$OrderItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemImplToJson(
      this,
    );
  }
}

abstract class _OrderItem implements OrderItem {
  const factory _OrderItem(
      {@JsonKey(name: 'product_id') final String? productId,
      final String? name,
      @JsonKey(name: 'title') final String? title,
      final int? quantity,
      final double? price,
      @JsonKey(name: 'unit_price') final double? unitPrice,
      final double? total,
      @JsonKey(name: 'line_total') final double? lineTotal,
      final String? currency,
      final String? sku,
      @JsonKey(name: 'variant_id') final String? variantId,
      @JsonKey(name: 'image_url') final String? imageUrl,
      final Map<String, dynamic> options,
      final Map<String, dynamic>? product}) = _$OrderItemImpl;

  factory _OrderItem.fromJson(Map<String, dynamic> json) =
      _$OrderItemImpl.fromJson;

  @override
  @JsonKey(name: 'product_id')
  String? get productId;
  @override
  String? get name;
  @override
  @JsonKey(name: 'title')
  String? get title;
  @override
  int? get quantity;
  @override
  double? get price;
  @override
  @JsonKey(name: 'unit_price')
  double? get unitPrice;
  @override
  double? get total;
  @override
  @JsonKey(name: 'line_total')
  double? get lineTotal;
  @override
  String? get currency;
  @override
  String? get sku;
  @override
  @JsonKey(name: 'variant_id')
  String? get variantId;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  Map<String, dynamic> get options;
  @override
  Map<String, dynamic>? get product;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderTotals _$OrderTotalsFromJson(Map<String, dynamic> json) {
  return _OrderTotals.fromJson(json);
}

/// @nodoc
mixin _$OrderTotals {
  @JsonKey(name: 'item_count')
  int? get itemCount => throw _privateConstructorUsedError;
  double? get subtotal => throw _privateConstructorUsedError;
  double? get discount => throw _privateConstructorUsedError;
  double? get shipping => throw _privateConstructorUsedError;
  double? get tax => throw _privateConstructorUsedError;
  @JsonKey(name: 'grand_total')
  double? get grandTotal => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;

  /// Serializes this OrderTotals to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderTotals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderTotalsCopyWith<OrderTotals> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderTotalsCopyWith<$Res> {
  factory $OrderTotalsCopyWith(
          OrderTotals value, $Res Function(OrderTotals) then) =
      _$OrderTotalsCopyWithImpl<$Res, OrderTotals>;
  @useResult
  $Res call(
      {@JsonKey(name: 'item_count') int? itemCount,
      double? subtotal,
      double? discount,
      double? shipping,
      double? tax,
      @JsonKey(name: 'grand_total') double? grandTotal,
      String? currency});
}

/// @nodoc
class _$OrderTotalsCopyWithImpl<$Res, $Val extends OrderTotals>
    implements $OrderTotalsCopyWith<$Res> {
  _$OrderTotalsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderTotals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemCount = freezed,
    Object? subtotal = freezed,
    Object? discount = freezed,
    Object? shipping = freezed,
    Object? tax = freezed,
    Object? grandTotal = freezed,
    Object? currency = freezed,
  }) {
    return _then(_value.copyWith(
      itemCount: freezed == itemCount
          ? _value.itemCount
          : itemCount // ignore: cast_nullable_to_non_nullable
              as int?,
      subtotal: freezed == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double?,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double?,
      shipping: freezed == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as double?,
      tax: freezed == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double?,
      grandTotal: freezed == grandTotal
          ? _value.grandTotal
          : grandTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderTotalsImplCopyWith<$Res>
    implements $OrderTotalsCopyWith<$Res> {
  factory _$$OrderTotalsImplCopyWith(
          _$OrderTotalsImpl value, $Res Function(_$OrderTotalsImpl) then) =
      __$$OrderTotalsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'item_count') int? itemCount,
      double? subtotal,
      double? discount,
      double? shipping,
      double? tax,
      @JsonKey(name: 'grand_total') double? grandTotal,
      String? currency});
}

/// @nodoc
class __$$OrderTotalsImplCopyWithImpl<$Res>
    extends _$OrderTotalsCopyWithImpl<$Res, _$OrderTotalsImpl>
    implements _$$OrderTotalsImplCopyWith<$Res> {
  __$$OrderTotalsImplCopyWithImpl(
      _$OrderTotalsImpl _value, $Res Function(_$OrderTotalsImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderTotals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemCount = freezed,
    Object? subtotal = freezed,
    Object? discount = freezed,
    Object? shipping = freezed,
    Object? tax = freezed,
    Object? grandTotal = freezed,
    Object? currency = freezed,
  }) {
    return _then(_$OrderTotalsImpl(
      itemCount: freezed == itemCount
          ? _value.itemCount
          : itemCount // ignore: cast_nullable_to_non_nullable
              as int?,
      subtotal: freezed == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double?,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double?,
      shipping: freezed == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as double?,
      tax: freezed == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double?,
      grandTotal: freezed == grandTotal
          ? _value.grandTotal
          : grandTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderTotalsImpl implements _OrderTotals {
  const _$OrderTotalsImpl(
      {@JsonKey(name: 'item_count') this.itemCount,
      this.subtotal,
      this.discount,
      this.shipping,
      this.tax,
      @JsonKey(name: 'grand_total') this.grandTotal,
      this.currency});

  factory _$OrderTotalsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderTotalsImplFromJson(json);

  @override
  @JsonKey(name: 'item_count')
  final int? itemCount;
  @override
  final double? subtotal;
  @override
  final double? discount;
  @override
  final double? shipping;
  @override
  final double? tax;
  @override
  @JsonKey(name: 'grand_total')
  final double? grandTotal;
  @override
  final String? currency;

  @override
  String toString() {
    return 'OrderTotals(itemCount: $itemCount, subtotal: $subtotal, discount: $discount, shipping: $shipping, tax: $tax, grandTotal: $grandTotal, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderTotalsImpl &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.shipping, shipping) ||
                other.shipping == shipping) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, itemCount, subtotal, discount,
      shipping, tax, grandTotal, currency);

  /// Create a copy of OrderTotals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderTotalsImplCopyWith<_$OrderTotalsImpl> get copyWith =>
      __$$OrderTotalsImplCopyWithImpl<_$OrderTotalsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderTotalsImplToJson(
      this,
    );
  }
}

abstract class _OrderTotals implements OrderTotals {
  const factory _OrderTotals(
      {@JsonKey(name: 'item_count') final int? itemCount,
      final double? subtotal,
      final double? discount,
      final double? shipping,
      final double? tax,
      @JsonKey(name: 'grand_total') final double? grandTotal,
      final String? currency}) = _$OrderTotalsImpl;

  factory _OrderTotals.fromJson(Map<String, dynamic> json) =
      _$OrderTotalsImpl.fromJson;

  @override
  @JsonKey(name: 'item_count')
  int? get itemCount;
  @override
  double? get subtotal;
  @override
  double? get discount;
  @override
  double? get shipping;
  @override
  double? get tax;
  @override
  @JsonKey(name: 'grand_total')
  double? get grandTotal;
  @override
  String? get currency;

  /// Create a copy of OrderTotals
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderTotalsImplCopyWith<_$OrderTotalsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderPayment _$OrderPaymentFromJson(Map<String, dynamic> json) {
  return _OrderPayment.fromJson(json);
}

/// @nodoc
mixin _$OrderPayment {
  String get provider => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'received_total')
  double? get receivedTotal => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_type')
  String? get paymentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'reported_at')
  DateTime? get reportedAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get paytr => throw _privateConstructorUsedError;

  /// Serializes this OrderPayment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderPaymentCopyWith<OrderPayment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderPaymentCopyWith<$Res> {
  factory $OrderPaymentCopyWith(
          OrderPayment value, $Res Function(OrderPayment) then) =
      _$OrderPaymentCopyWithImpl<$Res, OrderPayment>;
  @useResult
  $Res call(
      {String provider,
      String status,
      @JsonKey(name: 'received_total') double? receivedTotal,
      String currency,
      @JsonKey(name: 'payment_type') String? paymentType,
      @JsonKey(name: 'reported_at') DateTime? reportedAt,
      Map<String, dynamic>? paytr});
}

/// @nodoc
class _$OrderPaymentCopyWithImpl<$Res, $Val extends OrderPayment>
    implements $OrderPaymentCopyWith<$Res> {
  _$OrderPaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
    Object? status = null,
    Object? receivedTotal = freezed,
    Object? currency = null,
    Object? paymentType = freezed,
    Object? reportedAt = freezed,
    Object? paytr = freezed,
  }) {
    return _then(_value.copyWith(
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      receivedTotal: freezed == receivedTotal
          ? _value.receivedTotal
          : receivedTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as String?,
      reportedAt: freezed == reportedAt
          ? _value.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paytr: freezed == paytr
          ? _value.paytr
          : paytr // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderPaymentImplCopyWith<$Res>
    implements $OrderPaymentCopyWith<$Res> {
  factory _$$OrderPaymentImplCopyWith(
          _$OrderPaymentImpl value, $Res Function(_$OrderPaymentImpl) then) =
      __$$OrderPaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String provider,
      String status,
      @JsonKey(name: 'received_total') double? receivedTotal,
      String currency,
      @JsonKey(name: 'payment_type') String? paymentType,
      @JsonKey(name: 'reported_at') DateTime? reportedAt,
      Map<String, dynamic>? paytr});
}

/// @nodoc
class __$$OrderPaymentImplCopyWithImpl<$Res>
    extends _$OrderPaymentCopyWithImpl<$Res, _$OrderPaymentImpl>
    implements _$$OrderPaymentImplCopyWith<$Res> {
  __$$OrderPaymentImplCopyWithImpl(
      _$OrderPaymentImpl _value, $Res Function(_$OrderPaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
    Object? status = null,
    Object? receivedTotal = freezed,
    Object? currency = null,
    Object? paymentType = freezed,
    Object? reportedAt = freezed,
    Object? paytr = freezed,
  }) {
    return _then(_$OrderPaymentImpl(
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      receivedTotal: freezed == receivedTotal
          ? _value.receivedTotal
          : receivedTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as String?,
      reportedAt: freezed == reportedAt
          ? _value.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paytr: freezed == paytr
          ? _value._paytr
          : paytr // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderPaymentImpl implements _OrderPayment {
  const _$OrderPaymentImpl(
      {required this.provider,
      required this.status,
      @JsonKey(name: 'received_total') this.receivedTotal,
      required this.currency,
      @JsonKey(name: 'payment_type') this.paymentType,
      @JsonKey(name: 'reported_at') this.reportedAt,
      final Map<String, dynamic>? paytr})
      : _paytr = paytr;

  factory _$OrderPaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderPaymentImplFromJson(json);

  @override
  final String provider;
  @override
  final String status;
  @override
  @JsonKey(name: 'received_total')
  final double? receivedTotal;
  @override
  final String currency;
  @override
  @JsonKey(name: 'payment_type')
  final String? paymentType;
  @override
  @JsonKey(name: 'reported_at')
  final DateTime? reportedAt;
  final Map<String, dynamic>? _paytr;
  @override
  Map<String, dynamic>? get paytr {
    final value = _paytr;
    if (value == null) return null;
    if (_paytr is EqualUnmodifiableMapView) return _paytr;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'OrderPayment(provider: $provider, status: $status, receivedTotal: $receivedTotal, currency: $currency, paymentType: $paymentType, reportedAt: $reportedAt, paytr: $paytr)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderPaymentImpl &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.receivedTotal, receivedTotal) ||
                other.receivedTotal == receivedTotal) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.reportedAt, reportedAt) ||
                other.reportedAt == reportedAt) &&
            const DeepCollectionEquality().equals(other._paytr, _paytr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      provider,
      status,
      receivedTotal,
      currency,
      paymentType,
      reportedAt,
      const DeepCollectionEquality().hash(_paytr));

  /// Create a copy of OrderPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderPaymentImplCopyWith<_$OrderPaymentImpl> get copyWith =>
      __$$OrderPaymentImplCopyWithImpl<_$OrderPaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderPaymentImplToJson(
      this,
    );
  }
}

abstract class _OrderPayment implements OrderPayment {
  const factory _OrderPayment(
      {required final String provider,
      required final String status,
      @JsonKey(name: 'received_total') final double? receivedTotal,
      required final String currency,
      @JsonKey(name: 'payment_type') final String? paymentType,
      @JsonKey(name: 'reported_at') final DateTime? reportedAt,
      final Map<String, dynamic>? paytr}) = _$OrderPaymentImpl;

  factory _OrderPayment.fromJson(Map<String, dynamic> json) =
      _$OrderPaymentImpl.fromJson;

  @override
  String get provider;
  @override
  String get status;
  @override
  @JsonKey(name: 'received_total')
  double? get receivedTotal;
  @override
  String get currency;
  @override
  @JsonKey(name: 'payment_type')
  String? get paymentType;
  @override
  @JsonKey(name: 'reported_at')
  DateTime? get reportedAt;
  @override
  Map<String, dynamic>? get paytr;

  /// Create a copy of OrderPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderPaymentImplCopyWith<_$OrderPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderShipment _$OrderShipmentFromJson(Map<String, dynamic> json) {
  return _OrderShipment.fromJson(json);
}

/// @nodoc
mixin _$OrderShipment {
  String? get provider => throw _privateConstructorUsedError;
  @JsonKey(name: 'tracking_number')
  String? get trackingNumber => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'shipped_at')
  DateTime? get shippedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivered_at')
  DateTime? get deliveredAt => throw _privateConstructorUsedError;
  bool? get simulated => throw _privateConstructorUsedError;
  String? get log => throw _privateConstructorUsedError;

  /// Serializes this OrderShipment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderShipment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderShipmentCopyWith<OrderShipment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderShipmentCopyWith<$Res> {
  factory $OrderShipmentCopyWith(
          OrderShipment value, $Res Function(OrderShipment) then) =
      _$OrderShipmentCopyWithImpl<$Res, OrderShipment>;
  @useResult
  $Res call(
      {String? provider,
      @JsonKey(name: 'tracking_number') String? trackingNumber,
      String? status,
      @JsonKey(name: 'shipped_at') DateTime? shippedAt,
      @JsonKey(name: 'delivered_at') DateTime? deliveredAt,
      bool? simulated,
      String? log});
}

/// @nodoc
class _$OrderShipmentCopyWithImpl<$Res, $Val extends OrderShipment>
    implements $OrderShipmentCopyWith<$Res> {
  _$OrderShipmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderShipment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = freezed,
    Object? trackingNumber = freezed,
    Object? status = freezed,
    Object? shippedAt = freezed,
    Object? deliveredAt = freezed,
    Object? simulated = freezed,
    Object? log = freezed,
  }) {
    return _then(_value.copyWith(
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      trackingNumber: freezed == trackingNumber
          ? _value.trackingNumber
          : trackingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      shippedAt: freezed == shippedAt
          ? _value.shippedAt
          : shippedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      simulated: freezed == simulated
          ? _value.simulated
          : simulated // ignore: cast_nullable_to_non_nullable
              as bool?,
      log: freezed == log
          ? _value.log
          : log // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderShipmentImplCopyWith<$Res>
    implements $OrderShipmentCopyWith<$Res> {
  factory _$$OrderShipmentImplCopyWith(
          _$OrderShipmentImpl value, $Res Function(_$OrderShipmentImpl) then) =
      __$$OrderShipmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? provider,
      @JsonKey(name: 'tracking_number') String? trackingNumber,
      String? status,
      @JsonKey(name: 'shipped_at') DateTime? shippedAt,
      @JsonKey(name: 'delivered_at') DateTime? deliveredAt,
      bool? simulated,
      String? log});
}

/// @nodoc
class __$$OrderShipmentImplCopyWithImpl<$Res>
    extends _$OrderShipmentCopyWithImpl<$Res, _$OrderShipmentImpl>
    implements _$$OrderShipmentImplCopyWith<$Res> {
  __$$OrderShipmentImplCopyWithImpl(
      _$OrderShipmentImpl _value, $Res Function(_$OrderShipmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderShipment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = freezed,
    Object? trackingNumber = freezed,
    Object? status = freezed,
    Object? shippedAt = freezed,
    Object? deliveredAt = freezed,
    Object? simulated = freezed,
    Object? log = freezed,
  }) {
    return _then(_$OrderShipmentImpl(
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      trackingNumber: freezed == trackingNumber
          ? _value.trackingNumber
          : trackingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      shippedAt: freezed == shippedAt
          ? _value.shippedAt
          : shippedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      simulated: freezed == simulated
          ? _value.simulated
          : simulated // ignore: cast_nullable_to_non_nullable
              as bool?,
      log: freezed == log
          ? _value.log
          : log // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderShipmentImpl implements _OrderShipment {
  const _$OrderShipmentImpl(
      {this.provider,
      @JsonKey(name: 'tracking_number') this.trackingNumber,
      this.status,
      @JsonKey(name: 'shipped_at') this.shippedAt,
      @JsonKey(name: 'delivered_at') this.deliveredAt,
      this.simulated,
      this.log});

  factory _$OrderShipmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderShipmentImplFromJson(json);

  @override
  final String? provider;
  @override
  @JsonKey(name: 'tracking_number')
  final String? trackingNumber;
  @override
  final String? status;
  @override
  @JsonKey(name: 'shipped_at')
  final DateTime? shippedAt;
  @override
  @JsonKey(name: 'delivered_at')
  final DateTime? deliveredAt;
  @override
  final bool? simulated;
  @override
  final String? log;

  @override
  String toString() {
    return 'OrderShipment(provider: $provider, trackingNumber: $trackingNumber, status: $status, shippedAt: $shippedAt, deliveredAt: $deliveredAt, simulated: $simulated, log: $log)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderShipmentImpl &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.trackingNumber, trackingNumber) ||
                other.trackingNumber == trackingNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.shippedAt, shippedAt) ||
                other.shippedAt == shippedAt) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.simulated, simulated) ||
                other.simulated == simulated) &&
            (identical(other.log, log) || other.log == log));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, provider, trackingNumber, status,
      shippedAt, deliveredAt, simulated, log);

  /// Create a copy of OrderShipment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderShipmentImplCopyWith<_$OrderShipmentImpl> get copyWith =>
      __$$OrderShipmentImplCopyWithImpl<_$OrderShipmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderShipmentImplToJson(
      this,
    );
  }
}

abstract class _OrderShipment implements OrderShipment {
  const factory _OrderShipment(
      {final String? provider,
      @JsonKey(name: 'tracking_number') final String? trackingNumber,
      final String? status,
      @JsonKey(name: 'shipped_at') final DateTime? shippedAt,
      @JsonKey(name: 'delivered_at') final DateTime? deliveredAt,
      final bool? simulated,
      final String? log}) = _$OrderShipmentImpl;

  factory _OrderShipment.fromJson(Map<String, dynamic> json) =
      _$OrderShipmentImpl.fromJson;

  @override
  String? get provider;
  @override
  @JsonKey(name: 'tracking_number')
  String? get trackingNumber;
  @override
  String? get status;
  @override
  @JsonKey(name: 'shipped_at')
  DateTime? get shippedAt;
  @override
  @JsonKey(name: 'delivered_at')
  DateTime? get deliveredAt;
  @override
  bool? get simulated;
  @override
  String? get log;

  /// Create a copy of OrderShipment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderShipmentImplCopyWith<_$OrderShipmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderStatusHistory _$OrderStatusHistoryFromJson(Map<String, dynamic> json) {
  return _OrderStatusHistory.fromJson(json);
}

/// @nodoc
mixin _$OrderStatusHistory {
  String get status => throw _privateConstructorUsedError;
  DateTime get at => throw _privateConstructorUsedError;
  String get by => throw _privateConstructorUsedError;

  /// Serializes this OrderStatusHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderStatusHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderStatusHistoryCopyWith<OrderStatusHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusHistoryCopyWith<$Res> {
  factory $OrderStatusHistoryCopyWith(
          OrderStatusHistory value, $Res Function(OrderStatusHistory) then) =
      _$OrderStatusHistoryCopyWithImpl<$Res, OrderStatusHistory>;
  @useResult
  $Res call({String status, DateTime at, String by});
}

/// @nodoc
class _$OrderStatusHistoryCopyWithImpl<$Res, $Val extends OrderStatusHistory>
    implements $OrderStatusHistoryCopyWith<$Res> {
  _$OrderStatusHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderStatusHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? at = null,
    Object? by = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      at: null == at
          ? _value.at
          : at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      by: null == by
          ? _value.by
          : by // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderStatusHistoryImplCopyWith<$Res>
    implements $OrderStatusHistoryCopyWith<$Res> {
  factory _$$OrderStatusHistoryImplCopyWith(_$OrderStatusHistoryImpl value,
          $Res Function(_$OrderStatusHistoryImpl) then) =
      __$$OrderStatusHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, DateTime at, String by});
}

/// @nodoc
class __$$OrderStatusHistoryImplCopyWithImpl<$Res>
    extends _$OrderStatusHistoryCopyWithImpl<$Res, _$OrderStatusHistoryImpl>
    implements _$$OrderStatusHistoryImplCopyWith<$Res> {
  __$$OrderStatusHistoryImplCopyWithImpl(_$OrderStatusHistoryImpl _value,
      $Res Function(_$OrderStatusHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderStatusHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? at = null,
    Object? by = null,
  }) {
    return _then(_$OrderStatusHistoryImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      at: null == at
          ? _value.at
          : at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      by: null == by
          ? _value.by
          : by // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderStatusHistoryImpl implements _OrderStatusHistory {
  const _$OrderStatusHistoryImpl(
      {required this.status, required this.at, required this.by});

  factory _$OrderStatusHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderStatusHistoryImplFromJson(json);

  @override
  final String status;
  @override
  final DateTime at;
  @override
  final String by;

  @override
  String toString() {
    return 'OrderStatusHistory(status: $status, at: $at, by: $by)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderStatusHistoryImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.at, at) || other.at == at) &&
            (identical(other.by, by) || other.by == by));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, at, by);

  /// Create a copy of OrderStatusHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStatusHistoryImplCopyWith<_$OrderStatusHistoryImpl> get copyWith =>
      __$$OrderStatusHistoryImplCopyWithImpl<_$OrderStatusHistoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderStatusHistoryImplToJson(
      this,
    );
  }
}

abstract class _OrderStatusHistory implements OrderStatusHistory {
  const factory _OrderStatusHistory(
      {required final String status,
      required final DateTime at,
      required final String by}) = _$OrderStatusHistoryImpl;

  factory _OrderStatusHistory.fromJson(Map<String, dynamic> json) =
      _$OrderStatusHistoryImpl.fromJson;

  @override
  String get status;
  @override
  DateTime get at;
  @override
  String get by;

  /// Create a copy of OrderStatusHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderStatusHistoryImplCopyWith<_$OrderStatusHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderCustomer _$OrderCustomerFromJson(Map<String, dynamic> json) {
  return _OrderCustomer.fromJson(json);
}

/// @nodoc
mixin _$OrderCustomer {
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  OrderAddress get address => throw _privateConstructorUsedError;

  /// Serializes this OrderCustomer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderCustomer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCustomerCopyWith<OrderCustomer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCustomerCopyWith<$Res> {
  factory $OrderCustomerCopyWith(
          OrderCustomer value, $Res Function(OrderCustomer) then) =
      _$OrderCustomerCopyWithImpl<$Res, OrderCustomer>;
  @useResult
  $Res call(
      {@JsonKey(name: 'full_name') String fullName,
      String email,
      String phone,
      OrderAddress address});

  $OrderAddressCopyWith<$Res> get address;
}

/// @nodoc
class _$OrderCustomerCopyWithImpl<$Res, $Val extends OrderCustomer>
    implements $OrderCustomerCopyWith<$Res> {
  _$OrderCustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderCustomer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? phone = null,
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as OrderAddress,
    ) as $Val);
  }

  /// Create a copy of OrderCustomer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderAddressCopyWith<$Res> get address {
    return $OrderAddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderCustomerImplCopyWith<$Res>
    implements $OrderCustomerCopyWith<$Res> {
  factory _$$OrderCustomerImplCopyWith(
          _$OrderCustomerImpl value, $Res Function(_$OrderCustomerImpl) then) =
      __$$OrderCustomerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'full_name') String fullName,
      String email,
      String phone,
      OrderAddress address});

  @override
  $OrderAddressCopyWith<$Res> get address;
}

/// @nodoc
class __$$OrderCustomerImplCopyWithImpl<$Res>
    extends _$OrderCustomerCopyWithImpl<$Res, _$OrderCustomerImpl>
    implements _$$OrderCustomerImplCopyWith<$Res> {
  __$$OrderCustomerImplCopyWithImpl(
      _$OrderCustomerImpl _value, $Res Function(_$OrderCustomerImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderCustomer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? phone = null,
    Object? address = null,
  }) {
    return _then(_$OrderCustomerImpl(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as OrderAddress,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderCustomerImpl implements _OrderCustomer {
  const _$OrderCustomerImpl(
      {@JsonKey(name: 'full_name') required this.fullName,
      required this.email,
      required this.phone,
      required this.address});

  factory _$OrderCustomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderCustomerImplFromJson(json);

  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  final String email;
  @override
  final String phone;
  @override
  final OrderAddress address;

  @override
  String toString() {
    return 'OrderCustomer(fullName: $fullName, email: $email, phone: $phone, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderCustomerImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fullName, email, phone, address);

  /// Create a copy of OrderCustomer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderCustomerImplCopyWith<_$OrderCustomerImpl> get copyWith =>
      __$$OrderCustomerImplCopyWithImpl<_$OrderCustomerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderCustomerImplToJson(
      this,
    );
  }
}

abstract class _OrderCustomer implements OrderCustomer {
  const factory _OrderCustomer(
      {@JsonKey(name: 'full_name') required final String fullName,
      required final String email,
      required final String phone,
      required final OrderAddress address}) = _$OrderCustomerImpl;

  factory _OrderCustomer.fromJson(Map<String, dynamic> json) =
      _$OrderCustomerImpl.fromJson;

  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String get email;
  @override
  String get phone;
  @override
  OrderAddress get address;

  /// Create a copy of OrderCustomer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderCustomerImplCopyWith<_$OrderCustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderAddress _$OrderAddressFromJson(Map<String, dynamic> json) {
  return _OrderAddress.fromJson(json);
}

/// @nodoc
mixin _$OrderAddress {
  @JsonKey(name: 'line1')
  String get line1 => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  @JsonKey(name: 'postal_code')
  String get postalCode => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;

  /// Serializes this OrderAddress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderAddressCopyWith<OrderAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderAddressCopyWith<$Res> {
  factory $OrderAddressCopyWith(
          OrderAddress value, $Res Function(OrderAddress) then) =
      _$OrderAddressCopyWithImpl<$Res, OrderAddress>;
  @useResult
  $Res call(
      {@JsonKey(name: 'line1') String line1,
      String city,
      @JsonKey(name: 'postal_code') String postalCode,
      String country});
}

/// @nodoc
class _$OrderAddressCopyWithImpl<$Res, $Val extends OrderAddress>
    implements $OrderAddressCopyWith<$Res> {
  _$OrderAddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? line1 = null,
    Object? city = null,
    Object? postalCode = null,
    Object? country = null,
  }) {
    return _then(_value.copyWith(
      line1: null == line1
          ? _value.line1
          : line1 // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      postalCode: null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderAddressImplCopyWith<$Res>
    implements $OrderAddressCopyWith<$Res> {
  factory _$$OrderAddressImplCopyWith(
          _$OrderAddressImpl value, $Res Function(_$OrderAddressImpl) then) =
      __$$OrderAddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'line1') String line1,
      String city,
      @JsonKey(name: 'postal_code') String postalCode,
      String country});
}

/// @nodoc
class __$$OrderAddressImplCopyWithImpl<$Res>
    extends _$OrderAddressCopyWithImpl<$Res, _$OrderAddressImpl>
    implements _$$OrderAddressImplCopyWith<$Res> {
  __$$OrderAddressImplCopyWithImpl(
      _$OrderAddressImpl _value, $Res Function(_$OrderAddressImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? line1 = null,
    Object? city = null,
    Object? postalCode = null,
    Object? country = null,
  }) {
    return _then(_$OrderAddressImpl(
      line1: null == line1
          ? _value.line1
          : line1 // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      postalCode: null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderAddressImpl implements _OrderAddress {
  const _$OrderAddressImpl(
      {@JsonKey(name: 'line1') required this.line1,
      required this.city,
      @JsonKey(name: 'postal_code') required this.postalCode,
      this.country = 'TR'});

  factory _$OrderAddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderAddressImplFromJson(json);

  @override
  @JsonKey(name: 'line1')
  final String line1;
  @override
  final String city;
  @override
  @JsonKey(name: 'postal_code')
  final String postalCode;
  @override
  @JsonKey()
  final String country;

  @override
  String toString() {
    return 'OrderAddress(line1: $line1, city: $city, postalCode: $postalCode, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderAddressImpl &&
            (identical(other.line1, line1) || other.line1 == line1) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, line1, city, postalCode, country);

  /// Create a copy of OrderAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderAddressImplCopyWith<_$OrderAddressImpl> get copyWith =>
      __$$OrderAddressImplCopyWithImpl<_$OrderAddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderAddressImplToJson(
      this,
    );
  }
}

abstract class _OrderAddress implements OrderAddress {
  const factory _OrderAddress(
      {@JsonKey(name: 'line1') required final String line1,
      required final String city,
      @JsonKey(name: 'postal_code') required final String postalCode,
      final String country}) = _$OrderAddressImpl;

  factory _OrderAddress.fromJson(Map<String, dynamic> json) =
      _$OrderAddressImpl.fromJson;

  @override
  @JsonKey(name: 'line1')
  String get line1;
  @override
  String get city;
  @override
  @JsonKey(name: 'postal_code')
  String get postalCode;
  @override
  String get country;

  /// Create a copy of OrderAddress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderAddressImplCopyWith<_$OrderAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderShipping _$OrderShippingFromJson(Map<String, dynamic> json) {
  return _OrderShipping.fromJson(json);
}

/// @nodoc
mixin _$OrderShipping {
  String get provider => throw _privateConstructorUsedError;

  /// Serializes this OrderShipping to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderShipping
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderShippingCopyWith<OrderShipping> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderShippingCopyWith<$Res> {
  factory $OrderShippingCopyWith(
          OrderShipping value, $Res Function(OrderShipping) then) =
      _$OrderShippingCopyWithImpl<$Res, OrderShipping>;
  @useResult
  $Res call({String provider});
}

/// @nodoc
class _$OrderShippingCopyWithImpl<$Res, $Val extends OrderShipping>
    implements $OrderShippingCopyWith<$Res> {
  _$OrderShippingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderShipping
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
  }) {
    return _then(_value.copyWith(
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderShippingImplCopyWith<$Res>
    implements $OrderShippingCopyWith<$Res> {
  factory _$$OrderShippingImplCopyWith(
          _$OrderShippingImpl value, $Res Function(_$OrderShippingImpl) then) =
      __$$OrderShippingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String provider});
}

/// @nodoc
class __$$OrderShippingImplCopyWithImpl<$Res>
    extends _$OrderShippingCopyWithImpl<$Res, _$OrderShippingImpl>
    implements _$$OrderShippingImplCopyWith<$Res> {
  __$$OrderShippingImplCopyWithImpl(
      _$OrderShippingImpl _value, $Res Function(_$OrderShippingImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderShipping
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
  }) {
    return _then(_$OrderShippingImpl(
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderShippingImpl implements _OrderShipping {
  const _$OrderShippingImpl({required this.provider});

  factory _$OrderShippingImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderShippingImplFromJson(json);

  @override
  final String provider;

  @override
  String toString() {
    return 'OrderShipping(provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderShippingImpl &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, provider);

  /// Create a copy of OrderShipping
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderShippingImplCopyWith<_$OrderShippingImpl> get copyWith =>
      __$$OrderShippingImplCopyWithImpl<_$OrderShippingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderShippingImplToJson(
      this,
    );
  }
}

abstract class _OrderShipping implements OrderShipping {
  const factory _OrderShipping({required final String provider}) =
      _$OrderShippingImpl;

  factory _OrderShipping.fromJson(Map<String, dynamic> json) =
      _$OrderShippingImpl.fromJson;

  @override
  String get provider;

  /// Create a copy of OrderShipping
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderShippingImplCopyWith<_$OrderShippingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderEmailFlags _$OrderEmailFlagsFromJson(Map<String, dynamic> json) {
  return _OrderEmailFlags.fromJson(json);
}

/// @nodoc
mixin _$OrderEmailFlags {
  @JsonKey(name: 'shipped_sent')
  bool get shippedSent => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivered_sent')
  bool get deliveredSent => throw _privateConstructorUsedError;
  @JsonKey(name: 'canceled_sent')
  bool get canceledSent => throw _privateConstructorUsedError;

  /// Serializes this OrderEmailFlags to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderEmailFlags
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderEmailFlagsCopyWith<OrderEmailFlags> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderEmailFlagsCopyWith<$Res> {
  factory $OrderEmailFlagsCopyWith(
          OrderEmailFlags value, $Res Function(OrderEmailFlags) then) =
      _$OrderEmailFlagsCopyWithImpl<$Res, OrderEmailFlags>;
  @useResult
  $Res call(
      {@JsonKey(name: 'shipped_sent') bool shippedSent,
      @JsonKey(name: 'delivered_sent') bool deliveredSent,
      @JsonKey(name: 'canceled_sent') bool canceledSent});
}

/// @nodoc
class _$OrderEmailFlagsCopyWithImpl<$Res, $Val extends OrderEmailFlags>
    implements $OrderEmailFlagsCopyWith<$Res> {
  _$OrderEmailFlagsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderEmailFlags
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shippedSent = null,
    Object? deliveredSent = null,
    Object? canceledSent = null,
  }) {
    return _then(_value.copyWith(
      shippedSent: null == shippedSent
          ? _value.shippedSent
          : shippedSent // ignore: cast_nullable_to_non_nullable
              as bool,
      deliveredSent: null == deliveredSent
          ? _value.deliveredSent
          : deliveredSent // ignore: cast_nullable_to_non_nullable
              as bool,
      canceledSent: null == canceledSent
          ? _value.canceledSent
          : canceledSent // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderEmailFlagsImplCopyWith<$Res>
    implements $OrderEmailFlagsCopyWith<$Res> {
  factory _$$OrderEmailFlagsImplCopyWith(_$OrderEmailFlagsImpl value,
          $Res Function(_$OrderEmailFlagsImpl) then) =
      __$$OrderEmailFlagsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'shipped_sent') bool shippedSent,
      @JsonKey(name: 'delivered_sent') bool deliveredSent,
      @JsonKey(name: 'canceled_sent') bool canceledSent});
}

/// @nodoc
class __$$OrderEmailFlagsImplCopyWithImpl<$Res>
    extends _$OrderEmailFlagsCopyWithImpl<$Res, _$OrderEmailFlagsImpl>
    implements _$$OrderEmailFlagsImplCopyWith<$Res> {
  __$$OrderEmailFlagsImplCopyWithImpl(
      _$OrderEmailFlagsImpl _value, $Res Function(_$OrderEmailFlagsImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderEmailFlags
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shippedSent = null,
    Object? deliveredSent = null,
    Object? canceledSent = null,
  }) {
    return _then(_$OrderEmailFlagsImpl(
      shippedSent: null == shippedSent
          ? _value.shippedSent
          : shippedSent // ignore: cast_nullable_to_non_nullable
              as bool,
      deliveredSent: null == deliveredSent
          ? _value.deliveredSent
          : deliveredSent // ignore: cast_nullable_to_non_nullable
              as bool,
      canceledSent: null == canceledSent
          ? _value.canceledSent
          : canceledSent // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderEmailFlagsImpl implements _OrderEmailFlags {
  const _$OrderEmailFlagsImpl(
      {@JsonKey(name: 'shipped_sent') this.shippedSent = false,
      @JsonKey(name: 'delivered_sent') this.deliveredSent = false,
      @JsonKey(name: 'canceled_sent') this.canceledSent = false});

  factory _$OrderEmailFlagsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderEmailFlagsImplFromJson(json);

  @override
  @JsonKey(name: 'shipped_sent')
  final bool shippedSent;
  @override
  @JsonKey(name: 'delivered_sent')
  final bool deliveredSent;
  @override
  @JsonKey(name: 'canceled_sent')
  final bool canceledSent;

  @override
  String toString() {
    return 'OrderEmailFlags(shippedSent: $shippedSent, deliveredSent: $deliveredSent, canceledSent: $canceledSent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderEmailFlagsImpl &&
            (identical(other.shippedSent, shippedSent) ||
                other.shippedSent == shippedSent) &&
            (identical(other.deliveredSent, deliveredSent) ||
                other.deliveredSent == deliveredSent) &&
            (identical(other.canceledSent, canceledSent) ||
                other.canceledSent == canceledSent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, shippedSent, deliveredSent, canceledSent);

  /// Create a copy of OrderEmailFlags
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderEmailFlagsImplCopyWith<_$OrderEmailFlagsImpl> get copyWith =>
      __$$OrderEmailFlagsImplCopyWithImpl<_$OrderEmailFlagsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderEmailFlagsImplToJson(
      this,
    );
  }
}

abstract class _OrderEmailFlags implements OrderEmailFlags {
  const factory _OrderEmailFlags(
          {@JsonKey(name: 'shipped_sent') final bool shippedSent,
          @JsonKey(name: 'delivered_sent') final bool deliveredSent,
          @JsonKey(name: 'canceled_sent') final bool canceledSent}) =
      _$OrderEmailFlagsImpl;

  factory _OrderEmailFlags.fromJson(Map<String, dynamic> json) =
      _$OrderEmailFlagsImpl.fromJson;

  @override
  @JsonKey(name: 'shipped_sent')
  bool get shippedSent;
  @override
  @JsonKey(name: 'delivered_sent')
  bool get deliveredSent;
  @override
  @JsonKey(name: 'canceled_sent')
  bool get canceledSent;

  /// Create a copy of OrderEmailFlags
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderEmailFlagsImplCopyWith<_$OrderEmailFlagsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  OrderStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'tracking_number')
  String? get trackingNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'shipping_provider')
  String? get shippingProvider => throw _privateConstructorUsedError;
  @JsonKey(name: 'integration_code')
  String? get integrationCode => throw _privateConstructorUsedError;
  Address? get address => throw _privateConstructorUsedError;
  List<OrderItem>? get items => throw _privateConstructorUsedError;
  OrderTotals? get totals => throw _privateConstructorUsedError;
  OrderShipment? get shipment => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_name')
  String? get customerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_phone')
  String? get customerPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_email')
  String? get customerEmail =>
      throw _privateConstructorUsedError; // New backend fields
  OrderCustomer? get customer => throw _privateConstructorUsedError;
  OrderShipping? get shipping => throw _privateConstructorUsedError;
  OrderPayment? get payment => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_history')
  List<OrderStatusHistory>? get statusHistory =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'email_flags')
  OrderEmailFlags? get emailFlags => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_deleted')
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
      OrderStatus status,
      @JsonKey(name: 'tracking_number') String? trackingNumber,
      @JsonKey(name: 'shipping_provider') String? shippingProvider,
      @JsonKey(name: 'integration_code') String? integrationCode,
      Address? address,
      List<OrderItem>? items,
      OrderTotals? totals,
      OrderShipment? shipment,
      String? note,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'customer_name') String? customerName,
      @JsonKey(name: 'customer_phone') String? customerPhone,
      @JsonKey(name: 'customer_email') String? customerEmail,
      OrderCustomer? customer,
      OrderShipping? shipping,
      OrderPayment? payment,
      @JsonKey(name: 'status_history') List<OrderStatusHistory>? statusHistory,
      @JsonKey(name: 'email_flags') OrderEmailFlags? emailFlags,
      @JsonKey(name: 'is_deleted') bool isDeleted});

  $OrderStatusCopyWith<$Res> get status;
  $AddressCopyWith<$Res>? get address;
  $OrderTotalsCopyWith<$Res>? get totals;
  $OrderShipmentCopyWith<$Res>? get shipment;
  $OrderCustomerCopyWith<$Res>? get customer;
  $OrderShippingCopyWith<$Res>? get shipping;
  $OrderPaymentCopyWith<$Res>? get payment;
  $OrderEmailFlagsCopyWith<$Res>? get emailFlags;
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? status = null,
    Object? trackingNumber = freezed,
    Object? shippingProvider = freezed,
    Object? integrationCode = freezed,
    Object? address = freezed,
    Object? items = freezed,
    Object? totals = freezed,
    Object? shipment = freezed,
    Object? note = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? customerName = freezed,
    Object? customerPhone = freezed,
    Object? customerEmail = freezed,
    Object? customer = freezed,
    Object? shipping = freezed,
    Object? payment = freezed,
    Object? statusHistory = freezed,
    Object? emailFlags = freezed,
    Object? isDeleted = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      trackingNumber: freezed == trackingNumber
          ? _value.trackingNumber
          : trackingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      shippingProvider: freezed == shippingProvider
          ? _value.shippingProvider
          : shippingProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      integrationCode: freezed == integrationCode
          ? _value.integrationCode
          : integrationCode // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItem>?,
      totals: freezed == totals
          ? _value.totals
          : totals // ignore: cast_nullable_to_non_nullable
              as OrderTotals?,
      shipment: freezed == shipment
          ? _value.shipment
          : shipment // ignore: cast_nullable_to_non_nullable
              as OrderShipment?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      customerPhone: freezed == customerPhone
          ? _value.customerPhone
          : customerPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      customerEmail: freezed == customerEmail
          ? _value.customerEmail
          : customerEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as OrderCustomer?,
      shipping: freezed == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as OrderShipping?,
      payment: freezed == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as OrderPayment?,
      statusHistory: freezed == statusHistory
          ? _value.statusHistory
          : statusHistory // ignore: cast_nullable_to_non_nullable
              as List<OrderStatusHistory>?,
      emailFlags: freezed == emailFlags
          ? _value.emailFlags
          : emailFlags // ignore: cast_nullable_to_non_nullable
              as OrderEmailFlags?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderStatusCopyWith<$Res> get status {
    return $OrderStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderTotalsCopyWith<$Res>? get totals {
    if (_value.totals == null) {
      return null;
    }

    return $OrderTotalsCopyWith<$Res>(_value.totals!, (value) {
      return _then(_value.copyWith(totals: value) as $Val);
    });
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderShipmentCopyWith<$Res>? get shipment {
    if (_value.shipment == null) {
      return null;
    }

    return $OrderShipmentCopyWith<$Res>(_value.shipment!, (value) {
      return _then(_value.copyWith(shipment: value) as $Val);
    });
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderCustomerCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $OrderCustomerCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderShippingCopyWith<$Res>? get shipping {
    if (_value.shipping == null) {
      return null;
    }

    return $OrderShippingCopyWith<$Res>(_value.shipping!, (value) {
      return _then(_value.copyWith(shipping: value) as $Val);
    });
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderPaymentCopyWith<$Res>? get payment {
    if (_value.payment == null) {
      return null;
    }

    return $OrderPaymentCopyWith<$Res>(_value.payment!, (value) {
      return _then(_value.copyWith(payment: value) as $Val);
    });
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderEmailFlagsCopyWith<$Res>? get emailFlags {
    if (_value.emailFlags == null) {
      return null;
    }

    return $OrderEmailFlagsCopyWith<$Res>(_value.emailFlags!, (value) {
      return _then(_value.copyWith(emailFlags: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
          _$OrderImpl value, $Res Function(_$OrderImpl) then) =
      __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
      OrderStatus status,
      @JsonKey(name: 'tracking_number') String? trackingNumber,
      @JsonKey(name: 'shipping_provider') String? shippingProvider,
      @JsonKey(name: 'integration_code') String? integrationCode,
      Address? address,
      List<OrderItem>? items,
      OrderTotals? totals,
      OrderShipment? shipment,
      String? note,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'customer_name') String? customerName,
      @JsonKey(name: 'customer_phone') String? customerPhone,
      @JsonKey(name: 'customer_email') String? customerEmail,
      OrderCustomer? customer,
      OrderShipping? shipping,
      OrderPayment? payment,
      @JsonKey(name: 'status_history') List<OrderStatusHistory>? statusHistory,
      @JsonKey(name: 'email_flags') OrderEmailFlags? emailFlags,
      @JsonKey(name: 'is_deleted') bool isDeleted});

  @override
  $OrderStatusCopyWith<$Res> get status;
  @override
  $AddressCopyWith<$Res>? get address;
  @override
  $OrderTotalsCopyWith<$Res>? get totals;
  @override
  $OrderShipmentCopyWith<$Res>? get shipment;
  @override
  $OrderCustomerCopyWith<$Res>? get customer;
  @override
  $OrderShippingCopyWith<$Res>? get shipping;
  @override
  $OrderPaymentCopyWith<$Res>? get payment;
  @override
  $OrderEmailFlagsCopyWith<$Res>? get emailFlags;
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
      _$OrderImpl _value, $Res Function(_$OrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? status = null,
    Object? trackingNumber = freezed,
    Object? shippingProvider = freezed,
    Object? integrationCode = freezed,
    Object? address = freezed,
    Object? items = freezed,
    Object? totals = freezed,
    Object? shipment = freezed,
    Object? note = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? customerName = freezed,
    Object? customerPhone = freezed,
    Object? customerEmail = freezed,
    Object? customer = freezed,
    Object? shipping = freezed,
    Object? payment = freezed,
    Object? statusHistory = freezed,
    Object? emailFlags = freezed,
    Object? isDeleted = null,
  }) {
    return _then(_$OrderImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      trackingNumber: freezed == trackingNumber
          ? _value.trackingNumber
          : trackingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      shippingProvider: freezed == shippingProvider
          ? _value.shippingProvider
          : shippingProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      integrationCode: freezed == integrationCode
          ? _value.integrationCode
          : integrationCode // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItem>?,
      totals: freezed == totals
          ? _value.totals
          : totals // ignore: cast_nullable_to_non_nullable
              as OrderTotals?,
      shipment: freezed == shipment
          ? _value.shipment
          : shipment // ignore: cast_nullable_to_non_nullable
              as OrderShipment?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      customerPhone: freezed == customerPhone
          ? _value.customerPhone
          : customerPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      customerEmail: freezed == customerEmail
          ? _value.customerEmail
          : customerEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as OrderCustomer?,
      shipping: freezed == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as OrderShipping?,
      payment: freezed == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as OrderPayment?,
      statusHistory: freezed == statusHistory
          ? _value._statusHistory
          : statusHistory // ignore: cast_nullable_to_non_nullable
              as List<OrderStatusHistory>?,
      emailFlags: freezed == emailFlags
          ? _value.emailFlags
          : emailFlags // ignore: cast_nullable_to_non_nullable
              as OrderEmailFlags?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl(
      {this.id,
      @JsonKey(name: 'user_id') this.userId,
      @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
      required this.status,
      @JsonKey(name: 'tracking_number') this.trackingNumber,
      @JsonKey(name: 'shipping_provider') this.shippingProvider,
      @JsonKey(name: 'integration_code') this.integrationCode,
      this.address,
      final List<OrderItem>? items,
      this.totals,
      this.shipment,
      this.note,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'customer_name') this.customerName,
      @JsonKey(name: 'customer_phone') this.customerPhone,
      @JsonKey(name: 'customer_email') this.customerEmail,
      this.customer,
      this.shipping,
      this.payment,
      @JsonKey(name: 'status_history')
      final List<OrderStatusHistory>? statusHistory,
      @JsonKey(name: 'email_flags') this.emailFlags,
      @JsonKey(name: 'is_deleted') this.isDeleted = false})
      : _items = items,
        _statusHistory = statusHistory;

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  final OrderStatus status;
  @override
  @JsonKey(name: 'tracking_number')
  final String? trackingNumber;
  @override
  @JsonKey(name: 'shipping_provider')
  final String? shippingProvider;
  @override
  @JsonKey(name: 'integration_code')
  final String? integrationCode;
  @override
  final Address? address;
  final List<OrderItem>? _items;
  @override
  List<OrderItem>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final OrderTotals? totals;
  @override
  final OrderShipment? shipment;
  @override
  final String? note;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'customer_name')
  final String? customerName;
  @override
  @JsonKey(name: 'customer_phone')
  final String? customerPhone;
  @override
  @JsonKey(name: 'customer_email')
  final String? customerEmail;
// New backend fields
  @override
  final OrderCustomer? customer;
  @override
  final OrderShipping? shipping;
  @override
  final OrderPayment? payment;
  final List<OrderStatusHistory>? _statusHistory;
  @override
  @JsonKey(name: 'status_history')
  List<OrderStatusHistory>? get statusHistory {
    final value = _statusHistory;
    if (value == null) return null;
    if (_statusHistory is EqualUnmodifiableListView) return _statusHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'email_flags')
  final OrderEmailFlags? emailFlags;
  @override
  @JsonKey(name: 'is_deleted')
  final bool isDeleted;

  @override
  String toString() {
    return 'Order(id: $id, userId: $userId, status: $status, trackingNumber: $trackingNumber, shippingProvider: $shippingProvider, integrationCode: $integrationCode, address: $address, items: $items, totals: $totals, shipment: $shipment, note: $note, createdAt: $createdAt, updatedAt: $updatedAt, customerName: $customerName, customerPhone: $customerPhone, customerEmail: $customerEmail, customer: $customer, shipping: $shipping, payment: $payment, statusHistory: $statusHistory, emailFlags: $emailFlags, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.trackingNumber, trackingNumber) ||
                other.trackingNumber == trackingNumber) &&
            (identical(other.shippingProvider, shippingProvider) ||
                other.shippingProvider == shippingProvider) &&
            (identical(other.integrationCode, integrationCode) ||
                other.integrationCode == integrationCode) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totals, totals) || other.totals == totals) &&
            (identical(other.shipment, shipment) ||
                other.shipment == shipment) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerPhone, customerPhone) ||
                other.customerPhone == customerPhone) &&
            (identical(other.customerEmail, customerEmail) ||
                other.customerEmail == customerEmail) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.shipping, shipping) ||
                other.shipping == shipping) &&
            (identical(other.payment, payment) || other.payment == payment) &&
            const DeepCollectionEquality()
                .equals(other._statusHistory, _statusHistory) &&
            (identical(other.emailFlags, emailFlags) ||
                other.emailFlags == emailFlags) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        status,
        trackingNumber,
        shippingProvider,
        integrationCode,
        address,
        const DeepCollectionEquality().hash(_items),
        totals,
        shipment,
        note,
        createdAt,
        updatedAt,
        customerName,
        customerPhone,
        customerEmail,
        customer,
        shipping,
        payment,
        const DeepCollectionEquality().hash(_statusHistory),
        emailFlags,
        isDeleted
      ]);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(
      this,
    );
  }
}

abstract class _Order implements Order {
  const factory _Order(
      {final String? id,
      @JsonKey(name: 'user_id') final String? userId,
      @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
      required final OrderStatus status,
      @JsonKey(name: 'tracking_number') final String? trackingNumber,
      @JsonKey(name: 'shipping_provider') final String? shippingProvider,
      @JsonKey(name: 'integration_code') final String? integrationCode,
      final Address? address,
      final List<OrderItem>? items,
      final OrderTotals? totals,
      final OrderShipment? shipment,
      final String? note,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      @JsonKey(name: 'customer_name') final String? customerName,
      @JsonKey(name: 'customer_phone') final String? customerPhone,
      @JsonKey(name: 'customer_email') final String? customerEmail,
      final OrderCustomer? customer,
      final OrderShipping? shipping,
      final OrderPayment? payment,
      @JsonKey(name: 'status_history')
      final List<OrderStatusHistory>? statusHistory,
      @JsonKey(name: 'email_flags') final OrderEmailFlags? emailFlags,
      @JsonKey(name: 'is_deleted') final bool isDeleted}) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
  OrderStatus get status;
  @override
  @JsonKey(name: 'tracking_number')
  String? get trackingNumber;
  @override
  @JsonKey(name: 'shipping_provider')
  String? get shippingProvider;
  @override
  @JsonKey(name: 'integration_code')
  String? get integrationCode;
  @override
  Address? get address;
  @override
  List<OrderItem>? get items;
  @override
  OrderTotals? get totals;
  @override
  OrderShipment? get shipment;
  @override
  String? get note;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'customer_name')
  String? get customerName;
  @override
  @JsonKey(name: 'customer_phone')
  String? get customerPhone;
  @override
  @JsonKey(name: 'customer_email')
  String? get customerEmail; // New backend fields
  @override
  OrderCustomer? get customer;
  @override
  OrderShipping? get shipping;
  @override
  OrderPayment? get payment;
  @override
  @JsonKey(name: 'status_history')
  List<OrderStatusHistory>? get statusHistory;
  @override
  @JsonKey(name: 'email_flags')
  OrderEmailFlags? get emailFlags;
  @override
  @JsonKey(name: 'is_deleted')
  bool get isDeleted;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderCreateRequest _$OrderCreateRequestFromJson(Map<String, dynamic> json) {
  return _OrderCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$OrderCreateRequest {
  List<OrderCreateItem> get items => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this OrderCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCreateRequestCopyWith<OrderCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCreateRequestCopyWith<$Res> {
  factory $OrderCreateRequestCopyWith(
          OrderCreateRequest value, $Res Function(OrderCreateRequest) then) =
      _$OrderCreateRequestCopyWithImpl<$Res, OrderCreateRequest>;
  @useResult
  $Res call({List<OrderCreateItem> items, String? note});
}

/// @nodoc
class _$OrderCreateRequestCopyWithImpl<$Res, $Val extends OrderCreateRequest>
    implements $OrderCreateRequestCopyWith<$Res> {
  _$OrderCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderCreateItem>,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderCreateRequestImplCopyWith<$Res>
    implements $OrderCreateRequestCopyWith<$Res> {
  factory _$$OrderCreateRequestImplCopyWith(_$OrderCreateRequestImpl value,
          $Res Function(_$OrderCreateRequestImpl) then) =
      __$$OrderCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<OrderCreateItem> items, String? note});
}

/// @nodoc
class __$$OrderCreateRequestImplCopyWithImpl<$Res>
    extends _$OrderCreateRequestCopyWithImpl<$Res, _$OrderCreateRequestImpl>
    implements _$$OrderCreateRequestImplCopyWith<$Res> {
  __$$OrderCreateRequestImplCopyWithImpl(_$OrderCreateRequestImpl _value,
      $Res Function(_$OrderCreateRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? note = freezed,
  }) {
    return _then(_$OrderCreateRequestImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderCreateItem>,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderCreateRequestImpl implements _OrderCreateRequest {
  const _$OrderCreateRequestImpl(
      {required final List<OrderCreateItem> items, this.note})
      : _items = items;

  factory _$OrderCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderCreateRequestImplFromJson(json);

  final List<OrderCreateItem> _items;
  @override
  List<OrderCreateItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final String? note;

  @override
  String toString() {
    return 'OrderCreateRequest(items: $items, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderCreateRequestImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), note);

  /// Create a copy of OrderCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderCreateRequestImplCopyWith<_$OrderCreateRequestImpl> get copyWith =>
      __$$OrderCreateRequestImplCopyWithImpl<_$OrderCreateRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderCreateRequestImplToJson(
      this,
    );
  }
}

abstract class _OrderCreateRequest implements OrderCreateRequest {
  const factory _OrderCreateRequest(
      {required final List<OrderCreateItem> items,
      final String? note}) = _$OrderCreateRequestImpl;

  factory _OrderCreateRequest.fromJson(Map<String, dynamic> json) =
      _$OrderCreateRequestImpl.fromJson;

  @override
  List<OrderCreateItem> get items;
  @override
  String? get note;

  /// Create a copy of OrderCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderCreateRequestImplCopyWith<_$OrderCreateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderCreateItem _$OrderCreateItemFromJson(Map<String, dynamic> json) {
  return _OrderCreateItem.fromJson(json);
}

/// @nodoc
mixin _$OrderCreateItem {
  @JsonKey(name: 'product_id')
  String get productId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;

  /// Serializes this OrderCreateItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderCreateItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCreateItemCopyWith<OrderCreateItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCreateItemCopyWith<$Res> {
  factory $OrderCreateItemCopyWith(
          OrderCreateItem value, $Res Function(OrderCreateItem) then) =
      _$OrderCreateItemCopyWithImpl<$Res, OrderCreateItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') String productId,
      String name,
      int quantity,
      double price});
}

/// @nodoc
class _$OrderCreateItemCopyWithImpl<$Res, $Val extends OrderCreateItem>
    implements $OrderCreateItemCopyWith<$Res> {
  _$OrderCreateItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderCreateItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? name = null,
    Object? quantity = null,
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderCreateItemImplCopyWith<$Res>
    implements $OrderCreateItemCopyWith<$Res> {
  factory _$$OrderCreateItemImplCopyWith(_$OrderCreateItemImpl value,
          $Res Function(_$OrderCreateItemImpl) then) =
      __$$OrderCreateItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') String productId,
      String name,
      int quantity,
      double price});
}

/// @nodoc
class __$$OrderCreateItemImplCopyWithImpl<$Res>
    extends _$OrderCreateItemCopyWithImpl<$Res, _$OrderCreateItemImpl>
    implements _$$OrderCreateItemImplCopyWith<$Res> {
  __$$OrderCreateItemImplCopyWithImpl(
      _$OrderCreateItemImpl _value, $Res Function(_$OrderCreateItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderCreateItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? name = null,
    Object? quantity = null,
    Object? price = null,
  }) {
    return _then(_$OrderCreateItemImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderCreateItemImpl implements _OrderCreateItem {
  const _$OrderCreateItemImpl(
      {@JsonKey(name: 'product_id') required this.productId,
      required this.name,
      required this.quantity,
      required this.price});

  factory _$OrderCreateItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderCreateItemImplFromJson(json);

  @override
  @JsonKey(name: 'product_id')
  final String productId;
  @override
  final String name;
  @override
  final int quantity;
  @override
  final double price;

  @override
  String toString() {
    return 'OrderCreateItem(productId: $productId, name: $name, quantity: $quantity, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderCreateItemImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, productId, name, quantity, price);

  /// Create a copy of OrderCreateItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderCreateItemImplCopyWith<_$OrderCreateItemImpl> get copyWith =>
      __$$OrderCreateItemImplCopyWithImpl<_$OrderCreateItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderCreateItemImplToJson(
      this,
    );
  }
}

abstract class _OrderCreateItem implements OrderCreateItem {
  const factory _OrderCreateItem(
      {@JsonKey(name: 'product_id') required final String productId,
      required final String name,
      required final int quantity,
      required final double price}) = _$OrderCreateItemImpl;

  factory _OrderCreateItem.fromJson(Map<String, dynamic> json) =
      _$OrderCreateItemImpl.fromJson;

  @override
  @JsonKey(name: 'product_id')
  String get productId;
  @override
  String get name;
  @override
  int get quantity;
  @override
  double get price;

  /// Create a copy of OrderCreateItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderCreateItemImplCopyWith<_$OrderCreateItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrdersListResponse _$OrdersListResponseFromJson(Map<String, dynamic> json) {
  return _OrdersListResponse.fromJson(json);
}

/// @nodoc
mixin _$OrdersListResponse {
  List<Order> get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_cursor')
  String? get nextCursor => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  /// Serializes this OrdersListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrdersListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrdersListResponseCopyWith<OrdersListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersListResponseCopyWith<$Res> {
  factory $OrdersListResponseCopyWith(
          OrdersListResponse value, $Res Function(OrdersListResponse) then) =
      _$OrdersListResponseCopyWithImpl<$Res, OrdersListResponse>;
  @useResult
  $Res call(
      {List<Order> items,
      @JsonKey(name: 'next_cursor') String? nextCursor,
      int count});
}

/// @nodoc
class _$OrdersListResponseCopyWithImpl<$Res, $Val extends OrdersListResponse>
    implements $OrdersListResponseCopyWith<$Res> {
  _$OrdersListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrdersListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? nextCursor = freezed,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Order>,
      nextCursor: freezed == nextCursor
          ? _value.nextCursor
          : nextCursor // ignore: cast_nullable_to_non_nullable
              as String?,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrdersListResponseImplCopyWith<$Res>
    implements $OrdersListResponseCopyWith<$Res> {
  factory _$$OrdersListResponseImplCopyWith(_$OrdersListResponseImpl value,
          $Res Function(_$OrdersListResponseImpl) then) =
      __$$OrdersListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Order> items,
      @JsonKey(name: 'next_cursor') String? nextCursor,
      int count});
}

/// @nodoc
class __$$OrdersListResponseImplCopyWithImpl<$Res>
    extends _$OrdersListResponseCopyWithImpl<$Res, _$OrdersListResponseImpl>
    implements _$$OrdersListResponseImplCopyWith<$Res> {
  __$$OrdersListResponseImplCopyWithImpl(_$OrdersListResponseImpl _value,
      $Res Function(_$OrdersListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrdersListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? nextCursor = freezed,
    Object? count = null,
  }) {
    return _then(_$OrdersListResponseImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Order>,
      nextCursor: freezed == nextCursor
          ? _value.nextCursor
          : nextCursor // ignore: cast_nullable_to_non_nullable
              as String?,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrdersListResponseImpl implements _OrdersListResponse {
  const _$OrdersListResponseImpl(
      {required final List<Order> items,
      @JsonKey(name: 'next_cursor') this.nextCursor,
      required this.count})
      : _items = items;

  factory _$OrdersListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrdersListResponseImplFromJson(json);

  final List<Order> _items;
  @override
  List<Order> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(name: 'next_cursor')
  final String? nextCursor;
  @override
  final int count;

  @override
  String toString() {
    return 'OrdersListResponse(items: $items, nextCursor: $nextCursor, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrdersListResponseImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.nextCursor, nextCursor) ||
                other.nextCursor == nextCursor) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_items), nextCursor, count);

  /// Create a copy of OrdersListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrdersListResponseImplCopyWith<_$OrdersListResponseImpl> get copyWith =>
      __$$OrdersListResponseImplCopyWithImpl<_$OrdersListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrdersListResponseImplToJson(
      this,
    );
  }
}

abstract class _OrdersListResponse implements OrdersListResponse {
  const factory _OrdersListResponse(
      {required final List<Order> items,
      @JsonKey(name: 'next_cursor') final String? nextCursor,
      required final int count}) = _$OrdersListResponseImpl;

  factory _OrdersListResponse.fromJson(Map<String, dynamic> json) =
      _$OrdersListResponseImpl.fromJson;

  @override
  List<Order> get items;
  @override
  @JsonKey(name: 'next_cursor')
  String? get nextCursor;
  @override
  int get count;

  /// Create a copy of OrdersListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrdersListResponseImplCopyWith<_$OrdersListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdminOrdersQueueResponse _$AdminOrdersQueueResponseFromJson(
    Map<String, dynamic> json) {
  return _AdminOrdersQueueResponse.fromJson(json);
}

/// @nodoc
mixin _$AdminOrdersQueueResponse {
  List<Order> get preparing => throw _privateConstructorUsedError;
  List<Order> get shipped => throw _privateConstructorUsedError;
  AdminOrdersCount get count => throw _privateConstructorUsedError;

  /// Serializes this AdminOrdersQueueResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminOrdersQueueResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminOrdersQueueResponseCopyWith<AdminOrdersQueueResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminOrdersQueueResponseCopyWith<$Res> {
  factory $AdminOrdersQueueResponseCopyWith(AdminOrdersQueueResponse value,
          $Res Function(AdminOrdersQueueResponse) then) =
      _$AdminOrdersQueueResponseCopyWithImpl<$Res, AdminOrdersQueueResponse>;
  @useResult
  $Res call(
      {List<Order> preparing, List<Order> shipped, AdminOrdersCount count});

  $AdminOrdersCountCopyWith<$Res> get count;
}

/// @nodoc
class _$AdminOrdersQueueResponseCopyWithImpl<$Res,
        $Val extends AdminOrdersQueueResponse>
    implements $AdminOrdersQueueResponseCopyWith<$Res> {
  _$AdminOrdersQueueResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminOrdersQueueResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preparing = null,
    Object? shipped = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      preparing: null == preparing
          ? _value.preparing
          : preparing // ignore: cast_nullable_to_non_nullable
              as List<Order>,
      shipped: null == shipped
          ? _value.shipped
          : shipped // ignore: cast_nullable_to_non_nullable
              as List<Order>,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as AdminOrdersCount,
    ) as $Val);
  }

  /// Create a copy of AdminOrdersQueueResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AdminOrdersCountCopyWith<$Res> get count {
    return $AdminOrdersCountCopyWith<$Res>(_value.count, (value) {
      return _then(_value.copyWith(count: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AdminOrdersQueueResponseImplCopyWith<$Res>
    implements $AdminOrdersQueueResponseCopyWith<$Res> {
  factory _$$AdminOrdersQueueResponseImplCopyWith(
          _$AdminOrdersQueueResponseImpl value,
          $Res Function(_$AdminOrdersQueueResponseImpl) then) =
      __$$AdminOrdersQueueResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Order> preparing, List<Order> shipped, AdminOrdersCount count});

  @override
  $AdminOrdersCountCopyWith<$Res> get count;
}

/// @nodoc
class __$$AdminOrdersQueueResponseImplCopyWithImpl<$Res>
    extends _$AdminOrdersQueueResponseCopyWithImpl<$Res,
        _$AdminOrdersQueueResponseImpl>
    implements _$$AdminOrdersQueueResponseImplCopyWith<$Res> {
  __$$AdminOrdersQueueResponseImplCopyWithImpl(
      _$AdminOrdersQueueResponseImpl _value,
      $Res Function(_$AdminOrdersQueueResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminOrdersQueueResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preparing = null,
    Object? shipped = null,
    Object? count = null,
  }) {
    return _then(_$AdminOrdersQueueResponseImpl(
      preparing: null == preparing
          ? _value._preparing
          : preparing // ignore: cast_nullable_to_non_nullable
              as List<Order>,
      shipped: null == shipped
          ? _value._shipped
          : shipped // ignore: cast_nullable_to_non_nullable
              as List<Order>,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as AdminOrdersCount,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminOrdersQueueResponseImpl implements _AdminOrdersQueueResponse {
  const _$AdminOrdersQueueResponseImpl(
      {required final List<Order> preparing,
      required final List<Order> shipped,
      required this.count})
      : _preparing = preparing,
        _shipped = shipped;

  factory _$AdminOrdersQueueResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminOrdersQueueResponseImplFromJson(json);

  final List<Order> _preparing;
  @override
  List<Order> get preparing {
    if (_preparing is EqualUnmodifiableListView) return _preparing;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preparing);
  }

  final List<Order> _shipped;
  @override
  List<Order> get shipped {
    if (_shipped is EqualUnmodifiableListView) return _shipped;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shipped);
  }

  @override
  final AdminOrdersCount count;

  @override
  String toString() {
    return 'AdminOrdersQueueResponse(preparing: $preparing, shipped: $shipped, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminOrdersQueueResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._preparing, _preparing) &&
            const DeepCollectionEquality().equals(other._shipped, _shipped) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_preparing),
      const DeepCollectionEquality().hash(_shipped),
      count);

  /// Create a copy of AdminOrdersQueueResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminOrdersQueueResponseImplCopyWith<_$AdminOrdersQueueResponseImpl>
      get copyWith => __$$AdminOrdersQueueResponseImplCopyWithImpl<
          _$AdminOrdersQueueResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminOrdersQueueResponseImplToJson(
      this,
    );
  }
}

abstract class _AdminOrdersQueueResponse implements AdminOrdersQueueResponse {
  const factory _AdminOrdersQueueResponse(
      {required final List<Order> preparing,
      required final List<Order> shipped,
      required final AdminOrdersCount count}) = _$AdminOrdersQueueResponseImpl;

  factory _AdminOrdersQueueResponse.fromJson(Map<String, dynamic> json) =
      _$AdminOrdersQueueResponseImpl.fromJson;

  @override
  List<Order> get preparing;
  @override
  List<Order> get shipped;
  @override
  AdminOrdersCount get count;

  /// Create a copy of AdminOrdersQueueResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminOrdersQueueResponseImplCopyWith<_$AdminOrdersQueueResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AdminOrdersCount _$AdminOrdersCountFromJson(Map<String, dynamic> json) {
  return _AdminOrdersCount.fromJson(json);
}

/// @nodoc
mixin _$AdminOrdersCount {
  int get preparing => throw _privateConstructorUsedError;
  int get shipped => throw _privateConstructorUsedError;

  /// Serializes this AdminOrdersCount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminOrdersCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminOrdersCountCopyWith<AdminOrdersCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminOrdersCountCopyWith<$Res> {
  factory $AdminOrdersCountCopyWith(
          AdminOrdersCount value, $Res Function(AdminOrdersCount) then) =
      _$AdminOrdersCountCopyWithImpl<$Res, AdminOrdersCount>;
  @useResult
  $Res call({int preparing, int shipped});
}

/// @nodoc
class _$AdminOrdersCountCopyWithImpl<$Res, $Val extends AdminOrdersCount>
    implements $AdminOrdersCountCopyWith<$Res> {
  _$AdminOrdersCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminOrdersCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preparing = null,
    Object? shipped = null,
  }) {
    return _then(_value.copyWith(
      preparing: null == preparing
          ? _value.preparing
          : preparing // ignore: cast_nullable_to_non_nullable
              as int,
      shipped: null == shipped
          ? _value.shipped
          : shipped // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminOrdersCountImplCopyWith<$Res>
    implements $AdminOrdersCountCopyWith<$Res> {
  factory _$$AdminOrdersCountImplCopyWith(_$AdminOrdersCountImpl value,
          $Res Function(_$AdminOrdersCountImpl) then) =
      __$$AdminOrdersCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int preparing, int shipped});
}

/// @nodoc
class __$$AdminOrdersCountImplCopyWithImpl<$Res>
    extends _$AdminOrdersCountCopyWithImpl<$Res, _$AdminOrdersCountImpl>
    implements _$$AdminOrdersCountImplCopyWith<$Res> {
  __$$AdminOrdersCountImplCopyWithImpl(_$AdminOrdersCountImpl _value,
      $Res Function(_$AdminOrdersCountImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminOrdersCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preparing = null,
    Object? shipped = null,
  }) {
    return _then(_$AdminOrdersCountImpl(
      preparing: null == preparing
          ? _value.preparing
          : preparing // ignore: cast_nullable_to_non_nullable
              as int,
      shipped: null == shipped
          ? _value.shipped
          : shipped // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminOrdersCountImpl implements _AdminOrdersCount {
  const _$AdminOrdersCountImpl(
      {required this.preparing, required this.shipped});

  factory _$AdminOrdersCountImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminOrdersCountImplFromJson(json);

  @override
  final int preparing;
  @override
  final int shipped;

  @override
  String toString() {
    return 'AdminOrdersCount(preparing: $preparing, shipped: $shipped)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminOrdersCountImpl &&
            (identical(other.preparing, preparing) ||
                other.preparing == preparing) &&
            (identical(other.shipped, shipped) || other.shipped == shipped));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, preparing, shipped);

  /// Create a copy of AdminOrdersCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminOrdersCountImplCopyWith<_$AdminOrdersCountImpl> get copyWith =>
      __$$AdminOrdersCountImplCopyWithImpl<_$AdminOrdersCountImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminOrdersCountImplToJson(
      this,
    );
  }
}

abstract class _AdminOrdersCount implements AdminOrdersCount {
  const factory _AdminOrdersCount(
      {required final int preparing,
      required final int shipped}) = _$AdminOrdersCountImpl;

  factory _AdminOrdersCount.fromJson(Map<String, dynamic> json) =
      _$AdminOrdersCountImpl.fromJson;

  @override
  int get preparing;
  @override
  int get shipped;

  /// Create a copy of AdminOrdersCount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminOrdersCountImplCopyWith<_$AdminOrdersCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderShipRequest _$OrderShipRequestFromJson(Map<String, dynamic> json) {
  return _OrderShipRequest.fromJson(json);
}

/// @nodoc
mixin _$OrderShipRequest {
  @JsonKey(name: 'tracking_number')
  String? get trackingNumber => throw _privateConstructorUsedError;
  String get provider => throw _privateConstructorUsedError;

  /// Serializes this OrderShipRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderShipRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderShipRequestCopyWith<OrderShipRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderShipRequestCopyWith<$Res> {
  factory $OrderShipRequestCopyWith(
          OrderShipRequest value, $Res Function(OrderShipRequest) then) =
      _$OrderShipRequestCopyWithImpl<$Res, OrderShipRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'tracking_number') String? trackingNumber,
      String provider});
}

/// @nodoc
class _$OrderShipRequestCopyWithImpl<$Res, $Val extends OrderShipRequest>
    implements $OrderShipRequestCopyWith<$Res> {
  _$OrderShipRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderShipRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trackingNumber = freezed,
    Object? provider = null,
  }) {
    return _then(_value.copyWith(
      trackingNumber: freezed == trackingNumber
          ? _value.trackingNumber
          : trackingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderShipRequestImplCopyWith<$Res>
    implements $OrderShipRequestCopyWith<$Res> {
  factory _$$OrderShipRequestImplCopyWith(_$OrderShipRequestImpl value,
          $Res Function(_$OrderShipRequestImpl) then) =
      __$$OrderShipRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'tracking_number') String? trackingNumber,
      String provider});
}

/// @nodoc
class __$$OrderShipRequestImplCopyWithImpl<$Res>
    extends _$OrderShipRequestCopyWithImpl<$Res, _$OrderShipRequestImpl>
    implements _$$OrderShipRequestImplCopyWith<$Res> {
  __$$OrderShipRequestImplCopyWithImpl(_$OrderShipRequestImpl _value,
      $Res Function(_$OrderShipRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderShipRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trackingNumber = freezed,
    Object? provider = null,
  }) {
    return _then(_$OrderShipRequestImpl(
      trackingNumber: freezed == trackingNumber
          ? _value.trackingNumber
          : trackingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderShipRequestImpl implements _OrderShipRequest {
  const _$OrderShipRequestImpl(
      {@JsonKey(name: 'tracking_number') this.trackingNumber,
      this.provider = 'MANUAL'});

  factory _$OrderShipRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderShipRequestImplFromJson(json);

  @override
  @JsonKey(name: 'tracking_number')
  final String? trackingNumber;
  @override
  @JsonKey()
  final String provider;

  @override
  String toString() {
    return 'OrderShipRequest(trackingNumber: $trackingNumber, provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderShipRequestImpl &&
            (identical(other.trackingNumber, trackingNumber) ||
                other.trackingNumber == trackingNumber) &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, trackingNumber, provider);

  /// Create a copy of OrderShipRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderShipRequestImplCopyWith<_$OrderShipRequestImpl> get copyWith =>
      __$$OrderShipRequestImplCopyWithImpl<_$OrderShipRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderShipRequestImplToJson(
      this,
    );
  }
}

abstract class _OrderShipRequest implements OrderShipRequest {
  const factory _OrderShipRequest(
      {@JsonKey(name: 'tracking_number') final String? trackingNumber,
      final String provider}) = _$OrderShipRequestImpl;

  factory _OrderShipRequest.fromJson(Map<String, dynamic> json) =
      _$OrderShipRequestImpl.fromJson;

  @override
  @JsonKey(name: 'tracking_number')
  String? get trackingNumber;
  @override
  String get provider;

  /// Create a copy of OrderShipRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderShipRequestImplCopyWith<_$OrderShipRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderCancelRequest _$OrderCancelRequestFromJson(Map<String, dynamic> json) {
  return _OrderCancelRequest.fromJson(json);
}

/// @nodoc
mixin _$OrderCancelRequest {
  String get reason => throw _privateConstructorUsedError;

  /// Serializes this OrderCancelRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderCancelRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCancelRequestCopyWith<OrderCancelRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCancelRequestCopyWith<$Res> {
  factory $OrderCancelRequestCopyWith(
          OrderCancelRequest value, $Res Function(OrderCancelRequest) then) =
      _$OrderCancelRequestCopyWithImpl<$Res, OrderCancelRequest>;
  @useResult
  $Res call({String reason});
}

/// @nodoc
class _$OrderCancelRequestCopyWithImpl<$Res, $Val extends OrderCancelRequest>
    implements $OrderCancelRequestCopyWith<$Res> {
  _$OrderCancelRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderCancelRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
  }) {
    return _then(_value.copyWith(
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderCancelRequestImplCopyWith<$Res>
    implements $OrderCancelRequestCopyWith<$Res> {
  factory _$$OrderCancelRequestImplCopyWith(_$OrderCancelRequestImpl value,
          $Res Function(_$OrderCancelRequestImpl) then) =
      __$$OrderCancelRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String reason});
}

/// @nodoc
class __$$OrderCancelRequestImplCopyWithImpl<$Res>
    extends _$OrderCancelRequestCopyWithImpl<$Res, _$OrderCancelRequestImpl>
    implements _$$OrderCancelRequestImplCopyWith<$Res> {
  __$$OrderCancelRequestImplCopyWithImpl(_$OrderCancelRequestImpl _value,
      $Res Function(_$OrderCancelRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderCancelRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
  }) {
    return _then(_$OrderCancelRequestImpl(
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderCancelRequestImpl implements _OrderCancelRequest {
  const _$OrderCancelRequestImpl({required this.reason});

  factory _$OrderCancelRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderCancelRequestImplFromJson(json);

  @override
  final String reason;

  @override
  String toString() {
    return 'OrderCancelRequest(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderCancelRequestImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reason);

  /// Create a copy of OrderCancelRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderCancelRequestImplCopyWith<_$OrderCancelRequestImpl> get copyWith =>
      __$$OrderCancelRequestImplCopyWithImpl<_$OrderCancelRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderCancelRequestImplToJson(
      this,
    );
  }
}

abstract class _OrderCancelRequest implements OrderCancelRequest {
  const factory _OrderCancelRequest({required final String reason}) =
      _$OrderCancelRequestImpl;

  factory _OrderCancelRequest.fromJson(Map<String, dynamic> json) =
      _$OrderCancelRequestImpl.fromJson;

  @override
  String get reason;

  /// Create a copy of OrderCancelRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderCancelRequestImplCopyWith<_$OrderCancelRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
