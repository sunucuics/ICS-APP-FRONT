// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationTemplate _$NotificationTemplateFromJson(Map<String, dynamic> json) {
  return _NotificationTemplate.fromJson(json);
}

/// @nodoc
mixin _$NotificationTemplate {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Legacy fields for backward compatibility
  String? get title => throw _privateConstructorUsedError;
  String? get body => throw _privateConstructorUsedError;
  @JsonKey(name: 'template_type')
  String? get templateType => throw _privateConstructorUsedError;

  /// Serializes this NotificationTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationTemplateCopyWith<NotificationTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationTemplateCopyWith<$Res> {
  factory $NotificationTemplateCopyWith(NotificationTemplate value,
          $Res Function(NotificationTemplate) then) =
      _$NotificationTemplateCopyWithImpl<$Res, NotificationTemplate>;
  @useResult
  $Res call(
      {String id,
      String? name,
      String? subject,
      String? content,
      String? type,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      String? title,
      String? body,
      @JsonKey(name: 'template_type') String? templateType});
}

/// @nodoc
class _$NotificationTemplateCopyWithImpl<$Res,
        $Val extends NotificationTemplate>
    implements $NotificationTemplateCopyWith<$Res> {
  _$NotificationTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? subject = freezed,
    Object? content = freezed,
    Object? type = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? title = freezed,
    Object? body = freezed,
    Object? templateType = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
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
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      templateType: freezed == templateType
          ? _value.templateType
          : templateType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationTemplateImplCopyWith<$Res>
    implements $NotificationTemplateCopyWith<$Res> {
  factory _$$NotificationTemplateImplCopyWith(_$NotificationTemplateImpl value,
          $Res Function(_$NotificationTemplateImpl) then) =
      __$$NotificationTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? name,
      String? subject,
      String? content,
      String? type,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      String? title,
      String? body,
      @JsonKey(name: 'template_type') String? templateType});
}

