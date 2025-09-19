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

  factory AdminDashboardData.fromJson(Map<String, dynamic> json) =>
      _$AdminDashboardDataFromJson(json);
}
