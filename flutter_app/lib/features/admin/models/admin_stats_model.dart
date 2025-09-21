import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_stats_model.freezed.dart';
part 'admin_stats_model.g.dart';

@freezed
class AdminStats with _$AdminStats {
  const factory AdminStats({
    @Default(0) int totalUsers,
    @Default(0) int totalOrders,
    @Default(0.0) double totalRevenue,
    @Default(0) int activeDiscounts,
    @Default(0) int pendingComments,
    @Default(0) int upcomingAppointments,
    @Default(0) int lowStockProducts,
    @Default(0) int totalProducts,
    @Default(0) int totalServices,
  }) = _AdminStats;

  factory AdminStats.fromJson(Map<String, dynamic> json) =>
      _$AdminStatsFromJson(json);
}

@freezed
class AdminDashboardData with _$AdminDashboardData {
  const factory AdminDashboardData({
    required AdminStats stats,
    @Default([]) List<Map<String, dynamic>> recentOrders,
    @Default([]) List<Map<String, dynamic>> upcomingAppointments,
    @Default([]) List<Map<String, dynamic>> lowStockProducts,
    @Default([]) List<Map<String, dynamic>> recentUsers,
  }) = _AdminDashboardData;

  factory AdminDashboardData.fromJson(Map<String, dynamic> json) {
    // Backend'den gelen veri yapısını Flutter model'ine uygun hale getir
    final stats = AdminStats(
      totalUsers: json['total_users'] ?? 0,
      totalOrders: json['total_orders'] ?? 0,
      totalRevenue: (json['revenue_this_month'] ?? 0.0).toDouble(),
      activeDiscounts: json['active_discounts'] ?? 0,
      pendingComments: json['pending_comments'] ?? 0,
      upcomingAppointments: json['pending_appointments'] ?? 0,
      lowStockProducts: 0, // Backend'de bu alan yok, default 0
      totalProducts: json['total_products'] ?? 0,
      totalServices: json['total_services'] ?? 0,
    );

    return AdminDashboardData(
      stats: stats,
      recentOrders:
          List<Map<String, dynamic>>.from(json['recent_orders'] ?? []),
      upcomingAppointments:
          List<Map<String, dynamic>>.from(json['recent_appointments'] ?? []),
      lowStockProducts: [], // Backend'de bu alan yok, boş liste
      recentUsers: [], // Backend'de bu alan yok, boş liste
    );
  }
}