/// @nodoc
class __$$NotificationTemplateImplCopyWithImpl<$Res>
    extends _$NotificationTemplateCopyWithImpl<$Res, _$NotificationTemplateImpl>
    implements _$$NotificationTemplateImplCopyWith<$Res> {
  __$$NotificationTemplateImplCopyWithImpl(_$NotificationTemplateImpl _value,
      $Res Function(_$NotificationTemplateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? subject = freezed,
    Object? content = freezed,
    Object? type = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? title = freezed,
    Object? body = freezed,
    Object? templateType = freezed,
  }) {
    return _then(_$NotificationTemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
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
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      templateType: freezed == templateType
          ? _value.templateType
          : templateType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationTemplateImpl implements _NotificationTemplate {
  const _$NotificationTemplateImpl(
      {required this.id,
      this.name,
      this.subject,
      this.content,
      this.type,
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.title,
      this.body,
      @JsonKey(name: 'template_type') this.templateType});

  factory _$NotificationTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationTemplateImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;
  @override
  final String? subject;
  @override
  final String? content;
  @override
  final String? type;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
// Legacy fields for backward compatibility
  @override
  final String? title;
  @override
  final String? body;
  @override
  @JsonKey(name: 'template_type')
  final String? templateType;

  @override
  String toString() {
    return 'NotificationTemplate(id: $id, name: $name, subject: $subject, content: $content, type: $type, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, title: $title, body: $body, templateType: $templateType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.templateType, templateType) ||
                other.templateType == templateType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, subject, content, type,
      isActive, createdAt, updatedAt, title, body, templateType);

  /// Create a copy of NotificationTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationTemplateImplCopyWith<_$NotificationTemplateImpl>
      get copyWith =>
          __$$NotificationTemplateImplCopyWithImpl<_$NotificationTemplateImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationTemplateImplToJson(
      this,
    );
  }
}

abstract class _NotificationTemplate implements NotificationTemplate {
  const factory _NotificationTemplate(
          {required final String id,
          final String? name,
          final String? subject,
          final String? content,
          final String? type,
          @JsonKey(name: 'is_active') final bool isActive,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt,
          final String? title,
          final String? body,
          @JsonKey(name: 'template_type') final String? templateType}) =
      _$NotificationTemplateImpl;

  factory _NotificationTemplate.fromJson(Map<String, dynamic> json) =
      _$NotificationTemplateImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;
  @override
  String? get subject;
  @override
  String? get content;
  @override
  String? get type;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt; // Legacy fields for backward compatibility
  @override
  String? get title;
  @override
  String? get body;
  @override
  @JsonKey(name: 'template_type')
  String? get templateType;

  /// Create a copy of NotificationTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationTemplateImplCopyWith<_$NotificationTemplateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationRequest _$NotificationRequestFromJson(Map<String, dynamic> json) {
  return _NotificationRequest.fromJson(json);
}

/// @nodoc
mixin _$NotificationRequest {
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  @JsonKey(name: 'template_id')
  String? get templateId => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_users')
  List<String>? get targetUsers => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_segments')
  List<String>? get userSegments => throw _privateConstructorUsedError;
  @JsonKey(name: 'send_immediately')
  bool get sendImmediately => throw _privateConstructorUsedError;
  @JsonKey(name: 'scheduled_at')
  DateTime? get scheduledAt => throw _privateConstructorUsedError;

  /// Serializes this NotificationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationRequestCopyWith<NotificationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationRequestCopyWith<$Res> {
  factory $NotificationRequestCopyWith(
          NotificationRequest value, $Res Function(NotificationRequest) then) =
      _$NotificationRequestCopyWithImpl<$Res, NotificationRequest>;
  @useResult
  $Res call(
      {String title,
      String body,
      @JsonKey(name: 'template_id') String? templateId,
      @JsonKey(name: 'target_users') List<String>? targetUsers,
      @JsonKey(name: 'user_segments') List<String>? userSegments,
      @JsonKey(name: 'send_immediately') bool sendImmediately,
      @JsonKey(name: 'scheduled_at') DateTime? scheduledAt});
}

/// @nodoc
class _$NotificationRequestCopyWithImpl<$Res, $Val extends NotificationRequest>
    implements $NotificationRequestCopyWith<$Res> {
  _$NotificationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? templateId = freezed,
    Object? targetUsers = freezed,
    Object? userSegments = freezed,
    Object? sendImmediately = null,
    Object? scheduledAt = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: freezed == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetUsers: freezed == targetUsers
          ? _value.targetUsers
          : targetUsers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      userSegments: freezed == userSegments
          ? _value.userSegments
          : userSegments // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      sendImmediately: null == sendImmediately
          ? _value.sendImmediately
          : sendImmediately // ignore: cast_nullable_to_non_nullable
              as bool,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationRequestImplCopyWith<$Res>
    implements $NotificationRequestCopyWith<$Res> {
  factory _$$NotificationRequestImplCopyWith(_$NotificationRequestImpl value,
          $Res Function(_$NotificationRequestImpl) then) =
      __$$NotificationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String body,
      @JsonKey(name: 'template_id') String? templateId,
      @JsonKey(name: 'target_users') List<String>? targetUsers,
      @JsonKey(name: 'user_segments') List<String>? userSegments,
      @JsonKey(name: 'send_immediately') bool sendImmediately,
      @JsonKey(name: 'scheduled_at') DateTime? scheduledAt});
}

/// @nodoc
class __$$NotificationRequestImplCopyWithImpl<$Res>
    extends _$NotificationRequestCopyWithImpl<$Res, _$NotificationRequestImpl>
    implements _$$NotificationRequestImplCopyWith<$Res> {
  __$$NotificationRequestImplCopyWithImpl(_$NotificationRequestImpl _value,
      $Res Function(_$NotificationRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? templateId = freezed,
    Object? targetUsers = freezed,
    Object? userSegments = freezed,
    Object? sendImmediately = null,
    Object? scheduledAt = freezed,
  }) {
    return _then(_$NotificationRequestImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: freezed == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetUsers: freezed == targetUsers
          ? _value._targetUsers
          : targetUsers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      userSegments: freezed == userSegments
          ? _value._userSegments
          : userSegments // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      sendImmediately: null == sendImmediately
          ? _value.sendImmediately
          : sendImmediately // ignore: cast_nullable_to_non_nullable
              as bool,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationRequestImpl implements _NotificationRequest {
  const _$NotificationRequestImpl(
      {required this.title,
      required this.body,
      @JsonKey(name: 'template_id') this.templateId,
      @JsonKey(name: 'target_users') final List<String>? targetUsers,
      @JsonKey(name: 'user_segments') final List<String>? userSegments,
      @JsonKey(name: 'send_immediately') this.sendImmediately = true,
      @JsonKey(name: 'scheduled_at') this.scheduledAt})
      : _targetUsers = targetUsers,
        _userSegments = userSegments;

  factory _$NotificationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationRequestImplFromJson(json);

  @override
  final String title;
  @override
  final String body;
  @override
  @JsonKey(name: 'template_id')
  final String? templateId;
  final List<String>? _targetUsers;
  @override
  @JsonKey(name: 'target_users')
  List<String>? get targetUsers {
    final value = _targetUsers;
    if (value == null) return null;
    if (_targetUsers is EqualUnmodifiableListView) return _targetUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _userSegments;
  @override
  @JsonKey(name: 'user_segments')
  List<String>? get userSegments {
    final value = _userSegments;
    if (value == null) return null;
    if (_userSegments is EqualUnmodifiableListView) return _userSegments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'send_immediately')
  final bool sendImmediately;
  @override
  @JsonKey(name: 'scheduled_at')
  final DateTime? scheduledAt;

  @override
  String toString() {
    return 'NotificationRequest(title: $title, body: $body, templateId: $templateId, targetUsers: $targetUsers, userSegments: $userSegments, sendImmediately: $sendImmediately, scheduledAt: $scheduledAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            const DeepCollectionEquality()
                .equals(other._targetUsers, _targetUsers) &&
            const DeepCollectionEquality()
                .equals(other._userSegments, _userSegments) &&
            (identical(other.sendImmediately, sendImmediately) ||
                other.sendImmediately == sendImmediately) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      body,
      templateId,
      const DeepCollectionEquality().hash(_targetUsers),
      const DeepCollectionEquality().hash(_userSegments),
      sendImmediately,
      scheduledAt);

  /// Create a copy of NotificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationRequestImplCopyWith<_$NotificationRequestImpl> get copyWith =>
      __$$NotificationRequestImplCopyWithImpl<_$NotificationRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationRequestImplToJson(
      this,
    );
  }
}

abstract class _NotificationRequest implements NotificationRequest {
  const factory _NotificationRequest(
          {required final String title,
          required final String body,
          @JsonKey(name: 'template_id') final String? templateId,
          @JsonKey(name: 'target_users') final List<String>? targetUsers,
          @JsonKey(name: 'user_segments') final List<String>? userSegments,
          @JsonKey(name: 'send_immediately') final bool sendImmediately,
          @JsonKey(name: 'scheduled_at') final DateTime? scheduledAt}) =
      _$NotificationRequestImpl;

  factory _NotificationRequest.fromJson(Map<String, dynamic> json) =
      _$NotificationRequestImpl.fromJson;

  @override
  String get title;
  @override
  String get body;
  @override
  @JsonKey(name: 'template_id')
  String? get templateId;
  @override
  @JsonKey(name: 'target_users')
  List<String>? get targetUsers;
  @override
  @JsonKey(name: 'user_segments')
  List<String>? get userSegments;
  @override
  @JsonKey(name: 'send_immediately')
  bool get sendImmediately;
  @override
  @JsonKey(name: 'scheduled_at')
  DateTime? get scheduledAt;

  /// Create a copy of NotificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationRequestImplCopyWith<_$NotificationRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationCampaign _$NotificationCampaignFromJson(Map<String, dynamic> json) {
  return _NotificationCampaign.fromJson(json);
}

/// @nodoc
mixin _$NotificationCampaign {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  @JsonKey(name: 'template_id')
  String? get templateId => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_count')
  int get targetCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'sent_count')
  int get sentCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivered_count')
  int get deliveredCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'opened_count')
  int get openedCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'scheduled_at')
  DateTime? get scheduledAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'sent_at')
  DateTime? get sentAt => throw _privateConstructorUsedError;

  /// Serializes this NotificationCampaign to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationCampaign
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationCampaignCopyWith<NotificationCampaign> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationCampaignCopyWith<$Res> {
  factory $NotificationCampaignCopyWith(NotificationCampaign value,
          $Res Function(NotificationCampaign) then) =
      _$NotificationCampaignCopyWithImpl<$Res, NotificationCampaign>;
  @useResult
  $Res call(
      {String id,
      String title,
      String body,
      @JsonKey(name: 'template_id') String? templateId,
      @JsonKey(name: 'target_count') int targetCount,
      @JsonKey(name: 'sent_count') int sentCount,
      @JsonKey(name: 'delivered_count') int deliveredCount,
      @JsonKey(name: 'opened_count') int openedCount,
      @JsonKey(name: 'status') String status,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'scheduled_at') DateTime? scheduledAt,
      @JsonKey(name: 'sent_at') DateTime? sentAt});
}

