import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class AdminNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const AdminNavigation({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20 + MediaQuery.of(context).padding.bottom),
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
              ),
              _buildNavItem(
                context,
                Icons.category,
                'Kategoriler',
                1,
              ),
              _buildNavItem(
                context,
                Icons.inventory,
                'Ürünler',
                2,
              ),
              _buildNavItem(
                context,
                Icons.shopping_cart,
                'Siparişler',
                3,
              ),
              _buildNavItem(
                context,
                Icons.event,
                'Randevular',
                4,
              ),
              _buildNavItem(
                context,
                Icons.local_offer,
                'İndirimler',
                5,
              ),
              _buildNavItem(
                context,
                Icons.work,
                'Hizmetler',
                6,
              ),
              _buildNavItem(
                context,
                Icons.people,
                'Kullanıcılar',
                7,
              ),
              _buildNavItem(
                context,
                Icons.comment,
                'Yorumlar',
                8,
              ),
              _buildNavItem(
                context,
                Icons.notifications,
                'Bildirimler',
                9,
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
  ) {
    final isSelected = currentIndex == index;
    final activeColor = AppTheme.primaryOrange; // Vurgu rengi
    final inactiveColor = Colors.grey; // Pasif renk

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? activeColor : inactiveColor,
              size: 20,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? activeColor : inactiveColor,
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
