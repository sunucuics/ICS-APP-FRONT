import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// Modern menu section widget
class ModernMenuSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const ModernMenuSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
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
}

/// Modern menu item widget
class ModernMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const ModernMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkTheme ? Colors.black : Colors.white;
    final textColor = isDarkTheme ? Colors.white : Colors.black;
    final subtitleColor = isDarkTheme ? Colors.white70 : Colors.black87;
    final iconColor = isDarkTheme ? AppTheme.primaryNavy : AppTheme.primaryNavy;
    final iconBgColor = isDarkTheme
        ? AppTheme.primaryNavy.withOpacity(0.2)
        : AppTheme.primaryNavy.withOpacity(0.1);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryNavy,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
        ],
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
                        ? AppTheme.errorRed.withOpacity(0.2)
                        : iconBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: isDestructive ? AppTheme.errorRed : iconColor,
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
                          color: isDestructive ? AppTheme.errorRed : textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: subtitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: subtitleColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
