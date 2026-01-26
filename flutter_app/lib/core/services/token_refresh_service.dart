import '../utils/logger.dart';
import 'token_storage_service.dart';
import '../../features/auth/data/auth_api_service.dart';

/// Token yenileme servisi - Instagram gibi kalıcı oturum için
/// Uygulama açıldığında proaktif token refresh yapar
class TokenRefreshService {
  /// Token'ın geçerli olduğundan emin ol
  /// Token expired veya expire olmak üzere ise refresh yapar
  /// 
  /// Returns:
  /// - true: Token geçerli veya başarıyla yenilendi
  /// - false: Token yok veya refresh başarısız
  static Future<bool> ensureValidToken() async {
    try {
      AppLogger.debug('TokenRefreshService: Checking token validity...');
      
      // Token'ların var olup olmadığını kontrol et
      final hasTokens = await TokenStorageService.hasTokens();
      if (!hasTokens) {
        AppLogger.debug('TokenRefreshService: No tokens found');
        return false;
      }
      
      // Token expired veya expire olmak üzere mi?
      final shouldRefresh = await TokenStorageService.shouldRefreshToken();
      if (!shouldRefresh) {
        AppLogger.debug('TokenRefreshService: Token is still valid, no refresh needed');
        return true;
      }
      
      AppLogger.debug('TokenRefreshService: Token needs refresh, attempting...');
      
      // Refresh token'ı al
      final refreshToken = await TokenStorageService.getRefreshToken();
      if (refreshToken == null) {
        AppLogger.warning('TokenRefreshService: No refresh token found');
        return false;
      }
      
      // Token'ı yenile
      try {
        final authApiService = AuthApiService();
        await authApiService.refreshToken(refreshToken);
        AppLogger.success('TokenRefreshService: Token refreshed successfully');
        return true;
      } catch (e) {
        AppLogger.error('TokenRefreshService: Token refresh failed', e);
        // Refresh başarısız - token'ları temizle
        await TokenStorageService.clearTokens();
        return false;
      }
    } catch (e) {
      AppLogger.error('TokenRefreshService: Error ensuring valid token', e);
      return false;
    }
  }
  
  /// Token'ın geçerli olup olmadığını kontrol et (refresh yapmadan)
  /// 
  /// Returns:
  /// - true: Token var ve geçerli
  /// - false: Token yok veya expired
  static Future<bool> hasValidToken() async {
    try {
      final hasTokens = await TokenStorageService.hasTokens();
      if (!hasTokens) return false;
      
      final isExpired = await TokenStorageService.isTokenExpired();
      return !isExpired;
    } catch (e) {
      AppLogger.error('TokenRefreshService: Error checking token validity', e);
      return false;
    }
  }
  
  /// Zorla token refresh yap (expire olmamış olsa bile)
  /// 
  /// Returns:
  /// - true: Refresh başarılı
  /// - false: Refresh başarısız
  static Future<bool> forceRefresh() async {
    try {
      AppLogger.debug('TokenRefreshService: Force refreshing token...');
      
      final refreshToken = await TokenStorageService.getRefreshToken();
      if (refreshToken == null) {
        AppLogger.warning('TokenRefreshService: No refresh token for force refresh');
        return false;
      }
      
      final authApiService = AuthApiService();
      await authApiService.refreshToken(refreshToken);
      AppLogger.success('TokenRefreshService: Force refresh successful');
      return true;
    } catch (e) {
      AppLogger.error('TokenRefreshService: Force refresh failed', e);
      return false;
    }
  }
}
