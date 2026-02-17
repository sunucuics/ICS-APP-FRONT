import '../../../core/models/service_model.dart';
import '../../../core/models/paginated_response.dart';
import '../../../core/network/api_endpoints.dart';
import 'services_api_service.dart';

class ServicesRepository {
  final ServicesApiService _apiService = ServicesApiService();

  /// Get services with cursor-based pagination.
  Future<CursorPageResponse<Service>> getServices({
    int limit = 20,
    String? startAfter,
  }) async {
    try {
      return await _apiService.getServices(
        limit: limit,
        startAfter: startAfter,
      );
    } catch (e) {
      if (ApiEndpoints.isDebug) {
        print('Error fetching services: $e');
      }
      rethrow;
    }
  }

  // Get single service
  Future<Service> getService(String serviceId) async {
    try {
      return await _apiService.getService(serviceId);
    } catch (e) {
      // Only print in debug mode
      if (ApiEndpoints.isDebug) {
        print('Error fetching service: $e');
      }
      rethrow;
    }
  }
}
