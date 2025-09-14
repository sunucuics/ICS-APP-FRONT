import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../auth/providers/anonymous_auth_provider.dart' as anonymous;
import '../../../auth/presentation/pages/guest_upgrade_page.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../orders/presentation/pages/orders_list_page.dart';
import '../../../addresses/presentation/pages/addresses_list_page.dart';
import '../../../appointments/presentation/pages/my_appointments_page.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final currentUser = ref.watch(currentUserProvider);
    final isAnonymous = ref.watch(anonymous.isAnonymousProvider);

    // If registered user is authenticated, ignore anonymous authentication
    final isActuallyAnonymous = !authState.isAuthenticated && isAnonymous;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context, ref),
          ),
        ],
      ),
      body: authState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Profile Header
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: isActuallyAnonymous
                              ? Colors.orange
                              : Theme.of(context).primaryColor,
                          child: Text(
                            isActuallyAnonymous
                                ? 'M'
                                : _getInitials(currentUser?.name ?? 'U'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isActuallyAnonymous
                                    ? 'Misafir Kullanıcı'
                                    : (currentUser?.name ?? 'Kullanıcı'),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                isActuallyAnonymous
                                    ? 'Misafir olarak giriş yaptınız'
                                    : (currentUser?.email ??
                                        'email@example.com'),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                              if (isActuallyAnonymous) ...[
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.orange.withOpacity(0.3),
                                    ),
                                  ),
                                  child: const Text(
                                    'Misafir Modu',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ] else if (currentUser?.phone != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  currentUser!.phone,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.grey[500],
                                      ),
                                ),
                              ],
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  currentUser?.role == 'admin'
                                      ? 'Admin'
                                      : 'Aktif Üye',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Guest Upgrade Banner (only for anonymous users)
                if (isActuallyAnonymous) ...[
                  Card(
                    color: Colors.orange.withOpacity(0.05),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hesap Oluşturun',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange[800],
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Sipariş geçmişinizi, favorilerinizi ve daha fazlasını kaydedin',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.orange[700],
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.orange,
                                    side: BorderSide(color: Colors.orange),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Giriş Yap',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const GuestUpgradePage(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Hesap Oluştur',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Menu Items
                Card(
                  child: Column(
                    children: [
                      _buildMenuItem(
                        context,
                        icon: Icons.shopping_bag,
                        title: 'Siparişlerim',
                        subtitle: isActuallyAnonymous
                            ? 'Hesap oluşturun'
                            : 'Geçmiş siparişleri görüntüle',
                        onTap: isActuallyAnonymous
                            ? () => _showGuestUpgradeDialog(context)
                            : () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OrdersListPage(),
                                  ),
                                );
                              },
                      ),
                      const Divider(height: 1),
                      _buildMenuItem(
                        context,
                        icon: Icons.location_on,
                        title: 'Adreslerim',
                        subtitle: isActuallyAnonymous
                            ? 'Hesap oluşturun'
                            : 'Teslimat adreslerini yönet',
                        onTap: isActuallyAnonymous
                            ? () => _showGuestUpgradeDialog(context)
                            : () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddressesListPage(),
                                  ),
                                );
                              },
                      ),
                      const Divider(height: 1),
                      _buildMenuItem(
                        context,
                        icon: Icons.calendar_today,
                        title: 'Randevularım',
                        subtitle: isActuallyAnonymous
                            ? 'Hesap oluşturun'
                            : 'Aktif ve geçmiş randevular',
                        onTap: isActuallyAnonymous
                            ? () => _showGuestUpgradeDialog(context)
                            : () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MyAppointmentsPage(),
                                  ),
                                );
                              },
                      ),
                      const Divider(height: 1),
                      _buildMenuItem(
                        context,
                        icon: Icons.favorite,
                        title: 'Favorilerim',
                        subtitle: 'Beğendiğin ürünler',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Favoriler yakında eklenecek'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Settings & Support
                Card(
                  child: Column(
                    children: [
                      _buildMenuItem(
                        context,
                        icon: Icons.settings,
                        title: 'Ayarlar',
                        subtitle: 'Hesap ve uygulama ayarları',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Ayarlar sayfası yakında eklenecek'),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1),
                      _buildMenuItem(
                        context,
                        icon: Icons.help,
                        title: 'Yardım & Destek',
                        subtitle: 'SSS ve iletişim',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Yardım sayfası yakında eklenecek'),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1),
                      _buildMenuItem(
                        context,
                        icon: Icons.info,
                        title: 'Hakkında',
                        subtitle: 'Uygulama bilgisi',
                        onTap: () {
                          _showAboutDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Logout Button
                Card(
                  child: _buildMenuItem(
                    context,
                    icon: Icons.logout,
                    title: 'Çıkış Yap',
                    subtitle: 'Hesabından güvenli çıkış',
                    onTap: () => _showLogoutDialog(context, ref),
                    isDestructive: true,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDestructive ? Colors.red : null,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  String _getInitials(String name) {
    return name
        .split(' ')
        .take(2)
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
        .join();
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Çıkış Yap'),
          content: const Text(
              'Hesabınızdan çıkış yapmak istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();

                // Check if user is anonymous
                final isAnonymous = ref.read(anonymous.isAnonymousProvider);
                final authState = ref.read(authProvider);
                final isActuallyAnonymous =
                    !authState.isAuthenticated && isAnonymous;

                if (isActuallyAnonymous) {
                  // For anonymous users, use anonymous auth provider
                  await ref
                      .read(anonymous.anonymousAuthProvider.notifier)
                      .signOut();

                  // Navigate to login page after logout
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  }
                } else {
                  // For registered users, use regular auth provider
                  await ref.read(authProvider.notifier).logout();

                  // Navigate to login page after logout
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Çıkış Yap'),
            ),
          ],
        );
      },
    );
  }

  void _showGuestUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hesap Gerekli'),
          content: const Text(
            'Bu özelliği kullanmak için hesap oluşturmanız gerekiyor. '
            'Hesap oluşturmak ister misiniz?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const GuestUpgradePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hesap Oluştur'),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'ICS App',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2024 ICS App. Tüm hakları saklıdır.',
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'E-ticaret ve hizmet rezervasyon uygulaması. '
            'Ürün satın alma, hizmet randevusu alma ve daha fazlası için tasarlandı.',
          ),
        ),
      ],
    );
  }
}
