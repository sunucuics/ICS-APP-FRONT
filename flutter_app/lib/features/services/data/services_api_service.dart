import '../../../core/models/service_model.dart';
import '../../../core/models/paginated_response.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';

class ServicesApiService {
  final ApiClient _apiClient = ApiClient.instance;

  /// Get services with cursor-based pagination.
  Future<CursorPageResponse<Service>> getServices({
    int limit = 20,
    String? startAfter,
  }) async {
    final queryParameters = <String, dynamic>{
      'limit': limit,
    };
    if (startAfter != null) {
      queryParameters['start_after'] = startAfter;
    }

    final response = await _apiClient.get(
      ApiEndpoints.services,
      queryParameters: queryParameters,
    );

    // Backend returns CursorPage<ServiceOut> envelope
    final data = response.data as Map<String, dynamic>;
    return CursorPageResponse.fromJson(data, Service.fromJson);
  }

  // Get single service by ID
  Future<Service> getService(String serviceId) async {
    final response = await _apiClient.get(ApiEndpoints.service(serviceId));
    return Service.fromJson(response.data as Map<String, dynamic>);
  }
}
