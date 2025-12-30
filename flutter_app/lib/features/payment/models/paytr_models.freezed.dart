// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paytr_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BasketItem _$BasketItemFromJson(Map<String, dynamic> json) {
  return _BasketItem.fromJson(json);
}

/// @nodoc
mixin _$BasketItem {
  String get name => throw _privateConstructorUsedError;
  double get price =>
      throw _privateConstructorUsedError; // TL cinsinden (örn: 10.00)
  int get quantity => throw _privateConstructorUsedError;

  /// Serializes this BasketItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BasketItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BasketItemCopyWith<BasketItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BasketItemCopyWith<$Res> {
  factory $BasketItemCopyWith(
          BasketItem value, $Res Function(BasketItem) then) =
      _$BasketItemCopyWithImpl<$Res, BasketItem>;
  @useResult
  $Res call({String name, double price, int quantity});
}

/// @nodoc
class _$BasketItemCopyWithImpl<$Res, $Val extends BasketItem>
    implements $BasketItemCopyWith<$Res> {
  _$BasketItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BasketItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? price = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BasketItemImplCopyWith<$Res>
    implements $BasketItemCopyWith<$Res> {
  factory _$$BasketItemImplCopyWith(
          _$BasketItemImpl value, $Res Function(_$BasketItemImpl) then) =
      __$$BasketItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, double price, int quantity});
}

