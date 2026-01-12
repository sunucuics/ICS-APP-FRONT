import 'package:dio/dio.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/exceptions/api_exception.dart';
import '../models/paytr_models.dart';

/// PayTR API servisi
///
/// Backend'deki PayTR endpoint'lerini çağırır:
/// - /paytr/direct/init - Ödeme başlatma
/// - /paytr/direct/installment-quote - BIN bazlı taksit seçenekleri
/// - /paytr/direct/bin-detail - Kart tipi sorgulama
/// - /paytr/direct/refresh-token - Token yenileme
class PayTRService {
  final Dio _dio;

  PayTRService(this._dio);

  /// PayTR Direct API init çağrısı
  ///
  /// Backend'e sipariş bilgilerini gönderir ve PayTR form alanlarını alır.
  /// Dönen alanlar WebView'da HTML forma yazılır ve PayTR'ye POST edilir.
  ///
  /// [request] - Sipariş bilgileri (merchant_oid, email, payment_amount, basket, vs.)
  /// 3 taksit için request.binNumber zorunludur.
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

  /// BIN detayı sorgula
  ///
  /// Kartın ilk 6-8 hanesine göre:
  /// - Kredi/banka kartı mı (credit/debit)
  /// - Kart markası (visa, mastercard, bonus, world, vb.)
  /// - Taksit yapılabilir mi
  ///
  /// [binNumber] - Kartın ilk 6 veya 8 hanesi
  Future<BinDetailResponse> getBinDetail(String binNumber) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.paytrBinDetail,
        data: {
          'bin_number': binNumber.replaceAll(' ', ''),
          'debug_on': 0,
        },
      );

      return BinDetailResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Taksit seçeneklerini sorgula (BIN bazlı)
  ///
  /// Kartın BIN numarasına ve sepet tutarına göre:
  /// - Peşin fiyat
  /// - 3 taksit seçeneği (varsa, %15 vade farkı ile)
  ///
  /// Debit kart veya taksit programına uygun olmayan kartlar için
  /// sadece peşin seçeneği döner.
  ///
  /// [binNumber] - Kartın ilk 6 veya 8 hanesi
  /// [amountTl] - Peşin fiyat (TL cinsinden)
  Future<InstallmentQuoteResponse> getInstallmentQuote({
    required String binNumber,
    required double amountTl,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.paytrInstallmentQuote,
        data: {
          'bin_number': binNumber.replaceAll(' ', ''),
          'amount_tl': amountTl,
        },
      );

      return InstallmentQuoteResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Taksit oranlarını getir (genel - BIN bağımsız)
  /// 
  /// Not: Spesifik taksit seçenekleri için getInstallmentQuote kullanın.
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
  ///
  /// [merchantOid] - Sipariş/ödeme oturumu ID'si
  /// [installmentCount] - 0 (peşin) veya 3 (3 taksit)
  /// [binNumber] - 3 taksit için zorunlu, kartın ilk 6-8 hanesi
  Future<PayTRInitResponse> refreshToken({
    required String merchantOid,
    required int installmentCount,
    String? binNumber,
  }) async {
    try {
      final data = <String, dynamic>{
        'merchant_oid': merchantOid,
        'installment_count': installmentCount,
      };

      // 3 taksit için bin_number zorunlu
      if (binNumber != null && binNumber.isNotEmpty) {
        data['bin_number'] = binNumber.replaceAll(' ', '');
      }

      final response = await _dio.post(
        ApiEndpoints.paytrRefreshToken,
        data: data,
      );

      return PayTRInitResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
