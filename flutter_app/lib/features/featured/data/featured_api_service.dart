import 'package:dio/dio.dart';
import '../../../core/models/featured_model.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/exceptions/api_exception.dart';

class FeaturedApiService {
  final Dio _dio;

  FeaturedApiService(this._dio);

  /// Feature a product (Admin only)
  Future<FeaturedProduct> featureProduct(String productId) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.adminFeatured}/products/$productId',
      );
      return FeaturedProduct.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Unfeature a product (Admin only)
  Future<void> unfeatureProduct(String productId) async {
    try {
      await _dio.delete('${ApiEndpoints.adminFeatured}/products/$productId');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// List featured products (Admin only)
  Future<List<FeaturedProduct>> listFeaturedProducts() async {
    try {
      final response = await _dio.get('${ApiEndpoints.adminFeatured}/products');
      final List<dynamic> productsJson = response.data;
      return productsJson
          .map((json) => FeaturedProduct.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Feature a service (Admin only)
  Future<FeaturedService> featureService(String serviceId) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.adminFeatured}/services/$serviceId',
      );
      return FeaturedService.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Unfeature a service (Admin only)
  Future<void> unfeatureService(String serviceId) async {
    try {
      await _dio.delete('${ApiEndpoints.adminFeatured}/services/$serviceId');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// List featured services (Admin only)
  Future<List<FeaturedService>> listFeaturedServices() async {
    try {
      final response = await _dio.get('${ApiEndpoints.adminFeatured}/services');
      final List<dynamic> servicesJson = response.data;
      return servicesJson
          .map((json) => FeaturedService.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Get featured content for public display
  Future<FeaturedListResponse> getFeaturedContent() async {
    try {
      // Since we don't have public endpoints, we'll use admin endpoints
      // In a real app, you'd have public endpoints like /featured/products and /featured/services
      final products = await listFeaturedProducts();
      final services = await listFeaturedServices();

      return FeaturedListResponse(
        products: products,
        services: services,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Get featured products for public display (using regular products endpoint)
  Future<List<FeaturedProduct>> getFeaturedProducts() async {
    try {
      // Use regular products endpoint since featured endpoint doesn't exist
      final response = await _dio.get('/products');
      return (response.data as List)
          .take(3) // Get first 3 products as featured
          .map((json) => FeaturedProduct.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Get featured services for public display (using regular services endpoint)
  Future<List<FeaturedService>> getFeaturedServices() async {
    try {
      // Use regular services endpoint since featured endpoint doesn't exist
      final response = await _dio.get('/services');
      return (response.data as List)
          .take(3) // Get first 3 services as featured
          .map((json) => FeaturedService.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Get featured statistics
  Future<FeaturedStatistics> getFeaturedStatistics() async {
    try {
      final products = await listFeaturedProducts();
      final services = await listFeaturedServices();

      final upcomingProducts =
          products.where((p) => p.isUpcoming == true).length;
      final upcomingServices =
          services.where((s) => s.isUpcoming == true).length;
      final deletedServices = services.where((s) => s.isDeleted == true).length;

      return FeaturedStatistics(
        totalProducts: products.length,
        totalServices: services.length,
        upcomingProducts: upcomingProducts,
        upcomingServices: upcomingServices,
        deletedServices: deletedServices,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
