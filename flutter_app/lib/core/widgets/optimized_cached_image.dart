import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';

/// Android-optimized cached network image widget
class OptimizedCachedImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;

  const OptimizedCachedImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        width: width,
        height: height,
        // Android performance optimizations
        memCacheWidth: Platform.isAndroid ? 300 : null,
        memCacheHeight: Platform.isAndroid ? 300 : null,
        maxWidthDiskCache: Platform.isAndroid ? 800 : null,
        maxHeightDiskCache: Platform.isAndroid ? 800 : null,
        // Android-specific timeout
        httpHeaders: Platform.isAndroid
            ? {
                'Connection': 'keep-alive',
                'Cache-Control': 'max-age=3600',
              }
            : null,
        placeholder: (context, url) => Container(
          color: backgroundColor ??
              Theme.of(context).colorScheme.surfaceContainerHighest,
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: backgroundColor ??
              Theme.of(context).colorScheme.surfaceContainerHighest,
          child: const Icon(
            Icons.image_not_supported,
            size: 48,
          ),
        ),
        // Android memory optimization
        fadeInDuration: Platform.isAndroid
            ? const Duration(milliseconds: 200)
            : const Duration(milliseconds: 300),
        fadeOutDuration: Platform.isAndroid
            ? const Duration(milliseconds: 100)
            : const Duration(milliseconds: 200),
      ),
    );
  }
}
