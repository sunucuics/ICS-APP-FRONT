// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_type')
  String get targetType =>
      throw _privateConstructorUsedError; // 'product' or 'service'
  @JsonKey(name: 'target_id')
  String get targetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_name')
  String? get targetName =>
      throw _privateConstructorUsedError; // Ürün veya hizmet adı
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError; // 1-5
  @JsonKey(name: 'is_deleted')
  bool get isDeleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_hidden')
  bool get isHidden => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Comment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'target_type') String targetType,
      @JsonKey(name: 'target_id') String targetId,
      @JsonKey(name: 'target_name') String? targetName,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'user_name') String? userName,
      String content,
      int rating,
      @JsonKey(name: 'is_deleted') bool isDeleted,
      @JsonKey(name: 'is_hidden') bool isHidden,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? targetType = null,
    Object? targetId = null,
    Object? targetName = freezed,
    Object? userId = null,
    Object? userName = freezed,
    Object? content = null,
    Object? rating = null,
    Object? isDeleted = null,
    Object? isHidden = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      targetType: null == targetType
          ? _value.targetType
          : targetType // ignore: cast_nullable_to_non_nullable
              as String,
      targetId: null == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String,
      targetName: freezed == targetName
          ? _value.targetName
          : targetName // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isHidden: null == isHidden
          ? _value.isHidden
          : isHidden // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentImplCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$CommentImplCopyWith(
          _$CommentImpl value, $Res Function(_$CommentImpl) then) =
      __$$CommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'target_type') String targetType,
      @JsonKey(name: 'target_id') String targetId,
      @JsonKey(name: 'target_name') String? targetName,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'user_name') String? userName,
      String content,
      int rating,
      @JsonKey(name: 'is_deleted') bool isDeleted,
      @JsonKey(name: 'is_hidden') bool isHidden,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$CommentImplCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$CommentImpl>
    implements _$$CommentImplCopyWith<$Res> {
  __$$CommentImplCopyWithImpl(
      _$CommentImpl _value, $Res Function(_$CommentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? targetType = null,
    Object? targetId = null,
    Object? targetName = freezed,
    Object? userId = null,
    Object? userName = freezed,
    Object? content = null,
    Object? rating = null,
    Object? isDeleted = null,
    Object? isHidden = null,
    Object? createdAt = null,
  }) {
    return _then(_$CommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      targetType: null == targetType
          ? _value.targetType
          : targetType // ignore: cast_nullable_to_non_nullable
              as String,
      targetId: null == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String,
      targetName: freezed == targetName
          ? _value.targetName
          : targetName // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isHidden: null == isHidden
          ? _value.isHidden
          : isHidden // ignore: cast_nullable_to_non_nullable
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
class _$CommentImpl implements _Comment {
  const _$CommentImpl(
      {required this.id,
      @JsonKey(name: 'target_type') required this.targetType,
      @JsonKey(name: 'target_id') required this.targetId,
      @JsonKey(name: 'target_name') this.targetName,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'user_name') this.userName,
      required this.content,
      required this.rating,
      @JsonKey(name: 'is_deleted') this.isDeleted = false,
      @JsonKey(name: 'is_hidden') this.isHidden = false,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$CommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'target_type')
  final String targetType;
// 'product' or 'service'
  @override
  @JsonKey(name: 'target_id')
  final String targetId;
  @override
  @JsonKey(name: 'target_name')
  final String? targetName;
// Ürün veya hizmet adı
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
  @override
  final String content;
  @override
  final int rating;
// 1-5
  @override
  @JsonKey(name: 'is_deleted')
  final bool isDeleted;
  @override
  @JsonKey(name: 'is_hidden')
  final bool isHidden;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'Comment(id: $id, targetType: $targetType, targetId: $targetId, targetName: $targetName, userId: $userId, userName: $userName, content: $content, rating: $rating, isDeleted: $isDeleted, isHidden: $isHidden, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.targetType, targetType) ||
                other.targetType == targetType) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.targetName, targetName) ||
                other.targetName == targetName) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.isHidden, isHidden) ||
                other.isHidden == isHidden) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      targetType,
      targetId,
      targetName,
      userId,
      userName,
      content,
      rating,
      isDeleted,
      isHidden,
      createdAt);

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      __$$CommentImplCopyWithImpl<_$CommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentImplToJson(
      this,
    );
  }
}

