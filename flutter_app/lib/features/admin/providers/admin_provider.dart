import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/user_model.dart';
import '../../auth/providers/auth_provider.dart';

// Admin role check provider
final isAdminProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  final isAuthenticated = ref.watch(isAuthenticatedProvider);

  // Check if user is authenticated and has admin role
  if (isAuthenticated && user != null) {
    print('🔍 Admin Check: User authenticated');
    print('   - User role: ${user.role}');
    print('   - User email: ${user.email}');
    print('   - Is admin: ${user.role == 'admin'}');
    return user.role == 'admin';
  }

  return false;
});

// Admin user provider
final adminUserProvider = Provider<UserProfile?>((ref) {
  final user = ref.watch(currentUserProvider);
  final isAdmin = ref.watch(isAdminProvider);

  if (isAdmin && user != null) {
    return user;
  }
  return null;
});

// Admin panel access provider
final adminPanelAccessProvider = Provider<bool>((ref) {
  final isAuthenticated = ref.watch(isAuthenticatedProvider);
  final isAdmin = ref.watch(isAdminProvider);

  return isAuthenticated && isAdmin;
});
