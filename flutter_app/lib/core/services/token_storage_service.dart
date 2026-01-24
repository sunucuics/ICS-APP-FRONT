import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
}
