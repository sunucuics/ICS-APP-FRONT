import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    required String id,
    @JsonKey(name: 'target_type')
    required String targetType, // 'product' or 'service'
    @JsonKey(name: 'target_id') required String targetId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'user_name') String? userName,
    required String content,
    required int rating, // 1-5
    @JsonKey(name: 'is_deleted') @Default(false) bool isDeleted,
    @JsonKey(name: 'is_hidden') @Default(false) bool isHidden,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

@freezed
class CommentCreateRequest with _$CommentCreateRequest {
  const factory CommentCreateRequest({
    required String content,
    required int rating,
  }) = _CommentCreateRequest;

  const CommentCreateRequest._();

  Map<String, dynamic> toFormData() => {
        'content': content,
        'rating': rating.toString(),
      };
}

@freezed
class CommentListResponse with _$CommentListResponse {
  const factory CommentListResponse({
    @Default([]) List<Comment> comments,
  }) = _CommentListResponse;

  factory CommentListResponse.fromJson(List<dynamic> json) =>
      CommentListResponse(
        comments: json
            .map((item) => Comment.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
}

// Profanity filter models for admin
@freezed
class ProfanityWord with _$ProfanityWord {
  const factory ProfanityWord({
    required String id,
    required String word,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _ProfanityWord;

  factory ProfanityWord.fromJson(Map<String, dynamic> json) =>
      _$ProfanityWordFromJson(json);
}

@freezed
class ProfanityResponse with _$ProfanityResponse {
  const factory ProfanityResponse({
    required List<ProfanityWord> items,
    @JsonKey(name: 'blocked_words') required List<String> blockedWords,
  }) = _ProfanityResponse;

  factory ProfanityResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfanityResponseFromJson(json);
}

@freezed
class ProfanityAddRequest with _$ProfanityAddRequest {
  const factory ProfanityAddRequest({
    required List<String> words,
  }) = _ProfanityAddRequest;

  const ProfanityAddRequest._();

  Map<String, dynamic> toJson() => {
        'words': words,
      };
}
