import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import 'admin_dashboard_provider.dart';
import '../../../../core/models/user_model.dart';

final adminUsersProvider =
    StateNotifierProvider<AdminUsersNotifier, AsyncValue<List<UserProfile>>>(
        (ref) {
  return AdminUsersNotifier(ref.read(adminRepositoryProvider));
});

class AdminUsersNotifier extends StateNotifier<AsyncValue<List<UserProfile>>> {
  final AdminRepository _repository;

  AdminUsersNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadUsers();
  }

  Future<void> loadUsers() async {
    try {
      state = const AsyncValue.loading();
      final users = await _repository.getUsers();
      state = AsyncValue.data(users);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _repository.deleteUser(userId);
      await loadUsers(); // Refresh users list after deletion
    } catch (e) {
      // Handle error, maybe show a snackbar
      print('Error deleting user: $e');
      rethrow;
    }
  }

  Future<void> updateUserRole(String userId, String role) async {
    try {
      await _repository.updateUserRole(userId, role);
      await loadUsers(); // Refresh users list after role update
    } catch (e) {
      // Handle error, maybe show a snackbar
      print('Error updating user role: $e');
      rethrow;
    }
  }
}
