import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class UserNotification with _$UserNotification {
  // ignore: invalid_annotation_target
  const factory UserNotification({
    required String id,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'user_id') required String userId,
    required String title,
    required String body,
    required String type,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'created_at') DateTime? createdAt,
    Map<String, dynamic>? data,
  }) = _UserNotification;

  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      _$UserNotificationFromJson(json);
}
