import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/payment_model.dart';
import '../../providers/payment_provider.dart';
import 'checkout_page.dart';

class PaymentMethodPage extends ConsumerWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMethod = ref.watch(selectedPaymentMethodProvider);
    final summary = ref.watch(paymentSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ödeme Yöntemi'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPaymentSummary(context, ref, summary),
          _buildSinglePaymentMethodCard(context, ref, selectedMethod),
          const SizedBox(height: 100),
        ],
      ),
      bottomNavigationBar: _buildContinueButton(context, ref),
    );
  }

  Widget _buildPaymentSummary(
      BuildContext context, WidgetRef ref, PaymentSummary summary) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sipariş Özeti',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildSummaryRow('Ürün Toplamı', summary.total - summary.shipping),
            _buildSummaryRow('Kargo', summary.shipping),
            if (summary.discount > 0)
              _buildSummaryRow('İndirim', -summary.discount, isDiscount: true),
            const Divider(),
            _buildSummaryRow(
              'Toplam',
              summary.total,
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount,
      {bool isDiscount = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.green : null,
            ),
          ),
          Text(
            '₺${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color:
                  isDiscount ? Colors.green : (isTotal ? Colors.orange : null),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSinglePaymentMethodCard(
    BuildContext context,
    WidgetRef ref,
    PaymentMethod selectedMethod,
  ) {
    final method = const PaymentMethod.creditCard();
    final fee =
        ref.watch(paymentMethodFeesProvider)[method] ?? 0.0;
    final isSelected = selectedMethod == method;

    return Card(
      margin: const EdgeInsets.all(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ref.read(selectedPaymentMethodProvider.notifier).state =
              const PaymentMethod.creditCard();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Payment method icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).primaryColor.withOpacity(0.1)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      method.icon,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Payment method info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kart ile Ödeme',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Visa, Mastercard ve banka kartları ile güvenli ödeme',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      if (fee > 0) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Komisyon: ₺${fee.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.orange[600],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Selection indicator
                if (isSelected)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  )
                else
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context, WidgetRef ref) {
    final selectedMethod = ref.watch(selectedPaymentMethodProvider);
    final summary = ref.watch(paymentSummaryProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(
                    paymentMethod: selectedMethod,
                    totalAmount: summary.total,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xFFFF6B35), // AppTheme.primaryOrange
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 8,
              shadowColor: const Color(0xFFFF6B35).withOpacity(0.4),
            ),
            child: Text(
              'Devam Et - ₺${summary.total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
