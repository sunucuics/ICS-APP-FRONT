import 'package:dio/dio.dart';
import '../../services/firebase_auth_service.dart';
import '../../services/navigation_service.dart';

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

    // For public endpoints, add token if available
    // For protected endpoints, require authentication
    if (isPublicEndpoint) {
      // Public endpoint - add token if available
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
    try {
      // Get fresh ID token from Firebase (auto-refreshes if needed)
      return await FirebaseAuthService.getIdToken();
    } catch (e) {
      print('Error getting Firebase ID token: $e');
      return null;
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized
    if (err.response?.statusCode == 401) {
      await _handleTokenRefresh(err, handler);
    } else {
      handler.next(err);
    }
  }

  Future<void> _handleTokenRefresh(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final originalRequest = err.requestOptions;
    
    // Check if this request has already been retried
    if (originalRequest.extra['_retried'] == true) {
      handler.next(err);
      return;
    }

    // Get error detail from response
    final errorDetail = err.response?.data?['detail'] as String?;
    
    // If session is revoked, don't retry
    if (errorDetail == 'Session revoked') {
      print('Session revoked, redirecting to login');
      NavigationService.navigateToLogin();
      handler.next(err);
      return;
    }

    try {
      // Force refresh the token
      final freshToken = await FirebaseAuthService.getIdToken(forceRefresh: true);
      
      if (freshToken != null) {
        // Mark request as retried
        originalRequest.extra['_retried'] = true;
        originalRequest.headers['Authorization'] = 'Bearer $freshToken';
        
        // Retry the original request
        final dio = Dio();
        final response = await dio.fetch(originalRequest);
        handler.resolve(response);
        return;
      }
    } catch (e) {
      print('Token refresh failed: $e');
    }

    // If we get here, token refresh failed
    handler.next(err);
  }
}
