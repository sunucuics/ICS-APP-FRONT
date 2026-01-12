import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/fcm_service.dart';
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

      // Client-first'te backend token'ları boş döner, Firebase'deki token'ları kullan
      return AuthResponse(
        userId: response.data['user_id'],
        user: userProfile,
        idToken: idToken ?? '', // Firebase'den alınan token
        refreshToken: '', // Firebase otomatik yönetir
        expiresIn: 3600, // Firebase default
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
          
          return AuthResponse(
            userId: userCredential!.user!.uid,
            user: userProfile,
            idToken: await userCredential.user!.getIdToken() ?? '',
            refreshToken: '',
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

  // Login - Firebase ile giriş yap (önerilen yaklaşım)
  Future<AuthResponse> login(LoginRequest request) async {
    AppLogger.info(
        'AuthApiService: Starting Firebase login for email: ${AppLogger.maskEmail(request.email)}');

    try {
      // 1. Firebase ile giriş yap - Android için timeout artırıldı
      final userCredential =
          await FirebaseAuthService.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      if (userCredential?.user == null) {
        throw Exception('Failed to sign in with Firebase');
      }

      AppLogger.success('AuthApiService: Firebase login successful');

      // 2. Token refresh timeout optimizasyonu - force refresh yapma
      final idToken = await userCredential!.user!.getIdToken(false);
      AppLogger.debug('AuthApiService: Got fresh ID token');

      // 3. FCM token'ı backend'e gönder (opsiyonel)
      // FCM token güncellemesi FCMService.updateTokenToBackend() ile yapılıyor
      // Burada tekrar çağırmaya gerek yok

      // 4. User profile'ını çek
      final userProfile = await getCurrentUser();

      return AuthResponse(
        userId: userCredential.user!.uid,
        user: userProfile,
        idToken: idToken ?? '',
        refreshToken: '', // Firebase otomatik yönetir
        expiresIn: 3600, // Firebase tokens expire in 1 hour
      );
    } catch (e, stackTrace) {
      AppLogger.error('AuthApiService: Login failed', e, stackTrace);
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
      // 1. Backend logout endpoint'ini çağır (tüm refresh token'ları iptal eder)
      final idToken = await FirebaseAuthService.getIdToken();
      if (idToken != null) {
        AppLogger.debug('AuthApiService: Calling backend logout endpoint');
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
    } catch (e) {
      AppLogger.warning('AuthApiService: Backend logout failed', e);
      // Continue with Firebase logout even if backend call fails
    } finally {
      // 2. Firebase'den çık
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
