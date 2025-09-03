import 'package:dio/dio.dart';
import '../exceptions/api_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log the error for debugging
    print('API Error: ${err.type} - ${err.message}');
    print('Request: ${err.requestOptions.method} ${err.requestOptions.path}');

    if (err.response != null) {
      print('Response: ${err.response!.statusCode} - ${err.response!.data}');
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
