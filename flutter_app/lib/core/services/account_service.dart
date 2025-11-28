import '../network/api_client.dart';
import '../network/api_endpoints.dart';
import 'firebase_auth_service.dart';

class AccountService {
  final ApiClient _apiClient = ApiClient.instance;

  // Singleton pattern
  static final AccountService _instance = AccountService._internal();
  static AccountService get instance => _instance;
  AccountService._internal();

  /// Initiates the account deletion process by sending a verification code to the user's email.
  Future<void> initiateDeleteAccount() async {
    try {
      await _apiClient.post(ApiEndpoints.authDeleteInitiate);
    } catch (e) {
      print('Error initiating account deletion: $e');
      rethrow;
    }
  }

  /// Verifies the deletion code and deletes the account.
  Future<void> verifyAndDeleteAccount(String code) async {
    try {
      await _apiClient.post(
        ApiEndpoints.authDeleteVerify,
        data: {'code': code},
      );
      
      // If backend deletion is successful, sign out from Firebase on client side
      await FirebaseAuthService.signOut();
    } catch (e) {
      print('Error verifying account deletion: $e');
      rethrow;
    }
  }
}

