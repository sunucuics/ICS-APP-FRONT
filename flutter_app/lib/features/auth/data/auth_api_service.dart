import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/models/user_model.dart';

class AuthApiService {
  final ApiClient _apiClient = ApiClient.instance;

  // Register
  Future<AuthResponse> register(RegisterRequest request) async {
    final formData = FormData.fromMap({
      'name': request.name,
      'phone': request.phone,
      'email': request.email,
      'password': request.password,
    });

    final response = await _apiClient.postMultipart(
      ApiEndpoints.authRegister,
      formData,
    );

    // Register response'unda user bilgisi var, direkt parse edebiliriz
    return AuthResponse.fromJson(response.data);
  }

  // Login
  Future<AuthResponse> login(LoginRequest request) async {
    final formData = FormData.fromMap({
      'email': request.email,
      'password': request.password,
    });

    final response = await _apiClient.postMultipart(
      ApiEndpoints.authLogin,
      formData,
    );

    // Backend sadece token bilgilerini döndürüyor, user profile'ını ayrıca çekmemiz gerekiyor
    final loginData = response.data;

    // Token'ı geçici olarak kaydet ki user profile çekebilelim
    await ApiClient.saveToken(loginData['id_token']);

    // User profile'ını çek
    final userProfile = await getCurrentUser();

    // AuthResponse oluştur
    return AuthResponse(
      userId: loginData['user_id'],
      user: userProfile,
      idToken: loginData['id_token'],
      refreshToken: loginData['refresh_token'],
      expiresIn: loginData['expires_in'],
    );
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    await _apiClient.post(
      ApiEndpoints.authResetPassword,
      queryParameters: {'email': email},
    );
  }

  // Logout
  Future<void> logout() async {
    await _apiClient.post(ApiEndpoints.authLogout);
  }

  // Get current user profile
  Future<UserProfile> getCurrentUser() async {
    final response = await _apiClient.get(ApiEndpoints.userProfile);
    return UserProfile.fromJson(response.data);
  }
}
