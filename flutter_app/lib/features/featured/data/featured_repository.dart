import '../../../core/models/featured_model.dart';
import 'featured_api_service.dart';

class FeaturedRepository {
  final FeaturedApiService _apiService;

  FeaturedRepository(this._apiService);

  /// Feature a product (Admin only)
  Future<FeaturedProduct> featureProduct(String productId) async {
    return await _apiService.featureProduct(productId);
  }

  /// Unfeature a product (Admin only)
  Future<void> unfeatureProduct(String productId) async {
    return await _apiService.unfeatureProduct(productId);
  }

  /// List featured products (Admin only)
  Future<List<FeaturedProduct>> listFeaturedProducts() async {
    return await _apiService.listFeaturedProducts();
  }

  /// Feature a service (Admin only)
  Future<FeaturedService> featureService(String serviceId) async {
    return await _apiService.featureService(serviceId);
  }

  /// Unfeature a service (Admin only)
  Future<void> unfeatureService(String serviceId) async {
    return await _apiService.unfeatureService(serviceId);
  }

  /// List featured services (Admin only)
  Future<List<FeaturedService>> listFeaturedServices() async {
    return await _apiService.listFeaturedServices();
  }

  /// Get featured content for public display
  Future<FeaturedListResponse> getFeaturedContent() async {
    return await _apiService.getFeaturedContent();
  }

  /// Get featured products for public display
  Future<List<FeaturedProduct>> getFeaturedProducts() async {
    return await _apiService.getFeaturedProducts();
  }

  /// Get featured services for public display
  Future<List<FeaturedService>> getFeaturedServices() async {
    return await _apiService.getFeaturedServices();
  }

  /// Get featured statistics
  Future<FeaturedStatistics> getFeaturedStatistics() async {
    return await _apiService.getFeaturedStatistics();
  }
}
