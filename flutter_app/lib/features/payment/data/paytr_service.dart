import 'package:dio/dio.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/exceptions/api_exception.dart';
import '../models/paytr_models.dart';

/// PayTR API servisi
///
/// Backend'deki /paytr/direct/init endpoint'ini çağırır ve
/// PayTR form alanlarını alır.
class PayTRService {
  final Dio _dio;

  PayTRService(this._dio);

  /// PayTR Direct API init çağrısı
  ///
  /// Backend'e sipariş bilgilerini gönderir ve PayTR form alanlarını alır.
  /// Dönen alanlar WebView'da HTML forma yazılır ve PayTR'ye POST edilir.
  ///
  /// [request] - Sipariş bilgileri (merchant_oid, email, payment_amount, basket, vs.)
  ///
  /// Returns: PayTRInitResponse - action URL ve hidden form alanları
  Future<PayTRInitResponse> initDirectPayment(PayTRInitRequest request) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.paytrDirectInit,
        data: request.toApiJson(),
      );

      return PayTRInitResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Taksit oranlarını getir (opsiyonel)
  Future<Map<String, dynamic>> getInstallments() async {
    try {
      final response = await _dio.get(ApiEndpoints.paytrInstallments);
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Taksit değişikliği için token yenile
  ///
  /// Mevcut sipariş için yeni taksit sayısı ile PayTR token üretir.
  /// HMAC imzası taksit sayısını içerdiği için, taksit değiştiğinde
  /// yeni token almak gerekir.
  Future<PayTRInitResponse> refreshToken({
    required String merchantOid,
    required int installmentCount,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.paytrRefreshToken,
        data: {
          'merchant_oid': merchantOid,
          'installment_count': installmentCount,
        },
      );

      return PayTRInitResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}

