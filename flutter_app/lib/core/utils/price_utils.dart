/// Price utility functions for currency display and formatting
/// 
/// IMPORTANT: Database stores prices in TL (not kuruş)
/// Example: A 10 TL product is stored as 10.0 in the database
/// 
/// PayTR expects amounts in kuruş, but this conversion is handled
/// by the backend (to_cents function in paytr_direct.py)

/// Formats a price value for display
/// 
/// Example:
/// - 10.0 → "10,00 ₺"
/// - 149.99 → "149,99 ₺"
String formatPrice(double price) {
  if (!price.isFinite || price < 0) {
    return "0,00 ₺";
  }
  // Format with Turkish locale (comma as decimal separator)
  final parts = price.toStringAsFixed(2).split('.');
  return "${parts[0]},${parts[1]} ₺";
}

/// Formats a price value for display without currency symbol
/// 
/// Example:
/// - 10.0 → "10,00"
/// - 149.99 → "149,99"
String formatPriceWithoutSymbol(double price) {
  if (!price.isFinite || price < 0) {
    return "0,00";
  }
  final parts = price.toStringAsFixed(2).split('.');
  return "${parts[0]},${parts[1]}";
}

/// Safely parses a price string to double
/// Handles both dot and comma as decimal separators
double parsePrice(String? priceStr) {
  if (priceStr == null || priceStr.isEmpty) {
    return 0.0;
  }
  // Replace comma with dot for parsing
  final normalized = priceStr.replaceAll(',', '.').replaceAll('₺', '').trim();
  return double.tryParse(normalized) ?? 0.0;
}