abstract class _Comment implements Comment {
  const factory _Comment(
          {required final String id,
          @JsonKey(name: 'target_type') required final String targetType,
          @JsonKey(name: 'target_id') required final String targetId,
          @JsonKey(name: 'target_name') final String? targetName,
          @JsonKey(name: 'user_id') required final String userId,
          @JsonKey(name: 'user_name') final String? userName,
          required final String content,
          required final int rating,
          @JsonKey(name: 'is_deleted') final bool isDeleted,
          @JsonKey(name: 'is_hidden') final bool isHidden,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$CommentImpl;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$CommentImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'target_type')
  String get targetType; // 'product' or 'service'
  @override
  @JsonKey(name: 'target_id')
  String get targetId;
  @override
  @JsonKey(name: 'target_name')
  String? get targetName; // Ürün veya hizmet adı
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  String get content;
  @override
  int get rating; // 1-5
  @override
  @JsonKey(name: 'is_deleted')
  bool get isDeleted;
  @override
  @JsonKey(name: 'is_hidden')
  bool get isHidden;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CommentCreateRequest {
  String get content => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;

  /// Create a copy of CommentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentCreateRequestCopyWith<CommentCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCreateRequestCopyWith<$Res> {
  factory $CommentCreateRequestCopyWith(CommentCreateRequest value,
          $Res Function(CommentCreateRequest) then) =
      _$CommentCreateRequestCopyWithImpl<$Res, CommentCreateRequest>;
  @useResult
  $Res call({String content, int rating});
}

/// @nodoc
class _$CommentCreateRequestCopyWithImpl<$Res,
        $Val extends CommentCreateRequest>
    implements $CommentCreateRequestCopyWith<$Res> {
  _$CommentCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? rating = null,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentCreateRequestImplCopyWith<$Res>
    implements $CommentCreateRequestCopyWith<$Res> {
  factory _$$CommentCreateRequestImplCopyWith(_$CommentCreateRequestImpl value,
          $Res Function(_$CommentCreateRequestImpl) then) =
      __$$CommentCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content, int rating});
}

/// @nodoc
class __$$CommentCreateRequestImplCopyWithImpl<$Res>
    extends _$CommentCreateRequestCopyWithImpl<$Res, _$CommentCreateRequestImpl>
    implements _$$CommentCreateRequestImplCopyWith<$Res> {
  __$$CommentCreateRequestImplCopyWithImpl(_$CommentCreateRequestImpl _value,
      $Res Function(_$CommentCreateRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? rating = null,
  }) {
    return _then(_$CommentCreateRequestImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CommentCreateRequestImpl extends _CommentCreateRequest {
  const _$CommentCreateRequestImpl(
      {required this.content, required this.rating})
      : super._();

  @override
  final String content;
  @override
  final int rating;

  @override
  String toString() {
    return 'CommentCreateRequest(content: $content, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentCreateRequestImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content, rating);

  /// Create a copy of CommentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentCreateRequestImplCopyWith<_$CommentCreateRequestImpl>
      get copyWith =>
          __$$CommentCreateRequestImplCopyWithImpl<_$CommentCreateRequestImpl>(
              this, _$identity);
}

abstract class _CommentCreateRequest extends CommentCreateRequest {
  const factory _CommentCreateRequest(
      {required final String content,
      required final int rating}) = _$CommentCreateRequestImpl;
  const _CommentCreateRequest._() : super._();

  @override
  String get content;
  @override
  int get rating;

  /// Create a copy of CommentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentCreateRequestImplCopyWith<_$CommentCreateRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CommentListResponse _$CommentListResponseFromJson(Map<String, dynamic> json) {
  return _CommentListResponse.fromJson(json);
}

/// @nodoc
mixin _$CommentListResponse {
  List<Comment> get comments => throw _privateConstructorUsedError;

  /// Serializes this CommentListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommentListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentListResponseCopyWith<CommentListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentListResponseCopyWith<$Res> {
  factory $CommentListResponseCopyWith(
          CommentListResponse value, $Res Function(CommentListResponse) then) =
      _$CommentListResponseCopyWithImpl<$Res, CommentListResponse>;
  @useResult
  $Res call({List<Comment> comments});
}

/// @nodoc
class _$CommentListResponseCopyWithImpl<$Res, $Val extends CommentListResponse>
    implements $CommentListResponseCopyWith<$Res> {
  _$CommentListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = null,
  }) {
    return _then(_value.copyWith(
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentListResponseImplCopyWith<$Res>
    implements $CommentListResponseCopyWith<$Res> {
  factory _$$CommentListResponseImplCopyWith(_$CommentListResponseImpl value,
          $Res Function(_$CommentListResponseImpl) then) =
      __$$CommentListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Comment> comments});
}

/// @nodoc
class __$$CommentListResponseImplCopyWithImpl<$Res>
    extends _$CommentListResponseCopyWithImpl<$Res, _$CommentListResponseImpl>
    implements _$$CommentListResponseImplCopyWith<$Res> {
  __$$CommentListResponseImplCopyWithImpl(_$CommentListResponseImpl _value,
      $Res Function(_$CommentListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommentListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = null,
  }) {
    return _then(_$CommentListResponseImpl(
      comments: null == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentListResponseImpl implements _CommentListResponse {
  const _$CommentListResponseImpl({final List<Comment> comments = const []})
      : _comments = comments;

  factory _$CommentListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentListResponseImplFromJson(json);

  final List<Comment> _comments;
  @override
  @JsonKey()
  List<Comment> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  String toString() {
    return 'CommentListResponse(comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentListResponseImpl &&
            const DeepCollectionEquality().equals(other._comments, _comments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_comments));

  /// Create a copy of CommentListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentListResponseImplCopyWith<_$CommentListResponseImpl> get copyWith =>
      __$$CommentListResponseImplCopyWithImpl<_$CommentListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentListResponseImplToJson(
      this,
    );
  }
}

abstract class _CommentListResponse implements CommentListResponse {
  const factory _CommentListResponse({final List<Comment> comments}) =
      _$CommentListResponseImpl;

  factory _CommentListResponse.fromJson(Map<String, dynamic> json) =
      _$CommentListResponseImpl.fromJson;

  @override
  List<Comment> get comments;

  /// Create a copy of CommentListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentListResponseImplCopyWith<_$CommentListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfanityWord _$ProfanityWordFromJson(Map<String, dynamic> json) {
  return _ProfanityWord.fromJson(json);
}

/// @nodoc
mixin _$ProfanityWord {
  String get id => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ProfanityWord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfanityWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfanityWordCopyWith<ProfanityWord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfanityWordCopyWith<$Res> {
  factory $ProfanityWordCopyWith(
          ProfanityWord value, $Res Function(ProfanityWord) then) =
      _$ProfanityWordCopyWithImpl<$Res, ProfanityWord>;
  @useResult
  $Res call(
      {String id,
      String word,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$ProfanityWordCopyWithImpl<$Res, $Val extends ProfanityWord>
    implements $ProfanityWordCopyWith<$Res> {
  _$ProfanityWordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfanityWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfanityWordImplCopyWith<$Res>
    implements $ProfanityWordCopyWith<$Res> {
  factory _$$ProfanityWordImplCopyWith(
          _$ProfanityWordImpl value, $Res Function(_$ProfanityWordImpl) then) =
      __$$ProfanityWordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String word,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$ProfanityWordImplCopyWithImpl<$Res>
    extends _$ProfanityWordCopyWithImpl<$Res, _$ProfanityWordImpl>
    implements _$$ProfanityWordImplCopyWith<$Res> {
  __$$ProfanityWordImplCopyWithImpl(
      _$ProfanityWordImpl _value, $Res Function(_$ProfanityWordImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfanityWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? createdAt = null,
  }) {
    return _then(_$ProfanityWordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfanityWordImpl implements _ProfanityWord {
  const _$ProfanityWordImpl(
      {required this.id,
      required this.word,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$ProfanityWordImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfanityWordImplFromJson(json);

  @override
  final String id;
  @override
  final String word;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'ProfanityWord(id: $id, word: $word, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfanityWordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, word, createdAt);

  /// Create a copy of ProfanityWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfanityWordImplCopyWith<_$ProfanityWordImpl> get copyWith =>
      __$$ProfanityWordImplCopyWithImpl<_$ProfanityWordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfanityWordImplToJson(
      this,
    );
  }
}

abstract class _ProfanityWord implements ProfanityWord {
  const factory _ProfanityWord(
          {required final String id,
          required final String word,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$ProfanityWordImpl;

  factory _ProfanityWord.fromJson(Map<String, dynamic> json) =
      _$ProfanityWordImpl.fromJson;

  @override
  String get id;
  @override
  String get word;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of ProfanityWord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfanityWordImplCopyWith<_$ProfanityWordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfanityResponse _$ProfanityResponseFromJson(Map<String, dynamic> json) {
  return _ProfanityResponse.fromJson(json);
}

/// @nodoc
mixin _$ProfanityResponse {
  List<ProfanityWord> get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'blocked_words')
  List<String> get blockedWords => throw _privateConstructorUsedError;

  /// Serializes this ProfanityResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfanityResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfanityResponseCopyWith<ProfanityResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfanityResponseCopyWith<$Res> {
  factory $ProfanityResponseCopyWith(
          ProfanityResponse value, $Res Function(ProfanityResponse) then) =
      _$ProfanityResponseCopyWithImpl<$Res, ProfanityResponse>;
  @useResult
  $Res call(
      {List<ProfanityWord> items,
      @JsonKey(name: 'blocked_words') List<String> blockedWords});
}

/// @nodoc
class _$ProfanityResponseCopyWithImpl<$Res, $Val extends ProfanityResponse>
    implements $ProfanityResponseCopyWith<$Res> {
  _$ProfanityResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfanityResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? blockedWords = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ProfanityWord>,
      blockedWords: null == blockedWords
          ? _value.blockedWords
          : blockedWords // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfanityResponseImplCopyWith<$Res>
    implements $ProfanityResponseCopyWith<$Res> {
  factory _$$ProfanityResponseImplCopyWith(_$ProfanityResponseImpl value,
          $Res Function(_$ProfanityResponseImpl) then) =
      __$$ProfanityResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ProfanityWord> items,
      @JsonKey(name: 'blocked_words') List<String> blockedWords});
}

/// @nodoc
class __$$ProfanityResponseImplCopyWithImpl<$Res>
    extends _$ProfanityResponseCopyWithImpl<$Res, _$ProfanityResponseImpl>
    implements _$$ProfanityResponseImplCopyWith<$Res> {
  __$$ProfanityResponseImplCopyWithImpl(_$ProfanityResponseImpl _value,
      $Res Function(_$ProfanityResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfanityResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? blockedWords = null,
  }) {
    return _then(_$ProfanityResponseImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ProfanityWord>,
      blockedWords: null == blockedWords
          ? _value._blockedWords
          : blockedWords // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfanityResponseImpl implements _ProfanityResponse {
  const _$ProfanityResponseImpl(
      {required final List<ProfanityWord> items,
      @JsonKey(name: 'blocked_words') required final List<String> blockedWords})
      : _items = items,
        _blockedWords = blockedWords;

  factory _$ProfanityResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfanityResponseImplFromJson(json);

  final List<ProfanityWord> _items;
  @override
  List<ProfanityWord> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final List<String> _blockedWords;
  @override
  @JsonKey(name: 'blocked_words')
  List<String> get blockedWords {
    if (_blockedWords is EqualUnmodifiableListView) return _blockedWords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blockedWords);
  }

  @override
  String toString() {
    return 'ProfanityResponse(items: $items, blockedWords: $blockedWords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfanityResponseImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality()
                .equals(other._blockedWords, _blockedWords));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_blockedWords));

  /// Create a copy of ProfanityResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfanityResponseImplCopyWith<_$ProfanityResponseImpl> get copyWith =>
      __$$ProfanityResponseImplCopyWithImpl<_$ProfanityResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfanityResponseImplToJson(
      this,
    );
  }
}

abstract class _ProfanityResponse implements ProfanityResponse {
  const factory _ProfanityResponse(
      {required final List<ProfanityWord> items,
      @JsonKey(name: 'blocked_words')
      required final List<String> blockedWords}) = _$ProfanityResponseImpl;

  factory _ProfanityResponse.fromJson(Map<String, dynamic> json) =
      _$ProfanityResponseImpl.fromJson;

  @override
  List<ProfanityWord> get items;
  @override
  @JsonKey(name: 'blocked_words')
  List<String> get blockedWords;

  /// Create a copy of ProfanityResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfanityResponseImplCopyWith<_$ProfanityResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProfanityAddRequest {
  List<String> get words => throw _privateConstructorUsedError;

  /// Create a copy of ProfanityAddRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfanityAddRequestCopyWith<ProfanityAddRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfanityAddRequestCopyWith<$Res> {
  factory $ProfanityAddRequestCopyWith(
          ProfanityAddRequest value, $Res Function(ProfanityAddRequest) then) =
      _$ProfanityAddRequestCopyWithImpl<$Res, ProfanityAddRequest>;
  @useResult
  $Res call({List<String> words});
}

/// @nodoc
class _$ProfanityAddRequestCopyWithImpl<$Res, $Val extends ProfanityAddRequest>
    implements $ProfanityAddRequestCopyWith<$Res> {
  _$ProfanityAddRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfanityAddRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? words = null,
  }) {
    return _then(_value.copyWith(
      words: null == words
          ? _value.words
          : words // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfanityAddRequestImplCopyWith<$Res>
    implements $ProfanityAddRequestCopyWith<$Res> {
  factory _$$ProfanityAddRequestImplCopyWith(_$ProfanityAddRequestImpl value,
          $Res Function(_$ProfanityAddRequestImpl) then) =
      __$$ProfanityAddRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> words});
}

/// @nodoc
class __$$ProfanityAddRequestImplCopyWithImpl<$Res>
    extends _$ProfanityAddRequestCopyWithImpl<$Res, _$ProfanityAddRequestImpl>
    implements _$$ProfanityAddRequestImplCopyWith<$Res> {
  __$$ProfanityAddRequestImplCopyWithImpl(_$ProfanityAddRequestImpl _value,
      $Res Function(_$ProfanityAddRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfanityAddRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? words = null,
  }) {
    return _then(_$ProfanityAddRequestImpl(
      words: null == words
          ? _value._words
          : words // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$ProfanityAddRequestImpl extends _ProfanityAddRequest {
  const _$ProfanityAddRequestImpl({required final List<String> words})
      : _words = words,
        super._();

  final List<String> _words;
  @override
  List<String> get words {
    if (_words is EqualUnmodifiableListView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_words);
  }

  @override
  String toString() {
    return 'ProfanityAddRequest(words: $words)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfanityAddRequestImpl &&
            const DeepCollectionEquality().equals(other._words, _words));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_words));

  /// Create a copy of ProfanityAddRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfanityAddRequestImplCopyWith<_$ProfanityAddRequestImpl> get copyWith =>
      __$$ProfanityAddRequestImplCopyWithImpl<_$ProfanityAddRequestImpl>(
          this, _$identity);
}

abstract class _ProfanityAddRequest extends ProfanityAddRequest {
  const factory _ProfanityAddRequest({required final List<String> words}) =
      _$ProfanityAddRequestImpl;
  const _ProfanityAddRequest._() : super._();

  @override
  List<String> get words;

  /// Create a copy of ProfanityAddRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfanityAddRequestImplCopyWith<_$ProfanityAddRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
