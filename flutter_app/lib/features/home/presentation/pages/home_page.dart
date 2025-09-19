import 'package:flutter/material.dart';
import '../widgets/home_tab.dart';
import '../widgets/services_tab.dart';
import '../widgets/cart_tab.dart';
import '../widgets/catalog_tab_new.dart';
import '../widgets/profile_tab.dart';
import '../../../../core/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _currentIndex == 2
                        ? AppTheme.primaryOrange
                        : AppTheme.primaryOrange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 24,
                  ),
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
