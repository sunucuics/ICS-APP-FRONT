import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String title,
    String? description,
    required double price,
    double? finalPrice,
    required int stock,
    @Default(false) bool isUpcoming,
    String? categoryName,
    @Default([]) List<String> images,
    DateTime? createdAt,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson({
        'id': json['id'],
        'title': json['title'],
        'description': json['description'],
        'price': json['price'],
        'finalPrice': json['final_price'],
        'stock': json['stock'],
        'isUpcoming': json['is_upcoming'] ?? false,
        'categoryName': json['category_name'],
        'images': json['images'] ?? [],
        'createdAt': json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
      });
}

@freezed
class ProductListResponse with _$ProductListResponse {
  const factory ProductListResponse({
    @Default([]) List<Product> products,
  }) = _ProductListResponse;

  factory ProductListResponse.fromJson(List<dynamic> json) =>
      ProductListResponse(
        products: json
            .map((item) => Product.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
}

@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    String? description,
    String? image,
    String? coverImage,
    @Default('category') String kind,
    @Default(false) bool isDeleted,
    DateTime? createdAt,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson({
        'id': json['id'],
        'name': json['name'],
        'description': json['description'],
        'image': json['image'],
        'coverImage': json['cover_image'],
        'kind': json['kind'] ?? 'category',
        'isDeleted': json['is_deleted'] ?? false,
        'createdAt': json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
      });
}

@freezed
class CategoryListResponse with _$CategoryListResponse {
  const factory CategoryListResponse({
    @Default([]) List<Category> categories,
  }) = _CategoryListResponse;

  factory CategoryListResponse.fromJson(List<dynamic> json) =>
      CategoryListResponse(
        categories: json
            .map((item) => Category.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
}