/// @nodoc
class _$NotificationCampaignCopyWithImpl<$Res,
        $Val extends NotificationCampaign>
    implements $NotificationCampaignCopyWith<$Res> {
  _$NotificationCampaignCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationCampaign
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? templateId = freezed,
    Object? targetCount = null,
    Object? sentCount = null,
    Object? deliveredCount = null,
    Object? openedCount = null,
    Object? status = null,
    Object? createdAt = null,
    Object? scheduledAt = freezed,
    Object? sentAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: freezed == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetCount: null == targetCount
          ? _value.targetCount
          : targetCount // ignore: cast_nullable_to_non_nullable
              as int,
      sentCount: null == sentCount
          ? _value.sentCount
          : sentCount // ignore: cast_nullable_to_non_nullable
              as int,
      deliveredCount: null == deliveredCount
          ? _value.deliveredCount
          : deliveredCount // ignore: cast_nullable_to_non_nullable
              as int,
      openedCount: null == openedCount
          ? _value.openedCount
          : openedCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationCampaignImplCopyWith<$Res>
    implements $NotificationCampaignCopyWith<$Res> {
  factory _$$NotificationCampaignImplCopyWith(_$NotificationCampaignImpl value,
          $Res Function(_$NotificationCampaignImpl) then) =
      __$$NotificationCampaignImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String body,
      @JsonKey(name: 'template_id') String? templateId,
      @JsonKey(name: 'target_count') int targetCount,
      @JsonKey(name: 'sent_count') int sentCount,
      @JsonKey(name: 'delivered_count') int deliveredCount,
      @JsonKey(name: 'opened_count') int openedCount,
      @JsonKey(name: 'status') String status,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'scheduled_at') DateTime? scheduledAt,
      @JsonKey(name: 'sent_at') DateTime? sentAt});
}

