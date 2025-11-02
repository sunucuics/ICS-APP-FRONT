// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paytr_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PayTRBasketItem _$PayTRBasketItemFromJson(Map<String, dynamic> json) {
  return _PayTRBasketItem.fromJson(json);
}

/// @nodoc
mixin _$PayTRBasketItem {
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  /// Serializes this PayTRBasketItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayTRBasketItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayTRBasketItemCopyWith<PayTRBasketItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayTRBasketItemCopyWith<$Res> {
  factory $PayTRBasketItemCopyWith(
          PayTRBasketItem value, $Res Function(PayTRBasketItem) then) =
      _$PayTRBasketItemCopyWithImpl<$Res, PayTRBasketItem>;
  @useResult
  $Res call({String name, double price, int quantity});
}

/// @nodoc
class _$PayTRBasketItemCopyWithImpl<$Res, $Val extends PayTRBasketItem>
    implements $PayTRBasketItemCopyWith<$Res> {
  _$PayTRBasketItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayTRBasketItem
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
abstract class _$$PayTRBasketItemImplCopyWith<$Res>
    implements $PayTRBasketItemCopyWith<$Res> {
  factory _$$PayTRBasketItemImplCopyWith(_$PayTRBasketItemImpl value,
          $Res Function(_$PayTRBasketItemImpl) then) =
      __$$PayTRBasketItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, double price, int quantity});
}

/// @nodoc
class __$$PayTRBasketItemImplCopyWithImpl<$Res>
    extends _$PayTRBasketItemCopyWithImpl<$Res, _$PayTRBasketItemImpl>
    implements _$$PayTRBasketItemImplCopyWith<$Res> {
  __$$PayTRBasketItemImplCopyWithImpl(
      _$PayTRBasketItemImpl _value, $Res Function(_$PayTRBasketItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayTRBasketItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? price = null,
    Object? quantity = null,
  }) {
    return _then(_$PayTRBasketItemImpl(
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
class _$PayTRBasketItemImpl implements _PayTRBasketItem {
  const _$PayTRBasketItemImpl(
      {required this.name, required this.price, required this.quantity});

  factory _$PayTRBasketItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayTRBasketItemImplFromJson(json);

  @override
  final String name;
  @override
  final double price;
  @override
  final int quantity;

  @override
  String toString() {
    return 'PayTRBasketItem(name: $name, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayTRBasketItemImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, price, quantity);

  /// Create a copy of PayTRBasketItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayTRBasketItemImplCopyWith<_$PayTRBasketItemImpl> get copyWith =>
      __$$PayTRBasketItemImplCopyWithImpl<_$PayTRBasketItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayTRBasketItemImplToJson(
      this,
    );
  }
}

abstract class _PayTRBasketItem implements PayTRBasketItem {
  const factory _PayTRBasketItem(
      {required final String name,
      required final double price,
      required final int quantity}) = _$PayTRBasketItemImpl;

  factory _PayTRBasketItem.fromJson(Map<String, dynamic> json) =
      _$PayTRBasketItemImpl.fromJson;

  @override
  String get name;
  @override
  double get price;
  @override
  int get quantity;

  /// Create a copy of PayTRBasketItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayTRBasketItemImplCopyWith<_$PayTRBasketItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PayTRDirectInitRequest _$PayTRDirectInitRequestFromJson(
    Map<String, dynamic> json) {
  return _PayTRDirectInitRequest.fromJson(json);
}

/// @nodoc
mixin _$PayTRDirectInitRequest {
  @JsonKey(name: 'merchant_oid')
  String get merchantOid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_amount')
  double get paymentAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_type')
  String get paymentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'installment_count')
  int get installmentCount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'non_3d')
  int get non3d => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_lang')
  String get clientLang => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_address')
  String? get userAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_phone')
  String? get userPhone => throw _privateConstructorUsedError;
  List<PayTRBasketItem> get basket => throw _privateConstructorUsedError;
  @JsonKey(name: 'card_type')
  String? get cardType => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_ip')
  String? get userIp => throw _privateConstructorUsedError;
  @JsonKey(name: 'debug_on')
  int get debugOn => throw _privateConstructorUsedError;

  /// Serializes this PayTRDirectInitRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayTRDirectInitRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayTRDirectInitRequestCopyWith<PayTRDirectInitRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayTRDirectInitRequestCopyWith<$Res> {
  factory $PayTRDirectInitRequestCopyWith(PayTRDirectInitRequest value,
          $Res Function(PayTRDirectInitRequest) then) =
      _$PayTRDirectInitRequestCopyWithImpl<$Res, PayTRDirectInitRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'merchant_oid') String merchantOid,
      String email,
      @JsonKey(name: 'payment_amount') double paymentAmount,
      @JsonKey(name: 'payment_type') String paymentType,
      @JsonKey(name: 'installment_count') int installmentCount,
      String currency,
      @JsonKey(name: 'non_3d') int non3d,
      @JsonKey(name: 'client_lang') String clientLang,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'user_address') String? userAddress,
      @JsonKey(name: 'user_phone') String? userPhone,
      List<PayTRBasketItem> basket,
      @JsonKey(name: 'card_type') String? cardType,
      @JsonKey(name: 'user_ip') String? userIp,
      @JsonKey(name: 'debug_on') int debugOn});
}

/// @nodoc
class _$PayTRDirectInitRequestCopyWithImpl<$Res,
        $Val extends PayTRDirectInitRequest>
    implements $PayTRDirectInitRequestCopyWith<$Res> {
  _$PayTRDirectInitRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayTRDirectInitRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantOid = null,
    Object? email = null,
    Object? paymentAmount = null,
    Object? paymentType = null,
    Object? installmentCount = null,
    Object? currency = null,
    Object? non3d = null,
    Object? clientLang = null,
    Object? userName = freezed,
    Object? userAddress = freezed,
    Object? userPhone = freezed,
    Object? basket = null,
    Object? cardType = freezed,
    Object? userIp = freezed,
    Object? debugOn = null,
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
      paymentType: null == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as String,
      installmentCount: null == installmentCount
          ? _value.installmentCount
          : installmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      non3d: null == non3d
          ? _value.non3d
          : non3d // ignore: cast_nullable_to_non_nullable
              as int,
      clientLang: null == clientLang
          ? _value.clientLang
          : clientLang // ignore: cast_nullable_to_non_nullable
              as String,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userAddress: freezed == userAddress
          ? _value.userAddress
          : userAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      userPhone: freezed == userPhone
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      basket: null == basket
          ? _value.basket
          : basket // ignore: cast_nullable_to_non_nullable
              as List<PayTRBasketItem>,
      cardType: freezed == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String?,
      userIp: freezed == userIp
          ? _value.userIp
          : userIp // ignore: cast_nullable_to_non_nullable
              as String?,
      debugOn: null == debugOn
          ? _value.debugOn
          : debugOn // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayTRDirectInitRequestImplCopyWith<$Res>
    implements $PayTRDirectInitRequestCopyWith<$Res> {
  factory _$$PayTRDirectInitRequestImplCopyWith(
          _$PayTRDirectInitRequestImpl value,
          $Res Function(_$PayTRDirectInitRequestImpl) then) =
      __$$PayTRDirectInitRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'merchant_oid') String merchantOid,
      String email,
      @JsonKey(name: 'payment_amount') double paymentAmount,
      @JsonKey(name: 'payment_type') String paymentType,
      @JsonKey(name: 'installment_count') int installmentCount,
      String currency,
      @JsonKey(name: 'non_3d') int non3d,
      @JsonKey(name: 'client_lang') String clientLang,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'user_address') String? userAddress,
      @JsonKey(name: 'user_phone') String? userPhone,
      List<PayTRBasketItem> basket,
      @JsonKey(name: 'card_type') String? cardType,
      @JsonKey(name: 'user_ip') String? userIp,
      @JsonKey(name: 'debug_on') int debugOn});
}

