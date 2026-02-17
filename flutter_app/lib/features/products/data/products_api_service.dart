import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/models/product_model.dart';
import '../../../core/models/paginated_response.dart';

class ProductsApiService {
  final ApiClient _apiClient = ApiClient.instance;

  /// Get products with cursor-based pagination.
  ///
  /// Backend CursorPage<ProductOut> response döner:
  /// ```json
  /// {"items": [...], "count": 20, "next_cursor": "...", "has_more": true}
  /// ```
  Future<CursorPageResponse<Product>> getProducts({
    String? categoryName,
    int limit = 20,
    String? startAfter,
  }) async {
    final queryParameters = <String, dynamic>{
      'limit': limit,
    };
    if (categoryName != null && categoryName.isNotEmpty) {
      queryParameters['category_name'] = categoryName;
    }
    if (startAfter != null) {
      queryParameters['start_after'] = startAfter;
    }

    if (ApiEndpoints.isDebug) {
      print(
          '🔍 ProductsApiService.getProducts called with categoryName: $categoryName, limit: $limit, startAfter: $startAfter');
    }

    final response = await _apiClient.get(
      ApiEndpoints.products,
      queryParameters: queryParameters,
    );

    if (ApiEndpoints.isDebug) {
      print('🔍 Backend response status: ${response.statusCode}');
    }

    // Backend returns CursorPage<ProductOut> envelope
    final data = response.data as Map<String, dynamic>;
    return CursorPageResponse.fromJson(data, Product.fromJson);
  }

  // Get single product by ID
  Future<Product> getProduct(String productId) async {
    final response = await _apiClient.get(
      ApiEndpoints.product(productId),
    );

    return Product.fromJson(response.data);
  }

  // Get all categories
  Future<List<Category>> getCategories() async {
    final response = await _apiClient.get(ApiEndpoints.categories);

    // Backend returns List<Category>
    final categoryList = (response.data as List)
        .map((item) => Category.fromJson(item as Map<String, dynamic>))
        .toList();

    // Sort categories: fixed categories first, then by creation date (newest first)
    categoryList.sort((a, b) {
      // Fixed categories always come first
      if (a.isFixed && !b.isFixed) return -1;
      if (!a.isFixed && b.isFixed) return 1;

      // If both have same fixed status, sort by creation date (newest first)
      if (a.createdAt != null && b.createdAt != null) {
        return b.createdAt!.compareTo(a.createdAt!);
      }

      return 0;
    });

    return categoryList;
  }

  // Get single category by ID
  Future<Category> getCategory(String categoryId) async {
    final response = await _apiClient.get(
      ApiEndpoints.category(categoryId),
    );

    return Category.fromJson(response.data);
  }
}
