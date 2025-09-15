import 'package:flutter/foundation.dart';
import '../../../core/models/comment_model.dart';
import '../../../core/network/exceptions/api_exception.dart';
import '../data/comments_repository.dart';

class CommentsProvider with ChangeNotifier {
  final CommentsRepository _repository;

  CommentsProvider(this._repository);

  // State management
  final Map<String, List<Comment>> _productComments = {};
  final Map<String, List<Comment>> _serviceComments = {};
  final Map<String, bool> _loadingStates = {};
  final Map<String, String?> _errorStates = {};

  // Getters
  List<Comment> getProductComments(String productId) {
    return _productComments[productId] ?? [];
  }

  List<Comment> getServiceComments(String serviceId) {
    return _serviceComments[serviceId] ?? [];
  }

  bool isLoading(String key) {
    return _loadingStates[key] ?? false;
  }

  String? getError(String key) {
    return _errorStates[key];
  }

  // Clear error for a specific key
  void clearError(String key) {
    if (_errorStates.containsKey(key)) {
      _errorStates.remove(key);
      notifyListeners();
    }
  }

  // Clear all errors
  void clearAllErrors() {
    _errorStates.clear();
    notifyListeners();
  }

  // Set loading state
  void _setLoading(String key, bool loading) {
    _loadingStates[key] = loading;
    notifyListeners();
  }

  // Set error state
  void _setError(String key, String? error) {
    _errorStates[key] = error;
    notifyListeners();
  }

  // Add comment to product
  Future<Comment?> addProductComment({
    required String productId,
    required String content,
    required int rating,
  }) async {
    final key = 'add_product_$productId';

    try {
      _setLoading(key, true);
      _setError(key, null);

      final comment = await _repository.addProductComment(
        productId: productId,
        content: content,
        rating: rating,
      );

      // Add to local cache
      _productComments[productId] = [
        comment,
        ...(_productComments[productId] ?? []),
      ];

      _setLoading(key, false);
      return comment;
    } catch (e) {
      _setLoading(key, false);
      _setError(key, e is ApiException ? e.message : 'Failed to add comment');
      return null;
    }
  }

  // Get product comments
  Future<void> fetchProductComments({
    required String productId,
    int limit = 100,
    bool forceRefresh = false,
  }) async {
    final key = 'product_$productId';

    // Return cached data if available and not forcing refresh
    if (!forceRefresh && _productComments.containsKey(productId)) {
      return;
    }

    try {
      _setLoading(key, true);
      _setError(key, null);

      final comments = await _repository.getProductComments(
        productId: productId,
        limit: limit,
      );

      _productComments[productId] = comments;
      _setLoading(key, false);
    } catch (e) {
      _setLoading(key, false);
      _setError(
          key, e is ApiException ? e.message : 'Failed to fetch comments');
    }
  }

  // Add comment to service
  Future<Comment?> addServiceComment({
    required String serviceId,
    required String content,
    required int rating,
  }) async {
    final key = 'add_service_$serviceId';

    try {
      _setLoading(key, true);
      _setError(key, null);

      final comment = await _repository.addServiceComment(
        serviceId: serviceId,
        content: content,
        rating: rating,
      );

      // Add to local cache
      _serviceComments[serviceId] = [
        comment,
        ...(_serviceComments[serviceId] ?? []),
      ];

      _setLoading(key, false);
      return comment;
    } catch (e) {
      _setLoading(key, false);
      _setError(key, e is ApiException ? e.message : 'Failed to add comment');
      return null;
    }
  }

  // Get service comments
  Future<void> fetchServiceComments({
    required String serviceId,
    int limit = 100,
    bool forceRefresh = false,
  }) async {
    final key = 'service_$serviceId';

    // Return cached data if available and not forcing refresh
    if (!forceRefresh && _serviceComments.containsKey(serviceId)) {
      return;
    }

    try {
      _setLoading(key, true);
      _setError(key, null);

      final comments = await _repository.getServiceComments(
        serviceId: serviceId,
        limit: limit,
      );

      _serviceComments[serviceId] = comments;
      _setLoading(key, false);
    } catch (e) {
      _setLoading(key, false);
      _setError(
          key, e is ApiException ? e.message : 'Failed to fetch comments');
    }
  }

  // Refresh comments for a product
  Future<void> refreshProductComments(String productId) async {
    await fetchProductComments(productId: productId, forceRefresh: true);
  }

