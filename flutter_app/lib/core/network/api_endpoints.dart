import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiEndpoints {
  // Production URL - Google Cloud deployed backend
  static const String _productionUrl =
      'https://ics-backend-443215445942.europe-west1.run.app';

  // Local development URL
  // Android Emulator: 10.0.2.2 (localhost'un emulator karşılığı)
  // iOS Simulator: localhost
  // Fiziksel cihaz: Mac'in IP adresini kullan (örnek: http://192.168.1.100:8000)
  static const String _localUrl = 'http://10.0.2.2:8000'; // Android emulator için
  // iOS simulator için: 'http://localhost:8000'
  // Fiziksel cihaz için Mac IP: 'http://YOUR_MAC_IP:8000'

  // Debug mode flag - automatically detects debug/release mode
  static bool get isDebug => kDebugMode;

  // Base URL - Debug modda local, release modda production
  static String get baseUrl {
    if (isDebug) {
      // iOS Simulator için localhost kullan
      if (Platform.isIOS) {
        return 'http://localhost:8000';
      }
      // Android Emulator için 10.0.2.2 kullan
      return _localUrl;
    }
    return _productionUrl;
  }

  // Auth endpoints
  static const String authRegister = '/auth/register';
  static const String authLogin = '/auth/login';
  static const String authLogout = '/auth/logout';
  static const String authResetPassword = '/auth/reset-password';
  static const String authUpdateProfile = '/auth/me';
  static const String authCheckEmail = '/auth/check-email';
  static const String authDeleteInitiate = '/auth/delete-account/initiate';
  static const String authDeleteVerify = '/auth/delete-account/verify';

  // User endpoints
  static const String userProfile = '/users/me';
  static const String userAddresses = '/users/me/addresses';
  static const String userFcmToken = '/users/me/fcm-token';
  static String userAddress(String addressId) =>
      '/users/me/addresses/$addressId';

  // Address endpoints
  static const String addresses = '/users/me/addresses';
  static String address(String addressId) => '/users/me/addresses/$addressId';
  static const String currentAddress = '/users/me/addresses/current';

  // Categories endpoints
  static const String categories = '/categories';
  static String category(String categoryId) => '/categories/$categoryId';

  // Products endpoints
  static const String products = '/products';
  static String product(String productId) => '/products/$productId';

  // Services endpoints
  static const String services = '/services';
  static String service(String serviceId) => '/services/$serviceId';

  // Cart endpoints
  static const String cart = '/cart';
  static const String cartItems = '/cart/items';
  static const String cartTotal = '/cart/total';
  static String cartItem(String productId) => '/cart/items/$productId';

  // Orders endpoints
  static const String orders = '/orders';
  static String order(String orderId) => '/orders/$orderId';
  static String orderTracking(String orderId) => '/orders/$orderId/tracking';
  static const String ordersQueue = '/admin/orders/queue';
  static String orderShip(String orderId) => '/admin/orders/$orderId/ship';
  static String orderDeliver(String orderId) => '/admin/orders/$orderId/deliver';
  static String orderCancel(String orderId) => '/admin/orders/$orderId/cancel';
  static String adminOrderDelete(String orderId) => '/admin/orders/$orderId';
  static const String ordersDev = '/admin/orders/dev';
  static const String ordersEmailTest = '/admin/orders/_email-test';

  // PayTR endpoints - Direct API (new backend integration)
  static const String paytrDirectInit = '/paytr/direct/init';
  static const String paytrDirectVerify = '/paytr/direct/verify';
  static const String paytrRefreshToken = '/paytr/direct/refresh-token';
  static const String paytrCallback = '/paytr/callback';
  static const String paytrInstallments = '/paytr/installments';
  static const String paytrInstallmentQuote = '/paytr/direct/installment-quote';
  static const String paytrBinDetail = '/paytr/direct/bin-detail';

  // PayTR iFrame API (optional)
  static const String paytrIframeInit = '/paytr/iframe/init';

  // Legacy PayTR token endpoint (deprecated)
  @Deprecated('Use paytrDirectInit instead')
  static const String paytrToken = '/paytr/token';

  // Appointments endpoints
  static const String appointments = '/appointments/';
  static const String appointmentsCalendar = '/appointments/calendar';
  static const String myAppointments = '/appointments/my-appointments';
  static String appointment(String appointmentId) =>
      '/appointments/$appointmentId';
  static String serviceAvailability(String serviceId) =>
      '/appointments/service-availability/$serviceId';

  // Comments endpoints
  static const String comments = '/comments';
  static String comment(String commentId) => '/comments/$commentId';

  // Product comments
  static String productComments(String productId) =>
      '/comments/products/$productId';

  // Service comments
  static String serviceComments(String serviceId) =>
      '/comments/services/$serviceId';

  // Admin comments endpoints
  static const String adminCommentsProducts = '/admin/comments/products';
  static const String adminCommentsServices = '/admin/comments/services';
  static String adminComment(String commentId) => '/admin/comments/$commentId';

  // Profanity filter endpoints
  static const String adminProfanity = '/admin/comments/profanity';
  static String adminProfanityWord(String wordId) =>
      '/admin/comments/profanity/$wordId';

  // Featured endpoints
  static const String featured = '/featured';
  static const String featuredProducts = '/featured/products';
  static const String featuredServices = '/featured/services';

  // Notifications endpoints
  static const String notifications = '/notifications';
  static String notification(String id) => '/notifications/$id';
  static String notificationRead(String id) => '/notifications/$id/read';
  static const String notificationsReadAll = '/notifications/read-all';

  // Admin endpoints (not needed for mobile app, but kept for reference)
  static const String adminCategories = '/admin/categories';
  static const String adminProducts = '/admin/products';
  static const String adminServices = '/admin/services';
  static const String adminOrders = '/admin/orders';
  static const String adminAppointments = '/admin/appointments/';
  static String adminAppointment(String appointmentId) =>
      '/admin/appointments/$appointmentId';
  static String adminServiceAvailability(String serviceId) =>
      '/admin/appointments/service-availability/$serviceId';
  // Discounts endpoints (mounted at /admin/discounts in backend)
  static const String discounts = '/admin/discounts';
  static const String discountsList = '/admin/discounts/';
  static String discount(String discountId) => '/admin/discounts/$discountId';
  static String discountUpdateForm(String discountId) => '/admin/discounts/$discountId/form';
  
  static const String adminComments = '/admin/comments';
  static const String adminFeatured = '/admin/featured';

  // Admin Panel Notifications endpoints (gelen bildirimler - randevu, sipariş vb.)
  static const String adminPanelNotifications = '/admin/notifications';
  static const String adminPanelNotificationsUnreadCount =
      '/admin/notifications/unread-count';
  static const String adminPanelNotificationsReadAll =
      '/admin/notifications/read-all';
  static const String adminPanelNotificationsClearAll =
      '/admin/notifications/clear-all';
  static String adminPanelNotificationRead(String id) =>
      '/admin/notifications/$id/read';
  static String adminPanelNotificationDelete(String id) =>
      '/admin/notifications/$id';
}
