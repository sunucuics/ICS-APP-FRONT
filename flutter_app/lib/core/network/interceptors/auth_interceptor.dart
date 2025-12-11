import 'package:dio/dio.dart';
import '../../services/firebase_auth_service.dart';
import '../../services/navigation_service.dart';
import '../../utils/logger.dart';
import '../../../features/auth/services/mock_anonymous_auth_service.dart';

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
      '/auth/login', // Login endpoint doesn't need auth
      '/auth/reset-password', // Reset password doesn't need auth
    ];

    // Check if this is a public endpoint
    final isPublicEndpoint =
        publicPaths.any((path) => options.path.startsWith(path));

    // For all endpoints, add token if available (client-first approach)
    final token = await _getAuthToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    } else if (!isPublicEndpoint) {
      // Protected endpoint without token - this will result in 401
      AppLogger.warning(
          'AuthInterceptor: No token available for protected endpoint: ${options.path}');
    }

    handler.next(options);
  }

  Future<String?> _getAuthToken() async {
    try {
      // Get fresh ID token from Firebase (auto-refreshes if needed)
      return await FirebaseAuthService.getIdToken();
    } catch (e) {
      AppLogger.error('Error getting Firebase ID token', e);
      return null;
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized
    if (err.response?.statusCode == 401) {
      AppLogger.debug(
          'AuthInterceptor: 401 Unauthorized for ${err.requestOptions.path}');
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
      AppLogger.debug('AuthInterceptor: Request already retried, giving up');
      handler.next(err);
      return;
    }

    // Get error detail from response
    final errorDetail = err.response?.data?['detail'] as String?;

    // If session is revoked, don't retry
    if (errorDetail == 'Session revoked') {
      AppLogger.warning(
          'AuthInterceptor: Session revoked, redirecting to login');
      NavigationService.navigateToLogin();
      handler.next(err);
      return;
    }

    // Check if user is anonymous/guest - don't redirect to login for guest users
    try {
      // Check Firebase Auth first
      final firebaseUser = FirebaseAuthService.currentUser;
      if (firebaseUser?.isAnonymous == true) {
        AppLogger.debug(
            'AuthInterceptor: Firebase guest user 401 error, not redirecting to login');
        handler.next(err);
        return;
      }

      // Check Mock Anonymous Auth Service
      final mockAuthService = MockAnonymousAuthService();
      if (mockAuthService.isAnonymous) {
        AppLogger.debug(
            'AuthInterceptor: Mock guest user 401 error, not redirecting to login');
        handler.next(err);
        return;
      }
    } catch (e) {
      AppLogger.error('AuthInterceptor: Error checking user type', e);
    }

    try {
      AppLogger.debug('AuthInterceptor: Attempting token refresh...');
      // Force refresh the token
      final freshToken =
          await FirebaseAuthService.getIdToken(forceRefresh: true);

      if (freshToken != null) {
        AppLogger.success(
            'AuthInterceptor: Token refreshed successfully, retrying request');
        // Mark request as retried
        originalRequest.extra['_retried'] = true;
        originalRequest.headers['Authorization'] = 'Bearer $freshToken';

        // Retry the original request with new FormData
        final dio = Dio();

        // Create completely new request to avoid FormData reuse
        // Don't retry FormData requests to avoid the finalized error
        if (originalRequest.data is FormData) {
          AppLogger.debug(
              'AuthInterceptor: Skipping FormData retry to avoid finalized error');
          handler.next(err);
          return;
        }

        final newRequest = RequestOptions(
          method: originalRequest.method,
          path: originalRequest.path,
          baseUrl: originalRequest.baseUrl,
          headers: {
            ...originalRequest.headers,
            'Authorization': 'Bearer $freshToken',
          },
          data: originalRequest.data,
          queryParameters: originalRequest.queryParameters,
          connectTimeout: originalRequest.connectTimeout,
          receiveTimeout: originalRequest.receiveTimeout,
          sendTimeout: originalRequest.sendTimeout,
          validateStatus: originalRequest.validateStatus,
          followRedirects: originalRequest.followRedirects,
          maxRedirects: originalRequest.maxRedirects,
          responseType: originalRequest.responseType,
          contentType: originalRequest.contentType,
          extra: originalRequest.extra,
        );

        final response = await dio.fetch(newRequest);
        handler.resolve(response);
        return;
      } else {
        AppLogger.warning('AuthInterceptor: Token refresh returned null');
      }
    } catch (e) {
      AppLogger.error('AuthInterceptor: Token refresh failed', e);
    }

    // If we get here, token refresh failed
    AppLogger.warning(
        'AuthInterceptor: Token refresh failed, redirecting to login');
    NavigationService.navigateToLogin();
    handler.next(err);
  }
}
