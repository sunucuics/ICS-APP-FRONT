import 'package:dio/dio.dart';
import '../api_client.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Protected endpoints that require authentication
    final protectedPaths = [
      '/users',
      '/cart',
      '/orders',
      '/appointments',
      '/comments',
      '/auth/logout',
    ];

    // Check if this request needs authentication
    final needsAuth =
        protectedPaths.any((path) => options.path.startsWith(path));

    if (needsAuth) {
      final token = await ApiClient.getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized - token expired
    if (err.response?.statusCode == 401) {
      // Try to refresh token
      await _handleTokenRefresh(err, handler);
    } else {
      handler.next(err);
    }
  }

  Future<void> _handleTokenRefresh(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final refreshToken = await ApiClient.getRefreshToken();

      if (refreshToken != null) {
        // TODO: Firebase token refresh implementasyonu
        // Şimdilik sadece token'ları temizleyip hata döndürelim
        await ApiClient.clearAllAuthData();
      }

      // Token refresh başarısız, user'ı login'e yönlendir
      handler.next(err);
    } catch (e) {
      // Refresh failed, clear tokens and redirect to login
      await ApiClient.clearAllAuthData();
      handler.next(err);
    }
  }
}
