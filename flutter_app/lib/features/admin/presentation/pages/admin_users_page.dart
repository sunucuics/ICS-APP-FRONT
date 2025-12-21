import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/user_model.dart';
import '../../providers/admin_users_provider.dart';
import '../../../../core/services/snackbar_service.dart';

class AdminUsersPage extends ConsumerWidget {
  const AdminUsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(adminUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcı Yönetimi'),
        backgroundColor: AppTheme.primaryNavy,
        foregroundColor: Colors.white,
      ),
      body: usersAsync.when(
        data: (users) {
          if (users.isEmpty) {
            return const Center(
              child: Text('Henüz kullanıcı bulunmamaktadır.'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return _buildUserCard(context, ref, user);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Kullanıcılar yüklenemedi: $error'),
        ),
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, WidgetRef ref, UserProfile user) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (user.name == null || user.name!.isEmpty) ? 'İsimsiz Kullanıcı' : user.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      if (user.phone != null && user.phone!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          user.phone!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            user.role,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor:
                              user.role == 'admin' ? Colors.red : Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () =>
                              _showRoleChangeDialog(context, ref, user),
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          tooltip: 'Rol Değiştir',
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (user.addresses.isNotEmpty)
                          IconButton(
                            onPressed: () =>
                                _showAddressDetailsDialog(context, user),
                            icon: const Icon(Icons.location_on,
                                color: Colors.green),
                            tooltip: 'Adres Detayları',
                          ),
                        IconButton(
                          onPressed: () =>
                              _showDeleteDialog(context, ref, user),
                          icon: const Icon(Icons.delete, color: Colors.red),
                          tooltip: 'Kullanıcıyı Sil',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            if (user.addresses.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text(
                'Adresler:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              ...user.addresses.take(2).map((address) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '${address.label ?? 'Adres'}: ${address.name ?? ''}, ${address.city ?? ''}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  )),
              if (user.addresses.length > 2)
                Text(
                  '... ve ${user.addresses.length - 2} adres daha',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  void _showRoleChangeDialog(
      BuildContext context, WidgetRef ref, UserProfile user) {
    String selectedRole = user.role;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Kullanıcı Rolünü Değiştir'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      '${(user.name == null || user.name!.isEmpty) ? 'Kullanıcı' : user.name} için rol seçin:'),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'Rol',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'customer',
                        child: Text('Müşteri'),
                      ),
                      DropdownMenuItem(
                        value: 'admin',
                        child: Text('Admin'),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedRole = newValue;
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('İptal'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await _updateUserRole(context, ref, user, selectedRole);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Güncelle'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddressDetailsDialog(BuildContext context, UserProfile user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              '${(user.name == null || user.name!.isEmpty) ? 'Kullanıcı' : user.name} - Adres Detayları'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: user.addresses.length,
              itemBuilder: (context, index) {
                final address = user.addresses[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address.label ?? 'Adres ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildAddressField('Adres Adı', address.name),
                        _buildAddressField('Şehir', address.city),
                        _buildAddressField('İlçe', address.district),
                        _buildAddressField('Mahalle', address.neighborhood),
                        _buildAddressField('Sokak', address.street),
                        _buildAddressField('Bina No', address.buildingNo),
                        _buildAddressField('Kat', address.floor),
                        _buildAddressField('Daire', address.apartment),
                        _buildAddressField('Posta Kodu', address.zipCode),
                        if (address.note != null && address.note!.isNotEmpty)
                          _buildAddressField('Not', address.note),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAddressField(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, WidgetRef ref, UserProfile user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kullanıcıyı Sil'),
          content: Text(
            '${(user.name == null || user.name!.isEmpty) ? 'Bu kullanıcıyı' : user.name} silmek istediğinizden emin misiniz?\n\n'
            'Bu işlem geri alınamaz.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteUser(context, ref, user);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Sil'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateUserRole(BuildContext context, WidgetRef ref,
      UserProfile user, String newRole) async {
    try {
      await ref
          .read(adminUsersProvider.notifier)
          .updateUserRole(user.id, newRole);
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text(
                '${(user.name == null || user.name!.isEmpty) ? 'Kullanıcı' : user.name} rolü ${newRole == 'admin' ? 'Admin' : 'Müşteri'} olarak güncellendi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text('Rol güncellenirken hata oluştu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteUser(
      BuildContext context, WidgetRef ref, UserProfile user) async {
    try {
      await ref.read(adminUsersProvider.notifier).deleteUser(user.id);
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text(
                '${(user.name == null || user.name!.isEmpty) ? 'Kullanıcı' : user.name} başarıyla silindi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text('Kullanıcı silinirken hata oluştu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
