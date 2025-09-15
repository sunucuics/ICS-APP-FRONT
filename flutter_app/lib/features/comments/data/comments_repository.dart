import '../../../core/models/comment_model.dart';
import '../../../core/network/exceptions/api_exception.dart';
import 'comments_api_service.dart';

class CommentsRepository {
  final CommentsApiService _apiService;

  CommentsRepository(this._apiService);

  /// Add comment to a product
  Future<Comment> addProductComment({
    required String productId,
    required String content,
    required int rating,
  }) async {
    try {
      // Validate input
      if (content.trim().isEmpty) {
        throw ApiException(message: 'Comment content cannot be empty');
      }
      if (content.length > 500) {
        throw ApiException(
            message: 'Comment content cannot exceed 500 characters');
      }
      if (rating < 1 || rating > 5) {
        throw ApiException(message: 'Rating must be between 1 and 5');
      }

      return await _apiService.addProductComment(
        productId: productId,
        content: content.trim(),
        rating: rating,
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
          message: 'Failed to add product comment: ${e.toString()}');
    }
  }

  /// Get comments for a product
  Future<List<Comment>> getProductComments({
    required String productId,
    int limit = 100,
  }) async {
    try {
      if (limit < 1 || limit > 200) {
        throw ApiException(message: 'Limit must be between 1 and 200');
      }

      return await _apiService.getProductComments(
        productId: productId,
        limit: limit,
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
          message: 'Failed to fetch product comments: ${e.toString()}');
    }
  }

  /// Add comment to a service
  Future<Comment> addServiceComment({
    required String serviceId,
    required String content,
    required int rating,
  }) async {
    try {
      // Validate input
      if (content.trim().isEmpty) {
        throw ApiException(message: 'Comment content cannot be empty');
      }
      if (content.length > 500) {
        throw ApiException(
            message: 'Comment content cannot exceed 500 characters');
      }
      if (rating < 1 || rating > 5) {
        throw ApiException(message: 'Rating must be between 1 and 5');
      }

      return await _apiService.addServiceComment(
        serviceId: serviceId,
        content: content.trim(),
        rating: rating,
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
          message: 'Failed to add service comment: ${e.toString()}');
    }
  }

  /// Get comments for a service
  Future<List<Comment>> getServiceComments({
    required String serviceId,
    int limit = 100,
  }) async {
    try {
      if (limit < 1 || limit > 200) {
        throw ApiException(message: 'Limit must be between 1 and 200');
      }

      return await _apiService.getServiceComments(
        serviceId: serviceId,
        limit: limit,
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
          message: 'Failed to fetch service comments: ${e.toString()}');
    }
  }

  // Admin methods (for future admin panel integration)

  /// Get all product comments (admin)
  Future<List<Comment>> getAdminProductComments({int limit = 100}) async {
    try {
      if (limit < 1 || limit > 200) {
        throw ApiException(message: 'Limit must be between 1 and 200');
      }

      return await _apiService.getAdminProductComments(limit: limit);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
          message: 'Failed to fetch admin product comments: ${e.toString()}');
    }
  }

  /// Get all service comments (admin)
  Future<List<Comment>> getAdminServiceComments({int limit = 100}) async {
    try {
      if (limit < 1 || limit > 200) {
        throw ApiException(message: 'Limit must be between 1 and 200');
      }

      return await _apiService.getAdminServiceComments(limit: limit);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
          message: 'Failed to fetch admin service comments: ${e.toString()}');
    }
  }

  /// Delete comment (admin)
  Future<void> deleteComment({
    required String commentId,
    bool hard = false,
  }) async {
    try {
      await _apiService.deleteComment(
        commentId: commentId,
        hard: hard,
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Failed to delete comment: ${e.toString()}');
    }
  }

  /// Get profanity words (admin)
  Future<ProfanityResponse> getProfanityWords() async {
    try {
      return await _apiService.getProfanityWords();
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
          message: 'Failed to fetch profanity words: ${e.toString()}');
    }
  }

  /// Add profanity words (admin)
  Future<ProfanityResponse> addProfanityWords({
    required List<String> words,
  }) async {
    try {
      if (words.isEmpty) {
        throw ApiException(message: 'Words list cannot be empty');
      }

      // Filter out empty words
      final filteredWords = words
          .map((word) => word.trim())
          .where((word) => word.isNotEmpty)
          .toList();

      if (filteredWords.isEmpty) {
        throw ApiException(message: 'No valid words provided');
      }

      return await _apiService.addProfanityWords(words: filteredWords);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
          message: 'Failed to add profanity words: ${e.toString()}');
    }
  }

  /// Delete profanity word (admin)
  Future<ProfanityResponse> deleteProfanityWord({
    required String wordId,
  }) async {
    try {
      return await _apiService.deleteProfanityWord(wordId: wordId);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
          message: 'Failed to delete profanity word: ${e.toString()}');
    }
  }
}
