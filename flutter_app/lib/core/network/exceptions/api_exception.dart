import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? errorCode;
  final dynamic data;

  ApiException({
    required this.message,
    this.statusCode,
    this.errorCode,
    this.data,
  });

  factory ApiException.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException(
          message: 'Bağlantı zaman aşımına uğradı',
          statusCode: null,
          errorCode: 'CONNECTION_TIMEOUT',
        );

      case DioExceptionType.sendTimeout:
        return ApiException(
          message: 'İstek gönderme zaman aşımına uğradı',
          statusCode: null,
          errorCode: 'SEND_TIMEOUT',
        );

      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: 'Yanıt alma zaman aşımına uğradı',
          statusCode: null,
          errorCode: 'RECEIVE_TIMEOUT',
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(dioException);

      case DioExceptionType.cancel:
        return ApiException(
          message: 'İstek iptal edildi',
          statusCode: null,
          errorCode: 'REQUEST_CANCELLED',
        );

      case DioExceptionType.connectionError:
        return ApiException(
          message: 'İnternet bağlantısı bulunamadı',
          statusCode: null,
          errorCode: 'NO_INTERNET',
        );

      case DioExceptionType.badCertificate:
        return ApiException(
          message: 'Güvenlik sertifikası hatası',
          statusCode: null,
          errorCode: 'BAD_CERTIFICATE',
        );

      case DioExceptionType.unknown:
        return ApiException(
          message: 'Bilinmeyen bir hata oluştu',
          statusCode: null,
          errorCode: 'UNKNOWN_ERROR',
        );
    }
  }

  static ApiException _handleBadResponse(DioException dioException) {
    final response = dioException.response;
    final statusCode = response?.statusCode ?? 0;

    String message;
    String errorCode;

    switch (statusCode) {
      case 400:
        message = _extractErrorMessage(response?.data) ?? 'Geçersiz istek';
        errorCode = 'BAD_REQUEST';
        break;
      case 401:
        message = 'Oturum süreniz doldu. Lütfen tekrar giriş yapın';
        errorCode = 'UNAUTHORIZED';
        break;
      case 403:
        message = 'Bu işlem için yetkiniz bulunmuyor';
        errorCode = 'FORBIDDEN';
        break;
      case 404:
        message = 'Aranan kaynak bulunamadı';
        errorCode = 'NOT_FOUND';
        break;
      case 422:
        message = _extractErrorMessage(response?.data) ??
            'Gönderilen veriler geçersiz';
        errorCode = 'VALIDATION_ERROR';
        break;
      case 429:
        message = 'Çok fazla istek gönderildi. Lütfen biraz bekleyin';
        errorCode = 'TOO_MANY_REQUESTS';
        break;
      case 500:
        message = 'Sunucu hatası oluştu';
        errorCode = 'INTERNAL_SERVER_ERROR';
        break;
      case 502:
        message = 'Sunucu geçici olarak kullanılamıyor';
        errorCode = 'BAD_GATEWAY';
        break;
      case 503:
        message = 'Hizmet geçici olarak kullanılamıyor';
        errorCode = 'SERVICE_UNAVAILABLE';
        break;
      default:
        message = 'Bilinmeyen sunucu hatası ($statusCode)';
        errorCode = 'SERVER_ERROR';
    }

    return ApiException(
      message: message,
      statusCode: statusCode,
      errorCode: errorCode,
      data: response?.data,
    );
  }

  static String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;

    // Backend'inizde error format: {"detail": "Message here"}
    if (data is Map<String, dynamic>) {
      if (data.containsKey('detail')) {
        return data['detail'].toString();
      }
      if (data.containsKey('message')) {
        return data['message'].toString();
      }
      if (data.containsKey('error')) {
        return data['error'].toString();
      }
    }

    return null;
  }

  @override
  String toString() {
    return 'ApiException: $message (${statusCode ?? 'No status code'})';
  }
}
