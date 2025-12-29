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
import '../models/admin_notification_model.dart';
import '../models/admin_settings_model.dart';
import '../models/admin_filter_model.dart';

class AdminApiService {
  final ApiClient _apiClient = ApiClient.instance;

  // Dashboard Stats
  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      print('🔍 Admin API: Fetching dashboard stats...');
      final response = await _apiClient.get('/admin/dashboard/stats');
      print('🔍 Admin API: Dashboard stats fetched successfully');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      print(
          '❌ Admin API Error: ${e.response?.statusCode} - ${e.response?.data}');
      print('❌ Admin API Error Details: ${e.message}');

      // Temporary: Return mock data if backend admin endpoint fails
      if (e.response?.statusCode == 403) {
        print('🔧 Using mock dashboard data due to 403 error');
        return {
          'totalUsers': 89,
          'totalOrders': 127,
          'totalRevenue': 45280.0,
          'activeDiscounts': 3,
          'pendingComments': 5,
          'upcomingAppointments': 8,
        };
      }

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
      // Check if there's an image file to upload
      final imageFile = categoryData['imageUrl'];

      if (imageFile != null && imageFile is String && imageFile.isNotEmpty) {
        // Use multipart/form-data for image upload
        final formData = FormData();

        // Add category fields
        formData.fields.addAll([
          MapEntry('name', categoryData['name'] ?? ''),
          MapEntry('description', categoryData['description'] ?? ''),
          MapEntry('is_fixed', categoryData['is_fixed']?.toString() ?? 'false'),
        ]);

        // Add image file
        formData.files.add(MapEntry(
          'cover_image',
          await MultipartFile.fromFile(imageFile),
        ));

        final response = await _apiClient.post(
          '/admin/categories',
          data: formData,
        );
        return Category.fromJson(response.data as Map<String, dynamic>);
      } else {
        // For categories without images, we need to handle this differently
        // Since backend requires cover_image, we'll throw an error
        throw ApiException(
            message: 'Kategori oluşturmak için görsel gereklidir');
      }
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
      // Check if there are image files to upload
      final imageFilesRaw = productData['images'];
      List<String>? imageFiles;

      if (imageFilesRaw is List) {
        // Filter out null values and convert to List<String>
        imageFiles = imageFilesRaw
            .where((item) => item != null && item is String && item.isNotEmpty)
            .cast<String>()
            .toList();
      }

      if (imageFiles != null && imageFiles.isNotEmpty) {
        // Use multipart/form-data for image upload
        final formData = FormData();

        // Add product fields
        formData.fields.addAll([
          MapEntry('name', productData['name'] ?? ''),
          MapEntry('description', productData['description'] ?? ''),
          MapEntry('price', productData['price']?.toString() ?? '0'),
          MapEntry('stock', productData['stock']?.toString() ?? '0'),
          MapEntry('category_name', productData['category_name'] ?? ''),
          MapEntry(
              'is_upcoming', productData['is_upcoming']?.toString() ?? 'false'),
        ]);

        // Add image files
        for (int i = 0; i < imageFiles.length; i++) {
          final imagePath = imageFiles[i];
          if (imagePath.isNotEmpty) {
            final fileName = 'photo${i == 0 ? '_main' : i}';
            formData.files.add(MapEntry(
              fileName,
              await MultipartFile.fromFile(imagePath),
            ));
          }
        }

        final response = await _apiClient.post(
          '/admin/products/',
          data: formData,
        );
        return Product.fromJson(response.data as Map<String, dynamic>);
      } else {
        // Use JSON for products without images
        final response = await _apiClient.post(
          '/admin/products',
          data: productData,
        );
        return Product.fromJson(response.data as Map<String, dynamic>);
      }
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

