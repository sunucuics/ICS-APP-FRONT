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
      throw _privateConstructorUsedError; // 0=peşin, 3=3 taksit (sadece bu değerler geçerli)
  String get userName => throw _privateConstructorUsedError;
  String get userAddress => throw _privateConstructorUsedError;
  String get userPhone => throw _privateConstructorUsedError;
  List<BasketItem> get basket => throw _privateConstructorUsedError;
  String? get binNumber => throw _privateConstructorUsedError;

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
      List<BasketItem> basket,
      String? binNumber});
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
    Object? binNumber = freezed,
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
      binNumber: freezed == binNumber
          ? _value.binNumber
          : binNumber // ignore: cast_nullable_to_non_nullable
              as String?,
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
      List<BasketItem> basket,
      String? binNumber});
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
    Object? binNumber = freezed,
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
      binNumber: freezed == binNumber
          ? _value.binNumber
          : binNumber // ignore: cast_nullable_to_non_nullable
              as String?,
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
      required final List<BasketItem> basket,
      this.binNumber})
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
// 0=peşin, 3=3 taksit (sadece bu değerler geçerli)
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
  final String? binNumber;

  @override
  String toString() {
    return 'PayTRInitRequest(merchantOid: $merchantOid, email: $email, paymentAmount: $paymentAmount, installmentCount: $installmentCount, userName: $userName, userAddress: $userAddress, userPhone: $userPhone, basket: $basket, binNumber: $binNumber)';
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
            const DeepCollectionEquality().equals(other._basket, _basket) &&
            (identical(other.binNumber, binNumber) ||
                other.binNumber == binNumber));
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
      const DeepCollectionEquality().hash(_basket),
      binNumber);

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
      required final List<BasketItem> basket,
      final String? binNumber}) = _$PayTRInitRequestImpl;

  factory _PayTRInitRequest.fromJson(Map<String, dynamic> json) =
      _$PayTRInitRequestImpl.fromJson;

  @override
  String get merchantOid; // Sipariş ID (alfanümerik, maks 64)
  @override
  String get email;
  @override
  double get paymentAmount; // TL cinsinden toplam tutar
  @override
  int get installmentCount; // 0=peşin, 3=3 taksit (sadece bu değerler geçerli)
  @override
  String get userName;
  @override
  String get userAddress;
  @override
  String get userPhone;
  @override
  List<BasketItem> get basket;
  @override
  String? get binNumber;

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

BinDetailRequest _$BinDetailRequestFromJson(Map<String, dynamic> json) {
  return _BinDetailRequest.fromJson(json);
}

/// @nodoc
mixin _$BinDetailRequest {
  String get binNumber =>
      throw _privateConstructorUsedError; // Kartın ilk 6 veya 8 hanesi
  int get debugOn => throw _privateConstructorUsedError;

  /// Serializes this BinDetailRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BinDetailRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BinDetailRequestCopyWith<BinDetailRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BinDetailRequestCopyWith<$Res> {
  factory $BinDetailRequestCopyWith(
          BinDetailRequest value, $Res Function(BinDetailRequest) then) =
      _$BinDetailRequestCopyWithImpl<$Res, BinDetailRequest>;
  @useResult
  $Res call({String binNumber, int debugOn});
}