  // Refresh comments for a service
  Future<void> refreshServiceComments(String serviceId) async {
    await fetchServiceComments(serviceId: serviceId, forceRefresh: true);
  }

  // Get average rating for a product
  double getProductAverageRating(String productId) {
    final comments = getProductComments(productId);
    if (comments.isEmpty) return 0.0;

    final totalRating =
        comments.fold(0, (sum, comment) => sum + comment.rating);
    return totalRating / comments.length;
  }

  // Get average rating for a service
  double getServiceAverageRating(String serviceId) {
    final comments = getServiceComments(serviceId);
    if (comments.isEmpty) return 0.0;

    final totalRating =
        comments.fold(0, (sum, comment) => sum + comment.rating);
    return totalRating / comments.length;
  }

  // Get rating distribution for a product
  Map<int, int> getProductRatingDistribution(String productId) {
    final comments = getProductComments(productId);
    final distribution = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

    for (final comment in comments) {
      distribution[comment.rating] = (distribution[comment.rating] ?? 0) + 1;
    }

    return distribution;
  }

  // Get rating distribution for a service
  Map<int, int> getServiceRatingDistribution(String serviceId) {
    final comments = getServiceComments(serviceId);
    final distribution = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

    for (final comment in comments) {
      distribution[comment.rating] = (distribution[comment.rating] ?? 0) + 1;
    }

    return distribution;
  }

  // Clear cache for a specific product
  void clearProductComments(String productId) {
    _productComments.remove(productId);
    _loadingStates.remove('product_$productId');
    _errorStates.remove('product_$productId');
    notifyListeners();
  }

  // Clear cache for a specific service
  void clearServiceComments(String serviceId) {
    _serviceComments.remove(serviceId);
    _loadingStates.remove('service_$serviceId');
    _errorStates.remove('service_$serviceId');
    notifyListeners();
  }

  // Clear all cache
  void clearAllCache() {
    _productComments.clear();
    _serviceComments.clear();
    _loadingStates.clear();
    _errorStates.clear();
    notifyListeners();
  }

  // Admin methods (for future admin panel integration)

  // Get admin product comments
  Future<List<Comment>> getAdminProductComments({int limit = 100}) async {
    try {
      return await _repository.getAdminProductComments(limit: limit);
    } catch (e) {
      throw e is ApiException
          ? e
          : ApiException(message: 'Failed to fetch admin product comments');
    }
  }

  // Get admin service comments
  Future<List<Comment>> getAdminServiceComments({int limit = 100}) async {
    try {
      return await _repository.getAdminServiceComments(limit: limit);
    } catch (e) {
      throw e is ApiException
          ? e
          : ApiException(message: 'Failed to fetch admin service comments');
    }
  }

  // Delete comment (admin)
  Future<void> deleteComment({
    required String commentId,
    bool hard = false,
  }) async {
    try {
      await _repository.deleteComment(commentId: commentId, hard: hard);

      // Remove from local cache if it exists
      for (final productId in _productComments.keys) {
        _productComments[productId]
            ?.removeWhere((comment) => comment.id == commentId);
      }
      for (final serviceId in _serviceComments.keys) {
        _serviceComments[serviceId]
            ?.removeWhere((comment) => comment.id == commentId);
      }

      notifyListeners();
    } catch (e) {
      throw e is ApiException
          ? e
          : ApiException(message: 'Failed to delete comment');
    }
  }

  // Profanity filter methods (admin)

  // Get profanity words
  Future<ProfanityResponse> getProfanityWords() async {
    try {
      return await _repository.getProfanityWords();
    } catch (e) {
      throw e is ApiException
          ? e
          : ApiException(message: 'Failed to fetch profanity words');
    }
  }

  // Add profanity words
  Future<ProfanityResponse> addProfanityWords({
    required List<String> words,
  }) async {
    try {
      return await _repository.addProfanityWords(words: words);
    } catch (e) {
      throw e is ApiException
          ? e
          : ApiException(message: 'Failed to add profanity words');
    }
  }

  // Delete profanity word
  Future<ProfanityResponse> deleteProfanityWord({
    required String wordId,
  }) async {
    try {
      return await _repository.deleteProfanityWord(wordId: wordId);
    } catch (e) {
      throw e is ApiException
          ? e
          : ApiException(message: 'Failed to delete profanity word');
    }
  }
}
