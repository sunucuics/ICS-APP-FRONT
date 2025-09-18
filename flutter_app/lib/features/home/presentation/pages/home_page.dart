import 'package:flutter/material.dart';
import '../widgets/home_tab.dart';
import '../widgets/services_tab.dart';
import '../widgets/catalog_tab.dart';
import '../widgets/cart_tab.dart';
import '../widgets/profile_tab.dart';
import '../../../../core/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _switchToTab(int tabIndex) {
    setState(() {
      _currentIndex = tabIndex;
    });
  }

  late final List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      HomeTab(onNavigateToTab: _switchToTab),
      const ServicesTab(),
      const CatalogTab(),
      const CartTab(),
      const ProfileTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceElevated,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 24,
              ),
              selectedIcon: Icon(
                Icons.home,
                color: Colors.white,
                size: 24,
              ),
              label: 'Ana Sayfa',
            ),
            NavigationDestination(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _currentIndex == 1
                      ? AppTheme.primaryNavy.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.work_outline,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              selectedIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryNavy.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.work,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              label: 'Hizmetler',
            ),
            NavigationDestination(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _currentIndex == 2
                      ? AppTheme.primaryOrange.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.store_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              selectedIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryOrange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.store,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              label: 'Mağaza',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: 24,
              ),
              selectedIcon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 24,
              ),
              label: 'Sepet',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 24,
              ),
              selectedIcon: Icon(
                Icons.person,
                color: Colors.white,
                size: 24,
              ),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
