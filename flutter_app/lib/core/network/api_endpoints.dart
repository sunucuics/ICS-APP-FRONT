class ApiEndpoints {
  // Base URL - Backend 0.0.0.0 ile çalışıyor, gerçek IP kullanıyoruz
  static const String baseUrl = 'http://192.168.1.146:8000';

  // Debug mode flag
  static const bool isDebug = true;

  // Auth endpoints
  static const String authRegister = '/auth/register';
  static const String authLogin = '/auth/login';
  static const String authLogout = '/auth/logout';
  static const String authResetPassword = '/auth/reset-password';

  // User endpoints
  static const String userProfile = '/users/me';
  static const String userAddresses = '/users/me/addresses';
  static String userAddress(String addressId) =>
      '/users/me/addresses/$addressId';

  // Address endpoints
  static const String addresses = '/users/me/addresses';
  static String address(String addressId) => '/users/me/addresses/$addressId';
  static const String currentAddress = '/users/me/current-address';

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

  // Appointments endpoints
  static const String appointments = '/appointments';
  static const String appointmentsCalendar = '/appointments/calendar';
  static String appointment(String appointmentId) =>
      '/appointments/$appointmentId';

  // Comments endpoints
  static const String comments = '/comments';
  static String comment(String commentId) => '/comments/$commentId';

  // Featured endpoints
  static const String featured = '/featured';
  static const String featuredProducts = '/featured/products';
  static const String featuredServices = '/featured/services';

  // Admin endpoints (not needed for mobile app, but kept for reference)
  static const String adminCategories = '/admin/categories';
  static const String adminProducts = '/admin/products';
  static const String adminServices = '/admin/services';
  static const String adminOrders = '/admin/orders';
  static const String adminAppointments = '/admin/appointments';
  static const String adminDiscounts = '/admin/discounts';
  static const String adminComments = '/admin/comments';
  static const String adminFeatured = '/admin/featured';
}