/// @nodoc
class __$$PayTRDirectInitRequestImplCopyWithImpl<$Res>
    extends _$PayTRDirectInitRequestCopyWithImpl<$Res,
        _$PayTRDirectInitRequestImpl>
    implements _$$PayTRDirectInitRequestImplCopyWith<$Res> {
  __$$PayTRDirectInitRequestImplCopyWithImpl(
      _$PayTRDirectInitRequestImpl _value,
      $Res Function(_$PayTRDirectInitRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayTRDirectInitRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantOid = null,
    Object? email = null,
    Object? paymentAmount = null,
    Object? paymentType = null,
    Object? installmentCount = null,
    Object? currency = null,
    Object? non3d = null,
    Object? clientLang = null,
    Object? userName = freezed,
    Object? userAddress = freezed,
    Object? userPhone = freezed,
    Object? basket = null,
    Object? cardType = freezed,
    Object? userIp = freezed,
    Object? debugOn = null,
  }) {
    return _then(_$PayTRDirectInitRequestImpl(
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
      paymentType: null == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as String,
      installmentCount: null == installmentCount
          ? _value.installmentCount
          : installmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      non3d: null == non3d
          ? _value.non3d
          : non3d // ignore: cast_nullable_to_non_nullable
              as int,
      clientLang: null == clientLang
          ? _value.clientLang
          : clientLang // ignore: cast_nullable_to_non_nullable
              as String,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userAddress: freezed == userAddress
          ? _value.userAddress
          : userAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      userPhone: freezed == userPhone
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      basket: null == basket
          ? _value._basket
          : basket // ignore: cast_nullable_to_non_nullable
              as List<PayTRBasketItem>,
      cardType: freezed == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String?,
      userIp: freezed == userIp
          ? _value.userIp
          : userIp // ignore: cast_nullable_to_non_nullable
              as String?,
      debugOn: null == debugOn
          ? _value.debugOn
          : debugOn // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayTRDirectInitRequestImpl implements _PayTRDirectInitRequest {
  const _$PayTRDirectInitRequestImpl(
      {@JsonKey(name: 'merchant_oid') required this.merchantOid,
      required this.email,
      @JsonKey(name: 'payment_amount') required this.paymentAmount,
      @JsonKey(name: 'payment_type') this.paymentType = 'card',
      @JsonKey(name: 'installment_count') this.installmentCount = 0,
      this.currency = 'TL',
      @JsonKey(name: 'non_3d') this.non3d = 0,
      @JsonKey(name: 'client_lang') this.clientLang = 'tr',
      @JsonKey(name: 'user_name') this.userName,
      @JsonKey(name: 'user_address') this.userAddress,
      @JsonKey(name: 'user_phone') this.userPhone,
      required final List<PayTRBasketItem> basket,
      @JsonKey(name: 'card_type') this.cardType,
      @JsonKey(name: 'user_ip') this.userIp,
      @JsonKey(name: 'debug_on') this.debugOn = 1})
      : _basket = basket;

  factory _$PayTRDirectInitRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayTRDirectInitRequestImplFromJson(json);

  @override
  @JsonKey(name: 'merchant_oid')
  final String merchantOid;
  @override
  final String email;
  @override
  @JsonKey(name: 'payment_amount')
  final double paymentAmount;
  @override
  @JsonKey(name: 'payment_type')
  final String paymentType;
  @override
  @JsonKey(name: 'installment_count')
  final int installmentCount;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey(name: 'non_3d')
  final int non3d;
  @override
  @JsonKey(name: 'client_lang')
  final String clientLang;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
  @override
  @JsonKey(name: 'user_address')
  final String? userAddress;
  @override
  @JsonKey(name: 'user_phone')
  final String? userPhone;
  final List<PayTRBasketItem> _basket;
  @override
  List<PayTRBasketItem> get basket {
    if (_basket is EqualUnmodifiableListView) return _basket;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_basket);
  }

  @override
  @JsonKey(name: 'card_type')
  final String? cardType;
  @override
  @JsonKey(name: 'user_ip')
  final String? userIp;
  @override
  @JsonKey(name: 'debug_on')
  final int debugOn;

  @override
  String toString() {
    return 'PayTRDirectInitRequest(merchantOid: $merchantOid, email: $email, paymentAmount: $paymentAmount, paymentType: $paymentType, installmentCount: $installmentCount, currency: $currency, non3d: $non3d, clientLang: $clientLang, userName: $userName, userAddress: $userAddress, userPhone: $userPhone, basket: $basket, cardType: $cardType, userIp: $userIp, debugOn: $debugOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayTRDirectInitRequestImpl &&
            (identical(other.merchantOid, merchantOid) ||
                other.merchantOid == merchantOid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.paymentAmount, paymentAmount) ||
                other.paymentAmount == paymentAmount) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.installmentCount, installmentCount) ||
                other.installmentCount == installmentCount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.non3d, non3d) || other.non3d == non3d) &&
            (identical(other.clientLang, clientLang) ||
                other.clientLang == clientLang) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userAddress, userAddress) ||
                other.userAddress == userAddress) &&
            (identical(other.userPhone, userPhone) ||
                other.userPhone == userPhone) &&
            const DeepCollectionEquality().equals(other._basket, _basket) &&
            (identical(other.cardType, cardType) ||
                other.cardType == cardType) &&
            (identical(other.userIp, userIp) || other.userIp == userIp) &&
            (identical(other.debugOn, debugOn) || other.debugOn == debugOn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      merchantOid,
      email,
      paymentAmount,
      paymentType,
      installmentCount,
      currency,
      non3d,
      clientLang,
      userName,
      userAddress,
      userPhone,
      const DeepCollectionEquality().hash(_basket),
      cardType,
      userIp,
      debugOn);

  /// Create a copy of PayTRDirectInitRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayTRDirectInitRequestImplCopyWith<_$PayTRDirectInitRequestImpl>
      get copyWith => __$$PayTRDirectInitRequestImplCopyWithImpl<
          _$PayTRDirectInitRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayTRDirectInitRequestImplToJson(
      this,
    );
  }
}

abstract class _PayTRDirectInitRequest implements PayTRDirectInitRequest {
  const factory _PayTRDirectInitRequest(
          {@JsonKey(name: 'merchant_oid') required final String merchantOid,
          required final String email,
          @JsonKey(name: 'payment_amount') required final double paymentAmount,
          @JsonKey(name: 'payment_type') final String paymentType,
          @JsonKey(name: 'installment_count') final int installmentCount,
          final String currency,
          @JsonKey(name: 'non_3d') final int non3d,
          @JsonKey(name: 'client_lang') final String clientLang,
          @JsonKey(name: 'user_name') final String? userName,
          @JsonKey(name: 'user_address') final String? userAddress,
          @JsonKey(name: 'user_phone') final String? userPhone,
          required final List<PayTRBasketItem> basket,
          @JsonKey(name: 'card_type') final String? cardType,
          @JsonKey(name: 'user_ip') final String? userIp,
          @JsonKey(name: 'debug_on') final int debugOn}) =
      _$PayTRDirectInitRequestImpl;

  factory _PayTRDirectInitRequest.fromJson(Map<String, dynamic> json) =
      _$PayTRDirectInitRequestImpl.fromJson;

  @override
  @JsonKey(name: 'merchant_oid')
  String get merchantOid;
  @override
  String get email;
  @override
  @JsonKey(name: 'payment_amount')
  double get paymentAmount;
  @override
  @JsonKey(name: 'payment_type')
  String get paymentType;
  @override
  @JsonKey(name: 'installment_count')
  int get installmentCount;
  @override
  String get currency;
  @override
  @JsonKey(name: 'non_3d')
  int get non3d;
  @override
  @JsonKey(name: 'client_lang')
  String get clientLang;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  @JsonKey(name: 'user_address')
  String? get userAddress;
  @override
  @JsonKey(name: 'user_phone')
  String? get userPhone;
  @override
  List<PayTRBasketItem> get basket;
  @override
  @JsonKey(name: 'card_type')
  String? get cardType;
  @override
  @JsonKey(name: 'user_ip')
  String? get userIp;
  @override
  @JsonKey(name: 'debug_on')
  int get debugOn;

  /// Create a copy of PayTRDirectInitRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayTRDirectInitRequestImplCopyWith<_$PayTRDirectInitRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PayTRDirectInitResponse _$PayTRDirectInitResponseFromJson(
    Map<String, dynamic> json) {
  return _PayTRDirectInitResponse.fromJson(json);
}

/// @nodoc
mixin _$PayTRDirectInitResponse {
  String get action => throw _privateConstructorUsedError;
  PayTRDirectInitFields get fields => throw _privateConstructorUsedError;

  /// Serializes this PayTRDirectInitResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayTRDirectInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayTRDirectInitResponseCopyWith<PayTRDirectInitResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayTRDirectInitResponseCopyWith<$Res> {
  factory $PayTRDirectInitResponseCopyWith(PayTRDirectInitResponse value,
          $Res Function(PayTRDirectInitResponse) then) =
      _$PayTRDirectInitResponseCopyWithImpl<$Res, PayTRDirectInitResponse>;
  @useResult
  $Res call({String action, PayTRDirectInitFields fields});

  $PayTRDirectInitFieldsCopyWith<$Res> get fields;
}

