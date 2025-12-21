// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) {
  return _AppSettings.fromJson(json);
}

/// @nodoc
mixin _$AppSettings {
  @JsonKey(name: 'app_name')
  String get appName => throw _privateConstructorUsedError;
  @JsonKey(name: 'app_version')
  String get appVersion => throw _privateConstructorUsedError;
  @JsonKey(name: 'maintenance_mode')
  bool get maintenanceMode => throw _privateConstructorUsedError;
  @JsonKey(name: 'maintenance_message')
  String? get maintenanceMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_email')
  String? get contactEmail => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_phone')
  String? get contactPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'address')
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'working_hours')
  String get workingHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'social_media')
  SocialMediaSettings get socialMedia => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AppSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
          AppSettings value, $Res Function(AppSettings) then) =
      _$AppSettingsCopyWithImpl<$Res, AppSettings>;
  @useResult
  $Res call(
      {@JsonKey(name: 'app_name') String appName,
      @JsonKey(name: 'app_version') String appVersion,
      @JsonKey(name: 'maintenance_mode') bool maintenanceMode,
      @JsonKey(name: 'maintenance_message') String? maintenanceMessage,
      @JsonKey(name: 'contact_email') String? contactEmail,
      @JsonKey(name: 'contact_phone') String? contactPhone,
      @JsonKey(name: 'address') String address,
      @JsonKey(name: 'working_hours') String workingHours,
      @JsonKey(name: 'social_media') SocialMediaSettings socialMedia,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  $SocialMediaSettingsCopyWith<$Res> get socialMedia;
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res, $Val extends AppSettings>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appName = null,
    Object? appVersion = null,
    Object? maintenanceMode = null,
    Object? maintenanceMessage = freezed,
    Object? contactEmail = freezed,
    Object? contactPhone = freezed,
    Object? address = null,
    Object? workingHours = null,
    Object? socialMedia = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      maintenanceMode: null == maintenanceMode
          ? _value.maintenanceMode
          : maintenanceMode // ignore: cast_nullable_to_non_nullable
              as bool,
      maintenanceMessage: freezed == maintenanceMessage
          ? _value.maintenanceMessage
          : maintenanceMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      contactEmail: freezed == contactEmail
          ? _value.contactEmail
          : contactEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPhone: freezed == contactPhone
          ? _value.contactPhone
          : contactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      workingHours: null == workingHours
          ? _value.workingHours
          : workingHours // ignore: cast_nullable_to_non_nullable
              as String,
      socialMedia: null == socialMedia
          ? _value.socialMedia
          : socialMedia // ignore: cast_nullable_to_non_nullable
              as SocialMediaSettings,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SocialMediaSettingsCopyWith<$Res> get socialMedia {
    return $SocialMediaSettingsCopyWith<$Res>(_value.socialMedia, (value) {
      return _then(_value.copyWith(socialMedia: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppSettingsImplCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$$AppSettingsImplCopyWith(
          _$AppSettingsImpl value, $Res Function(_$AppSettingsImpl) then) =
      __$$AppSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'app_name') String appName,
      @JsonKey(name: 'app_version') String appVersion,
      @JsonKey(name: 'maintenance_mode') bool maintenanceMode,
      @JsonKey(name: 'maintenance_message') String? maintenanceMessage,
      @JsonKey(name: 'contact_email') String? contactEmail,
      @JsonKey(name: 'contact_phone') String? contactPhone,
      @JsonKey(name: 'address') String address,
      @JsonKey(name: 'working_hours') String workingHours,
      @JsonKey(name: 'social_media') SocialMediaSettings socialMedia,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  @override
  $SocialMediaSettingsCopyWith<$Res> get socialMedia;
}

/// @nodoc
class __$$AppSettingsImplCopyWithImpl<$Res>
    extends _$AppSettingsCopyWithImpl<$Res, _$AppSettingsImpl>
    implements _$$AppSettingsImplCopyWith<$Res> {
  __$$AppSettingsImplCopyWithImpl(
      _$AppSettingsImpl _value, $Res Function(_$AppSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appName = null,
    Object? appVersion = null,
    Object? maintenanceMode = null,
    Object? maintenanceMessage = freezed,
    Object? contactEmail = freezed,
    Object? contactPhone = freezed,
    Object? address = null,
    Object? workingHours = null,
    Object? socialMedia = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$AppSettingsImpl(
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      maintenanceMode: null == maintenanceMode
          ? _value.maintenanceMode
          : maintenanceMode // ignore: cast_nullable_to_non_nullable
              as bool,
      maintenanceMessage: freezed == maintenanceMessage
          ? _value.maintenanceMessage
          : maintenanceMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      contactEmail: freezed == contactEmail
          ? _value.contactEmail
          : contactEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPhone: freezed == contactPhone
          ? _value.contactPhone
          : contactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      workingHours: null == workingHours
          ? _value.workingHours
          : workingHours // ignore: cast_nullable_to_non_nullable
              as String,
      socialMedia: null == socialMedia
          ? _value.socialMedia
          : socialMedia // ignore: cast_nullable_to_non_nullable
              as SocialMediaSettings,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppSettingsImpl implements _AppSettings {
  const _$AppSettingsImpl(
      {@JsonKey(name: 'app_name') this.appName = 'ICS App',
      @JsonKey(name: 'app_version') this.appVersion = '1.0.0',
      @JsonKey(name: 'maintenance_mode') this.maintenanceMode = false,
      @JsonKey(name: 'maintenance_message') this.maintenanceMessage,
      @JsonKey(name: 'contact_email') this.contactEmail,
      @JsonKey(name: 'contact_phone') this.contactPhone,
      @JsonKey(name: 'address') this.address = 'Istanbul, Turkey',
      @JsonKey(name: 'working_hours') this.workingHours = '09:00 - 18:00',
      @JsonKey(name: 'social_media')
      this.socialMedia = const SocialMediaSettings(),
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$AppSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppSettingsImplFromJson(json);

  @override
  @JsonKey(name: 'app_name')
  final String appName;
  @override
  @JsonKey(name: 'app_version')
  final String appVersion;
  @override
  @JsonKey(name: 'maintenance_mode')
  final bool maintenanceMode;
  @override
  @JsonKey(name: 'maintenance_message')
  final String? maintenanceMessage;
  @override
  @JsonKey(name: 'contact_email')
  final String? contactEmail;
  @override
  @JsonKey(name: 'contact_phone')
  final String? contactPhone;
  @override
  @JsonKey(name: 'address')
  final String address;
  @override
  @JsonKey(name: 'working_hours')
  final String workingHours;
  @override
  @JsonKey(name: 'social_media')
  final SocialMediaSettings socialMedia;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'AppSettings(appName: $appName, appVersion: $appVersion, maintenanceMode: $maintenanceMode, maintenanceMessage: $maintenanceMessage, contactEmail: $contactEmail, contactPhone: $contactPhone, address: $address, workingHours: $workingHours, socialMedia: $socialMedia, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingsImpl &&
            (identical(other.appName, appName) || other.appName == appName) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.maintenanceMode, maintenanceMode) ||
                other.maintenanceMode == maintenanceMode) &&
            (identical(other.maintenanceMessage, maintenanceMessage) ||
                other.maintenanceMessage == maintenanceMessage) &&
            (identical(other.contactEmail, contactEmail) ||
                other.contactEmail == contactEmail) &&
            (identical(other.contactPhone, contactPhone) ||
                other.contactPhone == contactPhone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.workingHours, workingHours) ||
                other.workingHours == workingHours) &&
            (identical(other.socialMedia, socialMedia) ||
                other.socialMedia == socialMedia) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appName,
      appVersion,
      maintenanceMode,
      maintenanceMessage,
      contactEmail,
      contactPhone,
      address,
      workingHours,
      socialMedia,
      updatedAt);

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      __$$AppSettingsImplCopyWithImpl<_$AppSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppSettingsImplToJson(
      this,
    );
  }
}

abstract class _AppSettings implements AppSettings {
  const factory _AppSettings(
      {@JsonKey(name: 'app_name') final String appName,
      @JsonKey(name: 'app_version') final String appVersion,
      @JsonKey(name: 'maintenance_mode') final bool maintenanceMode,
      @JsonKey(name: 'maintenance_message') final String? maintenanceMessage,
      @JsonKey(name: 'contact_email') final String? contactEmail,
      @JsonKey(name: 'contact_phone') final String? contactPhone,
      @JsonKey(name: 'address') final String address,
      @JsonKey(name: 'working_hours') final String workingHours,
      @JsonKey(name: 'social_media') final SocialMediaSettings socialMedia,
      @JsonKey(name: 'updated_at')
      final DateTime? updatedAt}) = _$AppSettingsImpl;

  factory _AppSettings.fromJson(Map<String, dynamic> json) =
      _$AppSettingsImpl.fromJson;

  @override
  @JsonKey(name: 'app_name')
  String get appName;
  @override
  @JsonKey(name: 'app_version')
  String get appVersion;
  @override
  @JsonKey(name: 'maintenance_mode')
  bool get maintenanceMode;
  @override
  @JsonKey(name: 'maintenance_message')
  String? get maintenanceMessage;
  @override
  @JsonKey(name: 'contact_email')
  String? get contactEmail;
  @override
  @JsonKey(name: 'contact_phone')
  String? get contactPhone;
  @override
  @JsonKey(name: 'address')
  String get address;
  @override
  @JsonKey(name: 'working_hours')
  String get workingHours;
  @override
  @JsonKey(name: 'social_media')
  SocialMediaSettings get socialMedia;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SocialMediaSettings _$SocialMediaSettingsFromJson(Map<String, dynamic> json) {
  return _SocialMediaSettings.fromJson(json);
}

/// @nodoc
mixin _$SocialMediaSettings {
  String? get facebook => throw _privateConstructorUsedError;
  String? get instagram => throw _privateConstructorUsedError;
  String? get twitter => throw _privateConstructorUsedError;
  String? get linkedin => throw _privateConstructorUsedError;
  String? get youtube => throw _privateConstructorUsedError;

  /// Serializes this SocialMediaSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SocialMediaSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SocialMediaSettingsCopyWith<SocialMediaSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialMediaSettingsCopyWith<$Res> {
  factory $SocialMediaSettingsCopyWith(
          SocialMediaSettings value, $Res Function(SocialMediaSettings) then) =
      _$SocialMediaSettingsCopyWithImpl<$Res, SocialMediaSettings>;
  @useResult
  $Res call(
      {String? facebook,
      String? instagram,
      String? twitter,
      String? linkedin,
      String? youtube});
}

/// @nodoc
class _$SocialMediaSettingsCopyWithImpl<$Res, $Val extends SocialMediaSettings>
    implements $SocialMediaSettingsCopyWith<$Res> {
  _$SocialMediaSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SocialMediaSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? facebook = freezed,
    Object? instagram = freezed,
    Object? twitter = freezed,
    Object? linkedin = freezed,
    Object? youtube = freezed,
  }) {
    return _then(_value.copyWith(
      facebook: freezed == facebook
          ? _value.facebook
          : facebook // ignore: cast_nullable_to_non_nullable
              as String?,
      instagram: freezed == instagram
          ? _value.instagram
          : instagram // ignore: cast_nullable_to_non_nullable
              as String?,
      twitter: freezed == twitter
          ? _value.twitter
          : twitter // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedin: freezed == linkedin
          ? _value.linkedin
          : linkedin // ignore: cast_nullable_to_non_nullable
              as String?,
      youtube: freezed == youtube
          ? _value.youtube
          : youtube // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SocialMediaSettingsImplCopyWith<$Res>
    implements $SocialMediaSettingsCopyWith<$Res> {
  factory _$$SocialMediaSettingsImplCopyWith(_$SocialMediaSettingsImpl value,
          $Res Function(_$SocialMediaSettingsImpl) then) =
      __$$SocialMediaSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? facebook,
      String? instagram,
      String? twitter,
      String? linkedin,
      String? youtube});
}

/// @nodoc
class __$$SocialMediaSettingsImplCopyWithImpl<$Res>
    extends _$SocialMediaSettingsCopyWithImpl<$Res, _$SocialMediaSettingsImpl>
    implements _$$SocialMediaSettingsImplCopyWith<$Res> {
  __$$SocialMediaSettingsImplCopyWithImpl(_$SocialMediaSettingsImpl _value,
      $Res Function(_$SocialMediaSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SocialMediaSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? facebook = freezed,
    Object? instagram = freezed,
    Object? twitter = freezed,
    Object? linkedin = freezed,
    Object? youtube = freezed,
  }) {
    return _then(_$SocialMediaSettingsImpl(
      facebook: freezed == facebook
          ? _value.facebook
          : facebook // ignore: cast_nullable_to_non_nullable
              as String?,
      instagram: freezed == instagram
          ? _value.instagram
          : instagram // ignore: cast_nullable_to_non_nullable
              as String?,
      twitter: freezed == twitter
          ? _value.twitter
          : twitter // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedin: freezed == linkedin
          ? _value.linkedin
          : linkedin // ignore: cast_nullable_to_non_nullable
              as String?,
      youtube: freezed == youtube
          ? _value.youtube
          : youtube // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SocialMediaSettingsImpl implements _SocialMediaSettings {
  const _$SocialMediaSettingsImpl(
      {this.facebook,
      this.instagram,
      this.twitter,
      this.linkedin,
      this.youtube});

  factory _$SocialMediaSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SocialMediaSettingsImplFromJson(json);

  @override
  final String? facebook;
  @override
  final String? instagram;
  @override
  final String? twitter;
  @override
  final String? linkedin;
  @override
  final String? youtube;

  @override
  String toString() {
    return 'SocialMediaSettings(facebook: $facebook, instagram: $instagram, twitter: $twitter, linkedin: $linkedin, youtube: $youtube)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialMediaSettingsImpl &&
            (identical(other.facebook, facebook) ||
                other.facebook == facebook) &&
            (identical(other.instagram, instagram) ||
                other.instagram == instagram) &&
            (identical(other.twitter, twitter) || other.twitter == twitter) &&
            (identical(other.linkedin, linkedin) ||
                other.linkedin == linkedin) &&
            (identical(other.youtube, youtube) || other.youtube == youtube));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, facebook, instagram, twitter, linkedin, youtube);

  /// Create a copy of SocialMediaSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialMediaSettingsImplCopyWith<_$SocialMediaSettingsImpl> get copyWith =>
      __$$SocialMediaSettingsImplCopyWithImpl<_$SocialMediaSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SocialMediaSettingsImplToJson(
      this,
    );
  }
}

abstract class _SocialMediaSettings implements SocialMediaSettings {
  const factory _SocialMediaSettings(
      {final String? facebook,
      final String? instagram,
      final String? twitter,
      final String? linkedin,
      final String? youtube}) = _$SocialMediaSettingsImpl;

  factory _SocialMediaSettings.fromJson(Map<String, dynamic> json) =
      _$SocialMediaSettingsImpl.fromJson;

  @override
  String? get facebook;
  @override
  String? get instagram;
  @override
  String? get twitter;
  @override
  String? get linkedin;
  @override
  String? get youtube;

  /// Create a copy of SocialMediaSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SocialMediaSettingsImplCopyWith<_$SocialMediaSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentSettings _$PaymentSettingsFromJson(Map<String, dynamic> json) {
  return _PaymentSettings.fromJson(json);
}

/// @nodoc
mixin _$PaymentSettings {
  @JsonKey(name: 'iyzico_api_key')
  String get iyzicoApiKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'iyzico_secret_key')
  String get iyzicoSecretKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'iyzico_base_url')
  String get iyzicoBaseUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'test_mode')
  bool get testMode => throw _privateConstructorUsedError;
  @JsonKey(name: 'currency')
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_order_amount')
  double get minOrderAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_order_amount')
  double? get maxOrderAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PaymentSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentSettingsCopyWith<PaymentSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentSettingsCopyWith<$Res> {
  factory $PaymentSettingsCopyWith(
          PaymentSettings value, $Res Function(PaymentSettings) then) =
      _$PaymentSettingsCopyWithImpl<$Res, PaymentSettings>;
  @useResult
  $Res call(
      {@JsonKey(name: 'iyzico_api_key') String iyzicoApiKey,
      @JsonKey(name: 'iyzico_secret_key') String iyzicoSecretKey,
      @JsonKey(name: 'iyzico_base_url') String iyzicoBaseUrl,
      @JsonKey(name: 'test_mode') bool testMode,
      @JsonKey(name: 'currency') String currency,
      @JsonKey(name: 'min_order_amount') double minOrderAmount,
      @JsonKey(name: 'max_order_amount') double? maxOrderAmount,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$PaymentSettingsCopyWithImpl<$Res, $Val extends PaymentSettings>
    implements $PaymentSettingsCopyWith<$Res> {
  _$PaymentSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iyzicoApiKey = null,
    Object? iyzicoSecretKey = null,
    Object? iyzicoBaseUrl = null,
    Object? testMode = null,
    Object? currency = null,
    Object? minOrderAmount = null,
    Object? maxOrderAmount = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      iyzicoApiKey: null == iyzicoApiKey
          ? _value.iyzicoApiKey
          : iyzicoApiKey // ignore: cast_nullable_to_non_nullable
              as String,
      iyzicoSecretKey: null == iyzicoSecretKey
          ? _value.iyzicoSecretKey
          : iyzicoSecretKey // ignore: cast_nullable_to_non_nullable
              as String,
      iyzicoBaseUrl: null == iyzicoBaseUrl
          ? _value.iyzicoBaseUrl
          : iyzicoBaseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      testMode: null == testMode
          ? _value.testMode
          : testMode // ignore: cast_nullable_to_non_nullable
              as bool,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      minOrderAmount: null == minOrderAmount
          ? _value.minOrderAmount
          : minOrderAmount // ignore: cast_nullable_to_non_nullable
              as double,
      maxOrderAmount: freezed == maxOrderAmount
          ? _value.maxOrderAmount
          : maxOrderAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentSettingsImplCopyWith<$Res>
    implements $PaymentSettingsCopyWith<$Res> {
  factory _$$PaymentSettingsImplCopyWith(_$PaymentSettingsImpl value,
          $Res Function(_$PaymentSettingsImpl) then) =
      __$$PaymentSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'iyzico_api_key') String iyzicoApiKey,
      @JsonKey(name: 'iyzico_secret_key') String iyzicoSecretKey,
      @JsonKey(name: 'iyzico_base_url') String iyzicoBaseUrl,
      @JsonKey(name: 'test_mode') bool testMode,
      @JsonKey(name: 'currency') String currency,
      @JsonKey(name: 'min_order_amount') double minOrderAmount,
      @JsonKey(name: 'max_order_amount') double? maxOrderAmount,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$PaymentSettingsImplCopyWithImpl<$Res>
    extends _$PaymentSettingsCopyWithImpl<$Res, _$PaymentSettingsImpl>
    implements _$$PaymentSettingsImplCopyWith<$Res> {
  __$$PaymentSettingsImplCopyWithImpl(
      _$PaymentSettingsImpl _value, $Res Function(_$PaymentSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iyzicoApiKey = null,
    Object? iyzicoSecretKey = null,
    Object? iyzicoBaseUrl = null,
    Object? testMode = null,
    Object? currency = null,
    Object? minOrderAmount = null,
    Object? maxOrderAmount = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$PaymentSettingsImpl(
      iyzicoApiKey: null == iyzicoApiKey
          ? _value.iyzicoApiKey
          : iyzicoApiKey // ignore: cast_nullable_to_non_nullable
              as String,
      iyzicoSecretKey: null == iyzicoSecretKey
          ? _value.iyzicoSecretKey
          : iyzicoSecretKey // ignore: cast_nullable_to_non_nullable
              as String,
      iyzicoBaseUrl: null == iyzicoBaseUrl
          ? _value.iyzicoBaseUrl
          : iyzicoBaseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      testMode: null == testMode
          ? _value.testMode
          : testMode // ignore: cast_nullable_to_non_nullable
              as bool,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      minOrderAmount: null == minOrderAmount
          ? _value.minOrderAmount
          : minOrderAmount // ignore: cast_nullable_to_non_nullable
              as double,
      maxOrderAmount: freezed == maxOrderAmount
          ? _value.maxOrderAmount
          : maxOrderAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentSettingsImpl implements _PaymentSettings {
  const _$PaymentSettingsImpl(
      {@JsonKey(name: 'iyzico_api_key') this.iyzicoApiKey = '',
      @JsonKey(name: 'iyzico_secret_key') this.iyzicoSecretKey = '',
      @JsonKey(name: 'iyzico_base_url')
      this.iyzicoBaseUrl = 'https://sandbox-api.iyzipay.com',
      @JsonKey(name: 'test_mode') this.testMode = true,
      @JsonKey(name: 'currency') this.currency = 'TRY',
      @JsonKey(name: 'min_order_amount') this.minOrderAmount = 0.0,
      @JsonKey(name: 'max_order_amount') this.maxOrderAmount,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$PaymentSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentSettingsImplFromJson(json);

  @override
  @JsonKey(name: 'iyzico_api_key')
  final String iyzicoApiKey;
  @override
  @JsonKey(name: 'iyzico_secret_key')
  final String iyzicoSecretKey;
  @override
  @JsonKey(name: 'iyzico_base_url')
  final String iyzicoBaseUrl;
  @override
  @JsonKey(name: 'test_mode')
  final bool testMode;
  @override
  @JsonKey(name: 'currency')
  final String currency;
  @override
  @JsonKey(name: 'min_order_amount')
  final double minOrderAmount;
  @override
  @JsonKey(name: 'max_order_amount')
  final double? maxOrderAmount;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PaymentSettings(iyzicoApiKey: $iyzicoApiKey, iyzicoSecretKey: $iyzicoSecretKey, iyzicoBaseUrl: $iyzicoBaseUrl, testMode: $testMode, currency: $currency, minOrderAmount: $minOrderAmount, maxOrderAmount: $maxOrderAmount, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentSettingsImpl &&
            (identical(other.iyzicoApiKey, iyzicoApiKey) ||
                other.iyzicoApiKey == iyzicoApiKey) &&
            (identical(other.iyzicoSecretKey, iyzicoSecretKey) ||
                other.iyzicoSecretKey == iyzicoSecretKey) &&
            (identical(other.iyzicoBaseUrl, iyzicoBaseUrl) ||
                other.iyzicoBaseUrl == iyzicoBaseUrl) &&
            (identical(other.testMode, testMode) ||
                other.testMode == testMode) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.minOrderAmount, minOrderAmount) ||
                other.minOrderAmount == minOrderAmount) &&
            (identical(other.maxOrderAmount, maxOrderAmount) ||
                other.maxOrderAmount == maxOrderAmount) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      iyzicoApiKey,
      iyzicoSecretKey,
      iyzicoBaseUrl,
      testMode,
      currency,
      minOrderAmount,
      maxOrderAmount,
      updatedAt);

  /// Create a copy of PaymentSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentSettingsImplCopyWith<_$PaymentSettingsImpl> get copyWith =>
      __$$PaymentSettingsImplCopyWithImpl<_$PaymentSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentSettingsImplToJson(
      this,
    );
  }
}

abstract class _PaymentSettings implements PaymentSettings {
  const factory _PaymentSettings(
          {@JsonKey(name: 'iyzico_api_key') final String iyzicoApiKey,
          @JsonKey(name: 'iyzico_secret_key') final String iyzicoSecretKey,
          @JsonKey(name: 'iyzico_base_url') final String iyzicoBaseUrl,
          @JsonKey(name: 'test_mode') final bool testMode,
          @JsonKey(name: 'currency') final String currency,
          @JsonKey(name: 'min_order_amount') final double minOrderAmount,
          @JsonKey(name: 'max_order_amount') final double? maxOrderAmount,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$PaymentSettingsImpl;

  factory _PaymentSettings.fromJson(Map<String, dynamic> json) =
      _$PaymentSettingsImpl.fromJson;

  @override
  @JsonKey(name: 'iyzico_api_key')
  String get iyzicoApiKey;
  @override
  @JsonKey(name: 'iyzico_secret_key')
  String get iyzicoSecretKey;
  @override
  @JsonKey(name: 'iyzico_base_url')
  String get iyzicoBaseUrl;
  @override
  @JsonKey(name: 'test_mode')
  bool get testMode;
  @override
  @JsonKey(name: 'currency')
  String get currency;
  @override
  @JsonKey(name: 'min_order_amount')
  double get minOrderAmount;
  @override
  @JsonKey(name: 'max_order_amount')
  double? get maxOrderAmount;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of PaymentSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentSettingsImplCopyWith<_$PaymentSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmailTemplate _$EmailTemplateFromJson(Map<String, dynamic> json) {
  return _EmailTemplate.fromJson(json);
}

/// @nodoc
mixin _$EmailTemplate {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  @JsonKey(name: 'template_type')
  String get templateType => throw _privateConstructorUsedError;
  @JsonKey(name: 'variables')
  List<String> get variables => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this EmailTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailTemplateCopyWith<EmailTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailTemplateCopyWith<$Res> {
  factory $EmailTemplateCopyWith(
          EmailTemplate value, $Res Function(EmailTemplate) then) =
      _$EmailTemplateCopyWithImpl<$Res, EmailTemplate>;
  @useResult
  $Res call(
      {String id,
      String name,
      String subject,
      String body,
      @JsonKey(name: 'template_type') String templateType,
      @JsonKey(name: 'variables') List<String> variables,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$EmailTemplateCopyWithImpl<$Res, $Val extends EmailTemplate>
    implements $EmailTemplateCopyWith<$Res> {
  _$EmailTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? subject = null,
    Object? body = null,
    Object? templateType = null,
    Object? variables = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      templateType: null == templateType
          ? _value.templateType
          : templateType // ignore: cast_nullable_to_non_nullable
              as String,
      variables: null == variables
          ? _value.variables
          : variables // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailTemplateImplCopyWith<$Res>
    implements $EmailTemplateCopyWith<$Res> {
  factory _$$EmailTemplateImplCopyWith(
          _$EmailTemplateImpl value, $Res Function(_$EmailTemplateImpl) then) =
      __$$EmailTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String subject,
      String body,
      @JsonKey(name: 'template_type') String templateType,
      @JsonKey(name: 'variables') List<String> variables,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$EmailTemplateImplCopyWithImpl<$Res>
    extends _$EmailTemplateCopyWithImpl<$Res, _$EmailTemplateImpl>
    implements _$$EmailTemplateImplCopyWith<$Res> {
  __$$EmailTemplateImplCopyWithImpl(
      _$EmailTemplateImpl _value, $Res Function(_$EmailTemplateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? subject = null,
    Object? body = null,
    Object? templateType = null,
    Object? variables = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$EmailTemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      templateType: null == templateType
          ? _value.templateType
          : templateType // ignore: cast_nullable_to_non_nullable
              as String,
      variables: null == variables
          ? _value._variables
          : variables // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailTemplateImpl implements _EmailTemplate {
  const _$EmailTemplateImpl(
      {required this.id,
      this.name = '',
      this.subject = '',
      this.body = '',
      @JsonKey(name: 'template_type') this.templateType = 'email',
      @JsonKey(name: 'variables') final List<String> variables = const [],
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _variables = variables;

  factory _$EmailTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailTemplateImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String subject;
  @override
  @JsonKey()
  final String body;
  @override
  @JsonKey(name: 'template_type')
  final String templateType;
  final List<String> _variables;
  @override
  @JsonKey(name: 'variables')
  List<String> get variables {
    if (_variables is EqualUnmodifiableListView) return _variables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variables);
  }

  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'EmailTemplate(id: $id, name: $name, subject: $subject, body: $body, templateType: $templateType, variables: $variables, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.templateType, templateType) ||
                other.templateType == templateType) &&
            const DeepCollectionEquality()
                .equals(other._variables, _variables) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      subject,
      body,
      templateType,
      const DeepCollectionEquality().hash(_variables),
      isActive,
      createdAt,
      updatedAt);

  /// Create a copy of EmailTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailTemplateImplCopyWith<_$EmailTemplateImpl> get copyWith =>
      __$$EmailTemplateImplCopyWithImpl<_$EmailTemplateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailTemplateImplToJson(
      this,
    );
  }
}

abstract class _EmailTemplate implements EmailTemplate {
  const factory _EmailTemplate(
          {required final String id,
          final String name,
          final String subject,
          final String body,
          @JsonKey(name: 'template_type') final String templateType,
          @JsonKey(name: 'variables') final List<String> variables,
          @JsonKey(name: 'is_active') final bool isActive,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$EmailTemplateImpl;

  factory _EmailTemplate.fromJson(Map<String, dynamic> json) =
      _$EmailTemplateImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get subject;
  @override
  String get body;
  @override
  @JsonKey(name: 'template_type')
  String get templateType;
  @override
  @JsonKey(name: 'variables')
  List<String> get variables;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of EmailTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailTemplateImplCopyWith<_$EmailTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SystemSettings _$SystemSettingsFromJson(Map<String, dynamic> json) {
  return _SystemSettings.fromJson(json);
}

/// @nodoc
mixin _$SystemSettings {
  AppSettings get appSettings => throw _privateConstructorUsedError;
  PaymentSettings get paymentSettings => throw _privateConstructorUsedError;
  @JsonKey(name: 'emailTemplates')
  List<EmailTemplate> get emailTemplates => throw _privateConstructorUsedError;

  /// Serializes this SystemSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SystemSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SystemSettingsCopyWith<SystemSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SystemSettingsCopyWith<$Res> {
  factory $SystemSettingsCopyWith(
          SystemSettings value, $Res Function(SystemSettings) then) =
      _$SystemSettingsCopyWithImpl<$Res, SystemSettings>;
  @useResult
  $Res call(
      {AppSettings appSettings,
      PaymentSettings paymentSettings,
      @JsonKey(name: 'emailTemplates') List<EmailTemplate> emailTemplates});

  $AppSettingsCopyWith<$Res> get appSettings;
  $PaymentSettingsCopyWith<$Res> get paymentSettings;
}

/// @nodoc
class _$SystemSettingsCopyWithImpl<$Res, $Val extends SystemSettings>
    implements $SystemSettingsCopyWith<$Res> {
  _$SystemSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SystemSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appSettings = null,
    Object? paymentSettings = null,
    Object? emailTemplates = null,
  }) {
    return _then(_value.copyWith(
      appSettings: null == appSettings
          ? _value.appSettings
          : appSettings // ignore: cast_nullable_to_non_nullable
              as AppSettings,
      paymentSettings: null == paymentSettings
          ? _value.paymentSettings
          : paymentSettings // ignore: cast_nullable_to_non_nullable
              as PaymentSettings,
      emailTemplates: null == emailTemplates
          ? _value.emailTemplates
          : emailTemplates // ignore: cast_nullable_to_non_nullable
              as List<EmailTemplate>,
    ) as $Val);
  }

  /// Create a copy of SystemSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppSettingsCopyWith<$Res> get appSettings {
    return $AppSettingsCopyWith<$Res>(_value.appSettings, (value) {
      return _then(_value.copyWith(appSettings: value) as $Val);
    });
  }

  /// Create a copy of SystemSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentSettingsCopyWith<$Res> get paymentSettings {
    return $PaymentSettingsCopyWith<$Res>(_value.paymentSettings, (value) {
      return _then(_value.copyWith(paymentSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SystemSettingsImplCopyWith<$Res>
    implements $SystemSettingsCopyWith<$Res> {
  factory _$$SystemSettingsImplCopyWith(_$SystemSettingsImpl value,
          $Res Function(_$SystemSettingsImpl) then) =
      __$$SystemSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AppSettings appSettings,
      PaymentSettings paymentSettings,
      @JsonKey(name: 'emailTemplates') List<EmailTemplate> emailTemplates});

  @override
  $AppSettingsCopyWith<$Res> get appSettings;
  @override
  $PaymentSettingsCopyWith<$Res> get paymentSettings;
}

/// @nodoc
class __$$SystemSettingsImplCopyWithImpl<$Res>
    extends _$SystemSettingsCopyWithImpl<$Res, _$SystemSettingsImpl>
    implements _$$SystemSettingsImplCopyWith<$Res> {
  __$$SystemSettingsImplCopyWithImpl(
      _$SystemSettingsImpl _value, $Res Function(_$SystemSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SystemSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appSettings = null,
    Object? paymentSettings = null,
    Object? emailTemplates = null,
  }) {
    return _then(_$SystemSettingsImpl(
      appSettings: null == appSettings
          ? _value.appSettings
          : appSettings // ignore: cast_nullable_to_non_nullable
              as AppSettings,
      paymentSettings: null == paymentSettings
          ? _value.paymentSettings
          : paymentSettings // ignore: cast_nullable_to_non_nullable
              as PaymentSettings,
      emailTemplates: null == emailTemplates
          ? _value._emailTemplates
          : emailTemplates // ignore: cast_nullable_to_non_nullable
              as List<EmailTemplate>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SystemSettingsImpl implements _SystemSettings {
  const _$SystemSettingsImpl(
      {required this.appSettings,
      required this.paymentSettings,
      @JsonKey(name: 'emailTemplates')
      final List<EmailTemplate> emailTemplates = const []})
      : _emailTemplates = emailTemplates;

  factory _$SystemSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SystemSettingsImplFromJson(json);

  @override
  final AppSettings appSettings;
  @override
  final PaymentSettings paymentSettings;
  final List<EmailTemplate> _emailTemplates;
  @override
  @JsonKey(name: 'emailTemplates')
  List<EmailTemplate> get emailTemplates {
    if (_emailTemplates is EqualUnmodifiableListView) return _emailTemplates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_emailTemplates);
  }

  @override
  String toString() {
    return 'SystemSettings(appSettings: $appSettings, paymentSettings: $paymentSettings, emailTemplates: $emailTemplates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SystemSettingsImpl &&
            (identical(other.appSettings, appSettings) ||
                other.appSettings == appSettings) &&
            (identical(other.paymentSettings, paymentSettings) ||
                other.paymentSettings == paymentSettings) &&
            const DeepCollectionEquality()
                .equals(other._emailTemplates, _emailTemplates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, appSettings, paymentSettings,
      const DeepCollectionEquality().hash(_emailTemplates));

  /// Create a copy of SystemSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SystemSettingsImplCopyWith<_$SystemSettingsImpl> get copyWith =>
      __$$SystemSettingsImplCopyWithImpl<_$SystemSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SystemSettingsImplToJson(
      this,
    );
  }
}

abstract class _SystemSettings implements SystemSettings {
  const factory _SystemSettings(
      {required final AppSettings appSettings,
      required final PaymentSettings paymentSettings,
      @JsonKey(name: 'emailTemplates')
      final List<EmailTemplate> emailTemplates}) = _$SystemSettingsImpl;

  factory _SystemSettings.fromJson(Map<String, dynamic> json) =
      _$SystemSettingsImpl.fromJson;

  @override
  AppSettings get appSettings;
  @override
  PaymentSettings get paymentSettings;
  @override
  @JsonKey(name: 'emailTemplates')
  List<EmailTemplate> get emailTemplates;

  /// Create a copy of SystemSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SystemSettingsImplCopyWith<_$SystemSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
