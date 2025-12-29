import 'package:freezed_annotation/freezed_annotation.dart';

part 'paytr_installment_model.freezed.dart';
part 'paytr_installment_model.g.dart';

/// PayTR Installment Option - Single installment option for a specific month
@freezed
class PayTRInstallmentOption with _$PayTRInstallmentOption {
  const factory PayTRInstallmentOption({
    required int month, // Taksit sayısı (2-12)
    required double rate, // Komisyon oranı (%)
    required double monthlyAmount, // Aylık ödeme tutarı
    required double totalAmount, // Toplam ödeme tutarı
  }) = _PayTRInstallmentOption;

  factory PayTRInstallmentOption.fromJson(Map<String, dynamic> json) =>
      _$PayTRInstallmentOptionFromJson(json);

  /// Calculate installment values from base amount and rate
  factory PayTRInstallmentOption.calculate({
    required double baseAmount,
    required int month,
    required double ratePercent,
  }) {
    // Calculate total: baseAmount * (1 + rate/100), rounded to 2 decimals
    final total = double.parse((baseAmount * (1.0 + (ratePercent / 100.0))).toStringAsFixed(2));
    // Calculate monthly: total / month, rounded to 2 decimals
    final monthly = double.parse((total / month).toStringAsFixed(2));
    return PayTRInstallmentOption(
      month: month,
      rate: ratePercent,
      monthlyAmount: monthly,
      totalAmount: total,
    );
  }
}

extension PayTRInstallmentOptionExtension on PayTRInstallmentOption {
  double get baseAmount => totalAmount / (1.0 + (rate / 100.0));
}

/// PayTR Installment Options for a specific bank/card type
@freezed
class PayTRBankInstallments with _$PayTRBankInstallments {
  const factory PayTRBankInstallments({
    required String bankCode, // Banka kodu (bonus, maximum, world, etc.)
    required List<PayTRInstallmentOption> options, // Available installment options
  }) = _PayTRBankInstallments;

  factory PayTRBankInstallments.fromJson(Map<String, dynamic> json) =>
      _$PayTRBankInstallmentsFromJson(json);
}

/// PayTR Installments Response - Parsed installment data from PayTR
@freezed
class PayTRInstallmentsResponse with _$PayTRInstallmentsResponse {
  const factory PayTRInstallmentsResponse({
    @Default(false) bool success,
    String? errorMessage,
    @Default({}) Map<String, PayTRBankInstallments> banks, // bankCode -> installments
    @Default([]) List<PayTRInstallmentOption> allOptions, // Flattened list of all options (unique by month, best rate)
  }) = _PayTRInstallmentsResponse;

  factory PayTRInstallmentsResponse.fromJson(Map<String, dynamic> json) =>
      _$PayTRInstallmentsResponseFromJson(json);