/// @nodoc
class _$BinDetailRequestCopyWithImpl<$Res, $Val extends BinDetailRequest>
    implements $BinDetailRequestCopyWith<$Res> {
  _$BinDetailRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BinDetailRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? binNumber = null,
    Object? debugOn = null,
  }) {
    return _then(_value.copyWith(
      binNumber: null == binNumber
          ? _value.binNumber
          : binNumber // ignore: cast_nullable_to_non_nullable
              as String,
      debugOn: null == debugOn
          ? _value.debugOn
          : debugOn // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BinDetailRequestImplCopyWith<$Res>
    implements $BinDetailRequestCopyWith<$Res> {
  factory _$$BinDetailRequestImplCopyWith(_$BinDetailRequestImpl value,
          $Res Function(_$BinDetailRequestImpl) then) =
      __$$BinDetailRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String binNumber, int debugOn});
}

/// @nodoc
class __$$BinDetailRequestImplCopyWithImpl<$Res>
    extends _$BinDetailRequestCopyWithImpl<$Res, _$BinDetailRequestImpl>
    implements _$$BinDetailRequestImplCopyWith<$Res> {
  __$$BinDetailRequestImplCopyWithImpl(_$BinDetailRequestImpl _value,
      $Res Function(_$BinDetailRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of BinDetailRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? binNumber = null,
    Object? debugOn = null,
  }) {
    return _then(_$BinDetailRequestImpl(
      binNumber: null == binNumber
          ? _value.binNumber
          : binNumber // ignore: cast_nullable_to_non_nullable
              as String,
      debugOn: null == debugOn
          ? _value.debugOn
          : debugOn // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BinDetailRequestImpl implements _BinDetailRequest {
  const _$BinDetailRequestImpl({required this.binNumber, this.debugOn = 0});

  factory _$BinDetailRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BinDetailRequestImplFromJson(json);

  @override
  final String binNumber;
// Kartın ilk 6 veya 8 hanesi
  @override
  @JsonKey()
  final int debugOn;

  @override
  String toString() {
    return 'BinDetailRequest(binNumber: $binNumber, debugOn: $debugOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BinDetailRequestImpl &&
            (identical(other.binNumber, binNumber) ||
                other.binNumber == binNumber) &&
            (identical(other.debugOn, debugOn) || other.debugOn == debugOn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, binNumber, debugOn);

  /// Create a copy of BinDetailRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BinDetailRequestImplCopyWith<_$BinDetailRequestImpl> get copyWith =>
      __$$BinDetailRequestImplCopyWithImpl<_$BinDetailRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BinDetailRequestImplToJson(
      this,
    );
  }
}

abstract class _BinDetailRequest implements BinDetailRequest {
  const factory _BinDetailRequest(
      {required final String binNumber,
      final int debugOn}) = _$BinDetailRequestImpl;

  factory _BinDetailRequest.fromJson(Map<String, dynamic> json) =
      _$BinDetailRequestImpl.fromJson;

  @override
  String get binNumber; // Kartın ilk 6 veya 8 hanesi
  @override
  int get debugOn;

  /// Create a copy of BinDetailRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BinDetailRequestImplCopyWith<_$BinDetailRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BinDetailResponse {
  String get status =>
      throw _privateConstructorUsedError; // "success" veya "failed"
  String? get cardType =>
      throw _privateConstructorUsedError; // "credit" veya "debit"
  String? get brand =>
      throw _privateConstructorUsedError; // "visa", "mastercard", "bonus", "world", vb.
  String? get bankName => throw _privateConstructorUsedError;
  String? get cardFamily => throw _privateConstructorUsedError;
  String? get errMsg => throw _privateConstructorUsedError; // Hata durumunda
  Map<String, dynamic>? get raw => throw _privateConstructorUsedError;

  /// Create a copy of BinDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BinDetailResponseCopyWith<BinDetailResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BinDetailResponseCopyWith<$Res> {
  factory $BinDetailResponseCopyWith(
          BinDetailResponse value, $Res Function(BinDetailResponse) then) =
      _$BinDetailResponseCopyWithImpl<$Res, BinDetailResponse>;
  @useResult
  $Res call(
      {String status,
      String? cardType,
      String? brand,
      String? bankName,
      String? cardFamily,
      String? errMsg,
      Map<String, dynamic>? raw});
}

/// @nodoc
class _$BinDetailResponseCopyWithImpl<$Res, $Val extends BinDetailResponse>
    implements $BinDetailResponseCopyWith<$Res> {
  _$BinDetailResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BinDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? cardType = freezed,
    Object? brand = freezed,
    Object? bankName = freezed,
    Object? cardFamily = freezed,
    Object? errMsg = freezed,
    Object? raw = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      cardType: freezed == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      cardFamily: freezed == cardFamily
          ? _value.cardFamily
          : cardFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      errMsg: freezed == errMsg
          ? _value.errMsg
          : errMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      raw: freezed == raw
          ? _value.raw
          : raw // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BinDetailResponseImplCopyWith<$Res>
    implements $BinDetailResponseCopyWith<$Res> {
  factory _$$BinDetailResponseImplCopyWith(_$BinDetailResponseImpl value,
          $Res Function(_$BinDetailResponseImpl) then) =
      __$$BinDetailResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status,
      String? cardType,
      String? brand,
      String? bankName,
      String? cardFamily,
      String? errMsg,
      Map<String, dynamic>? raw});
}

/// @nodoc
class __$$BinDetailResponseImplCopyWithImpl<$Res>
    extends _$BinDetailResponseCopyWithImpl<$Res, _$BinDetailResponseImpl>
    implements _$$BinDetailResponseImplCopyWith<$Res> {
  __$$BinDetailResponseImplCopyWithImpl(_$BinDetailResponseImpl _value,
      $Res Function(_$BinDetailResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of BinDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? cardType = freezed,
    Object? brand = freezed,
    Object? bankName = freezed,
    Object? cardFamily = freezed,
    Object? errMsg = freezed,
    Object? raw = freezed,
  }) {
    return _then(_$BinDetailResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      cardType: freezed == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      cardFamily: freezed == cardFamily
          ? _value.cardFamily
          : cardFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      errMsg: freezed == errMsg
          ? _value.errMsg
          : errMsg // ignore: cast_nullable_to_non_nullable
              as String?,
      raw: freezed == raw
          ? _value._raw
          : raw // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$BinDetailResponseImpl implements _BinDetailResponse {
  const _$BinDetailResponseImpl(
      {required this.status,
      this.cardType,
      this.brand,
      this.bankName,
      this.cardFamily,
      this.errMsg,
      final Map<String, dynamic>? raw})
      : _raw = raw;

  @override
  final String status;
// "success" veya "failed"
  @override
  final String? cardType;
// "credit" veya "debit"
  @override
  final String? brand;
// "visa", "mastercard", "bonus", "world", vb.
  @override
  final String? bankName;
  @override
  final String? cardFamily;
  @override
  final String? errMsg;
// Hata durumunda
  final Map<String, dynamic>? _raw;
// Hata durumunda
  @override
  Map<String, dynamic>? get raw {
    final value = _raw;
    if (value == null) return null;
    if (_raw is EqualUnmodifiableMapView) return _raw;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'BinDetailResponse(status: $status, cardType: $cardType, brand: $brand, bankName: $bankName, cardFamily: $cardFamily, errMsg: $errMsg, raw: $raw)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BinDetailResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.cardType, cardType) ||
                other.cardType == cardType) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.cardFamily, cardFamily) ||
                other.cardFamily == cardFamily) &&
            (identical(other.errMsg, errMsg) || other.errMsg == errMsg) &&
            const DeepCollectionEquality().equals(other._raw, _raw));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, cardType, brand,
      bankName, cardFamily, errMsg, const DeepCollectionEquality().hash(_raw));

  /// Create a copy of BinDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BinDetailResponseImplCopyWith<_$BinDetailResponseImpl> get copyWith =>
      __$$BinDetailResponseImplCopyWithImpl<_$BinDetailResponseImpl>(
          this, _$identity);
}

abstract class _BinDetailResponse implements BinDetailResponse {
  const factory _BinDetailResponse(
      {required final String status,
      final String? cardType,
      final String? brand,
      final String? bankName,
      final String? cardFamily,
      final String? errMsg,
      final Map<String, dynamic>? raw}) = _$BinDetailResponseImpl;

  @override
  String get status; // "success" veya "failed"
  @override
  String? get cardType; // "credit" veya "debit"
  @override
  String? get brand; // "visa", "mastercard", "bonus", "world", vb.
  @override
  String? get bankName;
  @override
  String? get cardFamily;
  @override
  String? get errMsg; // Hata durumunda
  @override
  Map<String, dynamic>? get raw;

  /// Create a copy of BinDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BinDetailResponseImplCopyWith<_$BinDetailResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InstallmentOption {
  int get installmentCount =>
      throw _privateConstructorUsedError; // 0=peşin, 3=3 taksit
  double get ratePercent =>
      throw _privateConstructorUsedError; // Vade farkı yüzdesi (0 veya 15)
  String get totalTl =>
      throw _privateConstructorUsedError; // Toplam tutar (TL string)
  String get perInstallmentTl => throw _privateConstructorUsedError;

  /// Create a copy of InstallmentOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InstallmentOptionCopyWith<InstallmentOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InstallmentOptionCopyWith<$Res> {
  factory $InstallmentOptionCopyWith(
          InstallmentOption value, $Res Function(InstallmentOption) then) =
      _$InstallmentOptionCopyWithImpl<$Res, InstallmentOption>;
  @useResult
  $Res call(
      {int installmentCount,
      double ratePercent,
      String totalTl,
      String perInstallmentTl});
}

/// @nodoc
class _$InstallmentOptionCopyWithImpl<$Res, $Val extends InstallmentOption>
    implements $InstallmentOptionCopyWith<$Res> {
  _$InstallmentOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InstallmentOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? installmentCount = null,
    Object? ratePercent = null,
    Object? totalTl = null,
    Object? perInstallmentTl = null,
  }) {
    return _then(_value.copyWith(
      installmentCount: null == installmentCount
          ? _value.installmentCount
          : installmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      ratePercent: null == ratePercent
          ? _value.ratePercent
          : ratePercent // ignore: cast_nullable_to_non_nullable
              as double,
      totalTl: null == totalTl
          ? _value.totalTl
          : totalTl // ignore: cast_nullable_to_non_nullable
              as String,
      perInstallmentTl: null == perInstallmentTl
          ? _value.perInstallmentTl
          : perInstallmentTl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InstallmentOptionImplCopyWith<$Res>
    implements $InstallmentOptionCopyWith<$Res> {
  factory _$$InstallmentOptionImplCopyWith(_$InstallmentOptionImpl value,
          $Res Function(_$InstallmentOptionImpl) then) =
      __$$InstallmentOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int installmentCount,
      double ratePercent,
      String totalTl,
      String perInstallmentTl});
}

/// @nodoc
class __$$InstallmentOptionImplCopyWithImpl<$Res>
    extends _$InstallmentOptionCopyWithImpl<$Res, _$InstallmentOptionImpl>
    implements _$$InstallmentOptionImplCopyWith<$Res> {
  __$$InstallmentOptionImplCopyWithImpl(_$InstallmentOptionImpl _value,
      $Res Function(_$InstallmentOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of InstallmentOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? installmentCount = null,
    Object? ratePercent = null,
    Object? totalTl = null,
    Object? perInstallmentTl = null,
  }) {
    return _then(_$InstallmentOptionImpl(
      installmentCount: null == installmentCount
          ? _value.installmentCount
          : installmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      ratePercent: null == ratePercent
          ? _value.ratePercent
          : ratePercent // ignore: cast_nullable_to_non_nullable
              as double,
      totalTl: null == totalTl
          ? _value.totalTl
          : totalTl // ignore: cast_nullable_to_non_nullable
              as String,
      perInstallmentTl: null == perInstallmentTl
          ? _value.perInstallmentTl
          : perInstallmentTl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InstallmentOptionImpl implements _InstallmentOption {
  const _$InstallmentOptionImpl(
      {required this.installmentCount,
      required this.ratePercent,
      required this.totalTl,
      required this.perInstallmentTl});

  @override
  final int installmentCount;
// 0=peşin, 3=3 taksit
  @override
  final double ratePercent;
// Vade farkı yüzdesi (0 veya 15)
  @override
  final String totalTl;
// Toplam tutar (TL string)
  @override
  final String perInstallmentTl;

  @override
  String toString() {
    return 'InstallmentOption(installmentCount: $installmentCount, ratePercent: $ratePercent, totalTl: $totalTl, perInstallmentTl: $perInstallmentTl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InstallmentOptionImpl &&
            (identical(other.installmentCount, installmentCount) ||
                other.installmentCount == installmentCount) &&
            (identical(other.ratePercent, ratePercent) ||
                other.ratePercent == ratePercent) &&
            (identical(other.totalTl, totalTl) || other.totalTl == totalTl) &&
            (identical(other.perInstallmentTl, perInstallmentTl) ||
                other.perInstallmentTl == perInstallmentTl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, installmentCount, ratePercent, totalTl, perInstallmentTl);

  /// Create a copy of InstallmentOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InstallmentOptionImplCopyWith<_$InstallmentOptionImpl> get copyWith =>
      __$$InstallmentOptionImplCopyWithImpl<_$InstallmentOptionImpl>(
          this, _$identity);
}

abstract class _InstallmentOption implements InstallmentOption {
  const factory _InstallmentOption(
      {required final int installmentCount,
      required final double ratePercent,
      required final String totalTl,
      required final String perInstallmentTl}) = _$InstallmentOptionImpl;

  @override
  int get installmentCount; // 0=peşin, 3=3 taksit
  @override
  double get ratePercent; // Vade farkı yüzdesi (0 veya 15)
  @override
  String get totalTl; // Toplam tutar (TL string)
  @override
  String get perInstallmentTl;

  /// Create a copy of InstallmentOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InstallmentOptionImplCopyWith<_$InstallmentOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InstallmentQuoteRequest _$InstallmentQuoteRequestFromJson(
    Map<String, dynamic> json) {
  return _InstallmentQuoteRequest.fromJson(json);
}

/// @nodoc
mixin _$InstallmentQuoteRequest {
  String get binNumber =>
      throw _privateConstructorUsedError; // Kartın ilk 6 veya 8 hanesi
  double get amountTl => throw _privateConstructorUsedError;

  /// Serializes this InstallmentQuoteRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InstallmentQuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InstallmentQuoteRequestCopyWith<InstallmentQuoteRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InstallmentQuoteRequestCopyWith<$Res> {
  factory $InstallmentQuoteRequestCopyWith(InstallmentQuoteRequest value,
          $Res Function(InstallmentQuoteRequest) then) =
      _$InstallmentQuoteRequestCopyWithImpl<$Res, InstallmentQuoteRequest>;
  @useResult
  $Res call({String binNumber, double amountTl});
}

/// @nodoc
class _$InstallmentQuoteRequestCopyWithImpl<$Res,
        $Val extends InstallmentQuoteRequest>
    implements $InstallmentQuoteRequestCopyWith<$Res> {
  _$InstallmentQuoteRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InstallmentQuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? binNumber = null,
    Object? amountTl = null,
  }) {
    return _then(_value.copyWith(
      binNumber: null == binNumber
          ? _value.binNumber
          : binNumber // ignore: cast_nullable_to_non_nullable
              as String,
      amountTl: null == amountTl
          ? _value.amountTl
          : amountTl // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InstallmentQuoteRequestImplCopyWith<$Res>
    implements $InstallmentQuoteRequestCopyWith<$Res> {
  factory _$$InstallmentQuoteRequestImplCopyWith(
          _$InstallmentQuoteRequestImpl value,
          $Res Function(_$InstallmentQuoteRequestImpl) then) =
      __$$InstallmentQuoteRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String binNumber, double amountTl});
}

/// @nodoc
class __$$InstallmentQuoteRequestImplCopyWithImpl<$Res>
    extends _$InstallmentQuoteRequestCopyWithImpl<$Res,
        _$InstallmentQuoteRequestImpl>
    implements _$$InstallmentQuoteRequestImplCopyWith<$Res> {
  __$$InstallmentQuoteRequestImplCopyWithImpl(
      _$InstallmentQuoteRequestImpl _value,
      $Res Function(_$InstallmentQuoteRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of InstallmentQuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? binNumber = null,
    Object? amountTl = null,
  }) {
    return _then(_$InstallmentQuoteRequestImpl(
      binNumber: null == binNumber
          ? _value.binNumber
          : binNumber // ignore: cast_nullable_to_non_nullable
              as String,
      amountTl: null == amountTl
          ? _value.amountTl
          : amountTl // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InstallmentQuoteRequestImpl implements _InstallmentQuoteRequest {
  const _$InstallmentQuoteRequestImpl(
      {required this.binNumber, required this.amountTl});

  factory _$InstallmentQuoteRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$InstallmentQuoteRequestImplFromJson(json);

  @override
  final String binNumber;
// Kartın ilk 6 veya 8 hanesi
  @override
  final double amountTl;

  @override
  String toString() {
    return 'InstallmentQuoteRequest(binNumber: $binNumber, amountTl: $amountTl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InstallmentQuoteRequestImpl &&
            (identical(other.binNumber, binNumber) ||
                other.binNumber == binNumber) &&
            (identical(other.amountTl, amountTl) ||
                other.amountTl == amountTl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, binNumber, amountTl);

  /// Create a copy of InstallmentQuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InstallmentQuoteRequestImplCopyWith<_$InstallmentQuoteRequestImpl>
      get copyWith => __$$InstallmentQuoteRequestImplCopyWithImpl<
          _$InstallmentQuoteRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InstallmentQuoteRequestImplToJson(
      this,
    );
  }
}

abstract class _InstallmentQuoteRequest implements InstallmentQuoteRequest {
  const factory _InstallmentQuoteRequest(
      {required final String binNumber,
      required final double amountTl}) = _$InstallmentQuoteRequestImpl;

  factory _InstallmentQuoteRequest.fromJson(Map<String, dynamic> json) =
      _$InstallmentQuoteRequestImpl.fromJson;

  @override
  String get binNumber; // Kartın ilk 6 veya 8 hanesi
  @override
  double get amountTl;

  /// Create a copy of InstallmentQuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InstallmentQuoteRequestImplCopyWith<_$InstallmentQuoteRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InstallmentQuoteResponse {
  String get status =>
      throw _privateConstructorUsedError; // "success" veya "failed"
  String? get brand =>
      throw _privateConstructorUsedError; // Kart markası (bonus, world, vb.)
  String? get cardType =>
      throw _privateConstructorUsedError; // "credit" veya "debit"
  List<InstallmentOption> get installments =>
      throw _privateConstructorUsedError; // Taksit seçenekleri
  String? get reason =>
      throw _privateConstructorUsedError; // Başarısızlık nedeni
  Map<String, dynamic>? get bin => throw _privateConstructorUsedError;

  /// Create a copy of InstallmentQuoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InstallmentQuoteResponseCopyWith<InstallmentQuoteResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InstallmentQuoteResponseCopyWith<$Res> {
  factory $InstallmentQuoteResponseCopyWith(InstallmentQuoteResponse value,
          $Res Function(InstallmentQuoteResponse) then) =
      _$InstallmentQuoteResponseCopyWithImpl<$Res, InstallmentQuoteResponse>;
  @useResult
  $Res call(
      {String status,
      String? brand,
      String? cardType,
      List<InstallmentOption> installments,
      String? reason,
      Map<String, dynamic>? bin});
}

/// @nodoc
class _$InstallmentQuoteResponseCopyWithImpl<$Res,
        $Val extends InstallmentQuoteResponse>
    implements $InstallmentQuoteResponseCopyWith<$Res> {
  _$InstallmentQuoteResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InstallmentQuoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? brand = freezed,
    Object? cardType = freezed,
    Object? installments = null,
    Object? reason = freezed,
    Object? bin = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      cardType: freezed == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String?,
      installments: null == installments
          ? _value.installments
          : installments // ignore: cast_nullable_to_non_nullable
              as List<InstallmentOption>,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      bin: freezed == bin
          ? _value.bin
          : bin // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InstallmentQuoteResponseImplCopyWith<$Res>
    implements $InstallmentQuoteResponseCopyWith<$Res> {
  factory _$$InstallmentQuoteResponseImplCopyWith(
          _$InstallmentQuoteResponseImpl value,
          $Res Function(_$InstallmentQuoteResponseImpl) then) =
      __$$InstallmentQuoteResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status,
      String? brand,
      String? cardType,
      List<InstallmentOption> installments,
      String? reason,
      Map<String, dynamic>? bin});
}

/// @nodoc
class __$$InstallmentQuoteResponseImplCopyWithImpl<$Res>
    extends _$InstallmentQuoteResponseCopyWithImpl<$Res,
        _$InstallmentQuoteResponseImpl>
    implements _$$InstallmentQuoteResponseImplCopyWith<$Res> {
  __$$InstallmentQuoteResponseImplCopyWithImpl(
      _$InstallmentQuoteResponseImpl _value,
      $Res Function(_$InstallmentQuoteResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of InstallmentQuoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? brand = freezed,
    Object? cardType = freezed,
    Object? installments = null,
    Object? reason = freezed,
    Object? bin = freezed,
  }) {
    return _then(_$InstallmentQuoteResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      cardType: freezed == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String?,
      installments: null == installments
          ? _value._installments
          : installments // ignore: cast_nullable_to_non_nullable
              as List<InstallmentOption>,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      bin: freezed == bin
          ? _value._bin
          : bin // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$InstallmentQuoteResponseImpl implements _InstallmentQuoteResponse {
  const _$InstallmentQuoteResponseImpl(
      {required this.status,
      this.brand,
      this.cardType,
      required final List<InstallmentOption> installments,
      this.reason,
      final Map<String, dynamic>? bin})
      : _installments = installments,
        _bin = bin;

  @override
  final String status;
// "success" veya "failed"
  @override
  final String? brand;
// Kart markası (bonus, world, vb.)
  @override
  final String? cardType;
// "credit" veya "debit"
  final List<InstallmentOption> _installments;
// "credit" veya "debit"
  @override
  List<InstallmentOption> get installments {
    if (_installments is EqualUnmodifiableListView) return _installments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_installments);
  }

// Taksit seçenekleri
  @override
  final String? reason;
// Başarısızlık nedeni
  final Map<String, dynamic>? _bin;
// Başarısızlık nedeni
  @override
  Map<String, dynamic>? get bin {
    final value = _bin;
    if (value == null) return null;
    if (_bin is EqualUnmodifiableMapView) return _bin;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'InstallmentQuoteResponse(status: $status, brand: $brand, cardType: $cardType, installments: $installments, reason: $reason, bin: $bin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InstallmentQuoteResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.cardType, cardType) ||
                other.cardType == cardType) &&
            const DeepCollectionEquality()
                .equals(other._installments, _installments) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            const DeepCollectionEquality().equals(other._bin, _bin));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      brand,
      cardType,
      const DeepCollectionEquality().hash(_installments),
      reason,
      const DeepCollectionEquality().hash(_bin));

  /// Create a copy of InstallmentQuoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InstallmentQuoteResponseImplCopyWith<_$InstallmentQuoteResponseImpl>
      get copyWith => __$$InstallmentQuoteResponseImplCopyWithImpl<
          _$InstallmentQuoteResponseImpl>(this, _$identity);
}

abstract class _InstallmentQuoteResponse implements InstallmentQuoteResponse {
  const factory _InstallmentQuoteResponse(
      {required final String status,
      final String? brand,
      final String? cardType,
      required final List<InstallmentOption> installments,
      final String? reason,
      final Map<String, dynamic>? bin}) = _$InstallmentQuoteResponseImpl;

  @override
  String get status; // "success" veya "failed"
  @override
  String? get brand; // Kart markası (bonus, world, vb.)
  @override
  String? get cardType; // "credit" veya "debit"
  @override
  List<InstallmentOption> get installments; // Taksit seçenekleri
  @override
  String? get reason; // Başarısızlık nedeni
  @override
  Map<String, dynamic>? get bin;

  /// Create a copy of InstallmentQuoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InstallmentQuoteResponseImplCopyWith<_$InstallmentQuoteResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CheckoutState {
  CheckoutStatus get status => throw _privateConstructorUsedError;
  String? get merchantOid =>
      throw _privateConstructorUsedError; // Payment session ID (sipariş ID değil)
  String? get orderId =>
      throw _privateConstructorUsedError; // Sipariş ID (callback success sonrası oluşur)
  @JsonKey(includeFromJson: false, includeToJson: false)
  PayTRInitResponse? get paytrResponse => throw _privateConstructorUsedError;
  String? get errorMessage =>
      throw _privateConstructorUsedError; // Ödeme yöntemi
  PaymentMethod get paymentMethod =>
      throw _privateConstructorUsedError; // Taksit bilgileri
  int get selectedInstallment =>
      throw _privateConstructorUsedError; // 0=peşin, 3=3 taksit
  String? get binNumber =>
      throw _privateConstructorUsedError; // Kart BIN numarası
  InstallmentQuoteResponse? get installmentQuote =>
      throw _privateConstructorUsedError;

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
      String? merchantOid,
      String? orderId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      PayTRInitResponse? paytrResponse,
      String? errorMessage,
      PaymentMethod paymentMethod,
      int selectedInstallment,
      String? binNumber,
      InstallmentQuoteResponse? installmentQuote});

  $PayTRInitResponseCopyWith<$Res>? get paytrResponse;
  $InstallmentQuoteResponseCopyWith<$Res>? get installmentQuote;
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
    Object? merchantOid = freezed,
    Object? orderId = freezed,
    Object? paytrResponse = freezed,
    Object? errorMessage = freezed,
    Object? paymentMethod = null,
    Object? selectedInstallment = null,
    Object? binNumber = freezed,
    Object? installmentQuote = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CheckoutStatus,
      merchantOid: freezed == merchantOid
          ? _value.merchantOid
          : merchantOid // ignore: cast_nullable_to_non_nullable
              as String?,
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
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      selectedInstallment: null == selectedInstallment
          ? _value.selectedInstallment
          : selectedInstallment // ignore: cast_nullable_to_non_nullable
              as int,
      binNumber: freezed == binNumber
          ? _value.binNumber
          : binNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      installmentQuote: freezed == installmentQuote
          ? _value.installmentQuote
          : installmentQuote // ignore: cast_nullable_to_non_nullable
              as InstallmentQuoteResponse?,
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

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InstallmentQuoteResponseCopyWith<$Res>? get installmentQuote {
    if (_value.installmentQuote == null) {
      return null;
    }

    return $InstallmentQuoteResponseCopyWith<$Res>(_value.installmentQuote!,
        (value) {
      return _then(_value.copyWith(installmentQuote: value) as $Val);
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
      String? merchantOid,
      String? orderId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      PayTRInitResponse? paytrResponse,
      String? errorMessage,
      PaymentMethod paymentMethod,
      int selectedInstallment,
      String? binNumber,
      InstallmentQuoteResponse? installmentQuote});

  @override
  $PayTRInitResponseCopyWith<$Res>? get paytrResponse;
  @override
  $InstallmentQuoteResponseCopyWith<$Res>? get installmentQuote;
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
    Object? merchantOid = freezed,
    Object? orderId = freezed,
    Object? paytrResponse = freezed,
    Object? errorMessage = freezed,
    Object? paymentMethod = null,
    Object? selectedInstallment = null,
    Object? binNumber = freezed,
    Object? installmentQuote = freezed,
  }) {
    return _then(_$CheckoutStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CheckoutStatus,
      merchantOid: freezed == merchantOid
          ? _value.merchantOid
          : merchantOid // ignore: cast_nullable_to_non_nullable
              as String?,
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
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      selectedInstallment: null == selectedInstallment
          ? _value.selectedInstallment
          : selectedInstallment // ignore: cast_nullable_to_non_nullable
              as int,
      binNumber: freezed == binNumber
          ? _value.binNumber
          : binNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      installmentQuote: freezed == installmentQuote
          ? _value.installmentQuote
          : installmentQuote // ignore: cast_nullable_to_non_nullable
              as InstallmentQuoteResponse?,
    ));
  }
}

/// @nodoc

class _$CheckoutStateImpl implements _CheckoutState {
  const _$CheckoutStateImpl(
      {this.status = CheckoutStatus.idle,
      this.merchantOid,
      this.orderId,
      @JsonKey(includeFromJson: false, includeToJson: false) this.paytrResponse,
      this.errorMessage,
      this.paymentMethod = PaymentMethod.creditCard,
      this.selectedInstallment = 0,
      this.binNumber,
      this.installmentQuote});

  @override
  @JsonKey()
  final CheckoutStatus status;
  @override
  final String? merchantOid;
// Payment session ID (sipariş ID değil)
  @override
  final String? orderId;
// Sipariş ID (callback success sonrası oluşur)
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final PayTRInitResponse? paytrResponse;
  @override
  final String? errorMessage;
// Ödeme yöntemi
  @override
  @JsonKey()
  final PaymentMethod paymentMethod;
// Taksit bilgileri
  @override
  @JsonKey()
  final int selectedInstallment;
// 0=peşin, 3=3 taksit
  @override
  final String? binNumber;
// Kart BIN numarası
  @override
  final InstallmentQuoteResponse? installmentQuote;

  @override
  String toString() {
    return 'CheckoutState(status: $status, merchantOid: $merchantOid, orderId: $orderId, paytrResponse: $paytrResponse, errorMessage: $errorMessage, paymentMethod: $paymentMethod, selectedInstallment: $selectedInstallment, binNumber: $binNumber, installmentQuote: $installmentQuote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.merchantOid, merchantOid) ||
                other.merchantOid == merchantOid) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.paytrResponse, paytrResponse) ||
                other.paytrResponse == paytrResponse) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.selectedInstallment, selectedInstallment) ||
                other.selectedInstallment == selectedInstallment) &&
            (identical(other.binNumber, binNumber) ||
                other.binNumber == binNumber) &&
            (identical(other.installmentQuote, installmentQuote) ||
                other.installmentQuote == installmentQuote));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      merchantOid,
      orderId,
      paytrResponse,
      errorMessage,
      paymentMethod,
      selectedInstallment,
      binNumber,
      installmentQuote);

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
      final String? merchantOid,
      final String? orderId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final PayTRInitResponse? paytrResponse,
      final String? errorMessage,
      final PaymentMethod paymentMethod,
      final int selectedInstallment,
      final String? binNumber,
      final InstallmentQuoteResponse? installmentQuote}) = _$CheckoutStateImpl;

  @override
  CheckoutStatus get status;
  @override
  String? get merchantOid; // Payment session ID (sipariş ID değil)
  @override
  String? get orderId; // Sipariş ID (callback success sonrası oluşur)
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  PayTRInitResponse? get paytrResponse;
  @override
  String? get errorMessage; // Ödeme yöntemi
  @override
  PaymentMethod get paymentMethod; // Taksit bilgileri
  @override
  int get selectedInstallment; // 0=peşin, 3=3 taksit
  @override
  String? get binNumber; // Kart BIN numarası
  @override
  InstallmentQuoteResponse? get installmentQuote;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RefreshTokenRequest _$RefreshTokenRequestFromJson(Map<String, dynamic> json) {
  return _RefreshTokenRequest.fromJson(json);
}