/// @nodoc
class __$$NotificationCampaignImplCopyWithImpl<$Res>
    extends _$NotificationCampaignCopyWithImpl<$Res, _$NotificationCampaignImpl>
    implements _$$NotificationCampaignImplCopyWith<$Res> {
  __$$NotificationCampaignImplCopyWithImpl(_$NotificationCampaignImpl _value,
      $Res Function(_$NotificationCampaignImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationCampaign
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? templateId = freezed,
    Object? targetCount = null,
    Object? sentCount = null,
    Object? deliveredCount = null,
    Object? openedCount = null,
    Object? status = null,
    Object? createdAt = null,
    Object? scheduledAt = freezed,
    Object? sentAt = freezed,
  }) {
    return _then(_$NotificationCampaignImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: freezed == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetCount: null == targetCount
          ? _value.targetCount
          : targetCount // ignore: cast_nullable_to_non_nullable
              as int,
      sentCount: null == sentCount
          ? _value.sentCount
          : sentCount // ignore: cast_nullable_to_non_nullable
              as int,
      deliveredCount: null == deliveredCount
          ? _value.deliveredCount
          : deliveredCount // ignore: cast_nullable_to_non_nullable
              as int,
      openedCount: null == openedCount
          ? _value.openedCount
          : openedCount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationCampaignImpl implements _NotificationCampaign {
  const _$NotificationCampaignImpl(
      {required this.id,
      required this.title,
      required this.body,
      @JsonKey(name: 'template_id') this.templateId,
      @JsonKey(name: 'target_count') required this.targetCount,
      @JsonKey(name: 'sent_count') required this.sentCount,
      @JsonKey(name: 'delivered_count') required this.deliveredCount,
      @JsonKey(name: 'opened_count') required this.openedCount,
      @JsonKey(name: 'status') required this.status,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'scheduled_at') this.scheduledAt,
      @JsonKey(name: 'sent_at') this.sentAt});

  factory _$NotificationCampaignImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationCampaignImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String body;
  @override
  @JsonKey(name: 'template_id')
  final String? templateId;
  @override
  @JsonKey(name: 'target_count')
  final int targetCount;
  @override
  @JsonKey(name: 'sent_count')
  final int sentCount;
  @override
  @JsonKey(name: 'delivered_count')
  final int deliveredCount;
  @override
  @JsonKey(name: 'opened_count')
  final int openedCount;
  @override
  @JsonKey(name: 'status')
  final String status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'scheduled_at')
  final DateTime? scheduledAt;
  @override
  @JsonKey(name: 'sent_at')
  final DateTime? sentAt;

  @override
  String toString() {
    return 'NotificationCampaign(id: $id, title: $title, body: $body, templateId: $templateId, targetCount: $targetCount, sentCount: $sentCount, deliveredCount: $deliveredCount, openedCount: $openedCount, status: $status, createdAt: $createdAt, scheduledAt: $scheduledAt, sentAt: $sentAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationCampaignImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.targetCount, targetCount) ||
                other.targetCount == targetCount) &&
            (identical(other.sentCount, sentCount) ||
                other.sentCount == sentCount) &&
            (identical(other.deliveredCount, deliveredCount) ||
                other.deliveredCount == deliveredCount) &&
            (identical(other.openedCount, openedCount) ||
                other.openedCount == openedCount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      body,
      templateId,
      targetCount,
      sentCount,
      deliveredCount,
      openedCount,
      status,
      createdAt,
      scheduledAt,
      sentAt);

  /// Create a copy of NotificationCampaign
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationCampaignImplCopyWith<_$NotificationCampaignImpl>
      get copyWith =>
          __$$NotificationCampaignImplCopyWithImpl<_$NotificationCampaignImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationCampaignImplToJson(
      this,
    );
  }
}

