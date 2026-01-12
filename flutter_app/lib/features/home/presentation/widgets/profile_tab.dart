import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../auth/providers/anonymous_auth_provider.dart' as anonymous;
import '../../../auth/presentation/pages/login_page.dart';
import '../../../auth/presentation/pages/register_page.dart';
import '../../../orders/presentation/pages/orders_list_page.dart';
import '../../../addresses/presentation/pages/addresses_list_page.dart';
import '../../../appointments/presentation/pages/my_appointments_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../../../notifications/presentation/pages/notifications_list_page.dart';
import 'profile_card_widget.dart';
import 'profile_menu_widget.dart';
import 'profile_dialogs.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final currentUser = ref.watch(currentUserProvider);
    final isAnonymous = ref.watch(anonymous.isAnonymousProvider);

    // If registered user is authenticated, ignore anonymous authentication
    final isActuallyAnonymous = !authState.isAuthenticated && isAnonymous;

    // Listen to auth state changes and navigate when user logs out
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous?.isAuthenticated == true && next.isAuthenticated == false) {
        // User has logged out, navigate to login page
        if (context.mounted) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/welcome', (route) => false);
        }
      }
    });

    return Scaffold(
      body: authState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 32),
                child: Container(
                  margin: const EdgeInsets.only(top: 0),
                  child: Column(
                    children: [
                      // Profile Card
                      ProfileCardWidget(
                        currentUser: currentUser,
                        isActuallyAnonymous: isActuallyAnonymous,
                      ),
                      const SizedBox(height: 24),
                      // Modern Menu Items
                      ModernMenuSection(
                        title: 'Hesabım',
                        items: [
                          ModernMenuItem(
                            icon: Icons.shopping_bag_outlined,
                            title: 'Siparişlerim',
                            subtitle: isActuallyAnonymous
                                ? 'Hesap oluşturun'
                                : 'Geçmiş siparişleri görüntüle',
                            onTap: isActuallyAnonymous
                                ? () => showGuestUpgradeDialog(context)
                                : () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const OrdersListPage(),
                                      ),
                                    );
                                  },
                          ),
                          ModernMenuItem(
                            icon: Icons.location_on_outlined,
                            title: 'Adreslerim',
                            subtitle: isActuallyAnonymous
                                ? 'Hesap oluşturun'
                                : 'Teslimat adreslerini yönet',
                            onTap: isActuallyAnonymous
                                ? () => showGuestUpgradeDialog(context)
                                : () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AddressesListPage(),
                                      ),
                                    );
                                  },
                          ),
                          ModernMenuItem(
                            icon: Icons.calendar_today_outlined,
                            title: 'Randevularım',
                            subtitle: isActuallyAnonymous
                                ? 'Hesap oluşturun'
                                : 'Aktif ve geçmiş randevular',
                            onTap: isActuallyAnonymous
                                ? () => showGuestUpgradeDialog(context)
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
                      ModernMenuSection(
                        title: 'Uygulama',
                        items: [
                          ModernMenuItem(
                            icon: Icons.notifications_outlined,
                            title: 'Bildirimlerim',
                            subtitle: isActuallyAnonymous
                                ? 'Hesap oluşturun'
                                : 'Bildirimlerinizi görüntüleyin',
                            onTap: isActuallyAnonymous
                                ? () => showGuestUpgradeDialog(context)
                                : () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NotificationsListPage(),
                                      ),
                                    );
                                  },
                          ),
                          ModernMenuItem(
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
                          ModernMenuItem(
                            icon: Icons.info_outline,
                            title: 'Hakkında',
                            subtitle: 'Uygulama bilgisi',
                            onTap: () => showProfileAboutDialog(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Authentication Buttons for Guest Users
                      if (isActuallyAnonymous)
                        ModernMenuSection(
                          title: 'Hesap',
                          items: [
                            ModernMenuItem(
                              icon: Icons.login,
                              title: 'Giriş Yap',
                              subtitle: 'Mevcut hesabınızla giriş yapın',
                              onTap: () => _navigateToLogin(context),
                            ),
                            ModernMenuItem(
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
                          child: ModernMenuItem(
                            icon: Icons.logout,
                            title: 'Çıkış Yap',
                            subtitle: 'Hesabınızdan çıkış yapın',
                            isDestructive: true,
                            onTap: () => showLogoutDialog(context, ref),
                          ),
                        ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
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
}
