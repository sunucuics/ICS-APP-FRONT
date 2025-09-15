import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../data/comments_api_service.dart';
import '../data/comments_repository.dart';
import 'comments_provider.dart';

// API Client Provider
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

// Comments API Service Provider
final commentsApiServiceProvider = Provider<CommentsApiService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CommentsApiService(apiClient);
});

// Comments Repository Provider
final commentsRepositoryProvider = Provider<CommentsRepository>((ref) {
  final apiService = ref.watch(commentsApiServiceProvider);
  return CommentsRepository(apiService);
});

// Comments Provider
final commentsProviderNotifier =
    ChangeNotifierProvider<CommentsProvider>((ref) {
  final repository = ref.watch(commentsRepositoryProvider);
  return CommentsProvider(repository);
});
