import '../../../core/models/address_model.dart';
import 'addresses_api_service.dart';

class AddressesRepository {
  final AddressesApiService _apiService;

  AddressesRepository(this._apiService);

  /// Get user's profile information
  Future<Map<String, dynamic>> getMyProfile() async {
    return await _apiService.getMyProfile();
  }

  /// Add a new address
  Future<Address> addAddress(AddressCreateRequest address) async {
    return await _apiService.addAddress(address);
  }

  /// Update an existing address
  Future<Address> updateAddress(
      String addressId, AddressUpdateRequest address) async {
    return await _apiService.updateAddress(addressId, address);
  }

  /// Delete an address
  Future<void> deleteAddress(String addressId) async {
    return await _apiService.deleteAddress(addressId);
  }

  /// List all addresses
  Future<List<Address>> listAddresses() async {
    return await _apiService.listAddresses();
  }

  /// Choose current address
  Future<Address> chooseCurrentAddress(String addressId) async {
    return await _apiService.chooseCurrentAddress(addressId);
  }

  /// Get current address
  Future<Address?> getCurrentAddress() async {
    return await _apiService.getCurrentAddress();
  }
}