  /// Parse raw PayTR response (defensive parsing for variable formats)
  factory PayTRInstallmentsResponse.fromPayTRResponse(
    Map<String, dynamic> rawResponse, {
    double? baseAmount,
  }) {
    try {
      // PayTR response format can vary:
      // Option 1: { "status": "success", "data": { "bank_code": { "installments": { "3": 9.57, ... } } } }
      // Option 2: { "bank_code": { "installments": { "3": 9.57, ... } } }
      // Option 3: { "bank_code": { "3": 9.57, "6": 15.68, ... } }

      final status = rawResponse['status'] as String?;
      if (status != null && status != 'success') {
        return PayTRInstallmentsResponse(
          success: false,
          errorMessage: rawResponse['err_msg'] as String? ?? 'Unknown error',
        );
      }

      // Try to get data - handle different root structures
      final data = rawResponse['data'] as Map<String, dynamic>? ?? rawResponse;
      if (data.isEmpty) {
        return const PayTRInstallmentsResponse(
          success: false,
          errorMessage: 'No installment data available',
        );
      }

      final banks = <String, PayTRBankInstallments>{};
      final allOptionsMap = <int, PayTRInstallmentOption>{};

      // Iterate through banks
      for (final entry in data.entries) {
        final bankCode = entry.key;
        if (bankCode == 'status' || bankCode == 'err_msg' || bankCode == 'err_no') {
          continue; // Skip metadata fields
        }

        final bankData = entry.value;
        if (bankData is! Map<String, dynamic>) continue;

        // Try to get installments - handle different schema possibilities
        final installmentsRaw = bankData['installments'];
        final installmentsData = (installmentsRaw is Map<String, dynamic>)
            ? installmentsRaw
            : bankData;

        if (installmentsData.isEmpty) {
          continue;
        }

        final options = <PayTRInstallmentOption>[];

        // Parse each installment option
        for (final installmentEntry in installmentsData.entries) {
          final monthKey = installmentEntry.key;
          final rateValue = installmentEntry.value;

          // Try to parse month number
          final month = int.tryParse(monthKey);
          if (month == null || month < 2 || month > 12) continue;

          // Try to parse rate (can be number or string)
          double? rate;
          if (rateValue is num) {
            rate = rateValue.toDouble();
          } else if (rateValue is String) {
            rate = double.tryParse(rateValue);
          }

          if (rate == null) continue;

          // Calculate installment values if baseAmount is provided
          if (baseAmount != null) {
            final option = PayTRInstallmentOption.calculate(
              baseAmount: baseAmount,
              month: month,
              ratePercent: rate,
            );
            options.add(option);

            // Track best option for each month (lowest rate)
            final existing = allOptionsMap[month];
            if (existing == null || option.rate < existing.rate) {
              allOptionsMap[month] = option;
            }
          } else {
            // If no baseAmount, create option with rate only
            final option = PayTRInstallmentOption(
              month: month,
              rate: rate,
              monthlyAmount: 0.0,
              totalAmount: 0.0,
            );
            options.add(option);
          }
        }

        if (options.isNotEmpty) {
          // Sort by month
          options.sort((a, b) => a.month.compareTo(b.month));

          banks[bankCode] = PayTRBankInstallments(
            bankCode: bankCode,
            options: options,
          );
        }
      }

      if (banks.isEmpty) {
        return const PayTRInstallmentsResponse(
          success: false,
          errorMessage: 'No installment options found',
        );
      }

      return PayTRInstallmentsResponse(
        success: true,
        banks: banks,
        allOptions: allOptionsMap.values.toList()
          ..sort((a, b) => a.month.compareTo(b.month)),
      );
    } catch (e) {
      return PayTRInstallmentsResponse(
        success: false,
        errorMessage: 'Failed to parse installment data: $e',
      );
    }
  }
}

/// Helper extension for PayTRInstallmentsResponse methods
extension PayTRInstallmentsResponseExtension on PayTRInstallmentsResponse {
  /// Get installment options for a specific bank
  List<PayTRInstallmentOption>? getBankOptions(String bankCode) {
    return banks[bankCode]?.options;
  }

  /// Get best option for a specific month (lowest rate across all banks)
  PayTRInstallmentOption? getBestOptionForMonth(int month) {
    try {
      return allOptions.firstWhere(
        (option) => option.month == month,
      );
    } catch (e) {
      return null;
    }
  }
}

/// Helper extension for formatting installment display
extension PayTRInstallmentDisplayExtension on PayTRInstallmentOption {
  String get displayText {
    if (month == 0) return 'Tek Çekim';
    return '$month Taksit';
  }

  String get monthlyDisplayText {
    return '₺${monthlyAmount.toStringAsFixed(2)} / Ay';
  }

  String get totalDisplayText {
    return 'Toplam: ₺${totalAmount.toStringAsFixed(2)}';
  }

  String get rateDisplayText {
    if (rate == 0.0) return '';
    return 'Komisyon: %${rate.toStringAsFixed(2)}';
  }
}
