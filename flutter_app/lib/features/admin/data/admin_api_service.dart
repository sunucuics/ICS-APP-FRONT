import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/exceptions/api_exception.dart';
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

class AdminApiService {
  final ApiClient _apiClient = ApiClient.instance;

  // Dashboard Stats
  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final response = await _apiClient.get('/admin/dashboard/stats');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // Categories CRUD
  Future<List<Category>> getCategories() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.categories);
      final categoryList = (response.data as List)
          .map((item) => Category.fromJson(item as Map<String, dynamic>))
          .toList();
      return categoryList;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Category> createCategory(Map<String, dynamic> categoryData) async {
    try {
      final response = await _apiClient.post(
        '/admin/categories',
        data: categoryData,
      );
      return Category.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Category> updateCategory(
      String categoryId, Map<String, dynamic> categoryData) async {
    try {
      final response = await _apiClient.put(
        '/admin/categories/$categoryId',
        data: categoryData,
      );
      return Category.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await _apiClient.delete('/admin/categories/$categoryId');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // Products CRUD
  Future<List<Product>> getProducts() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.products);
      final productList = (response.data as List)
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
      return productList;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Product> createProduct(Map<String, dynamic> productData) async {
    try {
      final response = await _apiClient.post(
        '/admin/products',
        data: productData,
      );
      return Product.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Product> updateProduct(
      String productId, Map<String, dynamic> productData) async {
    try {
      final response = await _apiClient.put(
        '/admin/products/$productId',
        data: productData,
      );
      return Product.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _apiClient.delete('/admin/products/$productId');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // Orders Management
  Future<List<Order>> getOrders() async {
    try {
      final response = await _apiClient.get('/admin/orders');
      final orderList = (response.data as List)
          .map((item) => Order.fromJson(item as Map<String, dynamic>))
          .toList();
      return orderList;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Order> updateOrderStatus(String orderId, String status) async {
    try {
      final response = await _apiClient.put(
        '/admin/orders/$orderId/status',
        data: {'status': status},
      );
      return Order.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // Appointments Management
  Future<List<AppointmentWithDetails>> getAppointments() async {
    try {
      final response = await _apiClient.get('/admin/appointments');
      final appointmentList = (response.data as List)
          .map((item) =>
              AppointmentWithDetails.fromJson(item as Map<String, dynamic>))
          .toList();
      return appointmentList;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> updateAppointmentStatus(
      String appointmentId, String status) async {
    try {
      await _apiClient.put(
        '/admin/appointments/$appointmentId/status',
        data: {'status': status},
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // Comments Management
  Future<List<Comment>> getComments() async {
    try {
      final response = await _apiClient.get('/admin/comments');
      final commentList = (response.data as List)
          .map((item) => Comment.fromJson(item as Map<String, dynamic>))
          .toList();
      return commentList;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> approveComment(String commentId) async {
    try {
      await _apiClient.put('/admin/comments/$commentId/approve');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteComment(String commentId) async {
    try {
      await _apiClient.delete('/admin/comments/$commentId');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // Users Management
  Future<List<UserProfile>> getUsers() async {
    try {
      final response = await _apiClient.get('/admin/users');
      final userList = (response.data as List)
          .map((item) => UserProfile.fromJson(item as Map<String, dynamic>))
          .toList();
      return userList;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<UserProfile> updateUserRole(String userId, String role) async {
    try {
      final response = await _apiClient.put(
        '/admin/users/$userId/role',
        data: {'role': role},
      );
      return UserProfile.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // Discounts Management
  Future<List<AdminDiscount>> getDiscounts() async {
    try {
      final response = await _apiClient.get('/admin/discounts');
      final discountList = (response.data as List)
          .map((item) => AdminDiscount.fromJson(item as Map<String, dynamic>))
          .toList();
      return discountList;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<AdminDiscount> createDiscount(
      DiscountCreateRequest discountData) async {
    try {
      final response = await _apiClient.post(
        '/admin/discounts',
        data: discountData.toJson(),
      );
      return AdminDiscount.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<AdminDiscount> updateDiscount(
      String discountId, DiscountUpdateRequest discountData) async {
    try {
      final response = await _apiClient.put(
        '/admin/discounts/$discountId',
        data: discountData.toJson(),
      );
      return AdminDiscount.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteDiscount(String discountId) async {
    try {
      await _apiClient.delete('/admin/discounts/$discountId');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // Services Management
  Future<List<Service>> getServices() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.services);
      final serviceList = (response.data as List)
          .map((item) => Service.fromJson(item as Map<String, dynamic>))
          .toList();
      return serviceList;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Service> createService(Map<String, dynamic> serviceData) async {
    try {
      final response = await _apiClient.post(
        '/admin/services',
        data: serviceData,
      );
      return Service.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Service> updateService(
      String serviceId, Map<String, dynamic> serviceData) async {
    try {
      final response = await _apiClient.put(
        '/admin/services/$serviceId',
        data: serviceData,
      );
      return Service.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteService(String serviceId) async {
    try {
      await _apiClient.delete('/admin/services/$serviceId');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // Analytics
  Future<AnalyticsData> getAnalytics({
    String? period,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (period != null) queryParams['period'] = period;
      if (startDate != null)
        queryParams['start_date'] = startDate.toIso8601String();
      if (endDate != null) queryParams['end_date'] = endDate.toIso8601String();

      final response = await _apiClient.get('/admin/analytics',
          queryParameters: queryParams);
      return AnalyticsData.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<SalesReport> getSalesReport({
    String? period,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (period != null) queryParams['period'] = period;
      if (startDate != null)
        queryParams['start_date'] = startDate.toIso8601String();
      if (endDate != null) queryParams['end_date'] = endDate.toIso8601String();

      final response = await _apiClient.get('/admin/analytics/sales',
          queryParameters: queryParams);
      return SalesReport.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<UserActivity> getUserActivity({
    String? period,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (period != null) queryParams['period'] = period;
      if (startDate != null)
        queryParams['start_date'] = startDate.toIso8601String();
      if (endDate != null) queryParams['end_date'] = endDate.toIso8601String();

      final response = await _apiClient.get('/admin/analytics/users',
          queryParameters: queryParams);
      return UserActivity.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<RevenueChart> getRevenueChart({
    String? period,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (period != null) queryParams['period'] = period;
      if (startDate != null)
        queryParams['start_date'] = startDate.toIso8601String();
      if (endDate != null) queryParams['end_date'] = endDate.toIso8601String();

      final response = await _apiClient.get('/admin/analytics/revenue',
          queryParameters: queryParams);
      return RevenueChart.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // Notifications
  Future<List<NotificationTemplate>> getNotificationTemplates() async {
    try {
      final response = await _apiClient.get('/admin/notifications/templates');
      final templateList = (response.data as List)
          .map((item) =>
              NotificationTemplate.fromJson(item as Map<String, dynamic>))
          .toList();
      return templateList;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<NotificationTemplate> createNotificationTemplate(
      Map<String, dynamic> templateData) async {
    try {
      final response = await _apiClient.post(
        '/admin/notifications/templates',
        data: templateData,
      );
      return NotificationTemplate.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<NotificationTemplate> updateNotificationTemplate(
      String templateId, Map<String, dynamic> templateData) async {
    try {
      final response = await _apiClient.put(
        '/admin/notifications/templates/$templateId',
        data: templateData,
      );
      return NotificationTemplate.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteNotificationTemplate(String templateId) async {
    try {
      await _apiClient.delete('/admin/notifications/templates/$templateId');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> sendNotification(NotificationRequest notificationRequest) async {
    try {
      await _apiClient.post(
        '/admin/notifications/send',
        data: notificationRequest.toJson(),
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<NotificationCampaign>> getNotificationCampaigns() async {
    try {
      final response = await _apiClient.get('/admin/notifications/campaigns');
      final campaignList = (response.data as List)
          .map((item) =>
              NotificationCampaign.fromJson(item as Map<String, dynamic>))
          .toList();
      return campaignList;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<UserSegment>> getUserSegments() async {
    try {
      final response = await _apiClient.get('/admin/notifications/segments');
      final segmentList = (response.data as List)
          .map((item) => UserSegment.fromJson(item as Map<String, dynamic>))
          .toList();
      return segmentList;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // Settings
  Future<SystemSettings> getSystemSettings() async {
    try {
      final response = await _apiClient.get('/admin/settings');
      return SystemSettings.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<AppSettings> updateAppSettings(
      Map<String, dynamic> settingsData) async {
    try {
      final response = await _apiClient.put(
        '/admin/settings/app',
        data: settingsData,
      );
      return AppSettings.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<PaymentSettings> updatePaymentSettings(
      Map<String, dynamic> settingsData) async {
    try {
      final response = await _apiClient.put(
        '/admin/settings/payment',
        data: settingsData,
      );
      return PaymentSettings.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<EmailTemplate>> getEmailTemplates() async {
    try {
      final response = await _apiClient.get('/admin/settings/email-templates');
      final templateList = (response.data as List)
          .map((item) => EmailTemplate.fromJson(item as Map<String, dynamic>))
          .toList();
      return templateList;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<EmailTemplate> createEmailTemplate(
      Map<String, dynamic> templateData) async {
    try {
      final response = await _apiClient.post(
        '/admin/settings/email-templates',
        data: templateData,
      );
      return EmailTemplate.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<EmailTemplate> updateEmailTemplate(
      String templateId, Map<String, dynamic> templateData) async {
    try {
      final response = await _apiClient.put(
        '/admin/settings/email-templates/$templateId',
        data: templateData,
      );
      return EmailTemplate.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteEmailTemplate(String templateId) async {
    try {
      await _apiClient.delete('/admin/settings/email-templates/$templateId');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // Export
  Future<String> exportData(
      String endpoint, ExportOptions exportOptions) async {
    try {
      final response = await _apiClient.post(
        '/admin/export/$endpoint',
        data: exportOptions.toJson(),
      );
      return response.data['download_url'] as String;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