/// @nodoc
class _$PayTRDirectInitResponseCopyWithImpl<$Res,
        $Val extends PayTRDirectInitResponse>
    implements $PayTRDirectInitResponseCopyWith<$Res> {
  _$PayTRDirectInitResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayTRDirectInitResponse
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
              as PayTRDirectInitFields,
    ) as $Val);
  }

  /// Create a copy of PayTRDirectInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PayTRDirectInitFieldsCopyWith<$Res> get fields {
    return $PayTRDirectInitFieldsCopyWith<$Res>(_value.fields, (value) {
      return _then(_value.copyWith(fields: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PayTRDirectInitResponseImplCopyWith<$Res>
    implements $PayTRDirectInitResponseCopyWith<$Res> {
  factory _$$PayTRDirectInitResponseImplCopyWith(
          _$PayTRDirectInitResponseImpl value,
          $Res Function(_$PayTRDirectInitResponseImpl) then) =
      __$$PayTRDirectInitResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String action, PayTRDirectInitFields fields});

  @override
  $PayTRDirectInitFieldsCopyWith<$Res> get fields;
}

/// @nodoc
class __$$PayTRDirectInitResponseImplCopyWithImpl<$Res>
    extends _$PayTRDirectInitResponseCopyWithImpl<$Res,
        _$PayTRDirectInitResponseImpl>
    implements _$$PayTRDirectInitResponseImplCopyWith<$Res> {
  __$$PayTRDirectInitResponseImplCopyWithImpl(
      _$PayTRDirectInitResponseImpl _value,
      $Res Function(_$PayTRDirectInitResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayTRDirectInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? fields = null,
  }) {
    return _then(_$PayTRDirectInitResponseImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as PayTRDirectInitFields,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayTRDirectInitResponseImpl implements _PayTRDirectInitResponse {
  const _$PayTRDirectInitResponseImpl(
      {required this.action, required this.fields});

  factory _$PayTRDirectInitResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayTRDirectInitResponseImplFromJson(json);

  @override
  final String action;
  @override
  final PayTRDirectInitFields fields;

  @override
  String toString() {
    return 'PayTRDirectInitResponse(action: $action, fields: $fields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayTRDirectInitResponseImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.fields, fields) || other.fields == fields));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, action, fields);

  /// Create a copy of PayTRDirectInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayTRDirectInitResponseImplCopyWith<_$PayTRDirectInitResponseImpl>
      get copyWith => __$$PayTRDirectInitResponseImplCopyWithImpl<
          _$PayTRDirectInitResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayTRDirectInitResponseImplToJson(
      this,
    );
  }
}

abstract class _PayTRDirectInitResponse implements PayTRDirectInitResponse {
  const factory _PayTRDirectInitResponse(
          {required final String action,
          required final PayTRDirectInitFields fields}) =
      _$PayTRDirectInitResponseImpl;

  factory _PayTRDirectInitResponse.fromJson(Map<String, dynamic> json) =
      _$PayTRDirectInitResponseImpl.fromJson;

  @override
  String get action;
  @override
  PayTRDirectInitFields get fields;

  /// Create a copy of PayTRDirectInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayTRDirectInitResponseImplCopyWith<_$PayTRDirectInitResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PayTRDirectInitFields _$PayTRDirectInitFieldsFromJson(
    Map<String, dynamic> json) {
  return _PayTRDirectInitFields.fromJson(json);
}

/// @nodoc
mixin _$PayTRDirectInitFields {
  @JsonKey(name: 'merchant_id')
  String get merchantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_ip')
  String get userIp => throw _privateConstructorUsedError;
  @JsonKey(name: 'merchant_oid')
  String get merchantOid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_type')
  String get paymentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_amount')
  String get paymentAmount =>
      throw _privateConstructorUsedError; // Kuruş string
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'test_mode')
  String get testMode => throw _privateConstructorUsedError;
  @JsonKey(name: 'non_3d')
  String get non3d => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_lang')
  String get clientLang => throw _privateConstructorUsedError;
  @JsonKey(name: 'merchant_ok_url')
  String get merchantOkUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'merchant_fail_url')
  String get merchantFailUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String get userName => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_address')
  String get userAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_phone')
  String get userPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_basket')
  String get userBasket => throw _privateConstructorUsedError; // Base64 JSON
  @JsonKey(name: 'installment_count')
  String get installmentCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'debug_on')
  String get debugOn => throw _privateConstructorUsedError;
  @JsonKey(name: 'paytr_token')
  String get paytrToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'card_type')
  String? get cardType => throw _privateConstructorUsedError;

  /// Serializes this PayTRDirectInitFields to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayTRDirectInitFields
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayTRDirectInitFieldsCopyWith<PayTRDirectInitFields> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayTRDirectInitFieldsCopyWith<$Res> {
  factory $PayTRDirectInitFieldsCopyWith(PayTRDirectInitFields value,
          $Res Function(PayTRDirectInitFields) then) =
      _$PayTRDirectInitFieldsCopyWithImpl<$Res, PayTRDirectInitFields>;
  @useResult
  $Res call(
      {@JsonKey(name: 'merchant_id') String merchantId,
      @JsonKey(name: 'user_ip') String userIp,
      @JsonKey(name: 'merchant_oid') String merchantOid,
      String email,
      @JsonKey(name: 'payment_type') String paymentType,
      @JsonKey(name: 'payment_amount') String paymentAmount,
      String currency,
      @JsonKey(name: 'test_mode') String testMode,
      @JsonKey(name: 'non_3d') String non3d,
      @JsonKey(name: 'client_lang') String clientLang,
      @JsonKey(name: 'merchant_ok_url') String merchantOkUrl,
      @JsonKey(name: 'merchant_fail_url') String merchantFailUrl,
      @JsonKey(name: 'user_name') String userName,
      @JsonKey(name: 'user_address') String userAddress,
      @JsonKey(name: 'user_phone') String userPhone,
      @JsonKey(name: 'user_basket') String userBasket,
      @JsonKey(name: 'installment_count') String installmentCount,
      @JsonKey(name: 'debug_on') String debugOn,
      @JsonKey(name: 'paytr_token') String paytrToken,
      @JsonKey(name: 'card_type') String? cardType});
}

/// @nodoc
class _$PayTRDirectInitFieldsCopyWithImpl<$Res,
        $Val extends PayTRDirectInitFields>
    implements $PayTRDirectInitFieldsCopyWith<$Res> {
  _$PayTRDirectInitFieldsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayTRDirectInitFields
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantId = null,
    Object? userIp = null,
    Object? merchantOid = null,
    Object? email = null,
    Object? paymentType = null,
    Object? paymentAmount = null,
    Object? currency = null,
    Object? testMode = null,
    Object? non3d = null,
    Object? clientLang = null,
    Object? merchantOkUrl = null,
    Object? merchantFailUrl = null,
    Object? userName = null,
    Object? userAddress = null,
    Object? userPhone = null,
    Object? userBasket = null,
    Object? installmentCount = null,
    Object? debugOn = null,
    Object? paytrToken = null,
    Object? cardType = freezed,
  }) {
    return _then(_value.copyWith(
      merchantId: null == merchantId
          ? _value.merchantId
          : merchantId // ignore: cast_nullable_to_non_nullable
              as String,
      userIp: null == userIp
          ? _value.userIp
          : userIp // ignore: cast_nullable_to_non_nullable
              as String,
      merchantOid: null == merchantOid
          ? _value.merchantOid
          : merchantOid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      paymentType: null == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as String,
      paymentAmount: null == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      testMode: null == testMode
          ? _value.testMode
          : testMode // ignore: cast_nullable_to_non_nullable
              as String,
      non3d: null == non3d
          ? _value.non3d
          : non3d // ignore: cast_nullable_to_non_nullable
              as String,
      clientLang: null == clientLang
          ? _value.clientLang
          : clientLang // ignore: cast_nullable_to_non_nullable
              as String,
      merchantOkUrl: null == merchantOkUrl
          ? _value.merchantOkUrl
          : merchantOkUrl // ignore: cast_nullable_to_non_nullable
              as String,
      merchantFailUrl: null == merchantFailUrl
          ? _value.merchantFailUrl
          : merchantFailUrl // ignore: cast_nullable_to_non_nullable
              as String,
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
      userBasket: null == userBasket
          ? _value.userBasket
          : userBasket // ignore: cast_nullable_to_non_nullable
              as String,
      installmentCount: null == installmentCount
          ? _value.installmentCount
          : installmentCount // ignore: cast_nullable_to_non_nullable
              as String,
      debugOn: null == debugOn
          ? _value.debugOn
          : debugOn // ignore: cast_nullable_to_non_nullable
              as String,
      paytrToken: null == paytrToken
          ? _value.paytrToken
          : paytrToken // ignore: cast_nullable_to_non_nullable
              as String,
      cardType: freezed == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayTRDirectInitFieldsImplCopyWith<$Res>
    implements $PayTRDirectInitFieldsCopyWith<$Res> {
  factory _$$PayTRDirectInitFieldsImplCopyWith(
          _$PayTRDirectInitFieldsImpl value,
          $Res Function(_$PayTRDirectInitFieldsImpl) then) =
      __$$PayTRDirectInitFieldsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'merchant_id') String merchantId,
      @JsonKey(name: 'user_ip') String userIp,
      @JsonKey(name: 'merchant_oid') String merchantOid,
      String email,
      @JsonKey(name: 'payment_type') String paymentType,
      @JsonKey(name: 'payment_amount') String paymentAmount,
      String currency,
      @JsonKey(name: 'test_mode') String testMode,
      @JsonKey(name: 'non_3d') String non3d,
      @JsonKey(name: 'client_lang') String clientLang,
      @JsonKey(name: 'merchant_ok_url') String merchantOkUrl,
      @JsonKey(name: 'merchant_fail_url') String merchantFailUrl,
      @JsonKey(name: 'user_name') String userName,
      @JsonKey(name: 'user_address') String userAddress,
      @JsonKey(name: 'user_phone') String userPhone,
      @JsonKey(name: 'user_basket') String userBasket,
      @JsonKey(name: 'installment_count') String installmentCount,
      @JsonKey(name: 'debug_on') String debugOn,
      @JsonKey(name: 'paytr_token') String paytrToken,
      @JsonKey(name: 'card_type') String? cardType});
}

/// @nodoc
class __$$PayTRDirectInitFieldsImplCopyWithImpl<$Res>
    extends _$PayTRDirectInitFieldsCopyWithImpl<$Res,
        _$PayTRDirectInitFieldsImpl>
    implements _$$PayTRDirectInitFieldsImplCopyWith<$Res> {
  __$$PayTRDirectInitFieldsImplCopyWithImpl(_$PayTRDirectInitFieldsImpl _value,
      $Res Function(_$PayTRDirectInitFieldsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayTRDirectInitFields
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantId = null,
    Object? userIp = null,
    Object? merchantOid = null,
    Object? email = null,
    Object? paymentType = null,
    Object? paymentAmount = null,
    Object? currency = null,
    Object? testMode = null,
    Object? non3d = null,
    Object? clientLang = null,
    Object? merchantOkUrl = null,
    Object? merchantFailUrl = null,
    Object? userName = null,
    Object? userAddress = null,
    Object? userPhone = null,
    Object? userBasket = null,
    Object? installmentCount = null,
    Object? debugOn = null,
    Object? paytrToken = null,
    Object? cardType = freezed,
  }) {
    return _then(_$PayTRDirectInitFieldsImpl(
      merchantId: null == merchantId
          ? _value.merchantId
          : merchantId // ignore: cast_nullable_to_non_nullable
              as String,
      userIp: null == userIp
          ? _value.userIp
          : userIp // ignore: cast_nullable_to_non_nullable
              as String,
      merchantOid: null == merchantOid
          ? _value.merchantOid
          : merchantOid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      paymentType: null == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as String,
      paymentAmount: null == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      testMode: null == testMode
          ? _value.testMode
          : testMode // ignore: cast_nullable_to_non_nullable
              as String,
      non3d: null == non3d
          ? _value.non3d
          : non3d // ignore: cast_nullable_to_non_nullable
              as String,
      clientLang: null == clientLang
          ? _value.clientLang
          : clientLang // ignore: cast_nullable_to_non_nullable
              as String,
      merchantOkUrl: null == merchantOkUrl
          ? _value.merchantOkUrl
          : merchantOkUrl // ignore: cast_nullable_to_non_nullable
              as String,
      merchantFailUrl: null == merchantFailUrl
          ? _value.merchantFailUrl
          : merchantFailUrl // ignore: cast_nullable_to_non_nullable
              as String,
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
      userBasket: null == userBasket
          ? _value.userBasket
          : userBasket // ignore: cast_nullable_to_non_nullable
              as String,
      installmentCount: null == installmentCount
          ? _value.installmentCount
          : installmentCount // ignore: cast_nullable_to_non_nullable
              as String,
      debugOn: null == debugOn
          ? _value.debugOn
          : debugOn // ignore: cast_nullable_to_non_nullable
              as String,
      paytrToken: null == paytrToken
          ? _value.paytrToken
          : paytrToken // ignore: cast_nullable_to_non_nullable
              as String,
      cardType: freezed == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayTRDirectInitFieldsImpl implements _PayTRDirectInitFields {
  const _$PayTRDirectInitFieldsImpl(
      {@JsonKey(name: 'merchant_id') required this.merchantId,
      @JsonKey(name: 'user_ip') required this.userIp,
      @JsonKey(name: 'merchant_oid') required this.merchantOid,
      required this.email,
      @JsonKey(name: 'payment_type') required this.paymentType,
      @JsonKey(name: 'payment_amount') required this.paymentAmount,
      required this.currency,
      @JsonKey(name: 'test_mode') required this.testMode,
      @JsonKey(name: 'non_3d') required this.non3d,
      @JsonKey(name: 'client_lang') required this.clientLang,
      @JsonKey(name: 'merchant_ok_url') required this.merchantOkUrl,
      @JsonKey(name: 'merchant_fail_url') required this.merchantFailUrl,
      @JsonKey(name: 'user_name') required this.userName,
      @JsonKey(name: 'user_address') required this.userAddress,
      @JsonKey(name: 'user_phone') required this.userPhone,
      @JsonKey(name: 'user_basket') required this.userBasket,
      @JsonKey(name: 'installment_count') required this.installmentCount,
      @JsonKey(name: 'debug_on') required this.debugOn,
      @JsonKey(name: 'paytr_token') required this.paytrToken,
      @JsonKey(name: 'card_type') this.cardType});

  factory _$PayTRDirectInitFieldsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayTRDirectInitFieldsImplFromJson(json);

  @override
  @JsonKey(name: 'merchant_id')
  final String merchantId;
  @override
  @JsonKey(name: 'user_ip')
  final String userIp;
  @override
  @JsonKey(name: 'merchant_oid')
  final String merchantOid;
  @override
  final String email;
  @override
  @JsonKey(name: 'payment_type')
  final String paymentType;
  @override
  @JsonKey(name: 'payment_amount')
  final String paymentAmount;
// Kuruş string
  @override
  final String currency;
  @override
  @JsonKey(name: 'test_mode')
  final String testMode;
  @override
  @JsonKey(name: 'non_3d')
  final String non3d;
  @override
  @JsonKey(name: 'client_lang')
  final String clientLang;
  @override
  @JsonKey(name: 'merchant_ok_url')
  final String merchantOkUrl;
  @override
  @JsonKey(name: 'merchant_fail_url')
  final String merchantFailUrl;
  @override
  @JsonKey(name: 'user_name')
  final String userName;
  @override
  @JsonKey(name: 'user_address')
  final String userAddress;
  @override
  @JsonKey(name: 'user_phone')
  final String userPhone;
  @override
  @JsonKey(name: 'user_basket')
  final String userBasket;
// Base64 JSON
  @override
  @JsonKey(name: 'installment_count')
  final String installmentCount;
  @override
  @JsonKey(name: 'debug_on')
  final String debugOn;
  @override
  @JsonKey(name: 'paytr_token')
  final String paytrToken;
  @override
  @JsonKey(name: 'card_type')
  final String? cardType;

  @override
  String toString() {
    return 'PayTRDirectInitFields(merchantId: $merchantId, userIp: $userIp, merchantOid: $merchantOid, email: $email, paymentType: $paymentType, paymentAmount: $paymentAmount, currency: $currency, testMode: $testMode, non3d: $non3d, clientLang: $clientLang, merchantOkUrl: $merchantOkUrl, merchantFailUrl: $merchantFailUrl, userName: $userName, userAddress: $userAddress, userPhone: $userPhone, userBasket: $userBasket, installmentCount: $installmentCount, debugOn: $debugOn, paytrToken: $paytrToken, cardType: $cardType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayTRDirectInitFieldsImpl &&
            (identical(other.merchantId, merchantId) ||
                other.merchantId == merchantId) &&
            (identical(other.userIp, userIp) || other.userIp == userIp) &&
            (identical(other.merchantOid, merchantOid) ||
                other.merchantOid == merchantOid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.paymentAmount, paymentAmount) ||
                other.paymentAmount == paymentAmount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.testMode, testMode) ||
                other.testMode == testMode) &&
            (identical(other.non3d, non3d) || other.non3d == non3d) &&
            (identical(other.clientLang, clientLang) ||
                other.clientLang == clientLang) &&
            (identical(other.merchantOkUrl, merchantOkUrl) ||
                other.merchantOkUrl == merchantOkUrl) &&
            (identical(other.merchantFailUrl, merchantFailUrl) ||
                other.merchantFailUrl == merchantFailUrl) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userAddress, userAddress) ||
                other.userAddress == userAddress) &&
            (identical(other.userPhone, userPhone) ||
                other.userPhone == userPhone) &&
            (identical(other.userBasket, userBasket) ||
                other.userBasket == userBasket) &&
            (identical(other.installmentCount, installmentCount) ||
                other.installmentCount == installmentCount) &&
            (identical(other.debugOn, debugOn) || other.debugOn == debugOn) &&
            (identical(other.paytrToken, paytrToken) ||
                other.paytrToken == paytrToken) &&
            (identical(other.cardType, cardType) ||
                other.cardType == cardType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        merchantId,
        userIp,
        merchantOid,
        email,
        paymentType,
        paymentAmount,
        currency,
        testMode,
        non3d,
        clientLang,
        merchantOkUrl,
        merchantFailUrl,
        userName,
        userAddress,
        userPhone,
        userBasket,
        installmentCount,
        debugOn,
        paytrToken,
        cardType
      ]);

  /// Create a copy of PayTRDirectInitFields
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayTRDirectInitFieldsImplCopyWith<_$PayTRDirectInitFieldsImpl>
      get copyWith => __$$PayTRDirectInitFieldsImplCopyWithImpl<
          _$PayTRDirectInitFieldsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayTRDirectInitFieldsImplToJson(
      this,
    );
  }
}

