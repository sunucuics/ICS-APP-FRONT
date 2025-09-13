import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AnonymousAuthService {
  static final AnonymousAuthService _instance =
      AnonymousAuthService._internal();
  factory AnonymousAuthService() => _instance;
  AnonymousAuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user
  User? get currentUser => _auth.currentUser;

  /// Check if user is anonymous
  bool get isAnonymous => currentUser?.isAnonymous ?? false;

  /// Check if user is authenticated (anonymous or registered)
  bool get isAuthenticated => currentUser != null;

  /// Get user ID token
  Future<String?> getIdToken() async {
    try {
      final user = currentUser;
      if (user != null) {
        return await user.getIdToken();
      }
      return null;
    } catch (e) {
      debugPrint('Error getting ID token: $e');
      return null;
    }
  }

  /// Sign in anonymously
  Future<UserCredential?> signInAnonymously() async {
    try {
      final credential = await _auth.signInAnonymously();
      debugPrint('Anonymous sign in successful: ${credential.user?.uid}');
      return credential;
    } on FirebaseAuthException catch (e) {
      debugPrint('Anonymous sign in failed: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Unexpected error during anonymous sign in: $e');
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      debugPrint('Sign out successful');
    } catch (e) {
      debugPrint('Sign out failed: $e');
      rethrow;
    }
  }

  /// Link anonymous account with email/password
  Future<UserCredential?> linkWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = currentUser;
      if (user == null || !user.isAnonymous) {
        throw Exception('No anonymous user to link');
      }

      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      final result = await user.linkWithCredential(credential);
      debugPrint('Account linked successfully: ${result.user?.uid}');
      return result;
    } on FirebaseAuthException catch (e) {
      debugPrint('Account linking failed: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Unexpected error during account linking: $e');
      rethrow;
    }
  }

  /// Link anonymous account with phone number
  Future<ConfirmationResult?> linkWithPhoneNumber({
    required String phoneNumber,
  }) async {
    try {
      final user = currentUser;
      if (user == null || !user.isAnonymous) {
        throw Exception('No anonymous user to link');
      }

      final confirmationResult = await user.linkWithPhoneNumber(phoneNumber);
      debugPrint('Phone number linking initiated for: $phoneNumber');
      return confirmationResult;
    } on FirebaseAuthException catch (e) {
      debugPrint('Phone number linking failed: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Unexpected error during phone number linking: $e');
      rethrow;
    }
  }

  /// Delete anonymous account
  Future<void> deleteAnonymousAccount() async {
    try {
      final user = currentUser;
      if (user == null || !user.isAnonymous) {
        throw Exception('No anonymous user to delete');
      }

      await user.delete();
      debugPrint('Anonymous account deleted successfully');
    } on FirebaseAuthException catch (e) {
      debugPrint('Account deletion failed: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Unexpected error during account deletion: $e');
      rethrow;
    }
  }

  /// Listen to auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Listen to ID token changes
  Stream<User?> get idTokenChanges => _auth.idTokenChanges();

  /// Get user display name
  String? get displayName => currentUser?.displayName;

  /// Get user email
  String? get email => currentUser?.email;

  /// Get user phone number
  String? get phoneNumber => currentUser?.phoneNumber;

  /// Check if email is verified
  bool get isEmailVerified => currentUser?.emailVerified ?? false;

  /// Check if phone number is verified
  bool get isPhoneVerified => currentUser?.phoneNumber != null;

  /// Get user creation time
  DateTime? get creationTime => currentUser?.metadata.creationTime;

  /// Get last sign in time
  DateTime? get lastSignInTime => currentUser?.metadata.lastSignInTime;

  /// Get user provider data
  List<UserInfo> get providerData => currentUser?.providerData ?? [];

  /// Check if user has specific provider
  bool hasProvider(String providerId) {
    return providerData.any((info) => info.providerId == providerId);
  }

  /// Get user metadata
  UserMetadata? get metadata => currentUser?.metadata;

  /// Refresh user token
  Future<void> refreshToken() async {
    try {
      final user = currentUser;
      if (user != null) {
        await user.getIdToken(true); // Force refresh
        debugPrint('Token refreshed successfully');
      }
    } catch (e) {
      debugPrint('Token refresh failed: $e');
      rethrow;
    }
  }

  /// Check if user needs to re-authenticate
  bool get needsReauth {
    final user = currentUser;
    if (user == null) return false;

    // Check if token is expired or will expire soon
    final lastSignIn = lastSignInTime;
    if (lastSignIn == null) return true;

    final now = DateTime.now();
    final timeSinceLastSignIn = now.difference(lastSignIn);

    // If more than 1 hour since last sign in, might need reauth
    return timeSinceLastSignIn.inHours > 1;
  }
}
