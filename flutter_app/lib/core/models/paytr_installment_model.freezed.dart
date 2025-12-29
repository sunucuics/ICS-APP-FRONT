// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paytr_installment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PayTRInstallmentOption _$PayTRInstallmentOptionFromJson(
    Map<String, dynamic> json) {
  return _PayTRInstallmentOption.fromJson(json);
}

/// @nodoc
mixin _$PayTRInstallmentOption {
  int get month => throw _privateConstructorUsedError; // Taksit sayısı (2-12)
  double get rate => throw _privateConstructorUsedError; // Komisyon oranı (%)
  double get monthlyAmount =>
      throw _privateConstructorUsedError; // Aylık ödeme tutarı
  double get totalAmount => throw _privateConstructorUsedError;

  /// Serializes this PayTRInstallmentOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayTRInstallmentOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayTRInstallmentOptionCopyWith<PayTRInstallmentOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayTRInstallmentOptionCopyWith<$Res> {
  factory $PayTRInstallmentOptionCopyWith(PayTRInstallmentOption value,
          $Res Function(PayTRInstallmentOption) then) =
      _$PayTRInstallmentOptionCopyWithImpl<$Res, PayTRInstallmentOption>;
  @useResult
  $Res call({int month, double rate, double monthlyAmount, double totalAmount});
}

/// @nodoc
class _$PayTRInstallmentOptionCopyWithImpl<$Res,
        $Val extends PayTRInstallmentOption>
    implements $PayTRInstallmentOptionCopyWith<$Res> {
  _$PayTRInstallmentOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayTRInstallmentOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? rate = null,
    Object? monthlyAmount = null,
    Object? totalAmount = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyAmount: null == monthlyAmount
          ? _value.monthlyAmount
          : monthlyAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayTRInstallmentOptionImplCopyWith<$Res>
    implements $PayTRInstallmentOptionCopyWith<$Res> {
  factory _$$PayTRInstallmentOptionImplCopyWith(
          _$PayTRInstallmentOptionImpl value,
          $Res Function(_$PayTRInstallmentOptionImpl) then) =
      __$$PayTRInstallmentOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int month, double rate, double monthlyAmount, double totalAmount});
}

