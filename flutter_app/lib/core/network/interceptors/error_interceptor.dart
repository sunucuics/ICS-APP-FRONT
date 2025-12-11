import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../exceptions/api_exception.dart';
import '../../utils/logger.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log the error for debugging (only in debug mode)
    if (kDebugMode) {
      AppLogger.error('API Error: ${err.type} - ${err.message}');
      AppLogger.debug(
          'Request: ${err.requestOptions.method} ${err.requestOptions.path}');

      if (err.response != null) {
        // Sanitize response data to avoid logging sensitive information
        final statusCode = err.response!.statusCode;
        final responseData = err.response!.data;

        // Only log response data in debug mode, and sanitize it
        AppLogger.debug('Response: $statusCode');
        if (responseData is Map<String, dynamic>) {
          // Log sanitized response data
          final sanitized = AppLogger.sanitizeData(responseData);
          AppLogger.debug('Response data: $sanitized');
        } else {
          AppLogger.debug('Response data: [non-map data]');
        }
      }
    } else {
      // In release mode, only log generic error information
      AppLogger.error('API Error occurred: ${err.type}');
      AppLogger.debug(
          'Request: ${err.requestOptions.method} ${err.requestOptions.path}');
      if (err.response != null) {
        AppLogger.debug('Response status: ${err.response!.statusCode}');
      }
    }

    // Convert DioException to our custom ApiException
    final apiException = ApiException.fromDioException(err);

    // Pass the converted exception
    handler.next(DioException(
      requestOptions: err.requestOptions,
      error: apiException,
      type: err.type,
      response: err.response,
    ));
  }
}
