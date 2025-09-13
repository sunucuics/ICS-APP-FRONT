import 'package:dio/dio.dart';
import '../api_client.dart';
import '../../../features/auth/providers/anonymous_auth_provider.dart'
    as anonymous;

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Public endpoints that don't require authentication
    final publicPaths = [
      '/products',
      '/services',
      '/categories',
      '/featured',
    ];

    // Check if this is a public endpoint
    final isPublicEndpoint =
        publicPaths.any((path) => options.path.startsWith(path));

    // For public endpoints, add token if available (for anonymous users)
    // For protected endpoints, require authentication
    if (isPublicEndpoint) {
      // Public endpoint - add token if available (anonymous users can access)
      final token = await _getAuthToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } else {
      // Protected endpoint - require authentication
      final token = await _getAuthToken();
      if (token == null) {
        // No token available, this will result in 401
        handler.next(options);
        return;
      }
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  Future<String?> _getAuthToken() async {
    // First try to get token from secure storage (for registered users)
    final storedToken = await ApiClient.getToken();
    if (storedToken != null) {
      return storedToken;
    }

    // For anonymous users, get mock token
    // In real implementation, this would be:
    // final user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   return await user.getIdToken();
    // }

    // For now, return a mock token for anonymous users
    return 'mock_anonymous_token';
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
