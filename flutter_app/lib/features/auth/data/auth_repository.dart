import '../../../core/models/user_model.dart';
import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/token_storage_service.dart';
import 'auth_api_service.dart';

class AuthRepository {
  final AuthApiService _authApiService = AuthApiService();

  // Login
  Future<AuthResponse> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    final response = await _authApiService.login(request);
    // Token'lar AuthApiService tarafından secure storage'a kaydediliyor
    return response;
  }

  // Register
  Future<AuthResponse> register({
    required String name,
    String? phone,
    required String email,
    required String password,
  }) async {
    final request = RegisterRequest(
      name: name,
      phone: phone,
      email: email,
      password: password,
    );

    final response = await _authApiService.register(request);
    // Token'lar AuthApiService tarafından secure storage'a kaydediliyor
    return response;
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    await _authApiService.resetPassword(email);
  }

  // Logout
  Future<void> logout() async {
    await _authApiService.logout();
    // Firebase handles token cleanup automatically
  }

  // Check if user is logged in
  // Sadece token'ların VAR olup olmadığını kontrol et (ağ çağrısı YOK)
  // Token refresh işlemi startup'ta değil, API çağrısı sırasında auth interceptor tarafından yapılır
  Future<bool> isLoggedIn() async {
    // Token'lar varsa kullanıcı giriş yapmış kabul et
    // Token expired olsa bile auth interceptor otomatik refresh yapacak
    final hasTokens = await TokenStorageService.hasTokens();
    if (hasTokens) {
      return true;
    }
    
    // Fallback: Firebase kontrolü (token yoksa)
    return FirebaseAuthService.isSignedIn;
  }

  // Refresh token ile yeni access token al
  Future<AuthResponse> refreshToken(String refreshToken) async {
    return await _authApiService.refreshToken(refreshToken);
  }

  // Get current user
  // Token varsa direkt API call yap - Firebase kontrolü gereksiz
  // Token yoksa veya geçersizse interceptor 401 handle edecek
  Future<UserProfile?> getCurrentUser() async {
    try {
      return await _authApiService.getCurrentUser();
    } catch (e) {
      print('Failed to get current user: $e');
      return null;
    }
  }

  // Get current user ID from Firebase
  Future<String?> getCurrentUserId() async {
    return FirebaseAuthService.userUid;
  }

  // Update user profile
  Future<UserProfile> updateProfile({
    String? name,
    String? phone,
    String? email,
  }) async {
    final request = ProfileUpdateRequest(
      name: name,
      phone: phone,
      email: email,
    );
    return await _authApiService.updateProfile(request);
  }
}