/// @nodoc
class __$$PayTRInstallmentOptionImplCopyWithImpl<$Res>
    extends _$PayTRInstallmentOptionCopyWithImpl<$Res,
        _$PayTRInstallmentOptionImpl>
    implements _$$PayTRInstallmentOptionImplCopyWith<$Res> {
  __$$PayTRInstallmentOptionImplCopyWithImpl(
      _$PayTRInstallmentOptionImpl _value,
      $Res Function(_$PayTRInstallmentOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayTRInstallmentOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? rate = null,
    Object? monthlyAmount = null,
    Object? totalAmount = null,
  }) {
    return _then(_$PayTRInstallmentOptionImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyAmount: null == monthlyAmount
          ? _value.monthlyAmount
          : monthlyAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayTRInstallmentOptionImpl implements _PayTRInstallmentOption {
  const _$PayTRInstallmentOptionImpl(
      {required this.month,
      required this.rate,
      required this.monthlyAmount,
      required this.totalAmount});

  factory _$PayTRInstallmentOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayTRInstallmentOptionImplFromJson(json);

  @override
  final int month;
// Taksit sayısı (2-12)
  @override
  final double rate;
// Komisyon oranı (%)
  @override
  final double monthlyAmount;
// Aylık ödeme tutarı
  @override
  final double totalAmount;

  @override
  String toString() {
    return 'PayTRInstallmentOption(month: $month, rate: $rate, monthlyAmount: $monthlyAmount, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayTRInstallmentOptionImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.monthlyAmount, monthlyAmount) ||
                other.monthlyAmount == monthlyAmount) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, month, rate, monthlyAmount, totalAmount);

  /// Create a copy of PayTRInstallmentOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayTRInstallmentOptionImplCopyWith<_$PayTRInstallmentOptionImpl>
      get copyWith => __$$PayTRInstallmentOptionImplCopyWithImpl<
          _$PayTRInstallmentOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayTRInstallmentOptionImplToJson(
      this,
    );
  }
}

abstract class _PayTRInstallmentOption implements PayTRInstallmentOption {
  const factory _PayTRInstallmentOption(
      {required final int month,
      required final double rate,
      required final double monthlyAmount,
      required final double totalAmount}) = _$PayTRInstallmentOptionImpl;

  factory _PayTRInstallmentOption.fromJson(Map<String, dynamic> json) =
      _$PayTRInstallmentOptionImpl.fromJson;

  @override
  int get month; // Taksit sayısı (2-12)
  @override
  double get rate; // Komisyon oranı (%)
  @override
  double get monthlyAmount; // Aylık ödeme tutarı
  @override
  double get totalAmount;

  /// Create a copy of PayTRInstallmentOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayTRInstallmentOptionImplCopyWith<_$PayTRInstallmentOptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PayTRBankInstallments _$PayTRBankInstallmentsFromJson(
    Map<String, dynamic> json) {
  return _PayTRBankInstallments.fromJson(json);
}

/// @nodoc
mixin _$PayTRBankInstallments {
  String get bankCode =>
      throw _privateConstructorUsedError; // Banka kodu (bonus, maximum, world, etc.)
  List<PayTRInstallmentOption> get options =>
      throw _privateConstructorUsedError;

  /// Serializes this PayTRBankInstallments to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayTRBankInstallments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayTRBankInstallmentsCopyWith<PayTRBankInstallments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayTRBankInstallmentsCopyWith<$Res> {
  factory $PayTRBankInstallmentsCopyWith(PayTRBankInstallments value,
          $Res Function(PayTRBankInstallments) then) =
      _$PayTRBankInstallmentsCopyWithImpl<$Res, PayTRBankInstallments>;
  @useResult
  $Res call({String bankCode, List<PayTRInstallmentOption> options});
}

/// @nodoc
class _$PayTRBankInstallmentsCopyWithImpl<$Res,
        $Val extends PayTRBankInstallments>
    implements $PayTRBankInstallmentsCopyWith<$Res> {
  _$PayTRBankInstallmentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayTRBankInstallments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankCode = null,
    Object? options = null,
  }) {
    return _then(_value.copyWith(
      bankCode: null == bankCode
          ? _value.bankCode
          : bankCode // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<PayTRInstallmentOption>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayTRBankInstallmentsImplCopyWith<$Res>
    implements $PayTRBankInstallmentsCopyWith<$Res> {
  factory _$$PayTRBankInstallmentsImplCopyWith(
          _$PayTRBankInstallmentsImpl value,
          $Res Function(_$PayTRBankInstallmentsImpl) then) =
      __$$PayTRBankInstallmentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String bankCode, List<PayTRInstallmentOption> options});
}

/// @nodoc
class __$$PayTRBankInstallmentsImplCopyWithImpl<$Res>
    extends _$PayTRBankInstallmentsCopyWithImpl<$Res,
        _$PayTRBankInstallmentsImpl>
    implements _$$PayTRBankInstallmentsImplCopyWith<$Res> {
  __$$PayTRBankInstallmentsImplCopyWithImpl(_$PayTRBankInstallmentsImpl _value,
      $Res Function(_$PayTRBankInstallmentsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayTRBankInstallments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankCode = null,
    Object? options = null,
  }) {
    return _then(_$PayTRBankInstallmentsImpl(
      bankCode: null == bankCode
          ? _value.bankCode
          : bankCode // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<PayTRInstallmentOption>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayTRBankInstallmentsImpl implements _PayTRBankInstallments {
  const _$PayTRBankInstallmentsImpl(
      {required this.bankCode,
      required final List<PayTRInstallmentOption> options})
      : _options = options;

  factory _$PayTRBankInstallmentsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayTRBankInstallmentsImplFromJson(json);

  @override
  final String bankCode;
// Banka kodu (bonus, maximum, world, etc.)
  final List<PayTRInstallmentOption> _options;
// Banka kodu (bonus, maximum, world, etc.)
  @override
  List<PayTRInstallmentOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'PayTRBankInstallments(bankCode: $bankCode, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayTRBankInstallmentsImpl &&
            (identical(other.bankCode, bankCode) ||
                other.bankCode == bankCode) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, bankCode, const DeepCollectionEquality().hash(_options));

  /// Create a copy of PayTRBankInstallments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayTRBankInstallmentsImplCopyWith<_$PayTRBankInstallmentsImpl>
      get copyWith => __$$PayTRBankInstallmentsImplCopyWithImpl<
          _$PayTRBankInstallmentsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayTRBankInstallmentsImplToJson(
      this,
    );
  }
}

abstract class _PayTRBankInstallments implements PayTRBankInstallments {
  const factory _PayTRBankInstallments(
          {required final String bankCode,
          required final List<PayTRInstallmentOption> options}) =
      _$PayTRBankInstallmentsImpl;

  factory _PayTRBankInstallments.fromJson(Map<String, dynamic> json) =
      _$PayTRBankInstallmentsImpl.fromJson;

  @override
  String get bankCode; // Banka kodu (bonus, maximum, world, etc.)
  @override
  List<PayTRInstallmentOption> get options;

  /// Create a copy of PayTRBankInstallments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayTRBankInstallmentsImplCopyWith<_$PayTRBankInstallmentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PayTRInstallmentsResponse _$PayTRInstallmentsResponseFromJson(
    Map<String, dynamic> json) {
  return _PayTRInstallmentsResponse.fromJson(json);
}

/// @nodoc
mixin _$PayTRInstallmentsResponse {
  bool get success => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  Map<String, PayTRBankInstallments> get banks =>
      throw _privateConstructorUsedError; // bankCode -> installments
  List<PayTRInstallmentOption> get allOptions =>
      throw _privateConstructorUsedError;

  /// Serializes this PayTRInstallmentsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayTRInstallmentsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayTRInstallmentsResponseCopyWith<PayTRInstallmentsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayTRInstallmentsResponseCopyWith<$Res> {
  factory $PayTRInstallmentsResponseCopyWith(PayTRInstallmentsResponse value,
          $Res Function(PayTRInstallmentsResponse) then) =
      _$PayTRInstallmentsResponseCopyWithImpl<$Res, PayTRInstallmentsResponse>;
  @useResult
  $Res call(
      {bool success,
      String? errorMessage,
      Map<String, PayTRBankInstallments> banks,
      List<PayTRInstallmentOption> allOptions});
}

/// @nodoc
class _$PayTRInstallmentsResponseCopyWithImpl<$Res,
        $Val extends PayTRInstallmentsResponse>
    implements $PayTRInstallmentsResponseCopyWith<$Res> {
  _$PayTRInstallmentsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayTRInstallmentsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? errorMessage = freezed,
    Object? banks = null,
    Object? allOptions = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      banks: null == banks
          ? _value.banks
          : banks // ignore: cast_nullable_to_non_nullable
              as Map<String, PayTRBankInstallments>,
      allOptions: null == allOptions
          ? _value.allOptions
          : allOptions // ignore: cast_nullable_to_non_nullable
              as List<PayTRInstallmentOption>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayTRInstallmentsResponseImplCopyWith<$Res>
    implements $PayTRInstallmentsResponseCopyWith<$Res> {
  factory _$$PayTRInstallmentsResponseImplCopyWith(
          _$PayTRInstallmentsResponseImpl value,
          $Res Function(_$PayTRInstallmentsResponseImpl) then) =
      __$$PayTRInstallmentsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String? errorMessage,
      Map<String, PayTRBankInstallments> banks,
      List<PayTRInstallmentOption> allOptions});
}

/// @nodoc
class __$$PayTRInstallmentsResponseImplCopyWithImpl<$Res>
    extends _$PayTRInstallmentsResponseCopyWithImpl<$Res,
        _$PayTRInstallmentsResponseImpl>
    implements _$$PayTRInstallmentsResponseImplCopyWith<$Res> {
  __$$PayTRInstallmentsResponseImplCopyWithImpl(
      _$PayTRInstallmentsResponseImpl _value,
      $Res Function(_$PayTRInstallmentsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayTRInstallmentsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? errorMessage = freezed,
    Object? banks = null,
    Object? allOptions = null,
  }) {
    return _then(_$PayTRInstallmentsResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      banks: null == banks
          ? _value._banks
          : banks // ignore: cast_nullable_to_non_nullable
              as Map<String, PayTRBankInstallments>,
      allOptions: null == allOptions
          ? _value._allOptions
          : allOptions // ignore: cast_nullable_to_non_nullable
              as List<PayTRInstallmentOption>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayTRInstallmentsResponseImpl implements _PayTRInstallmentsResponse {
  const _$PayTRInstallmentsResponseImpl(
      {this.success = false,
      this.errorMessage,
      final Map<String, PayTRBankInstallments> banks = const {},
      final List<PayTRInstallmentOption> allOptions = const []})
      : _banks = banks,
        _allOptions = allOptions;

  factory _$PayTRInstallmentsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayTRInstallmentsResponseImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  final String? errorMessage;
  final Map<String, PayTRBankInstallments> _banks;
  @override
  @JsonKey()
  Map<String, PayTRBankInstallments> get banks {
    if (_banks is EqualUnmodifiableMapView) return _banks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_banks);
  }

// bankCode -> installments
  final List<PayTRInstallmentOption> _allOptions;
// bankCode -> installments
  @override
  @JsonKey()
  List<PayTRInstallmentOption> get allOptions {
    if (_allOptions is EqualUnmodifiableListView) return _allOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allOptions);
  }

  @override
  String toString() {
    return 'PayTRInstallmentsResponse(success: $success, errorMessage: $errorMessage, banks: $banks, allOptions: $allOptions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayTRInstallmentsResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other._banks, _banks) &&
            const DeepCollectionEquality()
                .equals(other._allOptions, _allOptions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      errorMessage,
      const DeepCollectionEquality().hash(_banks),
      const DeepCollectionEquality().hash(_allOptions));

  /// Create a copy of PayTRInstallmentsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayTRInstallmentsResponseImplCopyWith<_$PayTRInstallmentsResponseImpl>
      get copyWith => __$$PayTRInstallmentsResponseImplCopyWithImpl<
          _$PayTRInstallmentsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayTRInstallmentsResponseImplToJson(
      this,
    );
  }
}

abstract class _PayTRInstallmentsResponse implements PayTRInstallmentsResponse {
  const factory _PayTRInstallmentsResponse(
          {final bool success,
          final String? errorMessage,
          final Map<String, PayTRBankInstallments> banks,
          final List<PayTRInstallmentOption> allOptions}) =
      _$PayTRInstallmentsResponseImpl;

  factory _PayTRInstallmentsResponse.fromJson(Map<String, dynamic> json) =
      _$PayTRInstallmentsResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String? get errorMessage;
  @override
  Map<String, PayTRBankInstallments> get banks; // bankCode -> installments
  @override
  List<PayTRInstallmentOption> get allOptions;

  /// Create a copy of PayTRInstallmentsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayTRInstallmentsResponseImplCopyWith<_$PayTRInstallmentsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
