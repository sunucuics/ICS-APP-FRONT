import 'package:freezed_annotation/freezed_annotation.dart';

part 'featured_model.freezed.dart';
part 'featured_model.g.dart';

// Featured Item Base Model
@freezed
class FeaturedItem with _$FeaturedItem {
  const factory FeaturedItem({
    required String id,
    String? title,
    String? description,
    String? image,
    @JsonKey(name: 'is_upcoming') bool? isUpcoming,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _FeaturedItem;

  factory FeaturedItem.fromJson(Map<String, dynamic> json) =>
      _$FeaturedItemFromJson(json);
}

// Featured Product Model
@freezed
class FeaturedProduct with _$FeaturedProduct {
  const factory FeaturedProduct({
    required String id,
    String? title,
    String? description,
    double? price,
    @JsonKey(name: 'final_price') double? finalPrice,
    int? stock,
    @JsonKey(name: 'is_upcoming') bool? isUpcoming,
    @JsonKey(name: 'category_name') String? categoryName,
    @Default([]) List<String> images,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _FeaturedProduct;

  factory FeaturedProduct.fromJson(Map<String, dynamic> json) =>
      _$FeaturedProductFromJson(json);
}

// Featured Service Model
@freezed
class FeaturedService with _$FeaturedService {
  const factory FeaturedService({
    required String id,
    String? title,
    String? description,
    String? image,
    @JsonKey(name: 'is_upcoming') bool? isUpcoming,
    @JsonKey(name: 'is_deleted') bool? isDeleted,
    String? kind,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _FeaturedService;

  factory FeaturedService.fromJson(Map<String, dynamic> json) =>
      _$FeaturedServiceFromJson(json);
}

// Featured List Response Model
@freezed
class FeaturedListResponse with _$FeaturedListResponse {
  const factory FeaturedListResponse({
    @Default([]) List<FeaturedProduct> products,
    @Default([]) List<FeaturedService> services,
  }) = _FeaturedListResponse;

  factory FeaturedListResponse.fromJson(Map<String, dynamic> json) =>
      _$FeaturedListResponseFromJson(json);
}

// Featured Product List Response Model
@freezed
class FeaturedProductListResponse with _$FeaturedProductListResponse {
  const factory FeaturedProductListResponse({
    @Default([]) List<FeaturedProduct> products,
  }) = _FeaturedProductListResponse;

  factory FeaturedProductListResponse.fromJson(Map<String, dynamic> json) =>
      _$FeaturedProductListResponseFromJson(json);
}

// Featured Service List Response Model
@freezed
class FeaturedServiceListResponse with _$FeaturedServiceListResponse {
  const factory FeaturedServiceListResponse({
    @Default([]) List<FeaturedService> services,
  }) = _FeaturedServiceListResponse;

  factory FeaturedServiceListResponse.fromJson(Map<String, dynamic> json) =>
      _$FeaturedServiceListResponseFromJson(json);
}

// Featured Item Type Enum
enum FeaturedItemType {
  product('product'),
  service('service');

  const FeaturedItemType(this.value);
  final String value;

  static FeaturedItemType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'product':
        return FeaturedItemType.product;
      case 'service':
        return FeaturedItemType.service;
      default:
        return FeaturedItemType.product;
    }
  }
}

// Featured Action Type Enum
enum FeaturedActionType {
  feature('feature'),
  unfeature('unfeature');

  const FeaturedActionType(this.value);
  final String value;

  static FeaturedActionType fromString(String action) {
    switch (action.toLowerCase()) {
      case 'feature':
        return FeaturedActionType.feature;
      case 'unfeature':
        return FeaturedActionType.unfeature;
      default:
        return FeaturedActionType.feature;
    }
  }
}

// Featured Management Request Model
@freezed
class FeaturedManagementRequest with _$FeaturedManagementRequest {
  const factory FeaturedManagementRequest({
    required String itemId,
    required FeaturedItemType itemType,
    required FeaturedActionType action,
  }) = _FeaturedManagementRequest;

  factory FeaturedManagementRequest.fromJson(Map<String, dynamic> json) =>
      _$FeaturedManagementRequestFromJson(json);
}

// Featured Statistics Model
@freezed
class FeaturedStatistics with _$FeaturedStatistics {
  const factory FeaturedStatistics({
    @Default(0) int totalProducts,
    @Default(0) int totalServices,
    @Default(0) int upcomingProducts,
    @Default(0) int upcomingServices,
    @Default(0) int deletedServices,
  }) = _FeaturedStatistics;

  factory FeaturedStatistics.fromJson(Map<String, dynamic> json) =>
      _$FeaturedStatisticsFromJson(json);
}
