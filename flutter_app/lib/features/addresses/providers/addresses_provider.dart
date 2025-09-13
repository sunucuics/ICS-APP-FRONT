import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/address_model.dart';
import '../../../core/network/api_client.dart';
import '../data/addresses_api_service.dart';
import '../data/addresses_repository.dart';

// Repository Provider
final addressesRepositoryProvider = Provider<AddressesRepository>((ref) {
  final apiClient = ref.read(apiClientProvider);
  final apiService = AddressesApiService(apiClient);
  return AddressesRepository(apiService);
});

// Addresses List Provider
class AddressesNotifier extends StateNotifier<AsyncValue<List<Address>>> {
  final AddressesRepository _repository;

  AddressesNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadAddresses();
  }

  Future<void> loadAddresses() async {
    try {
      state = const AsyncValue.loading();
      final addresses = await _repository.listAddresses();
      state = AsyncValue.data(addresses);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadAddresses();
  }

  Future<Address> addAddress(AddressCreateRequest address) async {
    try {
      final newAddress = await _repository.addAddress(address);
      // Refresh the list
      await loadAddresses();
      return newAddress;
    } catch (error) {
      rethrow;
    }
  }

  Future<Address> updateAddress(
      String addressId, AddressUpdateRequest address) async {
    try {
      final updatedAddress =
          await _repository.updateAddress(addressId, address);
      // Refresh the list
      await loadAddresses();
      return updatedAddress;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteAddress(String addressId) async {
    try {
      await _repository.deleteAddress(addressId);
      // Refresh the list
      await loadAddresses();
    } catch (error) {
      rethrow;
    }
  }

  Future<Address> chooseCurrentAddress(String addressId) async {
    try {
      final currentAddress = await _repository.chooseCurrentAddress(addressId);
      // Refresh the list
      await loadAddresses();
      return currentAddress;
    } catch (error) {
      rethrow;
    }
  }
}

final addressesProvider =
    StateNotifierProvider<AddressesNotifier, AsyncValue<List<Address>>>((ref) {
  final repository = ref.read(addressesRepositoryProvider);
  return AddressesNotifier(repository);
});

// Current Address Provider
class CurrentAddressNotifier extends StateNotifier<AsyncValue<Address?>> {
  final AddressesRepository _repository;

  CurrentAddressNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadCurrentAddress();
  }

  Future<void> loadCurrentAddress() async {
    try {
      state = const AsyncValue.loading();
      final currentAddress = await _repository.getCurrentAddress();
      state = AsyncValue.data(currentAddress);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadCurrentAddress();
  }

  Future<Address> setCurrentAddress(String addressId) async {
    try {
      final currentAddress = await _repository.chooseCurrentAddress(addressId);
      state = AsyncValue.data(currentAddress);
      return currentAddress;
    } catch (error) {
      rethrow;
    }
  }
}

final currentAddressProvider =
    StateNotifierProvider<CurrentAddressNotifier, AsyncValue<Address?>>((ref) {
  final repository = ref.read(addressesRepositoryProvider);
  return CurrentAddressNotifier(repository);
});

// Convenience Providers
final addressesListProvider = Provider<List<Address>>((ref) {
  return ref.watch(addressesProvider).when(
        data: (addresses) => addresses,
        loading: () => <Address>[],
        error: (error, stack) => <Address>[],
      );
});

final currentAddressDataProvider = Provider<Address?>((ref) {
  return ref.watch(currentAddressProvider).when(
        data: (address) => address,
        loading: () => null,
        error: (error, stack) => null,
      );
});

final hasCurrentAddressProvider = Provider<bool>((ref) {
  final currentAddress = ref.watch(currentAddressDataProvider);
  return currentAddress != null;
});

// Helper to manage addresses from anywhere in the app
final addressManagerProvider = Provider<AddressManager>((ref) {
  return AddressManager(ref);
});

class AddressManager {
  final Ref ref;

  AddressManager(this.ref);

  Future<Address> addAddress(AddressCreateRequest address) async {
    return await ref.read(addressesProvider.notifier).addAddress(address);
  }

  Future<Address> updateAddress(
      String addressId, AddressUpdateRequest address) async {
    return await ref
        .read(addressesProvider.notifier)
        .updateAddress(addressId, address);
  }

  Future<void> deleteAddress(String addressId) async {
    return await ref.read(addressesProvider.notifier).deleteAddress(addressId);
  }

  Future<Address> setCurrentAddress(String addressId) async {
    return await ref
        .read(addressesProvider.notifier)
        .chooseCurrentAddress(addressId);
  }

  Future<void> refreshAddresses() async {
    await ref.read(addressesProvider.notifier).refresh();
    await ref.read(currentAddressProvider.notifier).refresh();
  }
}
