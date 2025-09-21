import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import 'admin_dashboard_provider.dart';
import '../../../../core/models/comment_model.dart';

final adminCommentsProvider =
    StateNotifierProvider<AdminCommentsNotifier, AsyncValue<List<Comment>>>(
        (ref) {
  return AdminCommentsNotifier(ref.read(adminRepositoryProvider));
});

class AdminCommentsNotifier extends StateNotifier<AsyncValue<List<Comment>>> {
  final AdminRepository _repository;

  AdminCommentsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadComments();
  }

  Future<void> loadComments() async {
    try {
      state = const AsyncValue.loading();
      final comments = await _repository.getComments();
      state = AsyncValue.data(comments);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadComments();
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
}
