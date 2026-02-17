import 'dart:async';
import 'package:dio/dio.dart';
import '../../services/firebase_auth_service.dart';
import '../../services/navigation_service.dart';
import '../../services/token_storage_service.dart';
import '../../utils/error_utils.dart';
import '../../utils/logger.dart';
import '../../../features/auth/data/auth_api_service.dart';
import '../../../features/auth/services/mock_anonymous_auth_service.dart';

class AuthInterceptor extends Interceptor {
  /// Completer tabanlı lock mekanizması.
  /// null = refresh yok, non-null = refresh devam ediyor.
  /// Tüm 401 alan istekler aynı Completer'ı bekler.
  /// Completer String? ile tamamlanır: yeni token (başarılı) veya null (başarısız).
  static Completer<String?>? _refreshCompleter;

  /// Interceptor state'ini sıfırla.
  /// Logout ve login öncesi çağrılmalı.
  /// Devam eden bir refresh varsa null ile tamamlar (bekleyen istekler başarısız olur).
  static void reset() {
    if (_refreshCompleter != null && !_refreshCompleter!.isCompleted) {
      AppLogger.debug('AuthInterceptor.reset(): Completing pending refresh with null');
      _refreshCompleter!.complete(null);
    }
    _refreshCompleter = null;
    AppLogger.debug('AuthInterceptor.reset(): State cleared');
  }

  /// Geçici hata mı (timeout, network) kontrol et
  bool _isTemporaryError(dynamic error) => ErrorUtils.isTemporaryError(error);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Public endpoints that don't require authentication
    final publicPaths = [
      '/products',
      '/services',
      '/categories',
      '/featured',
      '/auth/login',
      '/auth/register',
      '/auth/reset-password',
      '/auth/refresh',
    ];

    final isPublicEndpoint =
        publicPaths.any((path) => options.path.startsWith(path));

    // For all endpoints, add token if available
    final token = await _getAuthToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    } else if (!isPublicEndpoint) {
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
        AppLogger.debug(
            'AuthInterceptor: Using access token from secure storage');
        return accessToken;
      }

      // Fallback: Firebase'den token al (eski sistemle uyumluluk için)
      AppLogger.debug(
          'AuthInterceptor: No token in storage, trying Firebase');
      return await FirebaseAuthService.getIdToken();
    } catch (e) {
      AppLogger.error('Error getting auth token', e);
      return null;
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
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

    // Zaten retry edilmiş ise tekrar deneme
    if (originalRequest.extra['_retried'] == true) {
      AppLogger.debug('AuthInterceptor: Request already retried, giving up');
      handler.next(err);
      return;
    }

    // Session revoked ise doğrudan çıkış
    final errorDetail = err.response?.data?['detail'] as String?;
    if (errorDetail == 'Session revoked') {
      AppLogger.warning(
          'AUTH_REDIRECT | reason: session_revoked | path: ${originalRequest.path} | status: ${err.response?.statusCode} | uid: ${FirebaseAuthService.currentUser?.uid ?? 'null'}');
      await TokenStorageService.clearTokens();
      await FirebaseAuthService.signOut();
      NavigationService.navigateToWelcome();
      handler.next(err);
      return;
    }

    // Anonymous/guest kullanıcı kontrolü
    try {
      final firebaseUser = FirebaseAuthService.currentUser;
      if (firebaseUser?.isAnonymous == true) {
        AppLogger.debug(
            'AuthInterceptor: Firebase guest user 401 error, not redirecting');
        handler.next(err);
        return;
      }

      final mockAuthService = MockAnonymousAuthService();
      if (mockAuthService.isAnonymous) {
        AppLogger.debug(
            'AuthInterceptor: Mock guest user 401 error, not redirecting');
        handler.next(err);
        return;
      }
    } catch (e) {
      AppLogger.error('AuthInterceptor: Error checking user type', e);
    }

    // --- Completer tabanlı refresh koordinasyonu ---
    // Zaten bir refresh devam ediyorsa, aynı Completer'ı bekle
    if (_refreshCompleter != null) {
      AppLogger.debug(
          'AuthInterceptor: Refresh already in progress, waiting for result...');
      final newToken = await _refreshCompleter!.future;
      if (newToken != null) {
        // Refresh başarılı → bu isteği yeni token ile tekrar dene
        await _retryRequest(originalRequest, handler, newToken);
      } else {
        // Refresh başarısız → bu isteği de başarısız döndür
        handler.next(err);
      }
      return;
    }

    // Bu istek refresh'i başlatan ilk istek
    _refreshCompleter = Completer<String?>();

    try {
      AppLogger.debug('AuthInterceptor: Starting token refresh...');

      final refreshToken = await TokenStorageService.getRefreshToken();
      if (refreshToken == null) {
        AppLogger.warning('AuthInterceptor: No refresh token found');
        throw Exception('No refresh token available');
      }

      // AuthApiService.refreshToken() ayrı Dio instance kullanır,
      // bu interceptor'dan geçmez - döngüsel sorun olmaz
      final authApiService = AuthApiService();
      final authResponse = await authApiService.refreshToken(refreshToken);

      final newAccessToken = authResponse.idToken;
      AppLogger.success(
          'AuthInterceptor: Token refreshed successfully');

      // Completer'ı tamamla → bekleyen tüm istekler yeni token'ı alır
      _refreshCompleter!.complete(newAccessToken);
      _refreshCompleter = null;

      // Bu isteği yeni token ile tekrar dene
      await _retryRequest(originalRequest, handler, newAccessToken);
    } catch (e) {
      AppLogger.error('AuthInterceptor: Token refresh failed', e);

      // Completer'ı null ile tamamla → bekleyen istekler başarısız olur
      if (_refreshCompleter != null && !_refreshCompleter!.isCompleted) {
        _refreshCompleter!.complete(null);
      }
      _refreshCompleter = null;

      // Geçici hata mı yoksa gerçek auth hatası mı?
      if (_isTemporaryError(e)) {
        AppLogger.warning(
            'AUTH_REDIRECT | reason: temporary_error_kept_session | path: ${originalRequest.path} | status: ${err.response?.statusCode} | error: ${e.runtimeType}');
        handler.next(err);
      } else {
        // Gerçek auth hatası → token'ları temizle, Firebase signOut ve çıkış yap
        AppLogger.warning(
            'AUTH_REDIRECT | reason: auth_error_refresh_failed | path: ${originalRequest.path} | status: ${err.response?.statusCode} | error: ${e.runtimeType} | uid: ${FirebaseAuthService.currentUser?.uid ?? 'null'}');
        await TokenStorageService.clearTokens();
        await FirebaseAuthService.signOut();
        NavigationService.navigateToWelcome();
        handler.next(err);
      }
    }
  }

  /// İsteği yeni token ile tekrar dene.
  /// Future<void> döner (fire-and-forget değil, düzgün hata yönetimi).
  Future<void> _retryRequest(
    RequestOptions originalRequest,
    ErrorInterceptorHandler handler,
    String newToken,
  ) async {
    try {
      originalRequest.extra['_retried'] = true;

      // FormData istekleri tekrar denenemez (finalized hatası)
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
