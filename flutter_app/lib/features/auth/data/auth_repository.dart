import '../../../core/models/user_model.dart';
import '../../../core/services/firebase_auth_service.dart';
import 'auth_api_service.dart';

class AuthRepository {
  final AuthApiService _authApiService = AuthApiService();

  // Login
  Future<AuthResponse> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    final response = await _authApiService.login(request);

    // Firebase handles token management automatically
    // No need to manually save tokens to secure storage

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

    // Firebase handles token management automatically
    // No need to manually save tokens to secure storage

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
  Future<bool> isLoggedIn() async {
    return FirebaseAuthService.isSignedIn;
  }

  // Get current user
  Future<UserProfile?> getCurrentUser() async {
    try {
      // Check if Firebase user is signed in
      if (!FirebaseAuthService.isSignedIn) {
        return null;
      }
      
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
