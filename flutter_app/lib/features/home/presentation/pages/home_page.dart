import 'package:flutter/material.dart';
import '../widgets/home_tab.dart';
import '../widgets/services_tab.dart';
import '../widgets/catalog_tab.dart';
import '../widgets/cart_tab.dart';
import '../widgets/profile_tab.dart';

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
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          NavigationDestination(
            icon: Icon(Icons.work),
            label: 'Hizmetler',
          ),
          NavigationDestination(
            icon: Icon(Icons.store),
            label: 'Mağaza',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Sepet',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
