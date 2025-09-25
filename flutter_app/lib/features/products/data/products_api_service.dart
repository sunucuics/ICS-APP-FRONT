import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/models/product_model.dart';

class ProductsApiService {
  final ApiClient _apiClient = ApiClient.instance;

  // Get all products with optional category filter
  Future<List<Product>> getProducts({String? categoryName}) async {
    final queryParameters = <String, dynamic>{};
    if (categoryName != null && categoryName.isNotEmpty) {
      queryParameters['category_name'] = categoryName;
    }

    if (ApiEndpoints.isDebug) {
      print(
          '🔍 ProductsApiService.getProducts called with categoryName: $categoryName');
      print('🔍 Query parameters: $queryParameters');
    }

    final response = await _apiClient.get(
      ApiEndpoints.products,
      queryParameters: queryParameters,
    );

    if (ApiEndpoints.isDebug) {
      print('🔍 Backend response status: ${response.statusCode}');
      print('🔍 Backend response data type: ${response.data.runtimeType}');
      print(
          '🔍 Backend response data length: ${response.data is List ? (response.data as List).length : 'Not a list'}');
      if (response.data is List && (response.data as List).isNotEmpty) {
        print('🔍 First product sample: ${(response.data as List).first}');
      }
    }

    // Backend returns List<Product>
    final productList = (response.data as List)
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();

    if (ApiEndpoints.isDebug) {
      print('🔍 Parsed products count: ${productList.length}');
      if (productList.isNotEmpty) {
        print('🔍 First parsed product: ${productList.first.title}');
      }
    }

    return productList;
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
