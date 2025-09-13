import 'package:flutter/foundation.dart';

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

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'isAnonymous': isAnonymous,
        'email': email,
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'creationTime': creationTime.toIso8601String(),
        'lastSignInTime': lastSignInTime.toIso8601String(),
      };
}

class MockAnonymousAuthService {
  static final MockAnonymousAuthService _instance =
      MockAnonymousAuthService._internal();
  factory MockAnonymousAuthService() => _instance;
  MockAnonymousAuthService._internal();

  MockUser? _currentUser;
  final List<MockUser> _users = [];

  /// Get current user
  MockUser? get currentUser => _currentUser;

  /// Check if user is anonymous
  bool get isAnonymous => _currentUser?.isAnonymous ?? false;

  /// Check if user is authenticated (anonymous or registered)
  bool get isAuthenticated => _currentUser != null;

  /// Get user ID token (mock)
  Future<String?> getIdToken() async {
    if (_currentUser != null) {
      // Return a mock JWT token
      return 'mock_jwt_token_${_currentUser!.uid}';
    }
    return null;
  }

  /// Sign in anonymously
  Future<MockUser> signInAnonymously() async {
    try {
      final now = DateTime.now();
      final user = MockUser(
        uid: 'anonymous_${now.millisecondsSinceEpoch}',
        isAnonymous: true,
        creationTime: now,
        lastSignInTime: now,
      );

      _currentUser = user;
      _users.add(user);

      debugPrint('Mock anonymous sign in successful: ${user.uid}');
      return user;
    } catch (e) {
      debugPrint('Mock anonymous sign in failed: $e');
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      _currentUser = null;
      debugPrint('Mock sign out successful');
    } catch (e) {
      debugPrint('Mock sign out failed: $e');
      rethrow;
    }
  }

  /// Link anonymous account with email/password (mock)
  Future<MockUser> linkWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = _currentUser;
      if (user == null || !user.isAnonymous) {
        throw Exception('No anonymous user to link');
      }

      final linkedUser = MockUser(
        uid: user.uid,
        isAnonymous: false,
        email: email,
        displayName: email.split('@')[0],
        creationTime: user.creationTime,
        lastSignInTime: DateTime.now(),
      );

      _currentUser = linkedUser;
      debugPrint('Mock account linked successfully: ${linkedUser.uid}');
      return linkedUser;
    } catch (e) {
      debugPrint('Mock account linking failed: $e');
      rethrow;
    }
  }

  /// Delete anonymous account (mock)
  Future<void> deleteAnonymousAccount() async {
    try {
      final user = _currentUser;
      if (user == null || !user.isAnonymous) {
        throw Exception('No anonymous user to delete');
      }

      _currentUser = null;
      _users.removeWhere((u) => u.uid == user.uid);
      debugPrint('Mock anonymous account deleted successfully');
    } catch (e) {
      debugPrint('Mock account deletion failed: $e');
      rethrow;
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

  /// Check if email is verified (mock - always true for linked accounts)
  bool get isEmailVerified => _currentUser?.email != null;

  /// Check if phone number is verified (mock - always true if phone exists)
  bool get isPhoneVerified => _currentUser?.phoneNumber != null;

  /// Get user creation time
  DateTime? get creationTime => _currentUser?.creationTime;

  /// Get last sign in time
  DateTime? get lastSignInTime => _currentUser?.lastSignInTime;

  /// Get user provider data (mock)
  List<Map<String, dynamic>> get providerData {
    if (_currentUser == null) return [];

    final providers = <Map<String, dynamic>>[];
    if (_currentUser!.isAnonymous) {
      providers.add({'providerId': 'anonymous'});
    }
    if (_currentUser!.email != null) {
      providers.add({'providerId': 'password'});
    }
    if (_currentUser!.phoneNumber != null) {
      providers.add({'providerId': 'phone'});
    }

    return providers;
  }

  /// Check if user has specific provider
  bool hasProvider(String providerId) {
    return providerData.any((info) => info['providerId'] == providerId);
  }

  /// Get user metadata (mock)
  Map<String, dynamic>? get metadata => _currentUser?.toJson();

  /// Refresh user token (mock)
  Future<void> refreshToken() async {
    try {
      if (_currentUser != null) {
        debugPrint('Mock token refreshed successfully');
      }
    } catch (e) {
      debugPrint('Mock token refresh failed: $e');
      rethrow;
    }
  }

  /// Check if user needs to re-authenticate (mock)
  bool get needsReauth {
    final user = _currentUser;
    if (user == null) return false;

    final lastSignIn = lastSignInTime;
    if (lastSignIn == null) return true;

    final now = DateTime.now();
    final timeSinceLastSignIn = now.difference(lastSignIn);

    // If more than 1 hour since last sign in, might need reauth
    return timeSinceLastSignIn.inHours > 1;
  }
}
