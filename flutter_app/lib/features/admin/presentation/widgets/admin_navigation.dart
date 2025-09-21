import 'package:flutter/material.dart';
import '../pages/admin_categories_page.dart';
import '../pages/admin_products_page.dart';
import '../pages/admin_orders_page.dart';
import '../pages/admin_appointments_page.dart';
import '../pages/admin_discounts_page.dart';
import '../pages/admin_services_page.dart';
import '../pages/admin_users_page.dart';
import '../pages/admin_comments_page.dart';
import '../pages/admin_analytics_page.dart';
import '../pages/admin_notifications_page.dart';
import '../pages/admin_settings_page.dart';

class AdminNavigation extends StatelessWidget {
  const AdminNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                context,
                Icons.dashboard,
                'Dashboard',
                0,
                () => _navigateToTab(context, 0),
              ),
              _buildNavItem(
                context,
                Icons.category,
                'Kategoriler',
                1,
                () => _navigateToTab(context, 1),
              ),
              _buildNavItem(
                context,
                Icons.inventory,
                'Ürünler',
                2,
                () => _navigateToTab(context, 2),
              ),
              _buildNavItem(
                context,
                Icons.shopping_cart,
                'Siparişler',
                3,
                () => _navigateToTab(context, 3),
              ),
              _buildNavItem(
                context,
                Icons.event,
                'Randevular',
                4,
                () => _navigateToTab(context, 4),
              ),
              _buildNavItem(
                context,
                Icons.local_offer,
                'İndirimler',
                5,
                () => _navigateToTab(context, 5),
              ),
              _buildNavItem(
                context,
                Icons.work,
                'Hizmetler',
                6,
                () => _navigateToTab(context, 6),
              ),
              _buildNavItem(
                context,
                Icons.people,
                'Kullanıcılar',
                7,
                () => _navigateToTab(context, 7),
              ),
              _buildNavItem(
                context,
                Icons.comment,
                'Yorumlar',
                8,
                () => _navigateToTab(context, 8),
              ),
              _buildNavItem(
                context,
                Icons.analytics,
                'Analytics',
                9,
                () => _navigateToTab(context, 9),
              ),
              _buildNavItem(
                context,
                Icons.notifications,
                'Bildirimler',
                10,
                () => _navigateToTab(context, 10),
              ),
              _buildNavItem(
                context,
                Icons.settings,
                'Ayarlar',
                11,
                () => _navigateToTab(context, 11),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 20,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 9,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToTab(BuildContext context, int tabIndex) {
    switch (tabIndex) {
      case 0:
        // Dashboard - already handled by the parent
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AdminCategoriesPage(),
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AdminProductsPage(),
          ),
        );
        break;
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AdminOrdersPage(),
          ),
        );
        break;
      case 4:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AdminAppointmentsPage(),
          ),
        );
        break;
      case 5:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AdminDiscountsPage(),
          ),
        );
        break;
      case 6:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AdminServicesPage(),
          ),
        );
        break;
      case 7:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AdminUsersPage(),
          ),
        );
        break;
      case 8:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AdminCommentsPage(),
          ),
        );
        break;
      case 9:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AdminAnalyticsPage(),
          ),
        );
        break;
      case 10:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AdminNotificationsPage(),
          ),
        );
        break;
      case 11:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AdminSettingsPage(),
          ),
        );
        break;
    }
  }
}
