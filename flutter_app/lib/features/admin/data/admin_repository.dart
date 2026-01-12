import '../../../core/models/product_model.dart';
import '../../../core/models/order_model.dart';
import '../../../core/models/appointment_model.dart';
import '../../../core/models/comment_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/models/service_model.dart';
import '../models/admin_discount_model.dart';
import '../models/admin_notification_model.dart';
import '../models/admin_settings_model.dart';
import '../models/admin_filter_model.dart';
import 'admin_api_service.dart';

class AdminRepository {
  final AdminApiService _apiService;

  AdminRepository({required AdminApiService apiService})
      : _apiService = apiService;

  // Dashboard
  Future<Map<String, dynamic>> getDashboardStats() async {
    return await _apiService.getDashboardStats();
  }

  // Categories
  Future<List<Category>> getCategories() async {
    return await _apiService.getCategories();
  }

  Future<Category> createCategory(Map<String, dynamic> categoryData) async {
    return await _apiService.createCategory(categoryData);
  }

  Future<Category> updateCategory(
      String categoryId, Map<String, dynamic> categoryData) async {
    return await _apiService.updateCategory(categoryId, categoryData);
  }

  Future<void> deleteCategory(String categoryId) async {
    return await _apiService.deleteCategory(categoryId);
  }

  // Products
  Future<List<Product>> getProducts() async {
    return await _apiService.getProducts();
  }

  Future<Product> createProduct(Map<String, dynamic> productData) async {
    return await _apiService.createProduct(productData);
  }

  Future<Product> updateProduct(
      String productId, Map<String, dynamic> productData) async {
    return await _apiService.updateProduct(productId, productData);
  }

  Future<void> deleteProduct(String productId) async {
    return await _apiService.deleteProduct(productId);
  }

  // Orders - Updated for PayTR integration
  Future<List<Order>> getOrders() async {
    return await _apiService.getOrders();
  }

  Future<AdminOrdersQueueResponse> getOrdersQueue() async {
    return await _apiService.getOrdersQueue();
  }

  Future<Order> shipOrder(String orderId, OrderShipRequest request) async {
    return await _apiService.shipOrder(orderId, request);
  }

  Future<Order> deliverOrder(String orderId) async {
    return await _apiService.deliverOrder(orderId);
  }

  Future<Order> cancelOrder(String orderId, OrderCancelRequest request) async {
    return await _apiService.cancelOrder(orderId, request);
  }

  Future<void> deleteOrder(String orderId) async {
    return await _apiService.deleteOrder(orderId);
  }

  Future<Order> updateOrderStatus(String orderId, String status) async {
    return await _apiService.updateOrderStatus(orderId, status);
  }

  Future<Order> createTestOrder() async {
    return await _apiService.createTestOrder();
  }

  Future<Map<String, dynamic>> testEmail() async {
    return await _apiService.testEmail();
  }

  // Appointments
  Future<List<AppointmentWithDetails>> getAppointments() async {
    return await _apiService.getAppointments();
  }

  Future<void> updateAppointmentStatus(
      String appointmentId, String status) async {
    return await _apiService.updateAppointmentStatus(appointmentId, status);
  }

  // Comments
  Future<List<Comment>> getComments() async {
    return await _apiService.getComments();
  }

  Future<void> approveComment(String commentId) async {
    return await _apiService.approveComment(commentId);
  }

  Future<void> deleteComment(String commentId) async {
    return await _apiService.deleteComment(commentId);
  }

  // Discounts
  /// Get list of discounts with optional filters
  Future<List<AdminDiscount>> getDiscounts({
    String? productId,
    bool? active,
  }) async {
    return await _apiService.getDiscounts(
      productId: productId,
      active: active,
    );
  }

  /// Get single discount by ID
  Future<AdminDiscount> getDiscount(String discountId) async {
    return await _apiService.getDiscount(discountId);
  }

  /// Create discount using JSON (for category discounts or full control)
  Future<AdminDiscount> createDiscount(
      DiscountCreateRequest discountData) async {
    return await _apiService.createDiscount(discountData);
  }

  /// Create product discount using form-data (recommended for product discounts)
  Future<AdminDiscount> createDiscountForm(
      DiscountCreateFormRequest discountData) async {
    return await _apiService.createDiscountForm(discountData);
  }

  /// Update discount using JSON (for category discounts or full control)
  Future<AdminDiscount> updateDiscount(
      String discountId, DiscountUpdateRequest discountData) async {
    return await _apiService.updateDiscount(discountId, discountData);
  }