/// @nodoc
class __$$BasketItemImplCopyWithImpl<$Res>
    extends _$BasketItemCopyWithImpl<$Res, _$BasketItemImpl>
    implements _$$BasketItemImplCopyWith<$Res> {
  __$$BasketItemImplCopyWithImpl(
      _$BasketItemImpl _value, $Res Function(_$BasketItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of BasketItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? price = null,
    Object? quantity = null,
  }) {
    return _then(_$BasketItemImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BasketItemImpl implements _BasketItem {
  const _$BasketItemImpl(
      {required this.name, required this.price, required this.quantity});

  factory _$BasketItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$BasketItemImplFromJson(json);

  @override
  final String name;
  @override
  final double price;
// TL cinsinden (örn: 10.00)
  @override
  final int quantity;

  @override
  String toString() {
    return 'BasketItem(name: $name, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BasketItemImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, price, quantity);

  /// Create a copy of BasketItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BasketItemImplCopyWith<_$BasketItemImpl> get copyWith =>
      __$$BasketItemImplCopyWithImpl<_$BasketItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BasketItemImplToJson(
      this,
    );
  }
}

abstract class _BasketItem implements BasketItem {
  const factory _BasketItem(
      {required final String name,
      required final double price,
      required final int quantity}) = _$BasketItemImpl;

  factory _BasketItem.fromJson(Map<String, dynamic> json) =
      _$BasketItemImpl.fromJson;

  @override
  String get name;
  @override
  double get price; // TL cinsinden (örn: 10.00)
  @override
  int get quantity;

  /// Create a copy of BasketItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BasketItemImplCopyWith<_$BasketItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PayTRInitRequest _$PayTRInitRequestFromJson(Map<String, dynamic> json) {
  return _PayTRInitRequest.fromJson(json);
}

/// @nodoc
mixin _$PayTRInitRequest {
  String get merchantOid =>
      throw _privateConstructorUsedError; // Sipariş ID (alfanümerik, maks 64)
  String get email => throw _privateConstructorUsedError;
  double get paymentAmount =>
      throw _privateConstructorUsedError; // TL cinsinden toplam tutar
  int get installmentCount =>
      throw _privateConstructorUsedError; // 0=tek çekim, 2-12=taksit
  String get userName => throw _privateConstructorUsedError;
  String get userAddress => throw _privateConstructorUsedError;
  String get userPhone => throw _privateConstructorUsedError;
  List<BasketItem> get basket => throw _privateConstructorUsedError;

  /// Serializes this PayTRInitRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayTRInitRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayTRInitRequestCopyWith<PayTRInitRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayTRInitRequestCopyWith<$Res> {
  factory $PayTRInitRequestCopyWith(
          PayTRInitRequest value, $Res Function(PayTRInitRequest) then) =
      _$PayTRInitRequestCopyWithImpl<$Res, PayTRInitRequest>;
  @useResult
  $Res call(
      {String merchantOid,
      String email,
      double paymentAmount,
      int installmentCount,
      String userName,
      String userAddress,
      String userPhone,
      List<BasketItem> basket});
}

/// @nodoc
class _$PayTRInitRequestCopyWithImpl<$Res, $Val extends PayTRInitRequest>
    implements $PayTRInitRequestCopyWith<$Res> {
  _$PayTRInitRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayTRInitRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantOid = null,
    Object? email = null,
    Object? paymentAmount = null,
    Object? installmentCount = null,
    Object? userName = null,
    Object? userAddress = null,
    Object? userPhone = null,
    Object? basket = null,
  }) {
    return _then(_value.copyWith(
      merchantOid: null == merchantOid
          ? _value.merchantOid
          : merchantOid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      paymentAmount: null == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      installmentCount: null == installmentCount
          ? _value.installmentCount
          : installmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userAddress: null == userAddress
          ? _value.userAddress
          : userAddress // ignore: cast_nullable_to_non_nullable
              as String,
      userPhone: null == userPhone
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String,
      basket: null == basket
          ? _value.basket
          : basket // ignore: cast_nullable_to_non_nullable
              as List<BasketItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayTRInitRequestImplCopyWith<$Res>
    implements $PayTRInitRequestCopyWith<$Res> {
  factory _$$PayTRInitRequestImplCopyWith(_$PayTRInitRequestImpl value,
          $Res Function(_$PayTRInitRequestImpl) then) =
      __$$PayTRInitRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String merchantOid,
      String email,
      double paymentAmount,
      int installmentCount,
      String userName,
      String userAddress,
      String userPhone,
      List<BasketItem> basket});
}

/// @nodoc
class __$$PayTRInitRequestImplCopyWithImpl<$Res>
    extends _$PayTRInitRequestCopyWithImpl<$Res, _$PayTRInitRequestImpl>
    implements _$$PayTRInitRequestImplCopyWith<$Res> {
  __$$PayTRInitRequestImplCopyWithImpl(_$PayTRInitRequestImpl _value,
      $Res Function(_$PayTRInitRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayTRInitRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantOid = null,
    Object? email = null,
    Object? paymentAmount = null,
    Object? installmentCount = null,
    Object? userName = null,
    Object? userAddress = null,
    Object? userPhone = null,
    Object? basket = null,
  }) {
    return _then(_$PayTRInitRequestImpl(
      merchantOid: null == merchantOid
          ? _value.merchantOid
          : merchantOid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      paymentAmount: null == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      installmentCount: null == installmentCount
          ? _value.installmentCount
          : installmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userAddress: null == userAddress
          ? _value.userAddress
          : userAddress // ignore: cast_nullable_to_non_nullable
              as String,
      userPhone: null == userPhone
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String,
      basket: null == basket
          ? _value._basket
          : basket // ignore: cast_nullable_to_non_nullable
              as List<BasketItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayTRInitRequestImpl implements _PayTRInitRequest {
  const _$PayTRInitRequestImpl(
      {required this.merchantOid,
      required this.email,
      required this.paymentAmount,
      this.installmentCount = 0,
      required this.userName,
      required this.userAddress,
      required this.userPhone,
      required final List<BasketItem> basket})
      : _basket = basket;

  factory _$PayTRInitRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayTRInitRequestImplFromJson(json);

  @override
  final String merchantOid;
// Sipariş ID (alfanümerik, maks 64)
  @override
  final String email;
  @override
  final double paymentAmount;
// TL cinsinden toplam tutar
  @override
  @JsonKey()
  final int installmentCount;
// 0=tek çekim, 2-12=taksit
  @override
  final String userName;
  @override
  final String userAddress;
  @override
  final String userPhone;
  final List<BasketItem> _basket;
  @override
  List<BasketItem> get basket {
    if (_basket is EqualUnmodifiableListView) return _basket;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_basket);
  }

  @override
  String toString() {
    return 'PayTRInitRequest(merchantOid: $merchantOid, email: $email, paymentAmount: $paymentAmount, installmentCount: $installmentCount, userName: $userName, userAddress: $userAddress, userPhone: $userPhone, basket: $basket)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayTRInitRequestImpl &&
            (identical(other.merchantOid, merchantOid) ||
                other.merchantOid == merchantOid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.paymentAmount, paymentAmount) ||
                other.paymentAmount == paymentAmount) &&
            (identical(other.installmentCount, installmentCount) ||
                other.installmentCount == installmentCount) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userAddress, userAddress) ||
                other.userAddress == userAddress) &&
            (identical(other.userPhone, userPhone) ||
                other.userPhone == userPhone) &&
            const DeepCollectionEquality().equals(other._basket, _basket));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      merchantOid,
      email,
      paymentAmount,
      installmentCount,
      userName,
      userAddress,
      userPhone,
      const DeepCollectionEquality().hash(_basket));

  /// Create a copy of PayTRInitRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayTRInitRequestImplCopyWith<_$PayTRInitRequestImpl> get copyWith =>
      __$$PayTRInitRequestImplCopyWithImpl<_$PayTRInitRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayTRInitRequestImplToJson(
      this,
    );
  }
}

abstract class _PayTRInitRequest implements PayTRInitRequest {
  const factory _PayTRInitRequest(
      {required final String merchantOid,
      required final String email,
      required final double paymentAmount,
      final int installmentCount,
      required final String userName,
      required final String userAddress,
      required final String userPhone,
      required final List<BasketItem> basket}) = _$PayTRInitRequestImpl;

  factory _PayTRInitRequest.fromJson(Map<String, dynamic> json) =
      _$PayTRInitRequestImpl.fromJson;

  @override
  String get merchantOid; // Sipariş ID (alfanümerik, maks 64)
  @override
  String get email;
  @override
  double get paymentAmount; // TL cinsinden toplam tutar
  @override
  int get installmentCount; // 0=tek çekim, 2-12=taksit
  @override
  String get userName;
  @override
  String get userAddress;
  @override
  String get userPhone;
  @override
  List<BasketItem> get basket;

  /// Create a copy of PayTRInitRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayTRInitRequestImplCopyWith<_$PayTRInitRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PayTRInitResponse {
  String get action =>
      throw _privateConstructorUsedError; // https://www.paytr.com/odeme
  Map<String, String> get fields => throw _privateConstructorUsedError;

  /// Create a copy of PayTRInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayTRInitResponseCopyWith<PayTRInitResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayTRInitResponseCopyWith<$Res> {
  factory $PayTRInitResponseCopyWith(
          PayTRInitResponse value, $Res Function(PayTRInitResponse) then) =
      _$PayTRInitResponseCopyWithImpl<$Res, PayTRInitResponse>;
  @useResult
  $Res call({String action, Map<String, String> fields});
}

/// @nodoc
class _$PayTRInitResponseCopyWithImpl<$Res, $Val extends PayTRInitResponse>
    implements $PayTRInitResponseCopyWith<$Res> {
  _$PayTRInitResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayTRInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? fields = null,
  }) {
    return _then(_value.copyWith(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayTRInitResponseImplCopyWith<$Res>
    implements $PayTRInitResponseCopyWith<$Res> {
  factory _$$PayTRInitResponseImplCopyWith(_$PayTRInitResponseImpl value,
          $Res Function(_$PayTRInitResponseImpl) then) =
      __$$PayTRInitResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String action, Map<String, String> fields});
}

/// @nodoc
class __$$PayTRInitResponseImplCopyWithImpl<$Res>
    extends _$PayTRInitResponseCopyWithImpl<$Res, _$PayTRInitResponseImpl>
    implements _$$PayTRInitResponseImplCopyWith<$Res> {
  __$$PayTRInitResponseImplCopyWithImpl(_$PayTRInitResponseImpl _value,
      $Res Function(_$PayTRInitResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayTRInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? fields = null,
  }) {
    return _then(_$PayTRInitResponseImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc

class _$PayTRInitResponseImpl implements _PayTRInitResponse {
  const _$PayTRInitResponseImpl(
      {required this.action, required final Map<String, String> fields})
      : _fields = fields;

  @override
  final String action;
// https://www.paytr.com/odeme
  final Map<String, String> _fields;
// https://www.paytr.com/odeme
  @override
  Map<String, String> get fields {
    if (_fields is EqualUnmodifiableMapView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fields);
  }

  @override
  String toString() {
    return 'PayTRInitResponse(action: $action, fields: $fields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayTRInitResponseImpl &&
            (identical(other.action, action) || other.action == action) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, action, const DeepCollectionEquality().hash(_fields));

  /// Create a copy of PayTRInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayTRInitResponseImplCopyWith<_$PayTRInitResponseImpl> get copyWith =>
      __$$PayTRInitResponseImplCopyWithImpl<_$PayTRInitResponseImpl>(
          this, _$identity);
}

abstract class _PayTRInitResponse implements PayTRInitResponse {
  const factory _PayTRInitResponse(
      {required final String action,
      required final Map<String, String> fields}) = _$PayTRInitResponseImpl;

  @override
  String get action; // https://www.paytr.com/odeme
  @override
  Map<String, String> get fields;

  /// Create a copy of PayTRInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayTRInitResponseImplCopyWith<_$PayTRInitResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CheckoutState {
  CheckoutStatus get status => throw _privateConstructorUsedError;
  String? get orderId => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  PayTRInitResponse? get paytrResponse => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckoutStateCopyWith<CheckoutState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutStateCopyWith<$Res> {
  factory $CheckoutStateCopyWith(
          CheckoutState value, $Res Function(CheckoutState) then) =
      _$CheckoutStateCopyWithImpl<$Res, CheckoutState>;
  @useResult
  $Res call(
      {CheckoutStatus status,
      String? orderId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      PayTRInitResponse? paytrResponse,
      String? errorMessage});

  $PayTRInitResponseCopyWith<$Res>? get paytrResponse;
}

/// @nodoc
class _$CheckoutStateCopyWithImpl<$Res, $Val extends CheckoutState>
    implements $CheckoutStateCopyWith<$Res> {
  _$CheckoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? orderId = freezed,
    Object? paytrResponse = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CheckoutStatus,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      paytrResponse: freezed == paytrResponse
          ? _value.paytrResponse
          : paytrResponse // ignore: cast_nullable_to_non_nullable
              as PayTRInitResponse?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PayTRInitResponseCopyWith<$Res>? get paytrResponse {
    if (_value.paytrResponse == null) {
      return null;
    }

    return $PayTRInitResponseCopyWith<$Res>(_value.paytrResponse!, (value) {
      return _then(_value.copyWith(paytrResponse: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CheckoutStateImplCopyWith<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  factory _$$CheckoutStateImplCopyWith(
          _$CheckoutStateImpl value, $Res Function(_$CheckoutStateImpl) then) =
      __$$CheckoutStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CheckoutStatus status,
      String? orderId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      PayTRInitResponse? paytrResponse,
      String? errorMessage});

  @override
  $PayTRInitResponseCopyWith<$Res>? get paytrResponse;
}

/// @nodoc
class __$$CheckoutStateImplCopyWithImpl<$Res>
    extends _$CheckoutStateCopyWithImpl<$Res, _$CheckoutStateImpl>
    implements _$$CheckoutStateImplCopyWith<$Res> {
  __$$CheckoutStateImplCopyWithImpl(
      _$CheckoutStateImpl _value, $Res Function(_$CheckoutStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? orderId = freezed,
    Object? paytrResponse = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$CheckoutStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CheckoutStatus,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      paytrResponse: freezed == paytrResponse
          ? _value.paytrResponse
          : paytrResponse // ignore: cast_nullable_to_non_nullable
              as PayTRInitResponse?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CheckoutStateImpl implements _CheckoutState {
  const _$CheckoutStateImpl(
      {this.status = CheckoutStatus.idle,
      this.orderId,
      @JsonKey(includeFromJson: false, includeToJson: false) this.paytrResponse,
      this.errorMessage});

  @override
  @JsonKey()
  final CheckoutStatus status;
  @override
  final String? orderId;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final PayTRInitResponse? paytrResponse;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CheckoutState(status: $status, orderId: $orderId, paytrResponse: $paytrResponse, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.paytrResponse, paytrResponse) ||
                other.paytrResponse == paytrResponse) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, orderId, paytrResponse, errorMessage);

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      __$$CheckoutStateImplCopyWithImpl<_$CheckoutStateImpl>(this, _$identity);
}

abstract class _CheckoutState implements CheckoutState {
  const factory _CheckoutState(
      {final CheckoutStatus status,
      final String? orderId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final PayTRInitResponse? paytrResponse,
      final String? errorMessage}) = _$CheckoutStateImpl;

  @override
  CheckoutStatus get status;
  @override
  String? get orderId;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  PayTRInitResponse? get paytrResponse;
  @override
  String? get errorMessage;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
