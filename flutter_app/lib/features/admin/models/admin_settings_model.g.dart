// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingsImpl(
      appName: json['app_name'] as String? ?? 'ICS App',
      appVersion: json['app_version'] as String? ?? '1.0.0',
      maintenanceMode: json['maintenance_mode'] as bool? ?? false,
      maintenanceMessage: json['maintenance_message'] as String?,
      contactEmail: json['contact_email'] as String?,
      contactPhone: json['contact_phone'] as String?,
      address: json['address'] as String? ?? 'Istanbul, Turkey',
      workingHours: json['working_hours'] as String? ?? '09:00 - 18:00',
      socialMedia: json['social_media'] == null
          ? const SocialMediaSettings()
          : SocialMediaSettings.fromJson(
              json['social_media'] as Map<String, dynamic>),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'app_name': instance.appName,
      'app_version': instance.appVersion,
      'maintenance_mode': instance.maintenanceMode,
      'maintenance_message': instance.maintenanceMessage,
      'contact_email': instance.contactEmail,
      'contact_phone': instance.contactPhone,
      'address': instance.address,
      'working_hours': instance.workingHours,
      'social_media': instance.socialMedia,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$SocialMediaSettingsImpl _$$SocialMediaSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$SocialMediaSettingsImpl(
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      twitter: json['twitter'] as String?,
      linkedin: json['linkedin'] as String?,
      youtube: json['youtube'] as String?,
    );

Map<String, dynamic> _$$SocialMediaSettingsImplToJson(
        _$SocialMediaSettingsImpl instance) =>
    <String, dynamic>{
      'facebook': instance.facebook,
      'instagram': instance.instagram,
      'twitter': instance.twitter,
      'linkedin': instance.linkedin,
      'youtube': instance.youtube,
    };

_$PaymentSettingsImpl _$$PaymentSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentSettingsImpl(
      iyzicoApiKey: json['iyzico_api_key'] as String? ?? '',
      iyzicoSecretKey: json['iyzico_secret_key'] as String? ?? '',
      iyzicoBaseUrl: json['iyzico_base_url'] as String? ??
          'https://sandbox-api.iyzipay.com',
      testMode: json['test_mode'] as bool? ?? true,
      currency: json['currency'] as String? ?? 'TRY',
      minOrderAmount: (json['min_order_amount'] as num?)?.toDouble() ?? 0.0,
      maxOrderAmount: (json['max_order_amount'] as num?)?.toDouble(),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$PaymentSettingsImplToJson(
        _$PaymentSettingsImpl instance) =>
    <String, dynamic>{
      'iyzico_api_key': instance.iyzicoApiKey,
      'iyzico_secret_key': instance.iyzicoSecretKey,
      'iyzico_base_url': instance.iyzicoBaseUrl,
      'test_mode': instance.testMode,
      'currency': instance.currency,
      'min_order_amount': instance.minOrderAmount,
      'max_order_amount': instance.maxOrderAmount,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$EmailTemplateImpl _$$EmailTemplateImplFromJson(Map<String, dynamic> json) =>
    _$EmailTemplateImpl(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      subject: json['subject'] as String? ?? '',
      body: json['body'] as String? ?? '',
      templateType: json['template_type'] as String? ?? 'email',
      variables: (json['variables'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$EmailTemplateImplToJson(_$EmailTemplateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subject': instance.subject,
      'body': instance.body,
      'template_type': instance.templateType,
      'variables': instance.variables,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$SystemSettingsImpl _$$SystemSettingsImplFromJson(Map<String, dynamic> json) =>
    _$SystemSettingsImpl(
      appSettings:
          AppSettings.fromJson(json['appSettings'] as Map<String, dynamic>),
      paymentSettings: PaymentSettings.fromJson(
          json['paymentSettings'] as Map<String, dynamic>),
      emailTemplates: (json['emailTemplates'] as List<dynamic>?)
              ?.map((e) => EmailTemplate.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SystemSettingsImplToJson(
        _$SystemSettingsImpl instance) =>
    <String, dynamic>{
      'appSettings': instance.appSettings,
      'paymentSettings': instance.paymentSettings,
      'emailTemplates': instance.emailTemplates,
    };
