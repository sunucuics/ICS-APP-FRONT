// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['id'] as String,
      targetType: json['target_type'] as String,
      targetId: json['target_id'] as String,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String?,
      content: json['content'] as String,
      rating: (json['rating'] as num).toInt(),
      isDeleted: json['is_deleted'] as bool? ?? false,
      isHidden: json['is_hidden'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'target_type': instance.targetType,
      'target_id': instance.targetId,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'content': instance.content,
      'rating': instance.rating,
      'is_deleted': instance.isDeleted,
      'is_hidden': instance.isHidden,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$CommentListResponseImpl _$$CommentListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CommentListResponseImpl(
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CommentListResponseImplToJson(
        _$CommentListResponseImpl instance) =>
    <String, dynamic>{
      'comments': instance.comments,
    };

_$ProfanityWordImpl _$$ProfanityWordImplFromJson(Map<String, dynamic> json) =>
    _$ProfanityWordImpl(
      id: json['id'] as String,
      word: json['word'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ProfanityWordImplToJson(_$ProfanityWordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$ProfanityResponseImpl _$$ProfanityResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfanityResponseImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => ProfanityWord.fromJson(e as Map<String, dynamic>))
          .toList(),
      blockedWords: (json['blocked_words'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$ProfanityResponseImplToJson(
        _$ProfanityResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'blocked_words': instance.blockedWords,
    };
