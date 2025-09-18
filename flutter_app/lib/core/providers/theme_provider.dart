import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/theme_service.dart';

// Theme service provider
final themeServiceProvider = Provider<ThemeService>((ref) {
  return ThemeService();
});

// Theme mode provider
final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final themeService = ref.watch(themeServiceProvider);
  return ThemeModeNotifier(themeService);
});

// Theme mode notifier class
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final ThemeService _themeService;

  ThemeModeNotifier(this._themeService) : super(ThemeMode.system) {
    _initializeTheme();
  }

  Future<void> _initializeTheme() async {
    await _themeService.initialize();
    state = _themeService.currentThemeMode;

    // Listen to theme service changes
    _themeService.themeModeNotifier.addListener(_onThemeChanged);
  }

  void _onThemeChanged() {
    state = _themeService.currentThemeMode;
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _themeService.setThemeMode(themeMode);
    state = themeMode;
  }

  Future<void> toggleTheme() async {
    await _themeService.toggleTheme();
    state = _themeService.currentThemeMode;
  }

  String getThemeModeDisplayName(ThemeMode themeMode) {
    return _themeService.getThemeModeDisplayName(themeMode);
  }

  String getThemeModeDescription(ThemeMode themeMode) {
    return _themeService.getThemeModeDescription(themeMode);
  }

  @override
  void dispose() {
    _themeService.themeModeNotifier.removeListener(_onThemeChanged);
    super.dispose();
  }
}

// Theme data provider for light theme
final lightThemeProvider = Provider<ThemeData>((ref) {
  // Import AppTheme from the existing theme file
  // This will be imported in the main.dart file
  throw UnimplementedError('This provider should be overridden in main.dart');
});

// Theme data provider for dark theme
final darkThemeProvider = Provider<ThemeData>((ref) {
  // Import AppTheme from the existing theme file
  // This will be overridden in the main.dart file
  throw UnimplementedError('This provider should be overridden in main.dart');
});
