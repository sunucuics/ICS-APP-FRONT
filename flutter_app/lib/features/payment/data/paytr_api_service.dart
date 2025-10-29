import 'package:dio/dio.dart';
import '../../../core/models/paytr_model.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/exceptions/api_exception.dart';

class PayTRApiService {
  final Dio _dio;

  PayTRApiService(this._dio);

  /// Get PayTR payment token
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
