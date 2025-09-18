import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    IconData icon;
    String tooltip;

    switch (themeMode) {
      case ThemeMode.light:
        icon = Icons.dark_mode;
        tooltip = 'Koyu temaya geç';
        break;
      case ThemeMode.dark:
        icon = Icons.light_mode;
        tooltip = 'Açık temaya geç';
        break;
      case ThemeMode.system:
        icon = Icons.settings_suggest;
        tooltip = 'Tema ayarları';
        break;
    }

    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: () {
        ref.read(themeModeProvider.notifier).toggleTheme();
      },
    );
  }
}

class ThemeModeSelector extends ConsumerWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);

    return PopupMenuButton<ThemeMode>(
      icon: Icon(
        themeMode == ThemeMode.system
            ? Icons.settings_suggest
            : themeMode == ThemeMode.light
                ? Icons.light_mode
                : Icons.dark_mode,
      ),
      tooltip: 'Tema seç',
      onSelected: (ThemeMode mode) {
        themeNotifier.setThemeMode(mode);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.system,
          child: Row(
            children: [
              Icon(
                Icons.settings_suggest,
                color: themeMode == ThemeMode.system
                    ? AppTheme.primaryOrange
                    : null,
              ),
              const SizedBox(width: 12),
              Text(
                'Sistem Teması',
                style: TextStyle(
                  color: themeMode == ThemeMode.system
                      ? AppTheme.primaryOrange
                      : null,
                  fontWeight: themeMode == ThemeMode.system
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.light,
          child: Row(
            children: [
              Icon(
                Icons.light_mode,
                color: themeMode == ThemeMode.light
                    ? AppTheme.primaryOrange
                    : null,
              ),
              const SizedBox(width: 12),
              Text(
                'Açık Tema',
                style: TextStyle(
                  color: themeMode == ThemeMode.light
                      ? AppTheme.primaryOrange
                      : null,
                  fontWeight: themeMode == ThemeMode.light
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.dark,
          child: Row(
            children: [
              Icon(
                Icons.dark_mode,
                color:
                    themeMode == ThemeMode.dark ? AppTheme.primaryOrange : null,
              ),
              const SizedBox(width: 12),
              Text(
                'Koyu Tema',
                style: TextStyle(
                  color: themeMode == ThemeMode.dark
                      ? AppTheme.primaryOrange
                      : null,
                  fontWeight: themeMode == ThemeMode.dark
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
