import 'package:dio/dio.dart';
import '../../../core/models/paytr_model.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/exceptions/api_exception.dart';

class PayTRApiService {
  final Dio _dio;

  PayTRApiService(this._dio);

  /// Get PayTR Direct API init response (returns form fields for POST to PayTR)
  Future<PayTRDirectInitResponse> getDirectInit(PayTRDirectInitRequest request) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.paytrDirectInit,
        data: request.toJson(),
      );
      return PayTRDirectInitResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Verify PayTR Direct API fields (debug only)
  Future<Map<String, dynamic>> verifyDirectInit(PayTRDirectInitFields fields) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.paytrDirectVerify,
        data: {'fields': fields.toJson()},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Get PayTR iFrame token (optional)
  Future<PayTRIframeInitResponse> getIframeToken(PayTRIframeInitRequest request) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.paytrIframeInit,
        data: request.toJson(),
      );
      return PayTRIframeInitResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Get PayTR installments info
  Future<Map<String, dynamic>> getInstallments() async {
    try {
      final response = await _dio.get(ApiEndpoints.paytrInstallments);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // Legacy methods (deprecated)
  @Deprecated('Use getDirectInit instead')
  Future<PayTRTokenResponse> getPaymentToken(PayTRTokenRequest request) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.paytrToken,
        data: request.toJson(),
      );
      return PayTRTokenResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
