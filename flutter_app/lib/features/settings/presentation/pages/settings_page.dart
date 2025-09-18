import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/theme/app_theme.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tema Ayarları
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.palette,
                        color: AppTheme.primaryOrange,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Tema Ayarları',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                _buildThemeOption(
                  context,
                  ref,
                  ThemeMode.system,
                  'Sistem Teması',
                  'Cihaz ayarlarına göre tema seç',
                  Icons.settings_suggest,
                  themeMode,
                ),
                const Divider(height: 1),
                _buildThemeOption(
                  context,
                  ref,
                  ThemeMode.light,
                  'Açık Tema',
                  'Her zaman açık tema kullan',
                  Icons.light_mode,
                  themeMode,
                ),
                const Divider(height: 1),
                _buildThemeOption(
                  context,
                  ref,
                  ThemeMode.dark,
                  'Koyu Tema',
                  'Her zaman koyu tema kullan',
                  Icons.dark_mode,
                  themeMode,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Uygulama Bilgileri
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppTheme.primaryOrange,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Uygulama Bilgileri',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                _buildInfoItem(
                  context,
                  'Sürüm',
                  '1.0.0',
                  Icons.info,
                ),
                const Divider(height: 1),
                _buildInfoItem(
                  context,
                  'Geliştirici',
                  'ICS Team',
                  Icons.person,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Hakkında
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: AppTheme.primaryOrange,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Yardım & Destek',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                _buildActionItem(
                  context,
                  'Yardım Merkezi',
                  'SSS ve kullanım kılavuzu',
                  Icons.help,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Yardım merkezi yakında eklenecek'),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                _buildActionItem(
                  context,
                  'İletişim',
                  'Bizimle iletişime geçin',
                  Icons.contact_support,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('İletişim sayfası yakında eklenecek'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref,
    ThemeMode mode,
    String title,
    String subtitle,
    IconData icon,
    ThemeMode currentMode,
  ) {
    final isSelected = currentMode == mode;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppTheme.primaryOrange : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? AppTheme.primaryOrange : null,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: AppTheme.primaryOrange,
            )
          : null,
      onTap: () {
        ref.read(themeModeProvider.notifier).setThemeMode(mode);
      },
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Text(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
