import 'package:flutter/foundation.dart';

/// Production-safe logger that masks sensitive data
class AppLogger {
  /// Mask email addresses - shows first 2 chars and domain
  static String maskEmail(String email) {
    if (email.isEmpty) return email;
    final parts = email.split('@');
    if (parts.length != 2) return '***';
    final local = parts[0];
    final domain = parts[1];
    if (local.length <= 2) {
      return '${local[0]}***@$domain';
    }
    return '${local.substring(0, 2)}***@$domain';
  }

  /// Mask password - shows only length
  static String maskPassword(String password) {
    return '*' * password.length;
  }

  /// Mask token - shows first 8 and last 4 chars
  static String maskToken(String token) {
    if (token.length <= 12) return '***';
    return '${token.substring(0, 8)}...${token.substring(token.length - 4)}';
  }

  /// Mask phone number - shows first 3 and last 2 digits
  static String maskPhone(String phone) {
    if (phone.length <= 5) return '***';
    final cleaned = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length <= 5) return '***';
    return '${cleaned.substring(0, 3)}***${cleaned.substring(cleaned.length - 2)}';
  }

  /// Mask any sensitive string
  static String maskSensitive(String value,
      {int visibleStart = 2, int visibleEnd = 2}) {
    if (value.length <= visibleStart + visibleEnd) return '***';
    return '${value.substring(0, visibleStart)}***${value.substring(value.length - visibleEnd)}';
  }

  /// Log debug message (only in debug mode)
  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      if (error != null) {
        debugPrint('🔍 DEBUG: $message');
        debugPrint('Error: $error');
        if (stackTrace != null) {
          debugPrint('Stack: $stackTrace');
        }
      } else {
        debugPrint('🔍 DEBUG: $message');
      }
    }
  }

  /// Log info message (only in debug mode)
  static void info(String message) {
    if (kDebugMode) {
      debugPrint('ℹ️ INFO: $message');
    }
  }

  /// Log warning message (always logged)
  static void warning(String message, [Object? error]) {
    if (kDebugMode) {
      debugPrint('⚠️ WARNING: $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
    }
  }

  /// Log error message (always logged, but sanitized in release)
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('❌ ERROR: $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrint('Stack: $stackTrace');
      }
    } else {
      // In release mode, only log generic error messages
      debugPrint('❌ ERROR: $message');
    }
  }

  /// Log success message (only in debug mode)
  static void success(String message) {
    if (kDebugMode) {
      debugPrint('✅ SUCCESS: $message');
    }
  }

  /// Log network request (only in debug mode, with sensitive data masked)
  static void network(String method, String path,
      {Map<String, dynamic>? data}) {
    if (kDebugMode) {
      debugPrint('🌐 $method $path');
      if (data != null) {
        final sanitized = sanitizeData(data);
        debugPrint('📦 Data: $sanitized');
      }
    }
  }

  /// Sanitize data by masking sensitive fields
  static Map<String, dynamic> sanitizeData(Map<String, dynamic> data) {
    final sanitized = <String, dynamic>{};
    final sensitiveFields = [
      'password',
      'token',
      'idToken',
      'refreshToken',
      'fcm_token',
      'fcmToken',
      'apiKey',
      'api_key',
      'secret',
      'secretKey',
      'secret_key'
    ];

    data.forEach((key, value) {
      final lowerKey = key.toLowerCase();
      if (sensitiveFields.any((field) => lowerKey.contains(field))) {
        if (value is String) {
          sanitized[key] = '***MASKED***';
        } else {
          sanitized[key] = '***MASKED***';
        }
      } else if (key.toLowerCase() == 'email' && value is String) {
        sanitized[key] = maskEmail(value);
      } else if (key.toLowerCase() == 'phone' && value is String) {
        sanitized[key] = maskPhone(value);
      } else {
        sanitized[key] = value;
      }
    });

    return sanitized;
  }
}
