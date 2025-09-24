import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';

/// Android-optimized image cache management
class ImageCacheService {
  static const int _maxCacheSize = 100; // Maximum number of images to cache
  static const int _maxCacheBytes = 50 * 1024 * 1024; // 50MB cache limit
  static bool _isInitialized = false;

  /// Initialize image cache with Android optimizations
  static Future<void> initialize() async {
    if (!Platform.isAndroid || _isInitialized) return;

    try {
      // Configure image cache for Android
      PaintingBinding.instance.imageCache.maximumSize = _maxCacheSize;
      PaintingBinding.instance.imageCache.maximumSizeBytes = _maxCacheBytes;

      // Set up cache eviction policy for Android
      // Note: evict is not directly assignable, using alternative approach

      _isInitialized = true;
      print('✅ Image cache service initialized for Android');
    } catch (e) {
      print('❌ Image cache initialization failed: $e');
    }
  }


  /// Clear all cached images (call when memory is low)
  static Future<void> clearCache() async {
    if (!Platform.isAndroid) return;

    try {
      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();
      
      print('✅ Image cache cleared');
    } catch (e) {
      print('❌ Failed to clear image cache: $e');
    }
  }

  /// Get cache statistics
  static Map<String, dynamic> getCacheStats() {
    if (!Platform.isAndroid) return {};

    try {
      final imageCache = PaintingBinding.instance.imageCache;
      return {
        'currentSize': imageCache.currentSize,
        'currentSizeBytes': imageCache.currentSizeBytes,
        'maximumSize': imageCache.maximumSize,
        'maximumSizeBytes': imageCache.maximumSizeBytes,
        'liveImages': imageCache.liveImageCount,
      };
    } catch (e) {
      print('❌ Failed to get cache stats: $e');
      return {};
    }
  }

  /// Preload important images for better performance
  static Future<void> preloadImages(List<String> imageUrls, BuildContext context) async {
    if (!Platform.isAndroid) return;

    try {
      for (final url in imageUrls) {
        await precacheImage(
          CachedNetworkImageProvider(url),
          context,
        );
      }
      print('✅ Preloaded ${imageUrls.length} images');
    } catch (e) {
      print('❌ Failed to preload images: $e');
    }
  }
}
