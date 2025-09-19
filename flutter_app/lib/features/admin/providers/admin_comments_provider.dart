import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../providers/admin_dashboard_provider.dart';
import '../../../core/models/comment_model.dart';

// Comments Provider
final adminCommentsProvider = FutureProvider<List<Comment>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getComments();
});

// Comments State Notifier for CRUD operations
final adminCommentsNotifierProvider =
    StateNotifierProvider<AdminCommentsNotifier, AsyncValue<List<Comment>>>(
        (ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return AdminCommentsNotifier(repository);
});

class AdminCommentsNotifier extends StateNotifier<AsyncValue<List<Comment>>> {
  final AdminRepository _repository;

  AdminCommentsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadComments();
  }

  Future<void> loadComments() async {
    state = const AsyncValue.loading();
    try {
      final comments = await _repository.getComments();
      state = AsyncValue.data(comments);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> approveComment(String commentId) async {
    try {
      await _repository.approveComment(commentId);
      await loadComments(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteComment(String commentId) async {
    try {
      await _repository.deleteComment(commentId);
      await loadComments(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadComments();
  }
}
