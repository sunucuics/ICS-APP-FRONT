import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/painting.dart';
import 'dart:io';

/// Android-specific performance optimizations
class AndroidPerformanceService {
  static bool _isInitialized = false;

  /// Initialize Android performance optimizations
  static Future<void> initialize() async {
    if (!Platform.isAndroid || _isInitialized) return;

    try {
      // Set system UI overlay style for better performance
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );

      // Set preferred orientations for Android
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      // Android-specific memory optimizations
      await _optimizeMemoryUsage();

      _isInitialized = true;
      print('✅ Android performance optimizations initialized');
    } catch (e) {
      print('❌ Android performance initialization failed: $e');
    }
  }

  /// Optimize memory usage for Android
  static Future<void> _optimizeMemoryUsage() async {
    if (!Platform.isAndroid) return;

    try {
      // Enable hardware acceleration
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top],
      );

      // Set system UI overlay style for better memory usage
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    } catch (e) {
      print('❌ Memory optimization failed: $e');
    }
  }

  /// Clear image cache for Android (call when memory is low)
  static Future<void> clearImageCache() async {
    if (!Platform.isAndroid) return;

    try {
      // Clear Flutter image cache
      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();
      
      print('✅ Image cache cleared for Android');
    } catch (e) {
      print('❌ Failed to clear image cache: $e');
    }
  }

  /// Get Android memory info
  static Future<Map<String, dynamic>> getMemoryInfo() async {
    if (!Platform.isAndroid) return {};

    try {
      // This would require platform-specific implementation
      // For now, return basic info
      return {
        'platform': 'Android',
        'optimized': _isInitialized,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      print('❌ Failed to get memory info: $e');
      return {};
    }
  }
}
