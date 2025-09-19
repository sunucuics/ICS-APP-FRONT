import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_notification_model.freezed.dart';
part 'admin_notification_model.g.dart';

@freezed
class NotificationTemplate with _$NotificationTemplate {
  const factory NotificationTemplate({
    required String id,
    required String title,
    required String body,
    @JsonKey(name: 'template_type') required String templateType,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _NotificationTemplate;

  factory NotificationTemplate.fromJson(Map<String, dynamic> json) =>
      _$NotificationTemplateFromJson(json);
}

@freezed
class NotificationRequest with _$NotificationRequest {
  const factory NotificationRequest({
    required String title,
    required String body,
    @JsonKey(name: 'template_id') String? templateId,
    @JsonKey(name: 'target_users') List<String>? targetUsers,
    @JsonKey(name: 'user_segments') List<String>? userSegments,
    @JsonKey(name: 'send_immediately') @Default(true) bool sendImmediately,
    @JsonKey(name: 'scheduled_at') DateTime? scheduledAt,
  }) = _NotificationRequest;

  factory NotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationRequestFromJson(json);
}

@freezed
class NotificationCampaign with _$NotificationCampaign {
  const factory NotificationCampaign({
    required String id,
    required String title,
    required String body,
    @JsonKey(name: 'template_id') String? templateId,
    @JsonKey(name: 'target_count') required int targetCount,
    @JsonKey(name: 'sent_count') required int sentCount,
    @JsonKey(name: 'delivered_count') required int deliveredCount,
    @JsonKey(name: 'opened_count') required int openedCount,
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'scheduled_at') DateTime? scheduledAt,
    @JsonKey(name: 'sent_at') DateTime? sentAt,
  }) = _NotificationCampaign;

  factory NotificationCampaign.fromJson(Map<String, dynamic> json) =>
      _$NotificationCampaignFromJson(json);
}

@freezed
class UserSegment with _$UserSegment {
  const factory UserSegment({
    required String id,
    required String name,
    required String description,
    @JsonKey(name: 'criteria') required Map<String, dynamic> criteria,
    @JsonKey(name: 'user_count') required int userCount,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _UserSegment;

  factory UserSegment.fromJson(Map<String, dynamic> json) =>
      _$UserSegmentFromJson(json);
}