abstract class _PayTRDirectInitFields implements PayTRDirectInitFields {
  const factory _PayTRDirectInitFields(
      {@JsonKey(name: 'merchant_id') required final String merchantId,
      @JsonKey(name: 'user_ip') required final String userIp,
      @JsonKey(name: 'merchant_oid') required final String merchantOid,
      required final String email,
      @JsonKey(name: 'payment_type') required final String paymentType,
      @JsonKey(name: 'payment_amount') required final String paymentAmount,
      required final String currency,
      @JsonKey(name: 'test_mode') required final String testMode,
      @JsonKey(name: 'non_3d') required final String non3d,
      @JsonKey(name: 'client_lang') required final String clientLang,
      @JsonKey(name: 'merchant_ok_url') required final String merchantOkUrl,
      @JsonKey(name: 'merchant_fail_url') required final String merchantFailUrl,
      @JsonKey(name: 'user_name') required final String userName,
      @JsonKey(name: 'user_address') required final String userAddress,
      @JsonKey(name: 'user_phone') required final String userPhone,
      @JsonKey(name: 'user_basket') required final String userBasket,
      @JsonKey(name: 'installment_count')
      required final String installmentCount,
      @JsonKey(name: 'debug_on') required final String debugOn,
      @JsonKey(name: 'paytr_token') required final String paytrToken,
      @JsonKey(name: 'card_type')
      final String? cardType}) = _$PayTRDirectInitFieldsImpl;

  factory _PayTRDirectInitFields.fromJson(Map<String, dynamic> json) =
      _$PayTRDirectInitFieldsImpl.fromJson;