abstract class _NotificationCampaign implements NotificationCampaign {
  const factory _NotificationCampaign(
          {required final String id,
          required final String title,
          required final String body,
          @JsonKey(name: 'template_id') final String? templateId,
          @JsonKey(name: 'target_count') required final int targetCount,
          @JsonKey(name: 'sent_count') required final int sentCount,
          @JsonKey(name: 'delivered_count') required final int deliveredCount,
          @JsonKey(name: 'opened_count') required final int openedCount,
          @JsonKey(name: 'status') required final String status,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'scheduled_at') final DateTime? scheduledAt,
          @JsonKey(name: 'sent_at') final DateTime? sentAt}) =
      _$NotificationCampaignImpl;

  factory _NotificationCampaign.fromJson(Map<String, dynamic> json) =
      _$NotificationCampaignImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get body;
  @override
  @JsonKey(name: 'template_id')
  String? get templateId;
  @override
  @JsonKey(name: 'target_count')
  int get targetCount;
  @override
  @JsonKey(name: 'sent_count')
  int get sentCount;
  @override
  @JsonKey(name: 'delivered_count')
  int get deliveredCount;
  @override
  @JsonKey(name: 'opened_count')
  int get openedCount;
  @override
  @JsonKey(name: 'status')
  String get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'scheduled_at')
  DateTime? get scheduledAt;
  @override
  @JsonKey(name: 'sent_at')
  DateTime? get sentAt;

  /// Create a copy of NotificationCampaign
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationCampaignImplCopyWith<_$NotificationCampaignImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UserSegment _$UserSegmentFromJson(Map<String, dynamic> json) {
  return _UserSegment.fromJson(json);
}

