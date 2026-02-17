import 'package:dio/dio.dart';

/// Merkezi hata sınıflandırma utility'si.
/// Geçici hata (timeout, network) ile gerçek auth hatasını ayırt eder.
/// Tüm auth-related dosyalarda bu fonksiyon kullanılmalı.
class ErrorUtils {
  /// Geçici hata mı (timeout, network) yoksa gerçek auth hatası mı kontrol et.
  ///
  /// Geçici hatalar: timeout, connection error, network error, socket error
  /// Bu hatalarda kullanıcı oturumu KORUNMALI (logout yapılmamalı).
  ///
  /// Gerçek auth hataları: 401, invalid token, revoked token
  /// Bu hatalarda kullanıcı oturumu sonlandırılmalı.
  static bool isTemporaryError(dynamic error) {
    // DioException tipini kontrol et (en güvenilir yöntem)
    if (error is DioException) {
      return error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.connectionError;
    }

    // String tabanlı fallback (DioException olmayan hatalar için)
    final errorStr = error.toString().toLowerCase();
    return errorStr.contains('timeout') ||
        errorStr.contains('connection') ||
        errorStr.contains('network') ||
        errorStr.contains('socket') ||
        errorStr.contains('no_internet');
  }
}
