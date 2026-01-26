import 'package:dio/dio.dart';
import '../../services/firebase_auth_service.dart';
import '../../services/navigation_service.dart';
import '../../services/token_storage_service.dart';
import '../../utils/logger.dart';
import '../../../features/auth/data/auth_api_service.dart';
import '../../../features/auth/services/mock_anonymous_auth_service.dart';

// Pending request için helper class
class _PendingRequest {
  final RequestOptions requestOptions;
  final ErrorInterceptorHandler handler;

  _PendingRequest(this.requestOptions, this.handler);
}

class AuthInterceptor extends Interceptor {
  // Token refresh işlemi için lock mekanizması
  static bool _isRefreshing = false;
  static final List<_PendingRequest> _pendingRequests = [];
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
      '/auth/register', // Register endpoint doesn't need auth
      '/auth/reset-password', // Reset password doesn't need auth
      '/auth/refresh', // Refresh endpoint doesn't need auth
    ];

    // Check if this is a public endpoint
    final isPublicEndpoint =
        publicPaths.any((path) => options.path.startsWith(path));

    // For all endpoints, add token if available
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
      // Önce secure storage'dan access token al
      final accessToken = await TokenStorageService.getAccessToken();
      if (accessToken != null) {
        AppLogger.debug('AuthInterceptor: Using access token from secure storage');
        return accessToken;
      }

      // Fallback: Firebase'den token al (eski sistemle uyumluluk için)
      AppLogger.debug('AuthInterceptor: No token in storage, trying Firebase');
      return await FirebaseAuthService.getIdToken();
    } catch (e) {
      AppLogger.error('Error getting auth token', e);
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
          'AuthInterceptor: Session revoked, redirecting to welcome page');
      await TokenStorageService.clearTokens();
      NavigationService.navigateToWelcome();
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

    // Eğer zaten bir refresh işlemi devam ediyorsa, bu isteği beklet
    if (_isRefreshing) {
      AppLogger.debug('AuthInterceptor: Token refresh already in progress, queuing request');
      _pendingRequests.add(_PendingRequest(originalRequest, handler));
      return;
    }

    // Refresh işlemini başlat
    _isRefreshing = true;

    try {
      AppLogger.debug('AuthInterceptor: Attempting token refresh...');

      // Secure storage'dan refresh token al
      final refreshToken = await TokenStorageService.getRefreshToken();
      if (refreshToken == null) {
        AppLogger.warning('AuthInterceptor: No refresh token found');
        throw Exception('No refresh token available');
      }

      // Backend refresh endpoint'ine istek gönder
      // NOT: AuthApiService.refreshToken() ayrı Dio instance kullanır,
      // bu interceptor'dan geçmez - döngüsel sorun olmaz
      // Token'lar expire time ile birlikte kaydedilir (Instagram gibi kalıcı oturum)
      final authApiService = AuthApiService();
      final authResponse = await authApiService.refreshToken(refreshToken);

      AppLogger.success('AuthInterceptor: Token refreshed successfully with expiry');

      // Yeni token'ları kullan (zaten secure storage'a kaydedildi)
      final newAccessToken = authResponse.idToken;

      // Bekleyen tüm istekleri yeni token ile tekrarla
      for (final pendingRequest in _pendingRequests) {
        _retryRequest(pendingRequest.requestOptions, pendingRequest.handler, newAccessToken);
      }
      _pendingRequests.clear();

      // Orijinal isteği yeni token ile tekrarla
      _retryRequest(originalRequest, handler, newAccessToken);
    } catch (e) {
      AppLogger.error('AuthInterceptor: Token refresh failed', e);

      // Refresh başarısız oldu, tüm bekleyen istekleri iptal et
      for (final pendingRequest in _pendingRequests) {
        pendingRequest.handler.next(err);
      }
      _pendingRequests.clear();

      // Token'ları temizle ve login sayfasına yönlendir
      await TokenStorageService.clearTokens();
      NavigationService.navigateToWelcome();
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  void _retryRequest(
    RequestOptions originalRequest,
    ErrorInterceptorHandler handler,
    String newToken,
  ) async {
    try {
      // Mark request as retried
      originalRequest.extra['_retried'] = true;
      originalRequest.headers['Authorization'] = 'Bearer $newToken';

      // Don't retry FormData requests to avoid the finalized error
      if (originalRequest.data is FormData) {
        AppLogger.debug(
            'AuthInterceptor: Skipping FormData retry to avoid finalized error');
        handler.next(DioException(
          requestOptions: originalRequest,
          error: 'FormData request cannot be retried',
        ));
        return;
      }

      final dio = Dio();

      final newRequest = RequestOptions(
        method: originalRequest.method,
        path: originalRequest.path,
        baseUrl: originalRequest.baseUrl,
        headers: {
          ...originalRequest.headers,
          'Authorization': 'Bearer $newToken',
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
    } catch (e) {
      AppLogger.error('AuthInterceptor: Failed to retry request', e);
      handler.next(DioException(
        requestOptions: originalRequest,
        error: e,
      ));
    }
  }
}
