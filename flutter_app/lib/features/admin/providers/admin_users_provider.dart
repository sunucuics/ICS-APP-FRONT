import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../providers/admin_dashboard_provider.dart';
import '../../../core/models/user_model.dart';

// Users Provider
final adminUsersProvider = FutureProvider<List<UserProfile>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getUsers();
});

// Users State Notifier for CRUD operations
final adminUsersNotifierProvider =
    StateNotifierProvider<AdminUsersNotifier, AsyncValue<List<UserProfile>>>(
        (ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return AdminUsersNotifier(repository);
});

class AdminUsersNotifier extends StateNotifier<AsyncValue<List<UserProfile>>> {
  final AdminRepository _repository;

  AdminUsersNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadUsers();
  }

  Future<void> loadUsers() async {
    state = const AsyncValue.loading();
    try {
      final users = await _repository.getUsers();
      state = AsyncValue.data(users);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateUserRole(String userId, String role) async {
    try {
      await _repository.updateUserRole(userId, role);
      await loadUsers(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadUsers();
  }
}
