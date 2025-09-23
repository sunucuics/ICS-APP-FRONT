import 'package:flutter/material.dart';

/// Brand color tokens for section-based accent system
@immutable
class BrandColors extends ThemeExtension<BrandColors> {
  final Color storeOrange;
  final Color serviceBlue;
  final Color storeOrangeHover;
  final Color serviceBlueHover;
  final Color storeOrangePressed;
  final Color serviceBluePressed;

  const BrandColors({
    required this.storeOrange,
    required this.serviceBlue,
    required this.storeOrangeHover,
    required this.serviceBlueHover,
    required this.storeOrangePressed,
    required this.serviceBluePressed,
  });

  @override
  BrandColors copyWith({
    Color? storeOrange,
    Color? serviceBlue,
    Color? storeOrangeHover,
    Color? serviceBlueHover,
    Color? storeOrangePressed,
    Color? serviceBluePressed,
  }) =>
      BrandColors(
        storeOrange: storeOrange ?? this.storeOrange,
        serviceBlue: serviceBlue ?? this.serviceBlue,
        storeOrangeHover: storeOrangeHover ?? this.storeOrangeHover,
        serviceBlueHover: serviceBlueHover ?? this.serviceBlueHover,
        storeOrangePressed: storeOrangePressed ?? this.storeOrangePressed,
        serviceBluePressed: serviceBluePressed ?? this.serviceBluePressed,
      );

  @override
  BrandColors lerp(ThemeExtension<BrandColors>? other, double t) {
    if (other is! BrandColors) return this;
    return BrandColors(
      storeOrange: Color.lerp(storeOrange, other.storeOrange, t)!,
      serviceBlue: Color.lerp(serviceBlue, other.serviceBlue, t)!,
      storeOrangeHover: Color.lerp(storeOrangeHover, other.storeOrangeHover, t)!,
      serviceBlueHover: Color.lerp(serviceBlueHover, other.serviceBlueHover, t)!,
      storeOrangePressed: Color.lerp(storeOrangePressed, other.storeOrangePressed, t)!,
      serviceBluePressed: Color.lerp(serviceBluePressed, other.serviceBluePressed, t)!,
    );
  }

  /// Light theme brand colors
  static const BrandColors light = BrandColors(
    storeOrange: Color(0xFFFF6A00),      // ORANGE/600
    serviceBlue: Color(0xFF1E2DFF),      // BLUE/600
    storeOrangeHover: Color(0xFFFF7F26), // ORANGE/500
    serviceBlueHover: Color(0xFF3C4CFF), // BLUE/500
    storeOrangePressed: Color(0xFFE05800), // ORANGE/700
    serviceBluePressed: Color(0xFF1620CC), // BLUE/700
  );

  /// Dark theme brand colors (same as light for now)
  static const BrandColors dark = BrandColors(
    storeOrange: Color(0xFFFF6A00),      // ORANGE/600
    serviceBlue: Color(0xFF1E2DFF),      // BLUE/600
    storeOrangeHover: Color(0xFFFF7F26), // ORANGE/500
    serviceBlueHover: Color(0xFF3C4CFF), // BLUE/500
    storeOrangePressed: Color(0xFFE05800), // ORANGE/700
    serviceBluePressed: Color(0xFF1620CC), // BLUE/700
  );
}
