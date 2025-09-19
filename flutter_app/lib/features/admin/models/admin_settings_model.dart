import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_settings_model.freezed.dart';
part 'admin_settings_model.g.dart';

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    @JsonKey(name: 'app_name') required String appName,
    @JsonKey(name: 'app_version') required String appVersion,
    @JsonKey(name: 'maintenance_mode') @Default(false) bool maintenanceMode,
    @JsonKey(name: 'maintenance_message') String? maintenanceMessage,
    @JsonKey(name: 'contact_email') required String contactEmail,
    @JsonKey(name: 'contact_phone') required String contactPhone,
    @JsonKey(name: 'address') required String address,
    @JsonKey(name: 'working_hours') required String workingHours,
    @JsonKey(name: 'social_media') required SocialMediaSettings socialMedia,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
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
    @JsonKey(name: 'iyzico_api_key') required String iyzicoApiKey,
    @JsonKey(name: 'iyzico_secret_key') required String iyzicoSecretKey,
    @JsonKey(name: 'iyzico_base_url') required String iyzicoBaseUrl,
    @JsonKey(name: 'test_mode') @Default(true) bool testMode,
    @JsonKey(name: 'currency') @Default('TRY') String currency,
    @JsonKey(name: 'min_order_amount') @Default(0.0) double minOrderAmount,
    @JsonKey(name: 'max_order_amount') double? maxOrderAmount,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _PaymentSettings;

  factory PaymentSettings.fromJson(Map<String, dynamic> json) =>
      _$PaymentSettingsFromJson(json);
}

@freezed
class EmailTemplate with _$EmailTemplate {
  const factory EmailTemplate({
    required String id,
    required String name,
    required String subject,
    required String body,
    @JsonKey(name: 'template_type') required String templateType,
    @JsonKey(name: 'variables') required List<String> variables,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _EmailTemplate;

  factory EmailTemplate.fromJson(Map<String, dynamic> json) =>
      _$EmailTemplateFromJson(json);
}

@freezed
class SystemSettings with _$SystemSettings {
  const factory SystemSettings({
    required AppSettings appSettings,
    required PaymentSettings paymentSettings,
    @JsonKey(name: 'email_templates')
    required List<EmailTemplate> emailTemplates,
  }) = _SystemSettings;

  factory SystemSettings.fromJson(Map<String, dynamic> json) =>
      _$SystemSettingsFromJson(json);
}
