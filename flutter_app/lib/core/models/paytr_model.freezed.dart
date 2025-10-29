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
