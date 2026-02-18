import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/logger.dart';

/// Token'ları güvenli bir şekilde saklamak için servis
/// iOS Keychain ve Android Keystore kullanır
class TokenStorageService {
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // Storage key'leri
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _expiresAtKey = 'token_expires_at';

  /// Access token'ı kaydet
  static Future<void> saveAccessToken(String token) async {
    try {
      await _secureStorage.write(key: _accessTokenKey, value: token);
      AppLogger.debug('TokenStorageService: Access token saved');
    } catch (e) {
      AppLogger.error('TokenStorageService: Failed to save access token', e);
      rethrow;
    }
  }

  /// Refresh token'ı kaydet
  static Future<void> saveRefreshToken(String token) async {
    try {
      await _secureStorage.write(key: _refreshTokenKey, value: token);
      AppLogger.debug('TokenStorageService: Refresh token saved');
    } catch (e) {
      AppLogger.error('TokenStorageService: Failed to save refresh token', e);
      rethrow;
    }
  }

  /// Her iki token'ı da kaydet
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      await Future.wait([
        saveAccessToken(accessToken),
        saveRefreshToken(refreshToken),
      ]);
      AppLogger.debug('TokenStorageService: Both tokens saved');
    } catch (e) {
      AppLogger.error('TokenStorageService: Failed to save tokens', e);
      rethrow;
    }
  }

  /// Token'ları expire time ile birlikte kaydet
  /// Instagram gibi kalıcı oturum için - token expire olmadan önce refresh yapılır
  static Future<void> saveTokensWithExpiry({
    required String accessToken,
    required String refreshToken,
    required int expiresInSeconds,
  }) async {
    try {
      final expiresAt = DateTime.now().add(Duration(seconds: expiresInSeconds));
      await Future.wait([
        saveAccessToken(accessToken),
        saveRefreshToken(refreshToken),
        _secureStorage.write(key: _expiresAtKey, value: expiresAt.toIso8601String()),
      ]);
      AppLogger.debug('TokenStorageService: Tokens saved with expiry: $expiresAt');
    } catch (e) {
      AppLogger.error('TokenStorageService: Failed to save tokens with expiry', e);
      rethrow;
    }
  }

  /// Token'ın expire zamanını oku
  static Future<DateTime?> getExpiresAt() async {
    try {
      final expiresAtStr = await _secureStorage.read(key: _expiresAtKey);
      if (expiresAtStr == null) return null;
      return DateTime.parse(expiresAtStr);
    } catch (e) {
      AppLogger.error('TokenStorageService: Failed to read expires_at', e);
      return null;
    }
  }

  /// Token'ın expire olup olmadığını kontrol et
  static Future<bool> isTokenExpired() async {
    try {
      final expiresAt = await getExpiresAt();
      if (expiresAt == null) {
        // Expire zamanı bilinmiyorsa, expired kabul et (güvenli taraf)
        AppLogger.debug('TokenStorageService: No expires_at found, assuming expired');
        return true;
      }
      final isExpired = DateTime.now().isAfter(expiresAt);
      AppLogger.debug('TokenStorageService: Token expired: $isExpired (expires at: $expiresAt)');
      return isExpired;
    } catch (e) {
      AppLogger.error('TokenStorageService: Failed to check token expiry', e);
      return true;
    }
  }

  /// Token'ın refresh edilmesi gerekip gerekmediğini kontrol et
  /// Expire'dan 5 dakika önce true döner (proaktif refresh için)
  static Future<bool> shouldRefreshToken() async {
    try {
      final expiresAt = await getExpiresAt();
      if (expiresAt == null) {
        // Expire zamanı bilinmiyorsa optimistik davran: token geçerli kabul et.
        // Gerçekten expire olduysa interceptor 401→refresh→retry ile halleder.
        // true döndürmek çift refresh bug'ına neden oluyordu (proaktif + interceptor).
        AppLogger.debug('TokenStorageService: No expires_at found, assuming valid (interceptor will handle 401)');
        return false;
      }
      // 5 dakika kala refresh yap
      final refreshThreshold = expiresAt.subtract(const Duration(minutes: 5));
      final shouldRefresh = DateTime.now().isAfter(refreshThreshold);
      AppLogger.debug('TokenStorageService: Should refresh: $shouldRefresh (threshold: $refreshThreshold)');
      return shouldRefresh;
    } catch (e) {
      AppLogger.error('TokenStorageService: Failed to check if should refresh', e);
      return true;
    }
  }

  /// Access token'ı oku
  static Future<String?> getAccessToken() async {
    try {
      final token = await _secureStorage.read(key: _accessTokenKey);
      if (token != null) {
        AppLogger.debug('TokenStorageService: Access token retrieved');
      }
      return token;
    } catch (e) {
      AppLogger.error('TokenStorageService: Failed to read access token', e);
      return null;
    }
  }

  /// Refresh token'ı oku
  static Future<String?> getRefreshToken() async {
    try {
      final token = await _secureStorage.read(key: _refreshTokenKey);
      if (token != null) {
        AppLogger.debug('TokenStorageService: Refresh token retrieved');
      }
      return token;
    } catch (e) {
      AppLogger.error('TokenStorageService: Failed to read refresh token', e);
      return null;
    }
  }

  /// Token'ların var olup olmadığını kontrol et
  static Future<bool> hasTokens() async {
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      return accessToken != null && refreshToken != null;
    } catch (e) {
      AppLogger.error('TokenStorageService: Failed to check tokens', e);
      return false;
    }
  }

  /// Tüm token'ları sil
  static Future<void> clearTokens() async {
    try {
      await Future.wait([
        _secureStorage.delete(key: _accessTokenKey),
        _secureStorage.delete(key: _refreshTokenKey),
        _secureStorage.delete(key: _expiresAtKey),
      ]);
      AppLogger.debug('TokenStorageService: All tokens cleared');
    } catch (e) {
      AppLogger.error('TokenStorageService: Failed to clear tokens', e);
      // Hata olsa bile devam et
    }
  }

  /// Sadece access token'ı sil
  static Future<void> clearAccessToken() async {
    try {
      await _secureStorage.delete(key: _accessTokenKey);
      AppLogger.debug('TokenStorageService: Access token cleared');
    } catch (e) {
      AppLogger.error('TokenStorageService: Failed to clear access token', e);
    }
  }

  // --- Cached User Profile (SharedPreferences — hızlı okuma, startup fast path) ---

  static const String _cachedUserKey = 'cached_user_profile';

  /// User profile'ı SharedPreferences'a JSON olarak kaydet
  static Future<void> saveUserProfile(Map<String, dynamic> userJson) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cachedUserKey, jsonEncode(userJson));
      AppLogger.debug('TokenStorageService: User profile cached');
    } catch (e) {
      AppLogger.warning('TokenStorageService: Failed to cache user profile', e);
    }
  }

  /// Cached user profile'ı oku (hızlı, ağ çağrısı yok)
  static Future<Map<String, dynamic>?> getCachedUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = prefs.getString(_cachedUserKey);
      if (jsonStr == null) return null;
      return jsonDecode(jsonStr) as Map<String, dynamic>;
    } catch (e) {
      AppLogger.warning('TokenStorageService: Failed to read cached user profile', e);
      return null;
    }
  }

  /// Cached user profile'ı sil (logout sırasında)
  static Future<void> clearCachedUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cachedUserKey);
      AppLogger.debug('TokenStorageService: Cached user profile cleared');
    } catch (e) {
      AppLogger.warning('TokenStorageService: Failed to clear cached user profile', e);
    }
  }
}
