import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/paytr_installment_model.dart';
import '../../providers/installment_provider.dart';

/// Widget for selecting installment option
/// Shows available installment options and allows user to select one
class InstallmentSelectionWidget extends ConsumerWidget {
  final double baseAmount;
  final ValueChanged<int>? onInstallmentSelected;

  const InstallmentSelectionWidget({
    super.key,
    required this.baseAmount,
    this.onInstallmentSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCount = ref.watch(selectedInstallmentCountProvider);
    final installmentAsync = ref.watch(installmentOptionsProvider(baseAmount));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.credit_card, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Taksit Seçimi',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            installmentAsync.when(
              data: (response) {
                if (!response.success) {
                  // If error, show single payment option only
                  return _buildSinglePaymentOption(
                    context,
                    ref,
                    selectedCount,
                    baseAmount,
                  );
                }

                if (response.allOptions.isEmpty) {
                  // No installment options available
                  return _buildSinglePaymentOption(
                    context,
                    ref,
                    selectedCount,
                    baseAmount,
                  );
                }

                // Show installment options
                return _buildInstallmentOptions(
                  context,
                  ref,
                  selectedCount,
                  response.allOptions,
                  baseAmount,
                );
              },
              loading: () => _buildLoadingState(context),
              error: (error, stack) => _buildErrorState(
                context,
                ref,
                selectedCount,
                baseAmount,
                error.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSinglePaymentOption(
    BuildContext context,
    WidgetRef ref,
    int selectedCount,
    double amount,
  ) {
    final isSelected = selectedCount == 0;
    return _buildOptionTile(
      context: context,
      title: 'Tek Çekim',
      subtitle: '₺${amount.toStringAsFixed(2)}',
      isSelected: isSelected,
      onTap: () {
        ref.read(selectedInstallmentCountProvider.notifier).state = 0;
        onInstallmentSelected?.call(0);
      },
    );
  }

  Widget _buildInstallmentOptions(
    BuildContext context,
    WidgetRef ref,
    int selectedCount,
    List<PayTRInstallmentOption> options,
    double baseAmount,
  ) {
    return Column(
      children: [
        // Single payment option (always available)
        _buildOptionTile(
          context: context,
          title: 'Tek Çekim',
          subtitle: '₺${baseAmount.toStringAsFixed(2)}',
          isSelected: selectedCount == 0,
          onTap: () {
            ref.read(selectedInstallmentCountProvider.notifier).state = 0;
            onInstallmentSelected?.call(0);
          },
        ),
        const Divider(height: 1),
        // Installment options
        ...options.map((option) {
          final isSelected = selectedCount == option.month;
          return _buildOptionTile(
            context: context,
            title: option.displayText,
            subtitle: option.monthlyDisplayText,
            trailing: option.totalDisplayText,
            isSelected: isSelected,
            onTap: () {
              ref.read(selectedInstallmentCountProvider.notifier).state = option.month;
              onInstallmentSelected?.call(option.month);
            },
            showRate: option.rate > 0,
            rateText: option.rateDisplayText,
          );
        }),
      ],
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    String? trailing,
    required bool isSelected,
    required VoidCallback onTap,
    bool showRate = false,
    String? rateText,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                )
              : null,
        ),
        child: Row(
          children: [
            // Radio indicator
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  width: 2,
                ),
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  if (showRate && rateText != null && rateText.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      rateText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[500],
                            fontSize: 11,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            // Trailing (total amount)
            if (trailing != null)
              Text(
                trailing,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
              ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Taksit seçenekleri yükleniyor...'),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    WidgetRef ref,
    int selectedCount,
    double baseAmount,
    String errorMessage,
  ) {
    return Column(
      children: [
        // Show single payment option even on error
        _buildSinglePaymentOption(
          context,
          ref,
          selectedCount,
          baseAmount,
        ),
        const SizedBox(height: 8),
        // Optional: Show error message (collapsed by default, can expand)
        Text(
          'Taksit bilgileri alınamadı. Tek çekim ile devam edebilirsiniz.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.orange[700],
                fontStyle: FontStyle.italic,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