/// @nodoc
mixin _$UserSegment {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'criteria')
  Map<String, dynamic> get criteria => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_count')
  int get userCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this UserSegment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSegment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSegmentCopyWith<UserSegment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSegmentCopyWith<$Res> {
  factory $UserSegmentCopyWith(
          UserSegment value, $Res Function(UserSegment) then) =
      _$UserSegmentCopyWithImpl<$Res, UserSegment>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      @JsonKey(name: 'criteria') Map<String, dynamic> criteria,
      @JsonKey(name: 'user_count') int userCount,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$UserSegmentCopyWithImpl<$Res, $Val extends UserSegment>
    implements $UserSegmentCopyWith<$Res> {
  _$UserSegmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSegment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? criteria = null,
    Object? userCount = null,
    Object? isActive = null,
    Object? createdAt = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      criteria: null == criteria
          ? _value.criteria
          : criteria // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      userCount: null == userCount
          ? _value.userCount
          : userCount // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSegmentImplCopyWith<$Res>
    implements $UserSegmentCopyWith<$Res> {
  factory _$$UserSegmentImplCopyWith(
          _$UserSegmentImpl value, $Res Function(_$UserSegmentImpl) then) =
      __$$UserSegmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      @JsonKey(name: 'criteria') Map<String, dynamic> criteria,
      @JsonKey(name: 'user_count') int userCount,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$UserSegmentImplCopyWithImpl<$Res>
    extends _$UserSegmentCopyWithImpl<$Res, _$UserSegmentImpl>
    implements _$$UserSegmentImplCopyWith<$Res> {
  __$$UserSegmentImplCopyWithImpl(
      _$UserSegmentImpl _value, $Res Function(_$UserSegmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSegment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? criteria = null,
    Object? userCount = null,
    Object? isActive = null,
    Object? createdAt = null,
  }) {
    return _then(_$UserSegmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      criteria: null == criteria
          ? _value._criteria
          : criteria // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      userCount: null == userCount
          ? _value.userCount
          : userCount // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSegmentImpl implements _UserSegment {
  const _$UserSegmentImpl(
      {required this.id,
      required this.name,
      required this.description,
      @JsonKey(name: 'criteria') required final Map<String, dynamic> criteria,
      @JsonKey(name: 'user_count') required this.userCount,
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'created_at') required this.createdAt})
      : _criteria = criteria;

  factory _$UserSegmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSegmentImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  final Map<String, dynamic> _criteria;
  @override
  @JsonKey(name: 'criteria')
  Map<String, dynamic> get criteria {
    if (_criteria is EqualUnmodifiableMapView) return _criteria;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_criteria);
  }

  @override
  @JsonKey(name: 'user_count')
  final int userCount;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'UserSegment(id: $id, name: $name, description: $description, criteria: $criteria, userCount: $userCount, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSegmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._criteria, _criteria) &&
            (identical(other.userCount, userCount) ||
                other.userCount == userCount) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      const DeepCollectionEquality().hash(_criteria),
      userCount,
      isActive,
      createdAt);

  /// Create a copy of UserSegment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSegmentImplCopyWith<_$UserSegmentImpl> get copyWith =>
      __$$UserSegmentImplCopyWithImpl<_$UserSegmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSegmentImplToJson(
      this,
    );
  }
}

abstract class _UserSegment implements UserSegment {
  const factory _UserSegment(
      {required final String id,
      required final String name,
      required final String description,
      @JsonKey(name: 'criteria') required final Map<String, dynamic> criteria,
      @JsonKey(name: 'user_count') required final int userCount,
      @JsonKey(name: 'is_active') final bool isActive,
      @JsonKey(name: 'created_at')
      required final DateTime createdAt}) = _$UserSegmentImpl;

  factory _UserSegment.fromJson(Map<String, dynamic> json) =
      _$UserSegmentImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  @JsonKey(name: 'criteria')
  Map<String, dynamic> get criteria;
  @override
  @JsonKey(name: 'user_count')
  int get userCount;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of UserSegment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSegmentImplCopyWith<_$UserSegmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
