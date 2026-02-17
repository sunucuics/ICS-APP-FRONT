import '../../../core/models/product_model.dart';
import '../../../core/models/paginated_response.dart';
import '../../../core/network/api_endpoints.dart';
import 'products_api_service.dart';

class ProductsRepository {
  final ProductsApiService _apiService = ProductsApiService();

  /// Get products with cursor-based pagination.
  Future<CursorPageResponse<Product>> getProducts({
    String? categoryName,
    int limit = 20,
    String? startAfter,
  }) async {
    try {
      if (ApiEndpoints.isDebug) {
        print(
            '📦 ProductsRepository.getProducts called with categoryName: $categoryName, limit: $limit, startAfter: $startAfter');
      }

      final response = await _apiService.getProducts(
        categoryName: categoryName,
        limit: limit,
        startAfter: startAfter,
      );

      if (ApiEndpoints.isDebug) {
        print(
            '📦 ProductsRepository.getProducts returning ${response.count} products, hasMore: ${response.hasMore}');
      }

      return response;
    } catch (e) {
      if (ApiEndpoints.isDebug) {
        print('❌ Error fetching products: $e');
      }
      rethrow;
    }
  }

  // Get single product by ID
  Future<Product> getProduct(String productId) async {
    try {
      return await _apiService.getProduct(productId);
    } catch (e) {
      // Only print in debug mode
      if (ApiEndpoints.isDebug) {
        print('Error fetching product $productId: $e');
      }
      rethrow;
    }
  }

  // Get all categories
  Future<List<Category>> getCategories() async {
    try {
      return await _apiService.getCategories();
    } catch (e) {
      // Only print in debug mode
      if (ApiEndpoints.isDebug) {
        print('Error fetching categories: $e');
      }
      rethrow;
    }
  }

  // Get single category by ID
  Future<Category> getCategory(String categoryId) async {
    try {
      return await _apiService.getCategory(categoryId);
    } catch (e) {
      // Only print in debug mode
      if (ApiEndpoints.isDebug) {
        print('Error fetching category $categoryId: $e');
      }
      rethrow;
    }
  }
}
