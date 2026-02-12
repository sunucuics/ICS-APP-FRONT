import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/fcm_service.dart';
import '../../../core/services/token_storage_service.dart';
import '../../../core/utils/logger.dart';

class AuthApiService {
  final ApiClient _apiClient = ApiClient.instance;

  // Register - Client-first approach: Firebase ile kullanıcı oluştur, sonra backend'e profil yazdır
  Future<AuthResponse> register(RegisterRequest request) async {
    AppLogger.info(
        'AuthApiService: Starting client-first registration for email: ${AppLogger.maskEmail(request.email)}');
    UserCredential? userCredential;

    try {
      // 1. Firebase'de kullanıcı oluştur
      AppLogger.debug('AuthApiService: Creating Firebase user...');
      userCredential = await FirebaseAuthService.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      AppLogger.success('AuthApiService: Firebase user created successfully');

      if (userCredential?.user == null) {
        throw Exception('Failed to create Firebase user');
      }

      // 2. Taze ID token al (force refresh)
      final idToken = await userCredential!.user!.getIdToken(true);
      AppLogger.debug('AuthApiService: Got fresh ID token');

      // 3. FCM token'ı al
      final fcmToken = await FCMService.getFCMToken();
      AppLogger.debug('AuthApiService: FCM Token obtained');

      // 4. Backend'e profil yazdır (Authorization header ile)
      AppLogger.debug('AuthApiService: Sending profile to backend...');
      final formDataMap = <String, dynamic>{
        'name': request.name,
        'email': request.email,
        'password': request.password, // Backend validation için gerekli
        if (fcmToken != null) 'fcm_token': fcmToken,
      };
      // Add phone only if provided, otherwise send null
      if (request.phone != null && request.phone!.isNotEmpty) {
        formDataMap['phone'] =
            request.phone; // Backend expects "555 123 4567" format
      } else {
        formDataMap['phone'] = null; // Send null if phone is not provided
      }
      final formData = FormData.fromMap(formDataMap);

      final response = await _apiClient.postMultipart(
        ApiEndpoints.authRegister,
        formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
          },
        ),
      );
      AppLogger.success('AuthApiService: Backend profile creation successful');

      // 5. Backend'den dönen user profile'ını kullan
      final userProfile = UserProfile.fromJson(response.data['user']);

      // 6. Backend'den dönen token'ları al (eğer varsa)
      String finalIdToken = idToken ?? '';
      String finalRefreshToken = '';
      int finalExpiresIn = 3600;

      // Backend'den token döndüyse onları kullan (server-first yaklaşım)
      if (response.data['id_token'] != null && response.data['id_token'].toString().isNotEmpty) {
        finalIdToken = response.data['id_token'] as String;
        finalRefreshToken = response.data['refresh_token'] as String? ?? '';
        finalExpiresIn = response.data['expires_in'] as int? ?? 3600;
      } else {
        // Client-first yaklaşım: Backend token döndürmedi, login endpoint'ini çağırarak token al
        AppLogger.debug('AuthApiService: Backend did not return tokens, calling login endpoint...');
        try {
          final loginFormData = FormData.fromMap({
            'email': request.email,
            'password': request.password,
          });
          
          final loginResponse = await _apiClient.postMultipart(
            ApiEndpoints.authLogin,
            loginFormData,
          );
          
          finalIdToken = loginResponse.data['id_token'] as String;
          finalRefreshToken = loginResponse.data['refresh_token'] as String;
          finalExpiresIn = loginResponse.data['expires_in'] as int;
          
          AppLogger.debug('AuthApiService: Tokens obtained from login endpoint');
        } catch (loginError) {
          AppLogger.warning('AuthApiService: Failed to get tokens from login endpoint', loginError);
          // Token alınamazsa Firebase token'ını kullan (refresh token olmadan)
          // Bu durumda kullanıcı token yenileme yapamaz, tekrar login yapması gerekir
        }
      }

