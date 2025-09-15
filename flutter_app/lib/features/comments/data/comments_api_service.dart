import 'package:dio/dio.dart';
import '../../../core/models/comment_model.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/exceptions/api_exception.dart';

class CommentsApiService {
  final ApiClient _apiClient;

  CommentsApiService(this._apiClient);

  /// Add comment to a product
  Future<Comment> addProductComment({
    required String productId,
    required String content,
    required int rating,
  }) async {
    try {
      final formData = {
        'content': content,
        'rating': rating.toString(),
      };

      final response = await _apiClient.post(
        ApiEndpoints.productComments(productId),
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Comment.fromJson(response.data);
      } else {
        throw ApiException(
          message: response.data['detail'] ?? 'Failed to add comment',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }

  /// Get comments for a product
  Future<List<Comment>> getProductComments({
    required String productId,
    int limit = 100,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.productComments(productId),
        queryParameters: {'limit': limit.toString()},
      );

      if (response.statusCode == 200) {
        final List<dynamic> commentsJson = response.data;
        return commentsJson
            .map((json) => Comment.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(
          message: response.data['detail'] ?? 'Failed to fetch comments',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }

  /// Add comment to a service
  Future<Comment> addServiceComment({
    required String serviceId,
    required String content,
    required int rating,
  }) async {
    try {
      final formData = {
        'content': content,
        'rating': rating.toString(),
      };

      final response = await _apiClient.post(
        ApiEndpoints.serviceComments(serviceId),
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Comment.fromJson(response.data);
      } else {
        throw ApiException(
          message: response.data['detail'] ?? 'Failed to add comment',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }

  /// Get comments for a service
  Future<List<Comment>> getServiceComments({
    required String serviceId,
    int limit = 100,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.serviceComments(serviceId),
        queryParameters: {'limit': limit.toString()},
      );

      if (response.statusCode == 200) {
        final List<dynamic> commentsJson = response.data;
        return commentsJson
            .map((json) => Comment.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(
          message: response.data['detail'] ?? 'Failed to fetch comments',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }

  // Admin methods (for future admin panel integration)

  /// Get all product comments (admin)
  Future<List<Comment>> getAdminProductComments({int limit = 100}) async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.adminCommentsProducts,
        queryParameters: {'limit': limit.toString()},
      );

      if (response.statusCode == 200) {
        final List<dynamic> commentsJson = response.data;
        return commentsJson
            .map((json) => Comment.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(
          message: response.data['detail'] ?? 'Failed to fetch admin comments',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }

  /// Get all service comments (admin)
  Future<List<Comment>> getAdminServiceComments({int limit = 100}) async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.adminCommentsServices,
        queryParameters: {'limit': limit.toString()},
      );

      if (response.statusCode == 200) {
        final List<dynamic> commentsJson = response.data;
        return commentsJson
            .map((json) => Comment.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(
          message: response.data['detail'] ?? 'Failed to fetch admin comments',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }

  /// Delete comment (admin)
  Future<void> deleteComment({
    required String commentId,
    bool hard = false,
  }) async {
    try {
      final response = await _apiClient.delete(
        ApiEndpoints.adminComment(commentId),
        queryParameters: {'hard': hard.toString()},
      );

      if (response.statusCode != 200) {
        throw ApiException(
          message: response.data['detail'] ?? 'Failed to delete comment',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }

  /// Get profanity words (admin)
  Future<ProfanityResponse> getProfanityWords() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.adminProfanity);

      if (response.statusCode == 200) {
        return ProfanityResponse.fromJson(response.data);
      } else {
        throw ApiException(
          message: response.data['detail'] ?? 'Failed to fetch profanity words',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }

  /// Add profanity words (admin)
  Future<ProfanityResponse> addProfanityWords({
    required List<String> words,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.adminProfanity,
        data: {'words': words},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return ProfanityResponse.fromJson(response.data);
      } else {
        throw ApiException(
          message: response.data['detail'] ?? 'Failed to add profanity words',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }

  /// Delete profanity word (admin)
  Future<ProfanityResponse> deleteProfanityWord({
    required String wordId,
  }) async {
    try {
      final response = await _apiClient.delete(
        ApiEndpoints.adminProfanityWord(wordId),
      );

      if (response.statusCode == 200) {
        return ProfanityResponse.fromJson(response.data);
      } else {
        throw ApiException(
          message: response.data['detail'] ?? 'Failed to delete profanity word',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }
}
