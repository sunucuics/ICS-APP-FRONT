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
    UserCredential? userCredential;

    try {
      // Firebase'de kullanıcı oluştur
      userCredential = await FirebaseAuthService.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      if (userCredential?.user == null) {
        throw Exception('Failed to create Firebase user');
      }

      // Firebase ID token'ı al
      final idToken = await userCredential!.user!.getIdToken();

      // Backend'e kullanıcı bilgilerini gönder
      final formData = FormData.fromMap({
        'name': request.name,
        'phone': request.phone,
        'email': request.email,
        'password': request.password,
        'firebase_uid': userCredential.user!.uid,
      });

      await _apiClient.postMultipart(
        ApiEndpoints.authRegister,
        formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
          },
        ),
      );

      // User profile'ını çek
      final userProfile = await getCurrentUser();

      return AuthResponse(
        userId: userCredential.user!.uid,
        user: userProfile,
        idToken: idToken ?? '',
        refreshToken: '', // Firebase doesn't use refresh tokens in the same way
        expiresIn: 3600, // Firebase tokens expire in 1 hour
      );
    } catch (e) {
      // Backend'e kayıt başarısız olursa Firebase'deki hesabı da sil
      if (userCredential?.user != null) {
        try {
          await userCredential!.user!.delete();
          print('Firebase user deleted due to backend registration failure');
        } catch (deleteError) {
          print('Failed to delete Firebase user: $deleteError');
        }
      }

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
