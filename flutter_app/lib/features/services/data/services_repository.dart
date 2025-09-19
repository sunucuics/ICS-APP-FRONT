import '../../../core/models/service_model.dart';
import '../../../core/network/api_endpoints.dart';
import 'services_api_service.dart';

class ServicesRepository {
  final ServicesApiService _apiService = ServicesApiService();

  // Get all services
  Future<List<Service>> getServices() async {
    try {
      return await _apiService.getServices();
    } catch (e) {
      // Only print in debug mode
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
