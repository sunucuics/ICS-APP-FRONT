import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order_model.dart';

/// Format money with currency
/// Uses Intl.NumberFormat for proper formatting
String formatMoney(double value, {String currency = 'TRY'}) {
  return NumberFormat.currency(
    symbol: currency == 'TRY' ? '₺' : currency,
    decimalDigits: 2,
    locale: 'tr_TR',
  ).format(value);
}

/// Format date from ISO 8601 string to localized format
String formatDate(String isoString) {
  try {
    final date = DateTime.parse(isoString);
    return DateFormat('dd/MM/yyyy HH:mm', 'tr_TR').format(date);
  } catch (e) {
    return isoString;
  }
}

/// Format date from DateTime to localized format
String formatDateTime(DateTime? date) {
  if (date == null) return '';
  return DateFormat('dd/MM/yyyy HH:mm', 'tr_TR').format(date);
}

/// Get next page cursor from response
/// Returns null if no more pages
String? nextPage(OrdersListResponse response) {
  return response.nextCursor;
}

/// Check if order can be shipped (status is preparing)
bool canShip(Order order) {
  return order.status == const OrderStatus.preparing();
}

/// Check if order can be delivered (status is shipped)
bool canDeliver(Order order) {
  return order.status == const OrderStatus.shipped();
}

/// Check if order can be canceled (status is preparing or shipped)
bool canCancel(Order order) {
  return order.status == const OrderStatus.preparing() ||
      order.status == const OrderStatus.shipped();
}

/// Get status color for UI
Color getStatusColor(OrderStatus status) {
  return status.when(
    preparing: () => Colors.orange,
    shipped: () => Colors.purple,
    delivered: () => Colors.green,
    canceled: () => Colors.red,
    paymentFailed: () => Colors.red,
  );
}

/// Get status icon for UI
IconData getStatusIcon(OrderStatus status) {
  return status.when(
    preparing: () => Icons.shopping_bag,
    shipped: () => Icons.local_shipping,
    delivered: () => Icons.check_circle,
    canceled: () => Icons.cancel,
    paymentFailed: () => Icons.payment,
  );
}

