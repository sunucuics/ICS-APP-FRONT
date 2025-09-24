import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

/// Android crash prevention and error handling
class CrashPreventionService {
  static bool _isInitialized = false;

  /// Initialize crash prevention for Android
  static Future<void> initialize() async {
    if (!Platform.isAndroid || _isInitialized) return;

    try {
      // Set up global error handling for Android
      FlutterError.onError = (FlutterErrorDetails details) {
        if (kDebugMode) {
          FlutterError.presentError(details);
        } else {
          // In release mode, log error and prevent crash
          _handleError(details.exception, details.stack);
        }
      };

      // Set up platform error handling
      PlatformDispatcher.instance.onError = (error, stack) {
        _handleError(error, stack);
        return true; // Prevent crash
      };

      _isInitialized = true;
      print('✅ Crash prevention service initialized for Android');
    } catch (e) {
      print('❌ Crash prevention initialization failed: $e');
    }
  }

  /// Handle errors gracefully
  static void _handleError(dynamic error, StackTrace? stack) {
    if (!Platform.isAndroid) return;

    try {
      print('🚨 Android Error Caught: $error');
      if (stack != null) {
        print('📊 Stack Trace: $stack');
      }

      // Log error details for debugging
      _logError(error, stack);
    } catch (e) {
      print('❌ Error handling failed: $e');
    }
  }

  /// Log error details
  static void _logError(dynamic error, StackTrace? stack) {
    try {
      final timestamp = DateTime.now().toIso8601String();
      final errorInfo = {
        'timestamp': timestamp,
        'platform': 'Android',
        'error': error.toString(),
        'stack': stack?.toString(),
      };

      // In production, you would send this to a crash reporting service
      print('📝 Error logged: $errorInfo');
    } catch (e) {
      print('❌ Error logging failed: $e');
    }
  }

  /// Safe widget builder that prevents crashes
  static Widget safeBuilder(
    BuildContext context,
    Widget Function() builder, {
    Widget? fallback,
  }) {
    try {
      return builder();
    } catch (e) {
      _handleError(e, StackTrace.current);
      return fallback ?? const _ErrorFallback();
    }
  }

  /// Safe async operation
  static Future<T?> safeAsync<T>(
    Future<T> Function() operation, {
    T? fallback,
  }) async {
    try {
      return await operation();
    } catch (e) {
      _handleError(e, StackTrace.current);
      return fallback;
    }
  }
}

/// Error fallback widget
class _ErrorFallback extends StatelessWidget {
  const _ErrorFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Bir hata oluştu',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
