// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeaturedItemImpl _$$FeaturedItemImplFromJson(Map<String, dynamic> json) =>
    _$FeaturedItemImpl(
      id: json['id'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      isUpcoming: json['is_upcoming'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$FeaturedItemImplToJson(_$FeaturedItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'is_upcoming': instance.isUpcoming,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$FeaturedProductImpl _$$FeaturedProductImplFromJson(
        Map<String, dynamic> json) =>
    _$FeaturedProductImpl(
      id: json['id'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      finalPrice: (json['final_price'] as num?)?.toDouble(),
      stock: (json['stock'] as num?)?.toInt(),
      isUpcoming: json['is_upcoming'] as bool?,
      categoryName: json['category_name'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$FeaturedProductImplToJson(
        _$FeaturedProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'final_price': instance.finalPrice,
      'stock': instance.stock,
      'is_upcoming': instance.isUpcoming,
      'category_name': instance.categoryName,
      'images': instance.images,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$FeaturedServiceImpl _$$FeaturedServiceImplFromJson(
        Map<String, dynamic> json) =>
    _$FeaturedServiceImpl(
      id: json['id'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      isUpcoming: json['is_upcoming'] as bool?,
      isDeleted: json['is_deleted'] as bool?,
      kind: json['kind'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$FeaturedServiceImplToJson(
        _$FeaturedServiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'is_upcoming': instance.isUpcoming,
      'is_deleted': instance.isDeleted,
      'kind': instance.kind,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$FeaturedListResponseImpl _$$FeaturedListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$FeaturedListResponseImpl(
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => FeaturedProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      services: (json['services'] as List<dynamic>?)
              ?.map((e) => FeaturedService.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$FeaturedListResponseImplToJson(
        _$FeaturedListResponseImpl instance) =>
    <String, dynamic>{
      'products': instance.products,
      'services': instance.services,
    };

_$FeaturedProductListResponseImpl _$$FeaturedProductListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$FeaturedProductListResponseImpl(
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => FeaturedProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$FeaturedProductListResponseImplToJson(
        _$FeaturedProductListResponseImpl instance) =>
    <String, dynamic>{
      'products': instance.products,
    };

_$FeaturedServiceListResponseImpl _$$FeaturedServiceListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$FeaturedServiceListResponseImpl(
      services: (json['services'] as List<dynamic>?)
              ?.map((e) => FeaturedService.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$FeaturedServiceListResponseImplToJson(
        _$FeaturedServiceListResponseImpl instance) =>
    <String, dynamic>{
      'services': instance.services,
    };

_$FeaturedManagementRequestImpl _$$FeaturedManagementRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$FeaturedManagementRequestImpl(
      itemId: json['itemId'] as String,
      itemType: $enumDecode(_$FeaturedItemTypeEnumMap, json['itemType']),
      action: $enumDecode(_$FeaturedActionTypeEnumMap, json['action']),
    );

Map<String, dynamic> _$$FeaturedManagementRequestImplToJson(
        _$FeaturedManagementRequestImpl instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'itemType': _$FeaturedItemTypeEnumMap[instance.itemType]!,
      'action': _$FeaturedActionTypeEnumMap[instance.action]!,
    };

const _$FeaturedItemTypeEnumMap = {
  FeaturedItemType.product: 'product',
  FeaturedItemType.service: 'service',
};

const _$FeaturedActionTypeEnumMap = {
  FeaturedActionType.feature: 'feature',
  FeaturedActionType.unfeature: 'unfeature',
};

_$FeaturedStatisticsImpl _$$FeaturedStatisticsImplFromJson(
        Map<String, dynamic> json) =>
    _$FeaturedStatisticsImpl(
      totalProducts: (json['totalProducts'] as num?)?.toInt() ?? 0,
      totalServices: (json['totalServices'] as num?)?.toInt() ?? 0,
      upcomingProducts: (json['upcomingProducts'] as num?)?.toInt() ?? 0,
      upcomingServices: (json['upcomingServices'] as num?)?.toInt() ?? 0,
      deletedServices: (json['deletedServices'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FeaturedStatisticsImplToJson(
        _$FeaturedStatisticsImpl instance) =>
    <String, dynamic>{
      'totalProducts': instance.totalProducts,
      'totalServices': instance.totalServices,
      'upcomingProducts': instance.upcomingProducts,
      'upcomingServices': instance.upcomingServices,
      'deletedServices': instance.deletedServices,
    };
