import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_settings_model.freezed.dart';
part 'admin_settings_model.g.dart';

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    @JsonKey(name: 'app_name') @Default('ICS App') String appName,
    @JsonKey(name: 'app_version') @Default('1.0.0') String appVersion,
    @JsonKey(name: 'maintenance_mode') @Default(false) bool maintenanceMode,
    @JsonKey(name: 'maintenance_message') String? maintenanceMessage,
    @JsonKey(name: 'contact_email') String? contactEmail,
    @JsonKey(name: 'contact_phone') String? contactPhone,
    @JsonKey(name: 'address') @Default('Istanbul, Turkey') String address,
    @JsonKey(name: 'working_hours') @Default('09:00 - 18:00') String workingHours,
    @JsonKey(name: 'social_media') @Default(SocialMediaSettings()) SocialMediaSettings socialMedia,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}

@freezed
class SocialMediaSettings with _$SocialMediaSettings {
  const factory SocialMediaSettings({
    String? facebook,
    String? instagram,
    String? twitter,
    String? linkedin,
    String? youtube,
  }) = _SocialMediaSettings;

  factory SocialMediaSettings.fromJson(Map<String, dynamic> json) =>
      _$SocialMediaSettingsFromJson(json);
}

@freezed
class PaymentSettings with _$PaymentSettings {
  const factory PaymentSettings({
    @JsonKey(name: 'iyzico_api_key') @Default('') String iyzicoApiKey,
    @JsonKey(name: 'iyzico_secret_key') @Default('') String iyzicoSecretKey,
    @JsonKey(name: 'iyzico_base_url') @Default('https://sandbox-api.iyzipay.com') String iyzicoBaseUrl,
    @JsonKey(name: 'test_mode') @Default(true) bool testMode,
    @JsonKey(name: 'currency') @Default('TRY') String currency,
    @JsonKey(name: 'min_order_amount') @Default(0.0) double minOrderAmount,
    @JsonKey(name: 'max_order_amount') double? maxOrderAmount,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _PaymentSettings;

  factory PaymentSettings.fromJson(Map<String, dynamic> json) =>
      _$PaymentSettingsFromJson(json);
}

@freezed
class EmailTemplate with _$EmailTemplate {
  const factory EmailTemplate({
    required String id,
    @Default('') String name,
    @Default('') String subject,
    @Default('') String body,
    @JsonKey(name: 'template_type') @Default('email') String templateType,
    @JsonKey(name: 'variables') @Default([]) List<String> variables,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _EmailTemplate;

  factory EmailTemplate.fromJson(Map<String, dynamic> json) =>
      _$EmailTemplateFromJson(json);
}

@freezed
class SystemSettings with _$SystemSettings {
  const factory SystemSettings({
    required AppSettings appSettings,
    required PaymentSettings paymentSettings,
    @JsonKey(name: 'emailTemplates')
    @Default([])
    List<EmailTemplate> emailTemplates,
  }) = _SystemSettings;

  factory SystemSettings.fromJson(Map<String, dynamic> json) =>
      _$SystemSettingsFromJson(json);
}