/// @nodoc
mixin _$RefreshTokenRequest {
  String get merchantOid => throw _privateConstructorUsedError;
  int get installmentCount => throw _privateConstructorUsedError; // 0 veya 3
  String? get binNumber => throw _privateConstructorUsedError;

  /// Serializes this RefreshTokenRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RefreshTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RefreshTokenRequestCopyWith<RefreshTokenRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefreshTokenRequestCopyWith<$Res> {
  factory $RefreshTokenRequestCopyWith(
          RefreshTokenRequest value, $Res Function(RefreshTokenRequest) then) =
      _$RefreshTokenRequestCopyWithImpl<$Res, RefreshTokenRequest>;
  @useResult
  $Res call({String merchantOid, int installmentCount, String? binNumber});
}

/// @nodoc
class _$RefreshTokenRequestCopyWithImpl<$Res, $Val extends RefreshTokenRequest>
    implements $RefreshTokenRequestCopyWith<$Res> {
  _$RefreshTokenRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RefreshTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantOid = null,
    Object? installmentCount = null,
    Object? binNumber = freezed,
  }) {
    return _then(_value.copyWith(
      merchantOid: null == merchantOid
          ? _value.merchantOid
          : merchantOid // ignore: cast_nullable_to_non_nullable
              as String,
      installmentCount: null == installmentCount
          ? _value.installmentCount
          : installmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      binNumber: freezed == binNumber
          ? _value.binNumber
          : binNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RefreshTokenRequestImplCopyWith<$Res>
    implements $RefreshTokenRequestCopyWith<$Res> {
  factory _$$RefreshTokenRequestImplCopyWith(_$RefreshTokenRequestImpl value,
          $Res Function(_$RefreshTokenRequestImpl) then) =
      __$$RefreshTokenRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String merchantOid, int installmentCount, String? binNumber});
}

/// @nodoc
class __$$RefreshTokenRequestImplCopyWithImpl<$Res>
    extends _$RefreshTokenRequestCopyWithImpl<$Res, _$RefreshTokenRequestImpl>
    implements _$$RefreshTokenRequestImplCopyWith<$Res> {
  __$$RefreshTokenRequestImplCopyWithImpl(_$RefreshTokenRequestImpl _value,
      $Res Function(_$RefreshTokenRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of RefreshTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantOid = null,
    Object? installmentCount = null,
    Object? binNumber = freezed,
  }) {
    return _then(_$RefreshTokenRequestImpl(
      merchantOid: null == merchantOid
          ? _value.merchantOid
          : merchantOid // ignore: cast_nullable_to_non_nullable
              as String,
      installmentCount: null == installmentCount
          ? _value.installmentCount
          : installmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      binNumber: freezed == binNumber
          ? _value.binNumber
          : binNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RefreshTokenRequestImpl implements _RefreshTokenRequest {
  const _$RefreshTokenRequestImpl(
      {required this.merchantOid, this.installmentCount = 0, this.binNumber});

  factory _$RefreshTokenRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RefreshTokenRequestImplFromJson(json);

  @override
  final String merchantOid;
  @override
  @JsonKey()
  final int installmentCount;
// 0 veya 3
  @override
  final String? binNumber;

  @override
  String toString() {
    return 'RefreshTokenRequest(merchantOid: $merchantOid, installmentCount: $installmentCount, binNumber: $binNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshTokenRequestImpl &&
            (identical(other.merchantOid, merchantOid) ||
                other.merchantOid == merchantOid) &&
            (identical(other.installmentCount, installmentCount) ||
                other.installmentCount == installmentCount) &&
            (identical(other.binNumber, binNumber) ||
                other.binNumber == binNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, merchantOid, installmentCount, binNumber);

  /// Create a copy of RefreshTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshTokenRequestImplCopyWith<_$RefreshTokenRequestImpl> get copyWith =>
      __$$RefreshTokenRequestImplCopyWithImpl<_$RefreshTokenRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RefreshTokenRequestImplToJson(
      this,
    );
  }
}

abstract class _RefreshTokenRequest implements RefreshTokenRequest {
  const factory _RefreshTokenRequest(
      {required final String merchantOid,
      final int installmentCount,
      final String? binNumber}) = _$RefreshTokenRequestImpl;

  factory _RefreshTokenRequest.fromJson(Map<String, dynamic> json) =
      _$RefreshTokenRequestImpl.fromJson;

  @override
  String get merchantOid;
  @override
  int get installmentCount; // 0 veya 3
  @override
  String? get binNumber;

  /// Create a copy of RefreshTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshTokenRequestImplCopyWith<_$RefreshTokenRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
