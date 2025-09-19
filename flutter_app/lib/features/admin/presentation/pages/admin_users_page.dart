import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/admin_users_provider.dart';
import '../widgets/admin_navigation.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/user_model.dart';

class AdminUsersPage extends ConsumerWidget {
  const AdminUsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(adminUsersNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcı Yönetimi'),
        backgroundColor: AppTheme.primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(adminUsersNotifierProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: usersAsync.when(
        data: (users) => _buildUsersList(context, ref, users),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            _buildErrorWidget(context, ref, error.toString()),
      ),
      bottomNavigationBar: const AdminNavigation(),
    );
  }

  Widget _buildUsersList(
      BuildContext context, WidgetRef ref, List<UserProfile> users) {
    if (users.isEmpty) {
      return _buildEmptyState(context, ref);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(adminUsersNotifierProvider.notifier).refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return _buildUserCard(context, ref, user);
        },
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, WidgetRef ref, UserProfile user) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // User Avatar
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppTheme.primaryNavy.withOpacity(0.1),
              ),
              child: Center(
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryNavy,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user.email,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    user.phone,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildStatusChip(
                        user.role == 'admin' ? 'Admin' : 'Kullanıcı',
                        user.role == 'admin' ? Colors.purple : Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      if (user.isGuest)
                        _buildStatusChip('Misafir', Colors.orange),
                    ],
                  ),
                ],
              ),
            ),

            // Actions
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'admin':
                    _showRoleUpdateConfirmation(context, ref, user, 'admin');
                    break;
                  case 'customer':
                    _showRoleUpdateConfirmation(context, ref, user, 'customer');
                    break;
                  case 'details':
                    _showUserDetails(context, user);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'details',
                  child: Row(
                    children: [
                      Icon(Icons.info, size: 20),
                      SizedBox(width: 8),
                      Text('Detaylar'),
                    ],
                  ),
                ),
                if (user.role != 'admin')
                  const PopupMenuItem(
                    value: 'admin',
                    child: Row(
                      children: [
                        Icon(Icons.admin_panel_settings,
                            size: 20, color: Colors.purple),
                        SizedBox(width: 8),
                        Text('Admin Yap',
                            style: TextStyle(color: Colors.purple)),
                      ],
                    ),
                  ),
                if (user.role == 'admin')
                  const PopupMenuItem(
                    value: 'customer',
                    child: Row(
                      children: [
                        Icon(Icons.person, size: 20, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('Kullanıcı Yap',
                            style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz kullanıcı yok',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Kullanıcılar kayıt olduğunda burada görünecek',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, WidgetRef ref, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Hata Oluştu',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(adminUsersNotifierProvider.notifier).refresh();
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  void _showUserDetails(BuildContext context, UserProfile user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Kullanıcı Detayları: ${user.name}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ID: ${user.id}'),
              Text('Ad: ${user.name}'),
              Text('E-posta: ${user.email}'),
              Text('Telefon: ${user.phone}'),
              Text('Rol: ${user.role}'),
              Text('Misafir: ${user.isGuest ? 'Evet' : 'Hayır'}'),
              const SizedBox(height: 16),
              const Text('Adresler:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              if (user.addresses.isEmpty)
                const Text('Adres bulunamadı')
              else
                ...user.addresses.map((address) => Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('• ${address.city}, ${address.district}'),
                    )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  void _showRoleUpdateConfirmation(
      BuildContext context, WidgetRef ref, UserProfile user, String newRole) {
    final roleName = newRole == 'admin' ? 'Admin' : 'Kullanıcı';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rol Güncelle'),
        content: Text(
            '${user.name} kullanıcısının rolünü $roleName yapmak istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref
                  .read(adminUsersNotifierProvider.notifier)
                  .updateUserRole(user.id, newRole);
            },
            style:
                TextButton.styleFrom(foregroundColor: AppTheme.primaryOrange),
            child: const Text('Güncelle'),
          ),
        ],
      ),
    );
  }
}