  /// Update product discount using form-data (recommended for product discounts)
  Future<AdminDiscount> updateDiscountForm(
      String discountId, DiscountUpdateFormRequest discountData) async {
    return await _apiService.updateDiscountForm(discountId, discountData);
  }

  Future<void> deleteDiscount(String discountId) async {
    return await _apiService.deleteDiscount(discountId);
  }

  // Services
  Future<List<Service>> getServices() async {
    return await _apiService.getServices();
  }

  Future<Service> createService(Map<String, dynamic> serviceData) async {
    return await _apiService.createService(serviceData);
  }

  Future<Service> updateService(
      String serviceId, Map<String, dynamic> serviceData) async {
    return await _apiService.updateService(serviceId, serviceData);
  }

  Future<Service> deleteServiceImage(String serviceId, int index) async {
    return await _apiService.deleteServiceImage(serviceId, index);
  }

  Future<void> deleteService(String serviceId) async {
    return await _apiService.deleteService(serviceId);
  }

  // Notifications
  Future<List<NotificationTemplate>> getNotificationTemplates() async {
    return await _apiService.getNotificationTemplates();
  }

  Future<NotificationTemplate> createNotificationTemplate(
      Map<String, dynamic> templateData) async {
    return await _apiService.createNotificationTemplate(templateData);
  }

  Future<NotificationTemplate> updateNotificationTemplate(
      String templateId, Map<String, dynamic> templateData) async {
    return await _apiService.updateNotificationTemplate(
        templateId, templateData);
  }

  Future<void> deleteNotificationTemplate(String templateId) async {
    return await _apiService.deleteNotificationTemplate(templateId);
  }

  Future<void> sendNotification(NotificationRequest notificationRequest) async {
    return await _apiService.sendNotification(notificationRequest);
  }

  Future<List<NotificationCampaign>> getNotificationCampaigns() async {
    return await _apiService.getNotificationCampaigns();
  }

  Future<List<UserSegment>> getUserSegments() async {
    return await _apiService.getUserSegments();
  }

  // Settings
  Future<SystemSettings> getSystemSettings() async {
    return await _apiService.getSystemSettings();
  }

  Future<AppSettings> updateAppSettings(
      Map<String, dynamic> settingsData) async {
    return await _apiService.updateAppSettings(settingsData);
  }

  Future<PaymentSettings> updatePaymentSettings(
      Map<String, dynamic> settingsData) async {
    return await _apiService.updatePaymentSettings(settingsData);
  }

  Future<List<EmailTemplate>> getEmailTemplates() async {
    return await _apiService.getEmailTemplates();
  }

  Future<EmailTemplate> createEmailTemplate(
      Map<String, dynamic> templateData) async {
    return await _apiService.createEmailTemplate(templateData);
  }

  Future<EmailTemplate> updateEmailTemplate(
      String templateId, Map<String, dynamic> templateData) async {
    return await _apiService.updateEmailTemplate(templateId, templateData);
  }

  Future<void> deleteEmailTemplate(String templateId) async {
    return await _apiService.deleteEmailTemplate(templateId);
  }

  // Export
  Future<String> exportData(
      String endpoint, ExportOptions exportOptions) async {
    return await _apiService.exportData(endpoint, exportOptions);
  }

  // User Management
  Future<List<UserProfile>> getUsers() async {
    return await _apiService.getUsers();
  }

  Future<void> deleteUser(String userId) async {
    return await _apiService.deleteUser(userId);
  }

  Future<void> updateUserRole(String userId, String role) async {
    return await _apiService.updateUserRole(userId, role);
  }

  // Admin Panel Notifications (gelen bildirimler - randevu, sipariş vb.)
  Future<List<AdminPanelNotification>> getAdminPanelNotifications({
    int limit = 50,
    bool unreadOnly = false,
  }) async {
    return await _apiService.getAdminPanelNotifications(
      limit: limit,
      unreadOnly: unreadOnly,
    );
  }

  Future<int> getAdminPanelNotificationsUnreadCount() async {
    return await _apiService.getAdminPanelNotificationsUnreadCount();
  }

  Future<void> markAdminPanelNotificationAsRead(String notificationId) async {
    return await _apiService.markAdminPanelNotificationAsRead(notificationId);
  }

  Future<void> markAllAdminPanelNotificationsAsRead() async {
    return await _apiService.markAllAdminPanelNotificationsAsRead();
  }

  Future<void> deleteAdminPanelNotification(String notificationId) async {
    return await _apiService.deleteAdminPanelNotification(notificationId);
  }

  Future<void> clearAllReadAdminPanelNotifications() async {
    return await _apiService.clearAllReadAdminPanelNotifications();
  }
}
