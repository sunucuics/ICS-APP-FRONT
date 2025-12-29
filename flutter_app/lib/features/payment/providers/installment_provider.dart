import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/paytr_installment_model.dart';
import 'paytr_provider.dart';

/// Provider for installment state (selected installment count)
final selectedInstallmentCountProvider = StateProvider<int>((ref) => 0); // 0 = single payment

/// Provider for fetching and caching installment options
final installmentOptionsProvider = FutureProvider.autoDispose.family<PayTRInstallmentsResponse, double>(
  (ref, baseAmount) async {
    final repository = ref.read(paytrRepositoryProvider);
    
    try {
      final rawResponse = await repository.getInstallments();
      return PayTRInstallmentsResponse.fromPayTRResponse(
        rawResponse,
        baseAmount: baseAmount,
      );
    } catch (e) {
      // Return error response if fetching fails
      return PayTRInstallmentsResponse(
        success: false,
        errorMessage: 'Taksit bilgileri alınamadı: ${e.toString()}',
      );
    }
  },
);
