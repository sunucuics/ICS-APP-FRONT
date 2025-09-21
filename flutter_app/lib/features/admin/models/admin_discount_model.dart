import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_discount_model.freezed.dart';
part 'admin_discount_model.g.dart';

@freezed
class AdminDiscount with _$AdminDiscount {
  const factory AdminDiscount({
    required String id,
    @JsonKey(name: 'target_type')
    required String targetType, // 'product' or 'category'
    @JsonKey(name: 'target_id') String? targetId,
    @JsonKey(name: 'percent') required double percentage,
    @Default(true) bool active,
    @JsonKey(name: 'start_at') DateTime? startAt,
    @JsonKey(name: 'end_at') DateTime? endAt,
    String? targetName,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AdminDiscount;

  factory AdminDiscount.fromJson(Map<String, dynamic> json) =>
      _$AdminDiscountFromJson(json);
}

@freezed
class DiscountCreateRequest with _$DiscountCreateRequest {
  const factory DiscountCreateRequest({
    required String name,
    required double percentage,
    required String targetType,
    String? targetId,
    required DateTime startDate,
    required DateTime endDate,
    @Default(true) bool isActive,
    String? description,
  }) = _DiscountCreateRequest;

  factory DiscountCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$DiscountCreateRequestFromJson(json);
}

@freezed
class DiscountUpdateRequest with _$DiscountUpdateRequest {
  const factory DiscountUpdateRequest({
    String? name,
    double? percentage,
    String? targetType,
    String? targetId,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    String? description,
  }) = _DiscountUpdateRequest;

  factory DiscountUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$DiscountUpdateRequestFromJson(json);
}
