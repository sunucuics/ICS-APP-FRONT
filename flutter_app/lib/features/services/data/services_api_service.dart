import '../../../core/models/service_model.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';

class ServicesApiService {
  final ApiClient _apiClient = ApiClient.instance;

  // Get all services
  Future<List<Service>> getServices() async {
    final response = await _apiClient.get(ApiEndpoints.services);

    // Backend returns List<Service> directly
    final servicesList = response.data as List<dynamic>;
    return servicesList
        .map((service) => Service.fromJson(service as Map<String, dynamic>))
        .toList();
  }

  // Get single service by ID
  Future<Service> getService(String serviceId) async {
    final response = await _apiClient.get(ApiEndpoints.service(serviceId));
    return Service.fromJson(response.data as Map<String, dynamic>);
  }
}
