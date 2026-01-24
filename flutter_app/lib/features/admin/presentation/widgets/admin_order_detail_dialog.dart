import 'package:flutter/material.dart';
import '../../../../core/models/order_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/order_utils.dart';
import '../../../../core/utils/price_utils.dart';

class AdminOrderDetailDialog extends StatelessWidget {
  final Order order;

  const AdminOrderDetailDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final displayAddress = _getDisplayAddress();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final backgroundColor = isDark ? Colors.grey[900]! : Colors.white;
    final dividerColor = isDark ? Colors.grey[700]! : Colors.grey[300]!;

    return AlertDialog(
      title: Text('Sipariş Detayları #${order.id}', 
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Address Section - CRITICAL: Show FIRST, always visible
              _buildSectionHeader('Teslimat Adresi', context),
              // Address display - Always show this section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: displayAddress != null 
                      ? AppTheme.primaryOrange.withOpacity(0.1)
                      : Colors.red.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: displayAddress != null 
                        ? AppTheme.primaryOrange 
                        : Colors.red,
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: displayAddress != null 
                              ? AppTheme.primaryOrange 
                              : Colors.red,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            displayAddress ?? 'Adres bilgisi bulunamadı',
                            style: TextStyle(
                              color: displayAddress != null ? textColor : Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              // Section: Customer
              _buildSectionHeader('Müşteri Bilgileri', context),
              _buildInfoRow('Müşteri ID', order.userId, context),
              if (order.customer.fullName != null) 
                _buildInfoRow('Müşteri', order.customer.fullName!, context),
              if (order.customer.phone != null) 
                _buildInfoRow('Telefon', order.customer.phone!, context),
              if (order.customer.email != null) 
                _buildInfoRow('Email', order.customer.email!, context),

              const SizedBox(height: 16),
              _buildSectionHeader('Sipariş Durumu', context),
              _buildStatusChip(order.status.displayName, _getStatusColor(order.status)),
              
              // Shipping Details
              if (order.shipping.provider != null || order.shipping.trackingNumber != null) ...[
                 const SizedBox(height: 16),
                 _buildSectionHeader('Kargo Bilgileri', context),
                 if (order.shipping.provider != null) 
                   _buildInfoRow('Firma', order.shipping.provider!, context),
                 if (order.shipping.trackingNumber != null) 
                   _buildInfoRow('Takip No', order.shipping.trackingNumber!, context),
                 if (order.shipping.shippedAt != null) 
                   _buildInfoRow('Kargoya Veriliş', formatDateTime(order.shipping.shippedAt!), context),
              ],

              const SizedBox(height: 16),
              _buildSectionHeader('Ürünler', context),
              ...order.items.map((item) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: dividerColor),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Row(
                  children: [
                    Icon(Icons.inventory_2_outlined, size: 20, color: isDark ? Colors.grey[400] : Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(child: Text('${item.name} x${item.qty}', style: TextStyle(color: textColor))),
                    Text(formatMoney(item.finalPrice ?? item.price ?? 0), 
                        style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                  ],
                ),
              )),

              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Toplam Tutar:', style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                    Text(formatMoney(order.totals.grandTotal), 
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryOrange, fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Kapat'),
        ),
      ],
    );
  }

  String? _getDisplayAddress() {
    // Priority order for address lookup:
    // 1. shipping_info.address (from backend: shipping_info: { address: "..." })
    // 2. customer.address.full_address (from backend: customer: { address: { full_address: "..." } })
    
    // 1. Try shipping_info.address first
    final shippingInfoAddr = order.shippingInfo?.shippingAddress;
    if (shippingInfoAddr != null && shippingInfoAddr.trim().isNotEmpty) {
      return shippingInfoAddr.trim();
    }
    
    // 2. Try customer.address.full_address
    final customerFullAddr = order.customer.address?.fullAddress;
    if (customerFullAddr != null && customerFullAddr.trim().isNotEmpty) {
      return customerFullAddr.trim();
    }

    // 3. Try customer address components (line1, city, postalCode)
    if (order.customer.address?.line1 != null && 
        order.customer.address!.line1!.trim().isNotEmpty) {
      final parts = <String>[];
      parts.add(order.customer.address!.line1!.trim());
      if (order.customer.address!.city != null && 
          order.customer.address!.city!.trim().isNotEmpty) {
        parts.add(order.customer.address!.city!.trim());
      }
      if (order.customer.address!.postalCode != null && 
          order.customer.address!.postalCode!.trim().isNotEmpty) {
        parts.add(order.customer.address!.postalCode!.trim());
      }
      if (parts.isNotEmpty) {
        return parts.join(', ');
      }
    }

    // 4. Try legacy shipping.address field
    if (order.shipping.shippingAddress != null && 
        order.shipping.shippingAddress!.trim().isNotEmpty) {
      return order.shipping.shippingAddress!.trim();
    }
    
    // 5. Try legacy address field (old format)
    if (order.address != null) {
      final parts = <String>[];
      if (order.address!.street != null && order.address!.street!.trim().isNotEmpty) {
        parts.add(order.address!.street!.trim());
      }
      if (order.address!.buildingNo != null && order.address!.buildingNo!.trim().isNotEmpty) {
        parts.add('No: ${order.address!.buildingNo!.trim()}');
      }
      if (order.address!.city != null && order.address!.city!.trim().isNotEmpty) {
        parts.add(order.address!.city!.trim());
      }
      if (order.address!.zipCode != null && order.address!.zipCode!.trim().isNotEmpty) {
        parts.add(order.address!.zipCode!.trim());
      }
      if (parts.isNotEmpty) {
        return parts.join(', ');
      }
    }

    return null;
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppTheme.primaryNavy;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor,
          decoration: TextDecoration.underline,
          decorationColor: Colors.orange,
          decorationThickness: 2,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final labelColor = isDark ? Colors.grey[400] : Colors.grey;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: labelColor,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    return status.when(
      preparing: () => Colors.orange,
      shipped: () => Colors.purple,
      delivered: () => Colors.green,
      canceled: () => Colors.red,
      paymentFailed: () => Colors.red,
    );
  }
}
