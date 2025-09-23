import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/home_tab.dart';
import '../widgets/services_tab.dart';
import '../widgets/cart_tab.dart';
import '../widgets/catalog_tab_new.dart';
import '../widgets/profile_tab.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../cart/providers/cart_provider.dart';
import '../../../admin/providers/admin_provider.dart';
import '../../../admin/presentation/pages/admin_dashboard_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  void switchToTab(int tabIndex) {
    setState(() {
      _currentIndex = tabIndex;
    });
  }

  late final List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      HomeTab(onNavigateToTab: switchToTab),
      const ServicesTab(),
      const CartTab(),
      const CatalogTabNew(),
      const ProfileTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = ref.watch(isAdminProvider);

    // If user is admin, show admin dashboard
    if (isAdmin) {
      return const AdminDashboardPage();
    }

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Anasayfa (Home)
              GestureDetector(
                onTap: () => switchToTab(0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home,
                      color: _currentIndex == 0
                          ? Colors.grey[700]
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 24,
                    ),
                    if (_currentIndex == 0)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
              // Hizmetler (Services)
              GestureDetector(
                onTap: () => switchToTab(1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.work,
                      color: _currentIndex == 1
                          ? AppTheme.primaryNavy
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 24,
                    ),
                    if (_currentIndex == 1)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryNavy,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
              // Sepet (Cart) - Central Button
              GestureDetector(
                onTap: () => switchToTab(2),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color:
                            const Color(0xFFFF6A00), // Brand orange background
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFF6A00),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF6A00)
                                .withOpacity(0.4), // Reduced brand orange glow
                            blurRadius: 12,
                            offset: const Offset(0, 3),
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: const Color(0xFFFF6A00).withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 0),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    // Cart badge
                    Consumer(
                      builder: (context, ref, child) {
                        final cartItemCount = ref.watch(cartItemCountProvider);
                        if (cartItemCount > 0) {
                          return Positioned(
                            right: -2,
                            top: -2,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 20,
                                minHeight: 20,
                              ),
                              child: Text(
                                '$cartItemCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
              // Mağaza (Store)
              GestureDetector(
                onTap: () => switchToTab(3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.store,
                      color: _currentIndex == 3
                          ? AppTheme.primaryOrange
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 24,
                    ),
                    if (_currentIndex == 3)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryOrange,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
              // Profil (Profile)
              GestureDetector(
                onTap: () => switchToTab(4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person,
                      color: _currentIndex == 4
                          ? Colors.grey[700]
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 24,
                    ),
                    if (_currentIndex == 4)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
