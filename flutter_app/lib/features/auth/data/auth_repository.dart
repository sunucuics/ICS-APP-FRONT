import '../../../core/models/user_model.dart';
import '../../../core/network/api_client.dart';
import 'auth_api_service.dart';

class AuthRepository {
  final AuthApiService _authApiService = AuthApiService();

  // Login
  Future<AuthResponse> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    final response = await _authApiService.login(request);

    // Save tokens to secure storage
    await ApiClient.saveToken(response.idToken);
    await ApiClient.saveRefreshToken(response.refreshToken);
    await ApiClient.saveUserId(response.userId);

    return response;
  }

  // Register
  Future<AuthResponse> register({
    required String name,
    required String phone,
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

    // Save tokens to secure storage
    await ApiClient.saveToken(response.idToken);
    await ApiClient.saveRefreshToken(response.refreshToken);
    await ApiClient.saveUserId(response.userId);

    return response;
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    await _authApiService.resetPassword(email);
  }

  // Logout
  Future<void> logout() async {
    try {
      // Call logout endpoint to invalidate token on server
      await _authApiService.logout();
    } catch (e) {
      // Even if server call fails, we should clear local tokens
      print('Logout API call failed: $e');
    } finally {
      // Clear all local auth data
      await ApiClient.clearAllAuthData();
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await ApiClient.getToken();
    return token != null && token.isNotEmpty;
  }

  // Get current user
  Future<UserProfile?> getCurrentUser() async {
    try {
      return await _authApiService.getCurrentUser();
    } catch (e) {
      print('Failed to get current user: $e');
      return null;
    }
  }

  // Get stored user ID
  Future<String?> getCurrentUserId() async {
    return await ApiClient.getUserId();
  }
}
