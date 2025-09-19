import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../auth/providers/anonymous_auth_provider.dart' as anonymous;
import '../../../auth/presentation/pages/guest_upgrade_page.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../auth/presentation/pages/register_page.dart';
import '../../../orders/presentation/pages/orders_list_page.dart';
import '../../../addresses/presentation/pages/addresses_list_page.dart';
import '../../../appointments/presentation/pages/my_appointments_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../../../../core/theme/app_theme.dart';

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
      body: authState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                // Modern App Bar
                SliverAppBar(
                  expandedHeight: 100,
                  floating: false,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme.primaryOrange,
                            AppTheme.secondaryOrange,
                          ],
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        'Profil',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.logout,
                                        color: Colors.white,
                                      ),
                                      onPressed: () =>
                                          _showLogoutDialog(context, ref),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Modern Profile Content
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(top: 0),
                    child: Column(
                      children: [
                        // Profile Card
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                24.0, 20.0, 24.0, 24.0),
                            child: Column(
                              children: [
                                // Profile Avatar
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      AppTheme.primaryOrange.withOpacity(0.1),
                                  child: Text(
                                    isActuallyAnonymous
                                        ? 'M'
                                        : _getInitials(
                                            currentUser?.name ?? 'U'),
                                    style: TextStyle(
                                      color: AppTheme.primaryOrange,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // User Info
                                Text(
                                  isActuallyAnonymous
                                      ? 'Misafir Kullanıcı'
                                      : currentUser?.name ?? 'Kullanıcı',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (!isActuallyAnonymous &&
                                    currentUser?.email != null)
                                  Text(
                                    currentUser?.email ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                                  ),
                                const SizedBox(height: 16),
                                // Status Badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color:
                                        AppTheme.primaryOrange.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppTheme.primaryOrange
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.verified,
                                        color: AppTheme.primaryOrange,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        isActuallyAnonymous
                                            ? 'Misafir'
                                            : 'Aktif Üye',
                                        style: TextStyle(
                                          color: AppTheme.primaryOrange,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
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
                        // Modern Menu Items
                        _buildModernMenuSection(
                          context,
                          title: 'Hesabım',
                          items: [
                            _buildModernMenuItem(
                              context,
                              icon: Icons.shopping_bag_outlined,
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
                            _buildModernMenuItem(
                              context,
                              icon: Icons.location_on_outlined,
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
                            _buildModernMenuItem(
                              context,
                              icon: Icons.calendar_today_outlined,
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
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildModernMenuSection(
                          context,
                          title: 'Uygulama',
                          items: [
                            _buildModernMenuItem(
                              context,
                              icon: Icons.settings_outlined,
                              title: 'Ayarlar',
                              subtitle: 'Hesap ve uygulama ayarları',
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const SettingsPage(),
                                  ),
                                );
                              },
                            ),
                            _buildModernMenuItem(
                              context,
                              icon: Icons.info_outline,
                              title: 'Hakkında',
                              subtitle: 'Uygulama bilgisi',
                              onTap: () => _showAboutDialog(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Authentication Buttons for Guest Users
                        if (isActuallyAnonymous)
                          _buildModernMenuSection(
                            context,
                            title: 'Hesap',
                            items: [
                              _buildModernMenuItem(
                                context,
                                icon: Icons.login,
                                title: 'Giriş Yap',
                                subtitle: 'Mevcut hesabınızla giriş yapın',
                                onTap: () => _navigateToLogin(context),
                              ),
                              _buildModernMenuItem(
                                context,
                                icon: Icons.person_add,
                                title: 'Kayıt Ol',
                                subtitle: 'Yeni hesap oluşturun',
                                onTap: () => _navigateToRegister(context),
                              ),
                            ],
                          ),
                        // Logout Button for Registered Users
                        if (!isActuallyAnonymous)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildModernMenuItem(
                              context,
                              icon: Icons.logout,
                              title: 'Çıkış Yap',
                              subtitle: 'Hesabınızdan çıkış yapın',
                              isDestructive: true,
                              onTap: () => _showLogoutDialog(context, ref),
                            ),
                          ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildModernMenuSection(
    BuildContext context, {
    required String title,
    required List<Widget> items,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: items,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDestructive
                        ? AppTheme.errorRed.withOpacity(0.1)
                        : AppTheme.primaryOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: isDestructive
                        ? AppTheme.errorRed
                        : AppTheme.primaryOrange,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDestructive
                              ? AppTheme.errorRed
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
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
    final isActuallyAnonymous = !ref.read(authProvider).isAuthenticated &&
        ref.read(anonymous.isAnonymousProvider);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Çıkış Yap'),
          content: Text(isActuallyAnonymous
              ? 'Misafir oturumundan çıkış yapmak istediğinize emin misiniz?'
              : 'Hesabınızdan çıkış yapmak istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();

                if (isActuallyAnonymous) {
                  // Sign out from anonymous auth
                  await ref
                      .read(anonymous.anonymousAuthProvider.notifier)
                      .signOut();
                } else {
                  // Sign out from registered auth
                  await ref.read(authProvider.notifier).logout();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorRed,
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Hesap Oluşturun'),
          content: const Text(
              'Bu özelliği kullanmak için bir hesap oluşturmanız gerekiyor.'),
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
              child: const Text('Hesap Oluştur'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'ICS App',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryOrange,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.flash_on,
          color: Colors.white,
          size: 32,
        ),
      ),
      children: const [
        Text('ICS App - Akıllı Ev ve Hizmet Yönetimi'),
        SizedBox(height: 16),
        Text(
            'Bu uygulama ile evinizi akıllı hale getirin ve profesyonel hizmetlerden yararlanın.'),
      ],
    );
  }
}
