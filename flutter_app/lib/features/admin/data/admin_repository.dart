import '../../../core/models/product_model.dart';
import '../../../core/models/order_model.dart';
import '../../../core/models/appointment_model.dart';
import '../../../core/models/comment_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/models/service_model.dart';
import '../models/admin_discount_model.dart';
import '../models/admin_analytics_model.dart';
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

  // Orders
  Future<List<Order>> getOrders() async {
    return await _apiService.getOrders();
  }

  Future<Order> updateOrderStatus(String orderId, String status) async {
    return await _apiService.updateOrderStatus(orderId, status);
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

  // Users
  Future<List<UserProfile>> getUsers() async {
    return await _apiService.getUsers();
  }

  Future<UserProfile> updateUserRole(String userId, String role) async {
    return await _apiService.updateUserRole(userId, role);
  }

  // Discounts
  Future<List<AdminDiscount>> getDiscounts() async {
    return await _apiService.getDiscounts();
  }

  Future<AdminDiscount> createDiscount(
      DiscountCreateRequest discountData) async {
    return await _apiService.createDiscount(discountData);
  }

  Future<AdminDiscount> updateDiscount(
      String discountId, DiscountUpdateRequest discountData) async {
    return await _apiService.updateDiscount(discountId, discountData);
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

  Future<void> deleteService(String serviceId) async {
    return await _apiService.deleteService(serviceId);
  }

  // Analytics
  Future<AnalyticsData> getAnalytics({
    String? period,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _apiService.getAnalytics(
      period: period,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<SalesReport> getSalesReport({
    String? period,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _apiService.getSalesReport(
      period: period,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<UserActivity> getUserActivity({
    String? period,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _apiService.getUserActivity(
      period: period,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<RevenueChart> getRevenueChart({
    String? period,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _apiService.getRevenueChart(
      period: period,
      startDate: startDate,
      endDate: endDate,
    );
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
}