  @override
  @JsonKey(name: 'merchant_id')
  String get merchantId;
  @override
  @JsonKey(name: 'user_ip')
  String get userIp;
  @override
  @JsonKey(name: 'merchant_oid')
  String get merchantOid;
  @override
  String get email;
  @override
  @JsonKey(name: 'payment_type')
  String get paymentType;
  @override
  @JsonKey(name: 'payment_amount')
  String get paymentAmount; // Kuruş string
  @override
  String get currency;
  @override
  @JsonKey(name: 'test_mode')
  String get testMode;
  @override
  @JsonKey(name: 'non_3d')
  String get non3d;
  @override
  @JsonKey(name: 'client_lang')
  String get clientLang;
  @override
  @JsonKey(name: 'merchant_ok_url')
  String get merchantOkUrl;
  @override
  @JsonKey(name: 'merchant_fail_url')
  String get merchantFailUrl;
  @override
  @JsonKey(name: 'user_name')
  String get userName;
  @override
  @JsonKey(name: 'user_address')
  String get userAddress;
  @override
  @JsonKey(name: 'user_phone')
  String get userPhone;
  @override
  @JsonKey(name: 'user_basket')
  String get userBasket; // Base64 JSON
  @override
  @JsonKey(name: 'installment_count')
  String get installmentCount;
  @override
  @JsonKey(name: 'debug_on')
  String get debugOn;
  @override
  @JsonKey(name: 'paytr_token')
  String get paytrToken;
  @override
  @JsonKey(name: 'card_type')
  String? get cardType;

  /// Create a copy of PayTRDirectInitFields
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayTRDirectInitFieldsImplCopyWith<_$PayTRDirectInitFieldsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PayTRIframeInitRequest _$PayTRIframeInitRequestFromJson(
    Map<String, dynamic> json) {
  return _PayTRIframeInitRequest.fromJson(json);
}

/// @nodoc
mixin _$PayTRIframeInitRequest {
  @JsonKey(name: 'merchant_oid')
  String get merchantOid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_amount')
  double get paymentAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_address')
  String? get userAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_phone')
  String? get userPhone => throw _privateConstructorUsedError;
  List<PayTRBasketItem> get basket => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_ip')
  String? get userIp => throw _privateConstructorUsedError;
  @JsonKey(name: 'debug_on')
  int get debugOn => throw _privateConstructorUsedError;
  @JsonKey(name: 'no_installment')
  int get noInstallment => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_installment')
  int get maxInstallment => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;

  /// Serializes this PayTRIframeInitRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayTRIframeInitRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayTRIframeInitRequestCopyWith<PayTRIframeInitRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayTRIframeInitRequestCopyWith<$Res> {
  factory $PayTRIframeInitRequestCopyWith(PayTRIframeInitRequest value,
          $Res Function(PayTRIframeInitRequest) then) =
      _$PayTRIframeInitRequestCopyWithImpl<$Res, PayTRIframeInitRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'merchant_oid') String merchantOid,
      String email,
      @JsonKey(name: 'payment_amount') double paymentAmount,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'user_address') String? userAddress,
      @JsonKey(name: 'user_phone') String? userPhone,
      List<PayTRBasketItem> basket,
      @JsonKey(name: 'user_ip') String? userIp,
      @JsonKey(name: 'debug_on') int debugOn,
      @JsonKey(name: 'no_installment') int noInstallment,
      @JsonKey(name: 'max_installment') int maxInstallment,
      String currency});
}

/// @nodoc
class _$PayTRIframeInitRequestCopyWithImpl<$Res,
        $Val extends PayTRIframeInitRequest>
    implements $PayTRIframeInitRequestCopyWith<$Res> {
  _$PayTRIframeInitRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayTRIframeInitRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantOid = null,
    Object? email = null,
    Object? paymentAmount = null,
    Object? userName = freezed,
    Object? userAddress = freezed,
    Object? userPhone = freezed,
    Object? basket = null,
    Object? userIp = freezed,
    Object? debugOn = null,
    Object? noInstallment = null,
    Object? maxInstallment = null,
    Object? currency = null,
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
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userAddress: freezed == userAddress
          ? _value.userAddress
          : userAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      userPhone: freezed == userPhone
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      basket: null == basket
          ? _value.basket
          : basket // ignore: cast_nullable_to_non_nullable
              as List<PayTRBasketItem>,
      userIp: freezed == userIp
          ? _value.userIp
          : userIp // ignore: cast_nullable_to_non_nullable
              as String?,
      debugOn: null == debugOn
          ? _value.debugOn
          : debugOn // ignore: cast_nullable_to_non_nullable
              as int,
      noInstallment: null == noInstallment
          ? _value.noInstallment
          : noInstallment // ignore: cast_nullable_to_non_nullable
              as int,
      maxInstallment: null == maxInstallment
          ? _value.maxInstallment
          : maxInstallment // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayTRIframeInitRequestImplCopyWith<$Res>
    implements $PayTRIframeInitRequestCopyWith<$Res> {
  factory _$$PayTRIframeInitRequestImplCopyWith(
          _$PayTRIframeInitRequestImpl value,
          $Res Function(_$PayTRIframeInitRequestImpl) then) =
      __$$PayTRIframeInitRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'merchant_oid') String merchantOid,
      String email,
      @JsonKey(name: 'payment_amount') double paymentAmount,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'user_address') String? userAddress,
      @JsonKey(name: 'user_phone') String? userPhone,
      List<PayTRBasketItem> basket,
      @JsonKey(name: 'user_ip') String? userIp,
      @JsonKey(name: 'debug_on') int debugOn,
      @JsonKey(name: 'no_installment') int noInstallment,
      @JsonKey(name: 'max_installment') int maxInstallment,
      String currency});
}

/// @nodoc
class __$$PayTRIframeInitRequestImplCopyWithImpl<$Res>
    extends _$PayTRIframeInitRequestCopyWithImpl<$Res,
        _$PayTRIframeInitRequestImpl>
    implements _$$PayTRIframeInitRequestImplCopyWith<$Res> {
  __$$PayTRIframeInitRequestImplCopyWithImpl(
      _$PayTRIframeInitRequestImpl _value,
      $Res Function(_$PayTRIframeInitRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayTRIframeInitRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantOid = null,
    Object? email = null,
    Object? paymentAmount = null,
    Object? userName = freezed,
    Object? userAddress = freezed,
    Object? userPhone = freezed,
    Object? basket = null,
    Object? userIp = freezed,
    Object? debugOn = null,
    Object? noInstallment = null,
    Object? maxInstallment = null,
    Object? currency = null,
  }) {
    return _then(_$PayTRIframeInitRequestImpl(
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
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userAddress: freezed == userAddress
          ? _value.userAddress
          : userAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      userPhone: freezed == userPhone
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      basket: null == basket
          ? _value._basket
          : basket // ignore: cast_nullable_to_non_nullable
              as List<PayTRBasketItem>,
      userIp: freezed == userIp
          ? _value.userIp
          : userIp // ignore: cast_nullable_to_non_nullable
              as String?,
      debugOn: null == debugOn
          ? _value.debugOn
          : debugOn // ignore: cast_nullable_to_non_nullable
              as int,
      noInstallment: null == noInstallment
          ? _value.noInstallment
          : noInstallment // ignore: cast_nullable_to_non_nullable
              as int,
      maxInstallment: null == maxInstallment
          ? _value.maxInstallment
          : maxInstallment // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayTRIframeInitRequestImpl implements _PayTRIframeInitRequest {
  const _$PayTRIframeInitRequestImpl(
      {@JsonKey(name: 'merchant_oid') required this.merchantOid,
      required this.email,
      @JsonKey(name: 'payment_amount') required this.paymentAmount,
      @JsonKey(name: 'user_name') this.userName,
      @JsonKey(name: 'user_address') this.userAddress,
      @JsonKey(name: 'user_phone') this.userPhone,
      required final List<PayTRBasketItem> basket,
      @JsonKey(name: 'user_ip') this.userIp,
      @JsonKey(name: 'debug_on') this.debugOn = 1,
      @JsonKey(name: 'no_installment') this.noInstallment = 0,
      @JsonKey(name: 'max_installment') this.maxInstallment = 0,
      this.currency = 'TL'})
      : _basket = basket;

  factory _$PayTRIframeInitRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayTRIframeInitRequestImplFromJson(json);

  @override
  @JsonKey(name: 'merchant_oid')
  final String merchantOid;
  @override
  final String email;
  @override
  @JsonKey(name: 'payment_amount')
  final double paymentAmount;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
  @override
  @JsonKey(name: 'user_address')
  final String? userAddress;
  @override
  @JsonKey(name: 'user_phone')
  final String? userPhone;
  final List<PayTRBasketItem> _basket;
  @override
  List<PayTRBasketItem> get basket {
    if (_basket is EqualUnmodifiableListView) return _basket;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_basket);
  }

  @override
  @JsonKey(name: 'user_ip')
  final String? userIp;
  @override
  @JsonKey(name: 'debug_on')
  final int debugOn;
  @override
  @JsonKey(name: 'no_installment')
  final int noInstallment;
  @override
  @JsonKey(name: 'max_installment')
  final int maxInstallment;
  @override
  @JsonKey()
  final String currency;

  @override
  String toString() {
    return 'PayTRIframeInitRequest(merchantOid: $merchantOid, email: $email, paymentAmount: $paymentAmount, userName: $userName, userAddress: $userAddress, userPhone: $userPhone, basket: $basket, userIp: $userIp, debugOn: $debugOn, noInstallment: $noInstallment, maxInstallment: $maxInstallment, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayTRIframeInitRequestImpl &&
            (identical(other.merchantOid, merchantOid) ||
                other.merchantOid == merchantOid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.paymentAmount, paymentAmount) ||
                other.paymentAmount == paymentAmount) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userAddress, userAddress) ||
                other.userAddress == userAddress) &&
            (identical(other.userPhone, userPhone) ||
                other.userPhone == userPhone) &&
            const DeepCollectionEquality().equals(other._basket, _basket) &&
            (identical(other.userIp, userIp) || other.userIp == userIp) &&
            (identical(other.debugOn, debugOn) || other.debugOn == debugOn) &&
            (identical(other.noInstallment, noInstallment) ||
                other.noInstallment == noInstallment) &&
            (identical(other.maxInstallment, maxInstallment) ||
                other.maxInstallment == maxInstallment) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      merchantOid,
      email,
      paymentAmount,
      userName,
      userAddress,
      userPhone,
      const DeepCollectionEquality().hash(_basket),
      userIp,
      debugOn,
      noInstallment,
      maxInstallment,
      currency);

  /// Create a copy of PayTRIframeInitRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayTRIframeInitRequestImplCopyWith<_$PayTRIframeInitRequestImpl>
      get copyWith => __$$PayTRIframeInitRequestImplCopyWithImpl<
          _$PayTRIframeInitRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayTRIframeInitRequestImplToJson(
      this,
    );
  }
}

