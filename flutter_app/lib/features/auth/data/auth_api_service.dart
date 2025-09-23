import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/fcm_service.dart';

class AuthApiService {
  final ApiClient _apiClient = ApiClient.instance;

  // Register - Firebase ile kullanıcı oluştur, sonra backend'e kaydet
  Future<AuthResponse> register(RegisterRequest request) async {
    print(
        '🚀 AuthApiService: Starting registration for email: ${request.email}');
    UserCredential? userCredential;

    try {
      // Firebase'de kullanıcı oluştur
      print('🚀 AuthApiService: Creating Firebase user...');
      userCredential = await FirebaseAuthService.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      print('🚀 AuthApiService: Firebase user created successfully');

      if (userCredential?.user == null) {
        throw Exception('Failed to create Firebase user');
      }

      // Firebase kullanıcısı başarıyla oluşturuldu
      print('🚀 AuthApiService: Firebase user created successfully');

      // Backend'e kullanıcı bilgilerini gönder
      print('🚀 AuthApiService: Sending registration request to backend...');
      print('🚀 AuthApiService: Firebase UID: ${userCredential!.user!.uid}');

      // FCM token'ı al
      final fcmToken = await FCMService.getFCMToken();
      print('🚀 AuthApiService: FCM Token: $fcmToken');

      final formData = FormData.fromMap({
        'name': request.name,
        'phone': request.phone,
        'email': request.email,
        'password': request.password,
        if (fcmToken != null) 'fcm_token': fcmToken,
      });

      // Firebase ID token'ı al ve Authorization header'a ekle
      final idToken = await userCredential.user!.getIdToken();

      final response = await _apiClient.postMultipart(
        ApiEndpoints.authRegister,
        formData,
        headers: {
          'Authorization': 'Bearer $idToken',
        },
      );
      print('🚀 AuthApiService: Backend registration successful');

      // Backend'den dönen user profile'ını kullan
      final userProfile = UserProfile.fromJson(response.data['user']);

      // Firebase'den token'ları al (backend'den boş gelebilir)
      final idToken = await userCredential.user!.getIdToken();
      final refreshToken =
          await userCredential.user!.getIdToken(true); // Force refresh

      return AuthResponse(
        userId: response.data['user_id'],
        user: userProfile,
        idToken: idToken ?? '',
        refreshToken: refreshToken ?? '',
        expiresIn: 3600, // Firebase default
      );
    } catch (e) {
      print('🚀 AuthApiService: Registration failed with error: $e');
      print('🚀 AuthApiService: Error type: ${e.runtimeType}');

      // Firebase kullanıcısını temizle (sadece Firebase hatası durumunda)
      if (userCredential?.user != null) {
        // Sadece Firebase'de kullanıcı oluşturma hatası durumunda temizle
        if (e.toString().contains('email-already-in-use') ||
            e.toString().contains('Bu e-posta zaten kayıtlı')) {
          print(
              '🚀 AuthApiService: Firebase user creation failed, cleaning up...');
          try {
            await userCredential!.user!.delete();
            await FirebaseAuthService.signOut();
            print('🚀 AuthApiService: Firebase user cleaned up');
          } catch (cleanupError) {
            print(
                '🚀 AuthApiService: Failed to cleanup Firebase user: $cleanupError');
            await FirebaseAuthService.signOut(); // En azından sign out yap
          }
        }
      }

      print('🚀 AuthApiService: Rethrowing error');
      // Hata mesajını yeniden fırlat
      rethrow;
    }
  }

  // Login - Firebase ile giriş yap
  Future<AuthResponse> login(LoginRequest request) async {
    // Firebase ile giriş yap
    final userCredential = await FirebaseAuthService.signInWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );

    if (userCredential?.user == null) {
      throw Exception('Failed to sign in with Firebase');
    }

    // Firebase ID token'ı al
    final idToken = await userCredential!.user!.getIdToken();

    // FCM token'ı backend'e gönder
    final fcmToken = await FCMService.getFCMToken();
    if (fcmToken != null) {
      try {
        final formData = FormData.fromMap({
          'email': request.email,
          'password': request.password,
          'fcm_token': fcmToken,
        });

        await _apiClient.postMultipart(
          ApiEndpoints.authLogin,
          formData,
        );
        print('🚀 AuthApiService: FCM token updated on login');
      } catch (e) {
        print('🚀 AuthApiService: Failed to update FCM token: $e');
        // FCM token güncelleme hatası login'i engellemez
      }
    }

    // User profile'ını çek
    final userProfile = await getCurrentUser();

    return AuthResponse(
      userId: userCredential.user!.uid,
      user: userProfile,
      idToken: idToken ?? '',
      refreshToken: '', // Firebase doesn't use refresh tokens in the same way
      expiresIn: 3600, // Firebase tokens expire in 1 hour
    );
  }

  // Reset Password - Firebase ile şifre sıfırlama
  Future<void> resetPassword(String email) async {
    await FirebaseAuthService.sendPasswordResetEmail(email);
  }

  // Logout - Backend logout endpoint'ini çağır, sonra Firebase'den çık
  Future<void> logout() async {
    print('🚀 AuthApiService: Starting logout process');

    try {
      // Backend logout endpoint'ini çağır
      final idToken = await FirebaseAuthService.getIdToken();
      if (idToken != null) {
        print('🚀 AuthApiService: Calling backend logout endpoint');
        await _apiClient.post(
          ApiEndpoints.authLogout,
          options: Options(
            headers: {
              'Authorization': 'Bearer $idToken',
            },
          ),
        );
        print('🚀 AuthApiService: Backend logout successful');
      } else {
        print('🚀 AuthApiService: No ID token found, skipping backend logout');
      }
    } catch (e) {
      print('🚀 AuthApiService: Backend logout failed: $e');
      // Continue with Firebase logout even if backend call fails
    } finally {
      // Firebase'den çık
      print('🚀 AuthApiService: Signing out from Firebase');
      await FirebaseAuthService.signOut();
      print('🚀 AuthApiService: Firebase logout completed');
    }
  }

  // Get current user profile
  Future<UserProfile> getCurrentUser() async {
    final response = await _apiClient.get(ApiEndpoints.userProfile);
    return UserProfile.fromJson(response.data);
  }
}
