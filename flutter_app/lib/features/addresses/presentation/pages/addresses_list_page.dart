import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/address_model.dart';
import '../../providers/addresses_provider.dart';
import 'add_address_page.dart';
import 'edit_address_page.dart';

class AddressesListPage extends ConsumerWidget {
  const AddressesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressesAsync = ref.watch(addressesProvider);
    final currentAddressAsync = ref.watch(currentAddressProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adreslerim'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(addressesProvider.notifier).refresh();
              ref.read(currentAddressProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: addressesAsync.when(
        data: (addresses) => _buildAddressesContent(
            context, ref, addresses, currentAddressAsync),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            _buildErrorState(context, ref, error.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddAddressPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAddressesContent(BuildContext context, WidgetRef ref,
      List<Address> addresses, AsyncValue<Address?> currentAddressAsync) {
    if (addresses.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(addressesProvider.notifier).refresh();
        await ref.read(currentAddressProvider.notifier).refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final address = addresses[index];
          return _buildAddressCard(context, ref, address, currentAddressAsync);
        },
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, WidgetRef ref, Address address,
      AsyncValue<Address?> currentAddressAsync) {
    final isCurrent = currentAddressAsync.when(
      data: (current) => current?.id == address.id,
      loading: () => false,
      error: (error, stack) => false,
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditAddressPage(address: address),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    _getAddressIcon(address.label),
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      address.name ?? 'Adres',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  if (isCurrent)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Aktif',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),

              // Address details
              Text(
                _formatAddress(address),
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),

              // Actions
              const SizedBox(height: 12),
              Row(
                children: [
                  if (!isCurrent)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            _setCurrentAddress(context, ref, address),
                        icon: const Icon(Icons.check_circle_outline, size: 16),
                        label: const Text('Varsayılan Seç'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  if (!isCurrent) const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _deleteAddress(context, ref, address),
                      icon: const Icon(Icons.delete_outline, size: 16),
                      label: const Text('Sil'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz adres eklenmemiş',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sipariş verebilmek için en az bir adres eklemeniz gerekiyor',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddAddressPage(),
                ),
              );
            },
            icon: const Icon(Icons.add_location),
            label: const Text('Adres Ekle'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Adresler yüklenemedi',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(addressesProvider.notifier).refresh();
              ref.read(currentAddressProvider.notifier).refresh();
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  IconData _getAddressIcon(String? label) {
    switch (label?.toLowerCase()) {
      case 'ev':
      case 'home':
        return Icons.home;
      case 'iş':
      case 'work':
        return Icons.work;
      default:
        return Icons.location_on;
    }
  }

  String _formatAddress(Address address) {
    final parts = <String>[];

    if (address.street != null) parts.add(address.street!);
    if (address.buildingNo != null) parts.add('No: ${address.buildingNo}');
    if (address.apartment != null) parts.add('Daire: ${address.apartment}');
    if (address.floor != null) parts.add('Kat: ${address.floor}');
    if (address.neighborhood != null) parts.add(address.neighborhood!);
    if (address.district != null) parts.add(address.district!);
    if (address.city != null) parts.add(address.city!);
    if (address.zipCode != null) parts.add(address.zipCode!);

    return parts.join(', ');
  }

  Future<void> _setCurrentAddress(
      BuildContext context, WidgetRef ref, Address address) async {
    try {
      await ref
          .read(addressesProvider.notifier)
          .chooseCurrentAddress(address.id!);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${address.name} aktif adres olarak ayarlandı'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hata: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteAddress(
      BuildContext context, WidgetRef ref, Address address) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adresi Sil'),
        content: Text(
            '${address.name} adresini silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(addressesProvider.notifier).deleteAddress(address.id!);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${address.name} adresi silindi'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (error) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Hata: $error'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
