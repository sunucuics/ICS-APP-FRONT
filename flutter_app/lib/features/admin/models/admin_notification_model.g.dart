// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationTemplateImpl _$$NotificationTemplateImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationTemplateImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      subject: json['subject'] as String,
      content: json['content'] as String,
      type: json['type'] as String,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      title: json['title'] as String?,
      body: json['body'] as String?,
      templateType: json['template_type'] as String?,
    );

Map<String, dynamic> _$$NotificationTemplateImplToJson(
        _$NotificationTemplateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subject': instance.subject,
      'content': instance.content,
      'type': instance.type,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'title': instance.title,
      'body': instance.body,
      'template_type': instance.templateType,
    };

_$NotificationRequestImpl _$$NotificationRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationRequestImpl(
      title: json['title'] as String,
      body: json['body'] as String,
      templateId: json['template_id'] as String?,
      targetUsers: (json['target_users'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      userSegments: (json['user_segments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sendImmediately: json['send_immediately'] as bool? ?? true,
      scheduledAt: json['scheduled_at'] == null
          ? null
          : DateTime.parse(json['scheduled_at'] as String),
    );

Map<String, dynamic> _$$NotificationRequestImplToJson(
        _$NotificationRequestImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'template_id': instance.templateId,
      'target_users': instance.targetUsers,
      'user_segments': instance.userSegments,
      'send_immediately': instance.sendImmediately,
      'scheduled_at': instance.scheduledAt?.toIso8601String(),
    };

_$NotificationCampaignImpl _$$NotificationCampaignImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationCampaignImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      templateId: json['template_id'] as String?,
      targetCount: (json['target_count'] as num).toInt(),
      sentCount: (json['sent_count'] as num).toInt(),
      deliveredCount: (json['delivered_count'] as num).toInt(),
      openedCount: (json['opened_count'] as num).toInt(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      scheduledAt: json['scheduled_at'] == null
          ? null
          : DateTime.parse(json['scheduled_at'] as String),
      sentAt: json['sent_at'] == null
          ? null
          : DateTime.parse(json['sent_at'] as String),
    );

Map<String, dynamic> _$$NotificationCampaignImplToJson(
        _$NotificationCampaignImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'template_id': instance.templateId,
      'target_count': instance.targetCount,
      'sent_count': instance.sentCount,
      'delivered_count': instance.deliveredCount,
      'opened_count': instance.openedCount,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'scheduled_at': instance.scheduledAt?.toIso8601String(),
      'sent_at': instance.sentAt?.toIso8601String(),
    };

_$UserSegmentImpl _$$UserSegmentImplFromJson(Map<String, dynamic> json) =>
    _$UserSegmentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      criteria: json['criteria'] as Map<String, dynamic>,
      userCount: (json['user_count'] as num).toInt(),
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$UserSegmentImplToJson(_$UserSegmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'criteria': instance.criteria,
      'user_count': instance.userCount,
      'is_active': instance.isActive,
      'created_at': instance.createdAt.toIso8601String(),
    };
