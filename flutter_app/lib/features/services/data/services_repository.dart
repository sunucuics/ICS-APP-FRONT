import '../../../core/models/service_model.dart';
import 'services_api_service.dart';

class ServicesRepository {
  final ServicesApiService _apiService = ServicesApiService();

  // Get all services
  Future<List<Service>> getServices() async {
    try {
      return await _apiService.getServices();
    } catch (e) {
      print('Error fetching services: $e');
      rethrow;
    }
  }

  // Get single service
  Future<Service> getService(String serviceId) async {
    try {
      return await _apiService.getService(serviceId);
    } catch (e) {
      print('Error fetching service: $e');
      rethrow;
    }
  }
}
