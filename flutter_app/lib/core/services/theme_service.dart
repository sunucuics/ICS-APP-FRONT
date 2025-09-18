import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String _themeKey = 'theme_mode';

  // Singleton pattern
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  ThemeService._internal();

  // Theme mode notifier
  final ValueNotifier<ThemeMode> _themeModeNotifier =
      ValueNotifier(ThemeMode.system);
  ValueNotifier<ThemeMode> get themeModeNotifier => _themeModeNotifier;

  // Get current theme mode
  ThemeMode get currentThemeMode => _themeModeNotifier.value;

  // Initialize theme service
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);

    if (savedTheme != null) {
      _themeModeNotifier.value = _stringToThemeMode(savedTheme);
    } else {
      // Default to system theme
      _themeModeNotifier.value = ThemeMode.system;
    }
  }

  // Set theme mode
  Future<void> setThemeMode(ThemeMode themeMode) async {
    _themeModeNotifier.value = themeMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, _themeModeToString(themeMode));
  }

  // Toggle between light and dark themes
  Future<void> toggleTheme() async {
    final currentMode = _themeModeNotifier.value;

    if (currentMode == ThemeMode.light) {
      await setThemeMode(ThemeMode.dark);
    } else if (currentMode == ThemeMode.dark) {
      await setThemeMode(ThemeMode.light);
    } else {
      // If system, check system brightness and set opposite
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      if (brightness == Brightness.light) {
        await setThemeMode(ThemeMode.dark);
      } else {
        await setThemeMode(ThemeMode.light);
      }
    }
  }

  // Convert ThemeMode to string for storage
  String _themeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  // Convert string to ThemeMode
  ThemeMode _stringToThemeMode(String themeString) {
    switch (themeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  // Get theme mode display name
  String getThemeModeDisplayName(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'Açık Tema';
      case ThemeMode.dark:
        return 'Koyu Tema';
      case ThemeMode.system:
        return 'Sistem Teması';
    }
  }

  // Get theme mode description
  String getThemeModeDescription(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'Her zaman açık tema kullan';
      case ThemeMode.dark:
        return 'Her zaman koyu tema kullan';
      case ThemeMode.system:
        return 'Cihaz ayarlarına göre tema seç';
    }
  }

  // Dispose resources
  void dispose() {
    _themeModeNotifier.dispose();
  }
}
