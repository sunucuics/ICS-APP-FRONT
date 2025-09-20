import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/firebase_auth_service.dart';

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
      final formData = FormData.fromMap({
        'name': request.name,
        'phone': request.phone,
        'email': request.email,
        'password': request.password,
        'firebase_uid': userCredential.user!.uid,
      });

      final response = await _apiClient.postMultipart(
        ApiEndpoints.authRegister,
        formData,
      );
      print('🚀 AuthApiService: Backend registration successful');

      // Backend'den dönen user profile'ını kullan
      final userProfile = UserProfile.fromJson(response.data['user']);

      return AuthResponse(
        userId: response.data['user_id'],
        user: userProfile,
        idToken: response.data['id_token'],
        refreshToken: response.data['refresh_token'],
        expiresIn: response.data['expires_in'],
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
    try {
      // Backend logout endpoint'ini çağır
      final idToken = await FirebaseAuthService.getIdToken();
      if (idToken != null) {
        await _apiClient.post(
          ApiEndpoints.authLogout,
          options: Options(
            headers: {
              'Authorization': 'Bearer $idToken',
            },
          ),
        );
      }
    } catch (e) {
      print('Backend logout failed: $e');
      // Continue with Firebase logout even if backend call fails
    } finally {
      // Firebase'den çık
      await FirebaseAuthService.signOut();
    }
  }

  // Get current user profile
  Future<UserProfile> getCurrentUser() async {
    final response = await _apiClient.get(ApiEndpoints.userProfile);
    return UserProfile.fromJson(response.data);
  }
}