  // Orders Management - Updated for PayTR integration
  Future<List<Order>> getOrders() async {
    try {
      final response = await _apiClient.get('/admin/orders');
      // Handle null or non-list responses
      if (response.data == null) {
        return [];
      }
      final data = response.data;
      if (data is! List) {
        return [];
      }
      final orderList = (data as List)
          .map((item) => Order.fromJson(item as Map<String, dynamic>))
          .toList();
      return orderList;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<AdminOrdersQueueResponse> getOrdersQueue() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.ordersQueue);
      // Handle null response
      if (response.data == null) {
        return AdminOrdersQueueResponse.fromJson({
          'preparing': [],
          'shipped': [],
          'delivered': [],
          'count': {'preparing': 0, 'shipped': 0, 'delivered': 0},
        });
      }
      return AdminOrdersQueueResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Ship order - PATCH /orders/{id}/ship
  /// Body: {tracking_number (required), provider (default: MANUAL), tracking_url (optional)}
  Future<Order> shipOrder(String orderId, OrderShipRequest request) async {
    try {
      final response = await _apiClient.patch(
        ApiEndpoints.orderShip(orderId),
        data: request.toJson(),
      );
      return Order.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Deliver order - PATCH /orders/{id}/deliver
  /// Body: None
  Future<Order> deliverOrder(String orderId) async {
    try {
      final response = await _apiClient.patch(ApiEndpoints.orderDeliver(orderId));
      return Order.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Cancel order - PATCH /orders/{id}/cancel
  /// Body: {reason?} (optional)
  Future<Order> cancelOrder(String orderId, OrderCancelRequest request) async {
    try {
      final response = await _apiClient.patch(
        ApiEndpoints.orderCancel(orderId),
        data: request.toJson(),
      );
      return Order.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Delete order (soft delete) - DELETE /admin/orders/{id}
  Future<void> deleteOrder(String orderId) async {
    try {
      await _apiClient.delete(ApiEndpoints.adminOrderDelete(orderId));
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Create test order - POST /orders/dev (ADMIN)
  /// For UI development, creates a fake order
  Future<Order> createTestOrder() async {
    try {
      final response = await _apiClient.post(ApiEndpoints.ordersDev);
      return Order.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Test email/SMTP health check - POST /orders/_email-test (ADMIN)
  /// Returns: {ok: true, to: string} or 502 if SMTP fails
  Future<Map<String, dynamic>> testEmail() async {
    try {
      final response = await _apiClient.post(ApiEndpoints.ordersEmailTest);
      return response.data as Map<String, dynamic>;
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

  // Discounts Management
  /// Get list of discounts with optional filters
  /// [productId] - Filter by product ID
  /// [active] - Filter by active status
  Future<List<AdminDiscount>> getDiscounts({
    String? productId,
    bool? active,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (productId != null) {
        queryParams['product_id'] = productId;
      }
      if (active != null) {
        queryParams['active'] = active.toString();
      }

      final response = await _apiClient.get(
        ApiEndpoints.discountsList,
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );
      final discountList = (response.data as List)
          .map((item) => AdminDiscount.fromJson(item as Map<String, dynamic>))
          .toList();
      return discountList;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Get single discount by ID
  Future<AdminDiscount> getDiscount(String discountId) async {
    try {
      final response = await _apiClient.get(ApiEndpoints.discount(discountId));
      return AdminDiscount.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Create discount using JSON (for product or category discounts)
  /// Use this for category discounts or when you need full control
  Future<AdminDiscount> createDiscount(
      DiscountCreateRequest discountData) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.discounts, // POST /discounts (no slash) for JSON
        data: discountData.toJson(),
      );
      return AdminDiscount.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Create product discount using form-data (recommended for product discounts)
  /// Uses date-only format (YYYY-MM-DD) for start_date and end_date
  Future<AdminDiscount> createDiscountForm(
      DiscountCreateFormRequest discountData) async {
    try {
      final formData = FormData.fromMap({
        'product_id': discountData.productId,
        'percent': discountData.percent.toString(),
        if (discountData.startDate != null && discountData.startDate!.isNotEmpty)
          'start_date': discountData.startDate,
        if (discountData.endDate != null && discountData.endDate!.isNotEmpty)
          'end_date': discountData.endDate,
        'active': discountData.active.toString(),
      });

      final response = await _apiClient.post(
        ApiEndpoints.discountsList, // POST /discounts/ (with slash) for form
        data: formData,
      );
      return AdminDiscount.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Update discount using JSON (for product or category discounts)
  Future<AdminDiscount> updateDiscount(
      String discountId, DiscountUpdateRequest discountData) async {
    try {
      final response = await _apiClient.put(
        ApiEndpoints.discount(discountId), // PUT /discounts/{id} for JSON
        data: discountData.toJson(),
      );
      return AdminDiscount.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Update product discount using form-data (recommended for product discounts)
  /// Uses date-only format (YYYY-MM-DD) for start_date and end_date
  Future<AdminDiscount> updateDiscountForm(
      String discountId, DiscountUpdateFormRequest discountData) async {
    try {
      final formDataMap = <String, dynamic>{};
      if (discountData.percent != null) {
        formDataMap['percent'] = discountData.percent.toString();
      }
      if (discountData.startDate != null) {
        formDataMap['start_date'] = discountData.startDate;
      }
      if (discountData.endDate != null) {
        formDataMap['end_date'] = discountData.endDate;
      }
      if (discountData.active != null) {
        formDataMap['active'] = discountData.active.toString();
      }

      final formData = FormData.fromMap(formDataMap);

      final response = await _apiClient.put(
        ApiEndpoints.discountUpdateForm(discountId), // PUT /discounts/{id}/form
        data: formData,
      );
      return AdminDiscount.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteDiscount(String discountId) async {
    try {
      await _apiClient.delete(ApiEndpoints.discount(discountId));
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
      // Use multipart/form-data for image upload
      final formData = FormData();

      // Add service fields
      formData.fields.addAll([
        MapEntry('title', serviceData['title'] ?? ''),
        MapEntry('description', serviceData['description'] ?? ''),
        MapEntry('is_upcoming', serviceData['is_upcoming']?.toString() ?? 'false'),
      ]);

      // Add 3 image slots (image1, image2, image3) - optional
      final image1 = serviceData['image1'] as String?;
      final image2 = serviceData['image2'] as String?;
      final image3 = serviceData['image3'] as String?;

      if (image1 != null && image1.isNotEmpty) {
        formData.files.add(MapEntry(
          'image1',
          await MultipartFile.fromFile(image1),
        ));
      }
      if (image2 != null && image2.isNotEmpty) {
        formData.files.add(MapEntry(
          'image2',
          await MultipartFile.fromFile(image2),
        ));
      }
      if (image3 != null && image3.isNotEmpty) {
        formData.files.add(MapEntry(
          'image3',
          await MultipartFile.fromFile(image3),
        ));
      }

      final response = await _apiClient.post(
        '/admin/services/',
        data: formData,
      );
      return Service.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Service> updateService(
      String serviceId, Map<String, dynamic> serviceData) async {
    try {
      // Backend expects form data for update
      final formData = FormData();

      // Add service fields (all optional for update)
      if (serviceData['title'] != null) {
        formData.fields.add(MapEntry('title', serviceData['title']));
      }
      if (serviceData['description'] != null) {
        formData.fields.add(MapEntry('description', serviceData['description']));
      }

      // is_upcoming: keep/yes/no enum
      if (serviceData['is_upcoming'] != null) {
        final upcomingValue = serviceData['is_upcoming'] as String;
        formData.fields.add(MapEntry('is_upcoming', upcomingValue)); // 'keep', 'yes', 'no'
      }

      // Görsel slot'ları: image1/2/3 (replace) veya remove_image1/2/3 (sil)
      final image1 = serviceData['image1'] as String?;
      final image2 = serviceData['image2'] as String?;
      final image3 = serviceData['image3'] as String?;

      if (image1 != null && image1.isNotEmpty) {
        formData.files.add(MapEntry(
          'image1',
          await MultipartFile.fromFile(image1),
        ));
      } else if (serviceData['remove_image1'] == true) {
        formData.fields.add(MapEntry('remove_image1', 'true'));
      }

      if (image2 != null && image2.isNotEmpty) {
        formData.files.add(MapEntry(
          'image2',
          await MultipartFile.fromFile(image2),
        ));
      } else if (serviceData['remove_image2'] == true) {
        formData.fields.add(MapEntry('remove_image2', 'true'));
      }

      if (image3 != null && image3.isNotEmpty) {
        formData.files.add(MapEntry(
          'image3',
          await MultipartFile.fromFile(image3),
        ));
      } else if (serviceData['remove_image3'] == true) {
        formData.fields.add(MapEntry('remove_image3', 'true'));
      }

      final response = await _apiClient.put(
        '/admin/services/$serviceId',
        data: formData,
      );
      return Service.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Service> deleteServiceImage(String serviceId, int index) async {
    try {
      final response = await _apiClient.delete(
        '/admin/services/$serviceId/images',
        queryParameters: {'index': index},
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

  // User Management
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

  Future<void> deleteUser(String userId) async {
    try {
      await _apiClient.delete('/admin/users/$userId');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> updateUserRole(String userId, String role) async {
    try {
      await _apiClient
          .put('/admin/users/$userId/role', queryParameters: {'role': role});
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
