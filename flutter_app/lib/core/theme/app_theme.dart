import 'package:flutter/material.dart';
import 'brand_colors.dart';
import 'app_section.dart';

class AppTheme {
  // Primary Brand Colors
  static const Color primaryOrange = Color(0xFFFF6B35);
  static const Color secondaryOrange = Color(0xFFFF8C42);
  static const Color lightOrange = Color(0xFFFFB366);
  static const Color darkOrange = Color(0xFFE55A2B);

  // Navy Blue Color Palette (Services)
  static const Color primaryNavy = Color(0xFF1A237E);
  static const Color secondaryNavy = Color(0xFF283593);
  static const Color lightNavy = Color(0xFF3949AB);
  static const Color darkNavy = Color(0xFF0D1B69);

  // Service Card Blue
  static const Color serviceCardBlue = Color(0xFF0505B5);

  // WhatsApp Green Color Palette
  static const Color whatsappGreen = Color(0xFF25D366);
  static const Color whatsappGreenLight = Color(0xFF4AE54A);
  static const Color whatsappGreenDark = Color(0xFF128C7E);

  // Studio Colors
  static const Color studioBlack = Color(0xFF000000);
  static const Color categoryCardLightOrange = Color(0xFFFFE0B2);
  static const Color categoryCardTransparentOrange =
      Color(0x40FF6B35); // Daha şeffaf turuncu

  // Studio letter colors
  static const Color studioS = Color(0xFF2196F3); // Mavi
  static const Color studioT = Color(0xFFFF6B35); // Turuncu
  static const Color studioU = Color(0xFF4CAF50); // Yeşil
  static const Color studioD = Color(0xFFF44336); // Kırmızı
  static const Color studioI = Color(0xFFFFC107); // Sarı
  static const Color studioO = Color(0xFFE91E63); // Pembe

