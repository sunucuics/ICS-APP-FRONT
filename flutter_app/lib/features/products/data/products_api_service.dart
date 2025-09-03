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

    final response = await _apiClient.get(
      ApiEndpoints.products,
      queryParameters: queryParameters,
    );

    // Backend returns List<Product>
    final productList = (response.data as List)
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();

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
