// import 'package:firebase_auth/firebase_auth.dart'; // Temporarily disabled
import 'package:flutter/foundation.dart';

// Mock types for development
class MockUser {
  final String uid;
  final bool isAnonymous;
  final String? email;
  final String? displayName;
  final String? phoneNumber;
  final DateTime creationTime;
  final DateTime lastSignInTime;

  MockUser({
    required this.uid,
    required this.isAnonymous,
    this.email,
    this.displayName,
    this.phoneNumber,
    required this.creationTime,
    required this.lastSignInTime,
  });
}

class MockUserCredential {
  final MockUser? user;
  MockUserCredential({this.user});
}

class MockFirebaseAuthException implements Exception {
  final String code;
  final String message;
  MockFirebaseAuthException({required this.code, required this.message});
}

class AnonymousAuthService {
  static final AnonymousAuthService _instance =
      AnonymousAuthService._internal();
  factory AnonymousAuthService() => _instance;
  AnonymousAuthService._internal();

  MockUser? _currentUser;

  /// Get current user
  MockUser? get currentUser => _currentUser;

  /// Check if user is anonymous
  bool get isAnonymous => currentUser?.isAnonymous ?? false;

  /// Check if user is authenticated (anonymous or registered)
  bool get isAuthenticated => currentUser != null;

  /// Get user ID token
  Future<String?> getIdToken() async {
    try {
      final user = currentUser;
      if (user != null) {
        // Mock token for anonymous user
        return 'mock_anonymous_token_${user.uid}';
      }
      return null;
    } catch (e) {
      debugPrint('Error getting ID token: $e');
      return null;
    }
  }

  /// Sign in anonymously
  Future<MockUserCredential> signInAnonymously() async {
    try {
      // Create mock anonymous user
      final now = DateTime.now();
      _currentUser = MockUser(
        uid: 'anonymous_${now.millisecondsSinceEpoch}',
        isAnonymous: true,
        creationTime: now,
        lastSignInTime: now,
      );

      debugPrint('Mock anonymous sign in successful: ${_currentUser!.uid}');
      return MockUserCredential(user: _currentUser);
    } catch (e) {
      debugPrint('Error signing in anonymously: $e');
      throw MockFirebaseAuthException(
        code: 'anonymous-sign-in-failed',
        message: e.toString(),
      );
    }
  }

  /// Link anonymous account with email and password
  Future<MockUserCredential> linkWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (_currentUser == null || !_currentUser!.isAnonymous) {
        throw MockFirebaseAuthException(
          code: 'no-anonymous-user',
          message: 'No anonymous user to link',
        );
      }

      // Convert anonymous user to registered user
      _currentUser = MockUser(
        uid: _currentUser!.uid, // Keep same UID
        isAnonymous: false,
        email: email,
        displayName: email.split('@').first,
        creationTime: _currentUser!.creationTime,
        lastSignInTime: DateTime.now(),
      );

      debugPrint('Mock account linking successful: ${_currentUser!.uid}');
      return MockUserCredential(user: _currentUser);
    } catch (e) {
      debugPrint('Error linking account: $e');
      throw MockFirebaseAuthException(
        code: 'link-failed',
        message: e.toString(),
      );
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      _currentUser = null;
      debugPrint('Mock sign out successful');
    } catch (e) {
      debugPrint('Error signing out: $e');
      throw MockFirebaseAuthException(
        code: 'sign-out-failed',
        message: e.toString(),
      );
    }
  }

  /// Delete anonymous account
  Future<void> deleteAnonymousAccount() async {
    try {
      if (_currentUser != null && _currentUser!.isAnonymous) {
        _currentUser = null;
        debugPrint('Mock anonymous account deleted');
      }
    } catch (e) {
      debugPrint('Error deleting anonymous account: $e');
      throw MockFirebaseAuthException(
        code: 'delete-failed',
        message: e.toString(),
      );
    }
  }

  /// Listen to auth state changes (mock stream)
  Stream<MockUser?> get authStateChanges async* {
    // Emit current user immediately
    yield _currentUser;
    
    // In a real implementation, this would emit changes when auth state changes
    // For mock, we'll use a simple periodic check
    while (true) {
      await Future.delayed(const Duration(milliseconds: 100));
      yield _currentUser;
    }
  }

  /// Listen to ID token changes (mock stream)
  Stream<MockUser?> get idTokenChanges async* {
    yield _currentUser;
    // In a real implementation, this would emit changes when token changes
  }

  /// Get user display name
  String? get displayName => _currentUser?.displayName;

  /// Get user email
  String? get email => _currentUser?.email;

  /// Get user phone number
  String? get phoneNumber => _currentUser?.phoneNumber;

  /// Check if user needs reauth
  bool get needsReauth => false; // Mock implementation

  /// Get user metadata
  Map<String, dynamic> get userMetadata => {
        'creationTime': _currentUser?.creationTime.toIso8601String(),
        'lastSignInTime': _currentUser?.lastSignInTime.toIso8601String(),
      };

  /// Get user provider data
  List<Map<String, dynamic>> get providerData => [
        if (_currentUser?.email != null)
          {
            'providerId': 'password',
            'uid': _currentUser!.uid,
            'email': _currentUser!.email,
          },
      ];
}