  // New Design System Colors
  // Light Theme Colors
  static const Color lightBackground =
      Color(0xFFF6F7F9); // BG/Primary - gri iç sayfa zemini
  static const Color lightSurface =
      Color(0xFFFFFFFF); // BG/Surface - kart/alt bar
  static const Color lightSurfaceVariant = Color(0xFFF1F3F4);
  static const Color lightOnBackground = Color(0xFF111111); // Text/High
  static const Color lightOnSurface = Color(0xFF111111); // Text/High
  static const Color lightOnSurfaceVariant = Color(0xFF5F6B7A); // Text/Med
  static const Color lightOutline = Color(0xFFE6E8EC); // Divider
  static const Color lightOutlineVariant = Color(0xFFE8EAED);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0F1115); // BG/Primary
  static const Color darkSurface = Color(0xFF171A20); // BG/Surface
  static const Color darkSurfaceVariant = Color(0xFF2C2C2E);
  static const Color darkOnBackground = Color(0xFFFFFFFF); // Text/High
  static const Color darkOnSurface = Color(0xFFFFFFFF); // Text/High
  static const Color darkOnSurfaceVariant = Color(0xFFB7C1CE); // Text/Med
  static const Color darkOutline = Color(0xFF252A33); // Divider
  static const Color darkOutlineVariant = Color(0xFF2A2A2C);

  // Status Colors (tüm uygulama ortak)
  static const Color successGreen = Color(0xFF22C55E);
  static const Color warningYellow = Color(0xFFF59E0B);
  static const Color errorRed = Color(0xFFEF4444);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackground,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFFF6A00), // Store Orange (default)
      onPrimary: Colors.white,
      secondary: Color(0xFF1E2DFF), // Service Blue
      onSecondary: Colors.white,
      tertiary: Color(0xFF22C55E), // Success Green
      onTertiary: Colors.white,
      surface: lightSurface,
      onSurface: lightOnSurface,
      background: lightBackground,
      onBackground: lightOnBackground,
      error: errorRed,
      onError: Colors.white,
      outline: lightOutline,
      surfaceContainerHighest: lightSurfaceVariant,
      onSurfaceVariant: lightOnSurfaceVariant,
    ),
    extensions: const [BrandColors.light],
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: lightSurface,
      foregroundColor: lightOnSurface,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: lightOnSurface,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: lightOnSurface),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryOrange,
        foregroundColor: Colors.white,
        elevation: 3,
        shadowColor: primaryOrange.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryOrange,
        side: const BorderSide(color: primaryOrange, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: lightOutline.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      color: lightSurface,
      surfaceTintColor: Colors.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: lightOutline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: lightOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryOrange, width: 2),
      ),
      filled: true,
      fillColor: lightSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: lightSurface,
      indicatorColor: primaryOrange.withValues(alpha: 0.15),
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: primaryOrange,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          );
        }
        return TextStyle(
          color: lightOnSurfaceVariant,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(
            color: primaryOrange,
            size: 26,
          );
        }
        return IconThemeData(
          color: lightOnSurfaceVariant,
          size: 24,
        );
      }),
      height: 80,
      surfaceTintColor: Colors.transparent,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: lightOnBackground,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: lightOnBackground,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: lightOnBackground,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: lightOnBackground,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: lightOnBackground,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: lightOnBackground,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: lightOnBackground,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: lightOnSurfaceVariant,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: lightOnSurfaceVariant,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFF6A00), // Store Orange (default)
      onPrimary: Colors.white,
      secondary: Color(0xFF1E2DFF), // Service Blue
      onSecondary: Colors.white,
      tertiary: Color(0xFF22C55E), // Success Green
      onTertiary: Color(0xFF0B1A0F),
      surface: darkSurface,
      onSurface: darkOnSurface,
      background: darkBackground,
      onBackground: darkOnBackground,
      error: Color(0xFFF87171),
      onError: Color(0xFF1A1A1A),
      outline: darkOutline,
      surfaceVariant: darkSurfaceVariant,
      onSurfaceVariant: darkOnSurfaceVariant,
    ),
    extensions: const [BrandColors.dark],
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: darkSurface,
      foregroundColor: darkOnSurface,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: darkOnSurface,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: darkOnSurface),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryOrange,
        foregroundColor: Colors.white,
        elevation: 6,
        shadowColor: primaryOrange.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryOrange,
        side: const BorderSide(color: primaryOrange, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: darkOutline.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      color: darkSurface,
      surfaceTintColor: Colors.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: darkOutline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: darkOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryOrange, width: 2),
      ),
      filled: true,
      fillColor: darkSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: darkSurface,
      indicatorColor: primaryOrange.withValues(alpha: 0.25),
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: primaryOrange,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          );
        }
        return TextStyle(
          color: darkOnSurfaceVariant,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(
            color: primaryOrange,
            size: 26,
          );
        }
        return IconThemeData(
          color: darkOnSurfaceVariant,
          size: 24,
        );
      }),
      height: 80,
      surfaceTintColor: Colors.transparent,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: darkOnBackground,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: darkOnBackground,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: darkOnBackground,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: darkOnBackground,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: darkOnBackground,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: darkOnBackground,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: darkOnBackground,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: darkOnSurfaceVariant,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: darkOnSurfaceVariant,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ),
  );

  /// Section-based theme override for accent colors
  static ThemeData themedForSection(BuildContext context, AppSection section) {
    final base = Theme.of(context);
    final brand = Theme.of(context).extension<BrandColors>()!;

    switch (section) {
      case AppSection.services:
        return base.copyWith(
          colorScheme: base.colorScheme.copyWith(
            primary: brand.serviceBlue,
            secondary: brand.serviceBlue,
          ),
          navigationBarTheme: base.navigationBarTheme.copyWith(
            indicatorColor: brand.serviceBlue.withValues(alpha: 0.15),
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return TextStyle(
                  color: brand.serviceBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                );
              }
              return base.navigationBarTheme.labelTextStyle?.resolve(states);
            }),
            iconTheme: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return IconThemeData(
                  color: brand.serviceBlue,
                  size: 26,
                );
              }
              return base.navigationBarTheme.iconTheme?.resolve(states);
            }),
          ),
        );
      case AppSection.store:
        return base.copyWith(
          colorScheme: base.colorScheme.copyWith(
            primary: brand.storeOrange,
            secondary: brand.storeOrange,
          ),
          navigationBarTheme: base.navigationBarTheme.copyWith(
            indicatorColor: brand.storeOrange.withValues(alpha: 0.15),
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return TextStyle(
                  color: brand.storeOrange,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                );
              }
              return base.navigationBarTheme.labelTextStyle?.resolve(states);
            }),
            iconTheme: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return IconThemeData(
                  color: brand.storeOrange,
                  size: 26,
                );
              }
              return base.navigationBarTheme.iconTheme?.resolve(states);
            }),
          ),
        );
      default:
        return base; // Neutral theme for home, cart, profile
    }
  }
}