      // 7. Token'ları expire time ile birlikte kaydet (Instagram gibi kalıcı oturum için)
      if (finalRefreshToken.isNotEmpty) {
        await TokenStorageService.saveTokensWithExpiry(
          accessToken: finalIdToken,
          refreshToken: finalRefreshToken,
          expiresInSeconds: finalExpiresIn,
        );
        AppLogger.debug('AuthApiService: Tokens saved with expiry to secure storage');
      } else if (finalIdToken.isNotEmpty) {
        // Sadece access token varsa onu kaydet (refresh token olmadan)
        // Bu durumda expire time de kaydet
        await TokenStorageService.saveAccessToken(finalIdToken);
        AppLogger.warning('AuthApiService: Only access token saved (no refresh token)');
      }

      return AuthResponse(
        userId: response.data['user_id'],
        user: userProfile,
        idToken: finalIdToken,
        refreshToken: finalRefreshToken,
        expiresIn: finalExpiresIn,
      );
    } catch (e, stackTrace) {
      AppLogger.error('AuthApiService: Registration failed', e, stackTrace);

      // Eğer kullanıcı zaten kayıtlı hatası alındıysa, Firebase kullanıcısını temizleme
      // Çünkü kullanıcı zaten giriş yapmış durumda
      if (e.toString().contains('Bu kullanıcı zaten kayıtlı') ||
          e.toString().contains('Bu e-posta zaten kayıtlı')) {
        AppLogger.info(
            'AuthApiService: User already exists, keeping Firebase user signed in');

        // Kullanıcı zaten giriş yapmış, profil bilgilerini çek
        try {
          var userProfile = await getCurrentUser();
          
          // Eğer mevcut profilde isim boşsa, kayıt formundaki isimle güncelle
          if (userProfile.name == null || userProfile.name!.isEmpty) {
            AppLogger.info(
                'AuthApiService: Existing profile has no name, updating with registration name: ${request.name}');
            try {
              userProfile = await updateProfile(
                ProfileUpdateRequest(name: request.name),
              );
              AppLogger.success('AuthApiService: Profile name updated successfully');
            } catch (updateError) {
              AppLogger.warning(
                  'AuthApiService: Failed to update profile name', updateError);
              // Güncelleme başarısız olsa bile devam et
            }
          }
          
          // userCredential null check
          if (userCredential?.user == null) {
            throw Exception('UserCredential or user is null');
          }
          
          final existingIdToken = await userCredential!.user!.getIdToken() ?? '';
          
          // Token'ları secure storage'a kaydet (Firebase token'ları)
          // Not: Firebase refresh token'ı direkt alamıyoruz, bu durumda sadece ID token kaydediyoruz
          if (existingIdToken.isNotEmpty) {
            await TokenStorageService.saveAccessToken(existingIdToken);
            AppLogger.debug('AuthApiService: Existing token saved to secure storage');
          }

          return AuthResponse(
            userId: userCredential.user!.uid,
            user: userProfile,
            idToken: existingIdToken,
            refreshToken: '', // Firebase refresh token'ı direkt alamıyoruz
            expiresIn: 3600,
          );
        } catch (profileError) {
          AppLogger.error(
              'AuthApiService: Failed to get user profile', profileError);
          // Profil çekilemezse Firebase kullanıcısını temizle
          await userCredential!.user!.delete();
          await FirebaseAuthService.signOut();
          rethrow;
        }
      }

      // Diğer hatalar için Firebase kullanıcısını temizle
      if (userCredential?.user != null) {
        AppLogger.debug(
            'AuthApiService: Cleaning up Firebase user due to error...');
        try {
          await userCredential!.user!.delete();
          await FirebaseAuthService.signOut();
          AppLogger.debug('AuthApiService: Firebase user cleaned up');
        } catch (cleanupError) {
          AppLogger.error(
              'AuthApiService: Failed to cleanup Firebase user', cleanupError);
          await FirebaseAuthService.signOut(); // En azından sign out yap
        }
      }

      // Hata mesajını yeniden fırlat
      rethrow;
    }
  }

  // Login - Backend endpoint kullanarak login yap (refresh token almak için)
  Future<AuthResponse> login(LoginRequest request) async {
    AppLogger.info(
        'AuthApiService: Starting login for email: ${AppLogger.maskEmail(request.email)}');

    try {
      // 1. FCM token'ı al
      final fcmToken = await FCMService.getFCMToken();

      // 2. Backend login endpoint'ine istek gönder
      final formData = FormData.fromMap({
        'email': request.email,
        'password': request.password,
        if (fcmToken != null) 'fcm_token': fcmToken,
      });

      final response = await _apiClient.postMultipart(
        ApiEndpoints.authLogin,
        formData,
      );

      AppLogger.success('AuthApiService: Backend login successful');

      // 3. Backend'den dönen token'ları al
      final idToken = response.data['id_token'] as String;
      final refreshToken = response.data['refresh_token'] as String;
      final expiresIn = response.data['expires_in'] as int;
      final userId = response.data['user_id'] as String;

      // 4. Token'ları expire time ile birlikte kaydet (Instagram gibi kalıcı oturum için)
      await TokenStorageService.saveTokensWithExpiry(
        accessToken: idToken,
        refreshToken: refreshToken,
        expiresInSeconds: expiresIn,
      );
      AppLogger.debug('AuthApiService: Tokens saved with expiry to secure storage');

      // 5. Firebase'e de giriş yap (session persistence için)
      // Bu sayede uygulama yeniden açıldığında Firebase Auth state de persist edilir
      try {
        await FirebaseAuthService.signInWithEmailAndPassword(
          email: request.email,
          password: request.password,
        );
        AppLogger.debug('AuthApiService: Firebase sign-in successful for persistence');
      } catch (firebaseError) {
        // Firebase sign-in başarısız olsa bile devam et
        // Token-based auth çalışmaya devam edecek
        AppLogger.warning('AuthApiService: Firebase sign-in failed, continuing with token auth', firebaseError);
      }

      // 6. User profile'ını çek
      final userProfile = await getCurrentUser();

      return AuthResponse(
        userId: userId,
        user: userProfile,
        idToken: idToken,
        refreshToken: refreshToken,
        expiresIn: expiresIn,
      );
    } catch (e, stackTrace) {
      AppLogger.error('AuthApiService: Login failed', e, stackTrace);
      rethrow;
    }
  }

  // Refresh Token - Backend refresh endpoint'ini kullan
  // NOT: Bu method user profile çekmiyor çünkü token refresh sırasında
  // getCurrentUser() çağrısı döngüsel bağımlılık yaratır.
  // User profile gerekiyorsa, token refresh sonrası ayrıca çekilmeli.
  // ÖNEMLİ: Ayrı Dio instance kullanılıyor - interceptor'lardan geçmez, döngüsel sorun olmaz
  Future<AuthResponse> refreshToken(String refreshToken) async {
    AppLogger.info('AuthApiService: Refreshing token');

    try {
      // Ayrı Dio instance - interceptor'lardan geçmez, döngüsel sorun olmaz
      // Timeout'lar 30s - mobil ağda backend→Firebase zinciri yavaş olabilir
      final dio = Dio(BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ));

      // Backend refresh endpoint'ine istek gönder
      final response = await dio.post(
        ApiEndpoints.authRefresh,
        data: {
          'refresh_token': refreshToken,
        },
      );

      AppLogger.success('AuthApiService: Token refresh successful');

      // Yeni token'ları al
      final idToken = response.data['id_token'] as String;
      final newRefreshToken = response.data['refresh_token'] as String;
      final expiresIn = response.data['expires_in'] as int;

      // Token'ları expire time ile birlikte kaydet (Instagram gibi kalıcı oturum için)
      await TokenStorageService.saveTokensWithExpiry(
        accessToken: idToken,
        refreshToken: newRefreshToken,
        expiresInSeconds: expiresIn,
      );
      AppLogger.debug('AuthApiService: New tokens saved with expiry to secure storage');

      // User profile'ı burada çekmiyoruz - döngüsel bağımlılık önlenir
      // Caller gerekirse ayrıca getCurrentUser() çağırabilir
      return AuthResponse(
        userId: '', // Token refresh sonrası bilinmiyor
        user: const UserProfile(id: '', email: ''), // Placeholder profile
        idToken: idToken,
        refreshToken: newRefreshToken,
        expiresIn: expiresIn,
      );
    } catch (e, stackTrace) {
      AppLogger.error('AuthApiService: Token refresh failed', e, stackTrace);
      rethrow;
    }
  }

  // Reset Password - Backend endpoint kullan (FIREBASE_WEB_API_KEY gerekli)
  Future<void> resetPassword(String email) async {
    AppLogger.info(
        'AuthApiService: Sending password reset for email: ${AppLogger.maskEmail(email)}');

    try {
      // Backend endpoint'ini kullan (Firebase REST API proxy)
      await _apiClient.post(
        ApiEndpoints.authResetPassword,
        queryParameters: {'email': email},
      );
      AppLogger.success(
          'AuthApiService: Password reset email sent successfully');
    } catch (e) {
      AppLogger.error('AuthApiService: Password reset failed', e);
      // Fallback: Firebase SDK kullan
      AppLogger.debug('AuthApiService: Falling back to Firebase SDK...');
      await FirebaseAuthService.sendPasswordResetEmail(email);
    }
  }

  // Logout - Backend logout endpoint'ini çağır, sonra Firebase'den çık
  Future<void> logout() async {
    AppLogger.debug('AuthApiService: Starting logout process');

    try {
      // 1. Secure storage'dan access token al (eğer varsa)
      final accessToken = await TokenStorageService.getAccessToken();
      
      // 2. Backend logout endpoint'ini çağır (tüm refresh token'ları iptal eder)
      if (accessToken != null) {
        AppLogger.debug('AuthApiService: Calling backend logout endpoint');
        await _apiClient.post(
          ApiEndpoints.authLogout,
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
        );
        AppLogger.success('AuthApiService: Backend logout successful');
      } else {
        // Fallback: Firebase'den token al
        final idToken = await FirebaseAuthService.getIdToken();
        if (idToken != null) {
          AppLogger.debug('AuthApiService: Calling backend logout with Firebase token');
          await _apiClient.post(
            ApiEndpoints.authLogout,
            options: Options(
              headers: {
                'Authorization': 'Bearer $idToken',
              },
            ),
          );
          AppLogger.success('AuthApiService: Backend logout successful');
        } else {
          AppLogger.debug(
              'AuthApiService: No ID token found, skipping backend logout');
        }
      }
    } catch (e) {
      AppLogger.warning('AuthApiService: Backend logout failed', e);
      // Continue with cleanup even if backend call fails
    } finally {
      // 3. Token'ları secure storage'dan temizle
      await TokenStorageService.clearTokens();
      AppLogger.debug('AuthApiService: Tokens cleared from secure storage');

      // 4. Firebase'den çık
      AppLogger.debug('AuthApiService: Signing out from Firebase');
      await FirebaseAuthService.signOut();
      AppLogger.success('AuthApiService: Firebase logout completed');
    }
  }

  // Get current user profile
  Future<UserProfile> getCurrentUser() async {
    final response = await _apiClient.get(ApiEndpoints.userProfile);
    return UserProfile.fromJson(response.data);
  }

  // Update user profile
  Future<UserProfile> updateProfile(ProfileUpdateRequest request) async {
    AppLogger.info('AuthApiService: Updating user profile');
    
    try {
      // Get ID token for authorization
      final idToken = await FirebaseAuthService.getIdToken();
      if (idToken == null) {
        throw Exception('No ID token available. Please login again.');
      }

      // Prepare request data - only include non-null fields
      final data = <String, dynamic>{};
      if (request.name != null) {
        data['name'] = request.name;
      }
      if (request.phone != null) {
        data['phone'] = request.phone;
      }
      if (request.email != null) {
        data['email'] = request.email;
      }

      // Make PUT request to update profile
      final response = await _apiClient.put(
        ApiEndpoints.authUpdateProfile,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
          },
        ),
      );

      AppLogger.success('AuthApiService: Profile updated successfully');
      return UserProfile.fromJson(response.data);
    } catch (e, stackTrace) {
      AppLogger.error('AuthApiService: Profile update failed', e, stackTrace);
      rethrow;
    }
  }

  // Update FCM token
  Future<void> updateFcmToken(String fcmToken) async {
    try {
      await _apiClient.put(
        ApiEndpoints.userFcmToken,
        data: {'fcm_token': fcmToken},
      );
      AppLogger.debug('AuthApiService: FCM token updated successfully');
    } catch (e) {
      AppLogger.warning('AuthApiService: Failed to update FCM token', e);
      // Don't throw - FCM token update failure shouldn't break the app
    }
  }
}