abstract class _PayTRIframeInitRequest implements PayTRIframeInitRequest {
  const factory _PayTRIframeInitRequest(
      {@JsonKey(name: 'merchant_oid') required final String merchantOid,
      required final String email,
      @JsonKey(name: 'payment_amount') required final double paymentAmount,
      @JsonKey(name: 'user_name') final String? userName,
      @JsonKey(name: 'user_address') final String? userAddress,
      @JsonKey(name: 'user_phone') final String? userPhone,
      required final List<PayTRBasketItem> basket,
      @JsonKey(name: 'user_ip') final String? userIp,
      @JsonKey(name: 'debug_on') final int debugOn,
      @JsonKey(name: 'no_installment') final int noInstallment,
      @JsonKey(name: 'max_installment') final int maxInstallment,
      final String currency}) = _$PayTRIframeInitRequestImpl;

  factory _PayTRIframeInitRequest.fromJson(Map<String, dynamic> json) =
      _$PayTRIframeInitRequestImpl.fromJson;

  @override
  @JsonKey(name: 'merchant_oid')
  String get merchantOid;
  @override
  String get email;
  @override
  @JsonKey(name: 'payment_amount')
  double get paymentAmount;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  @JsonKey(name: 'user_address')
  String? get userAddress;
  @override
  @JsonKey(name: 'user_phone')
  String? get userPhone;
  @override
  List<PayTRBasketItem> get basket;
  @override
  @JsonKey(name: 'user_ip')
  String? get userIp;
  @override
  @JsonKey(name: 'debug_on')
  int get debugOn;
  @override
  @JsonKey(name: 'no_installment')
  int get noInstallment;
  @override
  @JsonKey(name: 'max_installment')
  int get maxInstallment;
  @override
  String get currency;

  /// Create a copy of PayTRIframeInitRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayTRIframeInitRequestImplCopyWith<_$PayTRIframeInitRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PayTRIframeInitResponse _$PayTRIframeInitResponseFromJson(
    Map<String, dynamic> json) {
  return _PayTRIframeInitResponse.fromJson(json);
}

/// @nodoc
mixin _$PayTRIframeInitResponse {
  String get token => throw _privateConstructorUsedError;

  /// Serializes this PayTRIframeInitResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayTRIframeInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayTRIframeInitResponseCopyWith<PayTRIframeInitResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayTRIframeInitResponseCopyWith<$Res> {
  factory $PayTRIframeInitResponseCopyWith(PayTRIframeInitResponse value,
          $Res Function(PayTRIframeInitResponse) then) =
      _$PayTRIframeInitResponseCopyWithImpl<$Res, PayTRIframeInitResponse>;
  @useResult
  $Res call({String token});
}

/// @nodoc
class _$PayTRIframeInitResponseCopyWithImpl<$Res,
        $Val extends PayTRIframeInitResponse>
    implements $PayTRIframeInitResponseCopyWith<$Res> {
  _$PayTRIframeInitResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayTRIframeInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayTRIframeInitResponseImplCopyWith<$Res>
    implements $PayTRIframeInitResponseCopyWith<$Res> {
  factory _$$PayTRIframeInitResponseImplCopyWith(
          _$PayTRIframeInitResponseImpl value,
          $Res Function(_$PayTRIframeInitResponseImpl) then) =
      __$$PayTRIframeInitResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$PayTRIframeInitResponseImplCopyWithImpl<$Res>
    extends _$PayTRIframeInitResponseCopyWithImpl<$Res,
        _$PayTRIframeInitResponseImpl>
    implements _$$PayTRIframeInitResponseImplCopyWith<$Res> {
  __$$PayTRIframeInitResponseImplCopyWithImpl(
      _$PayTRIframeInitResponseImpl _value,
      $Res Function(_$PayTRIframeInitResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayTRIframeInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$PayTRIframeInitResponseImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayTRIframeInitResponseImpl implements _PayTRIframeInitResponse {
  const _$PayTRIframeInitResponseImpl({required this.token});

  factory _$PayTRIframeInitResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayTRIframeInitResponseImplFromJson(json);

  @override
  final String token;

  @override
  String toString() {
    return 'PayTRIframeInitResponse(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayTRIframeInitResponseImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  /// Create a copy of PayTRIframeInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayTRIframeInitResponseImplCopyWith<_$PayTRIframeInitResponseImpl>
      get copyWith => __$$PayTRIframeInitResponseImplCopyWithImpl<
          _$PayTRIframeInitResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayTRIframeInitResponseImplToJson(
      this,
    );
  }
}

abstract class _PayTRIframeInitResponse implements PayTRIframeInitResponse {
  const factory _PayTRIframeInitResponse({required final String token}) =
      _$PayTRIframeInitResponseImpl;

  factory _PayTRIframeInitResponse.fromJson(Map<String, dynamic> json) =
      _$PayTRIframeInitResponseImpl.fromJson;

  @override
  String get token;

  /// Create a copy of PayTRIframeInitResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayTRIframeInitResponseImplCopyWith<_$PayTRIframeInitResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PayTRTokenRequest _$PayTRTokenRequestFromJson(Map<String, dynamic> json) {
  return _PayTRTokenRequest.fromJson(json);
}

/// @nodoc
mixin _$PayTRTokenRequest {
  @JsonKey(name: 'merchant_oid')
  String get merchantOid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String get userName => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_address')
  String get userAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_phone')
  String get userPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_amount')
  double get paymentAmount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  List<PayTRBasketItem> get basket => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_ip')
  String? get userIp => throw _privateConstructorUsedError;
  @JsonKey(name: 'no_installment')
  int get noInstallment => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_installment')
  int get maxInstallment => throw _privateConstructorUsedError;
  @JsonKey(name: 'timeout_limit')
  int get timeoutLimit => throw _privateConstructorUsedError;
  String get lang => throw _privateConstructorUsedError;
  @JsonKey(name: 'debug_on')
  int get debugOn => throw _privateConstructorUsedError;

  /// Serializes this PayTRTokenRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayTRTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayTRTokenRequestCopyWith<PayTRTokenRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayTRTokenRequestCopyWith<$Res> {
  factory $PayTRTokenRequestCopyWith(
          PayTRTokenRequest value, $Res Function(PayTRTokenRequest) then) =
      _$PayTRTokenRequestCopyWithImpl<$Res, PayTRTokenRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'merchant_oid') String merchantOid,
      String email,
      @JsonKey(name: 'user_name') String userName,
      @JsonKey(name: 'user_address') String userAddress,
      @JsonKey(name: 'user_phone') String userPhone,
      @JsonKey(name: 'payment_amount') double paymentAmount,
      String currency,
      List<PayTRBasketItem> basket,
      @JsonKey(name: 'user_ip') String? userIp,
      @JsonKey(name: 'no_installment') int noInstallment,
      @JsonKey(name: 'max_installment') int maxInstallment,
      @JsonKey(name: 'timeout_limit') int timeoutLimit,
      String lang,
      @JsonKey(name: 'debug_on') int debugOn});
}

/// @nodoc
class _$PayTRTokenRequestCopyWithImpl<$Res, $Val extends PayTRTokenRequest>
    implements $PayTRTokenRequestCopyWith<$Res> {
  _$PayTRTokenRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayTRTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantOid = null,
    Object? email = null,
    Object? userName = null,
    Object? userAddress = null,
    Object? userPhone = null,
    Object? paymentAmount = null,
    Object? currency = null,
    Object? basket = null,
    Object? userIp = freezed,
    Object? noInstallment = null,
    Object? maxInstallment = null,
    Object? timeoutLimit = null,
    Object? lang = null,
    Object? debugOn = null,
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
      paymentAmount: null == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      basket: null == basket
          ? _value.basket
          : basket // ignore: cast_nullable_to_non_nullable
              as List<PayTRBasketItem>,
      userIp: freezed == userIp
          ? _value.userIp
          : userIp // ignore: cast_nullable_to_non_nullable
              as String?,
      noInstallment: null == noInstallment
          ? _value.noInstallment
          : noInstallment // ignore: cast_nullable_to_non_nullable
              as int,
      maxInstallment: null == maxInstallment
          ? _value.maxInstallment
          : maxInstallment // ignore: cast_nullable_to_non_nullable
              as int,
      timeoutLimit: null == timeoutLimit
          ? _value.timeoutLimit
          : timeoutLimit // ignore: cast_nullable_to_non_nullable
              as int,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      debugOn: null == debugOn
          ? _value.debugOn
          : debugOn // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayTRTokenRequestImplCopyWith<$Res>
    implements $PayTRTokenRequestCopyWith<$Res> {
  factory _$$PayTRTokenRequestImplCopyWith(_$PayTRTokenRequestImpl value,
          $Res Function(_$PayTRTokenRequestImpl) then) =
      __$$PayTRTokenRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'merchant_oid') String merchantOid,
      String email,
      @JsonKey(name: 'user_name') String userName,
      @JsonKey(name: 'user_address') String userAddress,
      @JsonKey(name: 'user_phone') String userPhone,
      @JsonKey(name: 'payment_amount') double paymentAmount,
      String currency,
      List<PayTRBasketItem> basket,
      @JsonKey(name: 'user_ip') String? userIp,
      @JsonKey(name: 'no_installment') int noInstallment,
      @JsonKey(name: 'max_installment') int maxInstallment,
      @JsonKey(name: 'timeout_limit') int timeoutLimit,
      String lang,
      @JsonKey(name: 'debug_on') int debugOn});
}

