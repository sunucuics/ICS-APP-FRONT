import 'package:dio/dio.dart';
import '../../../core/models/address_model.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/exceptions/api_exception.dart';

class AddressesApiService {
  final Dio _dio;

  AddressesApiService(this._dio);

  /// Get user's profile information
  Future<Map<String, dynamic>> getMyProfile() async {
    try {
      final response = await _dio.get(ApiEndpoints.userProfile);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Add a new address
  Future<Address> addAddress(AddressCreateRequest address) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.addresses,
        data: address.toJson(),
      );
      return Address.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Update an existing address
  Future<Address> updateAddress(
      String addressId, AddressUpdateRequest address) async {
    try {
      final response = await _dio.put(
        '${ApiEndpoints.addresses}/$addressId',
        data: address.toJson(),
      );
      return Address.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Delete an address
  Future<void> deleteAddress(String addressId) async {
    try {
      await _dio.delete('${ApiEndpoints.addresses}/$addressId');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// List all addresses
  Future<List<Address>> listAddresses() async {
    try {
      final response = await _dio.get(ApiEndpoints.addresses);
      final List<dynamic> addressesJson = response.data;
      return addressesJson.map((json) => Address.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Choose current address
  Future<Address> chooseCurrentAddress(String addressId) async {
    try {
      final response = await _dio
          .post('${ApiEndpoints.addresses}/$addressId/choose-current');
      return Address.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Get current address
  Future<Address?> getCurrentAddress() async {
    try {
      final response = await _dio.get(
        ApiEndpoints.currentAddress,
        options: Options(
          validateStatus: (status) {
            return status != null &&
                status < 500; // Accept 4xx as valid responses
          },
        ),
      );

      if (response.statusCode == 404) {
        return null; // No current address - this is normal
      }

      return Address.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null; // No current address
      }
      throw ApiException.fromDioException(e);
    }
  }
}