/// @nodoc
class __$$PayTRTokenRequestImplCopyWithImpl<$Res>
    extends _$PayTRTokenRequestCopyWithImpl<$Res, _$PayTRTokenRequestImpl>
    implements _$$PayTRTokenRequestImplCopyWith<$Res> {
  __$$PayTRTokenRequestImplCopyWithImpl(_$PayTRTokenRequestImpl _value,
      $Res Function(_$PayTRTokenRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayTRTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchantOid = null,
    Object? email = null,
    Object? userName = null,
    Object? userAddress = null,
    Object? userPhone = null,
    Object? paymentAmount = null,
    Object? currency = null,
    Object? basket = null,
    Object? userIp = freezed,
    Object? noInstallment = null,
    Object? maxInstallment = null,
    Object? timeoutLimit = null,
    Object? lang = null,
    Object? debugOn = null,
  }) {
    return _then(_$PayTRTokenRequestImpl(
      merchantOid: null == merchantOid
          ? _value.merchantOid
          : merchantOid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
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
      paymentAmount: null == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      basket: null == basket
          ? _value._basket
          : basket // ignore: cast_nullable_to_non_nullable
              as List<PayTRBasketItem>,
      userIp: freezed == userIp
          ? _value.userIp
          : userIp // ignore: cast_nullable_to_non_nullable
              as String?,
      noInstallment: null == noInstallment
          ? _value.noInstallment
          : noInstallment // ignore: cast_nullable_to_non_nullable
              as int,
      maxInstallment: null == maxInstallment
          ? _value.maxInstallment
          : maxInstallment // ignore: cast_nullable_to_non_nullable
              as int,
      timeoutLimit: null == timeoutLimit
          ? _value.timeoutLimit
          : timeoutLimit // ignore: cast_nullable_to_non_nullable
              as int,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
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
class _$PayTRTokenRequestImpl implements _PayTRTokenRequest {
  const _$PayTRTokenRequestImpl(
      {@JsonKey(name: 'merchant_oid') required this.merchantOid,
      required this.email,
      @JsonKey(name: 'user_name') required this.userName,
      @JsonKey(name: 'user_address') required this.userAddress,
      @JsonKey(name: 'user_phone') required this.userPhone,
      @JsonKey(name: 'payment_amount') required this.paymentAmount,
      required this.currency,
      required final List<PayTRBasketItem> basket,
      @JsonKey(name: 'user_ip') this.userIp,
      @JsonKey(name: 'no_installment') this.noInstallment = 0,
      @JsonKey(name: 'max_installment') this.maxInstallment = 0,
      @JsonKey(name: 'timeout_limit') this.timeoutLimit = 30,
      this.lang = 'tr',
      @JsonKey(name: 'debug_on') this.debugOn = 1})
      : _basket = basket;

  factory _$PayTRTokenRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayTRTokenRequestImplFromJson(json);

  @override
  @JsonKey(name: 'merchant_oid')
  final String merchantOid;
  @override
  final String email;
  @override
  @JsonKey(name: 'user_name')
  final String userName;
  @override
  @JsonKey(name: 'user_address')
  final String userAddress;
  @override
  @JsonKey(name: 'user_phone')
  final String userPhone;
  @override
  @JsonKey(name: 'payment_amount')
  final double paymentAmount;
  @override
  final String currency;
  final List<PayTRBasketItem> _basket;
  @override
  List<PayTRBasketItem> get basket {
    if (_basket is EqualUnmodifiableListView) return _basket;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_basket);
  }

  @override
  @JsonKey(name: 'user_ip')
  final String? userIp;
  @override
  @JsonKey(name: 'no_installment')
  final int noInstallment;
  @override
  @JsonKey(name: 'max_installment')
  final int maxInstallment;
  @override
  @JsonKey(name: 'timeout_limit')
  final int timeoutLimit;
  @override
  @JsonKey()
  final String lang;
  @override
  @JsonKey(name: 'debug_on')
  final int debugOn;

  @override
  String toString() {
    return 'PayTRTokenRequest(merchantOid: $merchantOid, email: $email, userName: $userName, userAddress: $userAddress, userPhone: $userPhone, paymentAmount: $paymentAmount, currency: $currency, basket: $basket, userIp: $userIp, noInstallment: $noInstallment, maxInstallment: $maxInstallment, timeoutLimit: $timeoutLimit, lang: $lang, debugOn: $debugOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayTRTokenRequestImpl &&
            (identical(other.merchantOid, merchantOid) ||
                other.merchantOid == merchantOid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userAddress, userAddress) ||
                other.userAddress == userAddress) &&
            (identical(other.userPhone, userPhone) ||
                other.userPhone == userPhone) &&
            (identical(other.paymentAmount, paymentAmount) ||
                other.paymentAmount == paymentAmount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            const DeepCollectionEquality().equals(other._basket, _basket) &&
            (identical(other.userIp, userIp) || other.userIp == userIp) &&
            (identical(other.noInstallment, noInstallment) ||
                other.noInstallment == noInstallment) &&
            (identical(other.maxInstallment, maxInstallment) ||
                other.maxInstallment == maxInstallment) &&
            (identical(other.timeoutLimit, timeoutLimit) ||
                other.timeoutLimit == timeoutLimit) &&
            (identical(other.lang, lang) || other.lang == lang) &&
            (identical(other.debugOn, debugOn) || other.debugOn == debugOn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      merchantOid,
      email,
      userName,
      userAddress,
      userPhone,
      paymentAmount,
      currency,
      const DeepCollectionEquality().hash(_basket),
      userIp,
      noInstallment,
      maxInstallment,
      timeoutLimit,
      lang,
      debugOn);

  /// Create a copy of PayTRTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayTRTokenRequestImplCopyWith<_$PayTRTokenRequestImpl> get copyWith =>
      __$$PayTRTokenRequestImplCopyWithImpl<_$PayTRTokenRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayTRTokenRequestImplToJson(
      this,
    );
  }
}

abstract class _PayTRTokenRequest implements PayTRTokenRequest {
  const factory _PayTRTokenRequest(
      {@JsonKey(name: 'merchant_oid') required final String merchantOid,
      required final String email,
      @JsonKey(name: 'user_name') required final String userName,
      @JsonKey(name: 'user_address') required final String userAddress,
      @JsonKey(name: 'user_phone') required final String userPhone,
      @JsonKey(name: 'payment_amount') required final double paymentAmount,
      required final String currency,
      required final List<PayTRBasketItem> basket,
      @JsonKey(name: 'user_ip') final String? userIp,
      @JsonKey(name: 'no_installment') final int noInstallment,
      @JsonKey(name: 'max_installment') final int maxInstallment,
      @JsonKey(name: 'timeout_limit') final int timeoutLimit,
      final String lang,
      @JsonKey(name: 'debug_on') final int debugOn}) = _$PayTRTokenRequestImpl;

  factory _PayTRTokenRequest.fromJson(Map<String, dynamic> json) =
      _$PayTRTokenRequestImpl.fromJson;

  @override
  @JsonKey(name: 'merchant_oid')
  String get merchantOid;
  @override
  String get email;
  @override
  @JsonKey(name: 'user_name')
  String get userName;
  @override
  @JsonKey(name: 'user_address')
  String get userAddress;
  @override
  @JsonKey(name: 'user_phone')
  String get userPhone;
  @override
  @JsonKey(name: 'payment_amount')
  double get paymentAmount;
  @override
  String get currency;
  @override
  List<PayTRBasketItem> get basket;
  @override
  @JsonKey(name: 'user_ip')
  String? get userIp;
  @override
  @JsonKey(name: 'no_installment')
  int get noInstallment;
  @override
  @JsonKey(name: 'max_installment')
  int get maxInstallment;
  @override
  @JsonKey(name: 'timeout_limit')
  int get timeoutLimit;
  @override
  String get lang;
  @override
  @JsonKey(name: 'debug_on')
  int get debugOn;

  /// Create a copy of PayTRTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayTRTokenRequestImplCopyWith<_$PayTRTokenRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PayTRTokenResponse _$PayTRTokenResponseFromJson(Map<String, dynamic> json) {
  return _PayTRTokenResponse.fromJson(json);
}

/// @nodoc
mixin _$PayTRTokenResponse {
  String get token => throw _privateConstructorUsedError;
  @JsonKey(name: 'iframe_url')
  String get iframeUrl => throw _privateConstructorUsedError;

  /// Serializes this PayTRTokenResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayTRTokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayTRTokenResponseCopyWith<PayTRTokenResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayTRTokenResponseCopyWith<$Res> {
  factory $PayTRTokenResponseCopyWith(
          PayTRTokenResponse value, $Res Function(PayTRTokenResponse) then) =
      _$PayTRTokenResponseCopyWithImpl<$Res, PayTRTokenResponse>;
  @useResult
  $Res call({String token, @JsonKey(name: 'iframe_url') String iframeUrl});
}

/// @nodoc
class _$PayTRTokenResponseCopyWithImpl<$Res, $Val extends PayTRTokenResponse>
    implements $PayTRTokenResponseCopyWith<$Res> {
  _$PayTRTokenResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayTRTokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? iframeUrl = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      iframeUrl: null == iframeUrl
          ? _value.iframeUrl
          : iframeUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayTRTokenResponseImplCopyWith<$Res>
    implements $PayTRTokenResponseCopyWith<$Res> {
  factory _$$PayTRTokenResponseImplCopyWith(_$PayTRTokenResponseImpl value,
          $Res Function(_$PayTRTokenResponseImpl) then) =
      __$$PayTRTokenResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token, @JsonKey(name: 'iframe_url') String iframeUrl});
}

/// @nodoc
class __$$PayTRTokenResponseImplCopyWithImpl<$Res>
    extends _$PayTRTokenResponseCopyWithImpl<$Res, _$PayTRTokenResponseImpl>
    implements _$$PayTRTokenResponseImplCopyWith<$Res> {
  __$$PayTRTokenResponseImplCopyWithImpl(_$PayTRTokenResponseImpl _value,
      $Res Function(_$PayTRTokenResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayTRTokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? iframeUrl = null,
  }) {
    return _then(_$PayTRTokenResponseImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      iframeUrl: null == iframeUrl
          ? _value.iframeUrl
          : iframeUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayTRTokenResponseImpl implements _PayTRTokenResponse {
  const _$PayTRTokenResponseImpl(
      {required this.token,
      @JsonKey(name: 'iframe_url') required this.iframeUrl});

  factory _$PayTRTokenResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayTRTokenResponseImplFromJson(json);

  @override
  final String token;
  @override
  @JsonKey(name: 'iframe_url')
  final String iframeUrl;

  @override
  String toString() {
    return 'PayTRTokenResponse(token: $token, iframeUrl: $iframeUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayTRTokenResponseImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.iframeUrl, iframeUrl) ||
                other.iframeUrl == iframeUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, iframeUrl);

  /// Create a copy of PayTRTokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayTRTokenResponseImplCopyWith<_$PayTRTokenResponseImpl> get copyWith =>
      __$$PayTRTokenResponseImplCopyWithImpl<_$PayTRTokenResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayTRTokenResponseImplToJson(
      this,
    );
  }
}

abstract class _PayTRTokenResponse implements PayTRTokenResponse {
  const factory _PayTRTokenResponse(
          {required final String token,
          @JsonKey(name: 'iframe_url') required final String iframeUrl}) =
      _$PayTRTokenResponseImpl;

  factory _PayTRTokenResponse.fromJson(Map<String, dynamic> json) =
      _$PayTRTokenResponseImpl.fromJson;

  @override
  String get token;
  @override
  @JsonKey(name: 'iframe_url')
  String get iframeUrl;

  /// Create a copy of PayTRTokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayTRTokenResponseImplCopyWith<_$PayTRTokenResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PayTRPaymentInfo _$PayTRPaymentInfoFromJson(Map<String, dynamic> json) {
  return _PayTRPaymentInfo.fromJson(json);
}

/// @nodoc
mixin _$PayTRPaymentInfo {
  String get provider => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'received_total')
  double get receivedTotal => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_type')
  String get paymentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'reported_at')
  DateTime get reportedAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get paytr => throw _privateConstructorUsedError;

  /// Serializes this PayTRPaymentInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayTRPaymentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayTRPaymentInfoCopyWith<PayTRPaymentInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayTRPaymentInfoCopyWith<$Res> {
  factory $PayTRPaymentInfoCopyWith(
          PayTRPaymentInfo value, $Res Function(PayTRPaymentInfo) then) =
      _$PayTRPaymentInfoCopyWithImpl<$Res, PayTRPaymentInfo>;
  @useResult
  $Res call(
      {String provider,
      String status,
      @JsonKey(name: 'received_total') double receivedTotal,
      String currency,
      @JsonKey(name: 'payment_type') String paymentType,
      @JsonKey(name: 'reported_at') DateTime reportedAt,
      Map<String, dynamic>? paytr});
}

/// @nodoc
class _$PayTRPaymentInfoCopyWithImpl<$Res, $Val extends PayTRPaymentInfo>
    implements $PayTRPaymentInfoCopyWith<$Res> {
  _$PayTRPaymentInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayTRPaymentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
    Object? status = null,
    Object? receivedTotal = null,
    Object? currency = null,
    Object? paymentType = null,
    Object? reportedAt = null,
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
      receivedTotal: null == receivedTotal
          ? _value.receivedTotal
          : receivedTotal // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      paymentType: null == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as String,
      reportedAt: null == reportedAt
          ? _value.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paytr: freezed == paytr
          ? _value.paytr
          : paytr // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayTRPaymentInfoImplCopyWith<$Res>
    implements $PayTRPaymentInfoCopyWith<$Res> {
  factory _$$PayTRPaymentInfoImplCopyWith(_$PayTRPaymentInfoImpl value,
          $Res Function(_$PayTRPaymentInfoImpl) then) =
      __$$PayTRPaymentInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String provider,
      String status,
      @JsonKey(name: 'received_total') double receivedTotal,
      String currency,
      @JsonKey(name: 'payment_type') String paymentType,
      @JsonKey(name: 'reported_at') DateTime reportedAt,
      Map<String, dynamic>? paytr});
}

/// @nodoc
class __$$PayTRPaymentInfoImplCopyWithImpl<$Res>
    extends _$PayTRPaymentInfoCopyWithImpl<$Res, _$PayTRPaymentInfoImpl>
    implements _$$PayTRPaymentInfoImplCopyWith<$Res> {
  __$$PayTRPaymentInfoImplCopyWithImpl(_$PayTRPaymentInfoImpl _value,
      $Res Function(_$PayTRPaymentInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayTRPaymentInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
    Object? status = null,
    Object? receivedTotal = null,
    Object? currency = null,
    Object? paymentType = null,
    Object? reportedAt = null,
    Object? paytr = freezed,
  }) {
    return _then(_$PayTRPaymentInfoImpl(
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      receivedTotal: null == receivedTotal
          ? _value.receivedTotal
          : receivedTotal // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      paymentType: null == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as String,
      reportedAt: null == reportedAt
          ? _value.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paytr: freezed == paytr
          ? _value._paytr
          : paytr // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayTRPaymentInfoImpl implements _PayTRPaymentInfo {
  const _$PayTRPaymentInfoImpl(
      {required this.provider,
      required this.status,
      @JsonKey(name: 'received_total') required this.receivedTotal,
      required this.currency,
      @JsonKey(name: 'payment_type') required this.paymentType,
      @JsonKey(name: 'reported_at') required this.reportedAt,
      final Map<String, dynamic>? paytr})
      : _paytr = paytr;

  factory _$PayTRPaymentInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayTRPaymentInfoImplFromJson(json);

  @override
  final String provider;
  @override
  final String status;
  @override
  @JsonKey(name: 'received_total')
  final double receivedTotal;
  @override
  final String currency;
  @override
  @JsonKey(name: 'payment_type')
  final String paymentType;
  @override
  @JsonKey(name: 'reported_at')
  final DateTime reportedAt;
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
    return 'PayTRPaymentInfo(provider: $provider, status: $status, receivedTotal: $receivedTotal, currency: $currency, paymentType: $paymentType, reportedAt: $reportedAt, paytr: $paytr)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayTRPaymentInfoImpl &&
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

  /// Create a copy of PayTRPaymentInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayTRPaymentInfoImplCopyWith<_$PayTRPaymentInfoImpl> get copyWith =>
      __$$PayTRPaymentInfoImplCopyWithImpl<_$PayTRPaymentInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayTRPaymentInfoImplToJson(
      this,
    );
  }
}

abstract class _PayTRPaymentInfo implements PayTRPaymentInfo {
  const factory _PayTRPaymentInfo(
      {required final String provider,
      required final String status,
      @JsonKey(name: 'received_total') required final double receivedTotal,
      required final String currency,
      @JsonKey(name: 'payment_type') required final String paymentType,
      @JsonKey(name: 'reported_at') required final DateTime reportedAt,
      final Map<String, dynamic>? paytr}) = _$PayTRPaymentInfoImpl;

  factory _PayTRPaymentInfo.fromJson(Map<String, dynamic> json) =
      _$PayTRPaymentInfoImpl.fromJson;

  @override
  String get provider;
  @override
  String get status;
  @override
  @JsonKey(name: 'received_total')
  double get receivedTotal;
  @override
  String get currency;
  @override
  @JsonKey(name: 'payment_type')
  String get paymentType;
  @override
  @JsonKey(name: 'reported_at')
  DateTime get reportedAt;
  @override
  Map<String, dynamic>? get paytr;

  /// Create a copy of PayTRPaymentInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayTRPaymentInfoImplCopyWith<_$PayTRPaymentInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
