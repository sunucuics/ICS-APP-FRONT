import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_analytics_model.freezed.dart';
part 'admin_analytics_model.g.dart';

@freezed
class SalesReport with _$SalesReport {
  const factory SalesReport({
    @JsonKey(name: 'total_sales') required double totalSales,
    @JsonKey(name: 'total_orders') required int totalOrders,
    @JsonKey(name: 'average_order_value') required double averageOrderValue,
    @JsonKey(name: 'conversion_rate') required double conversionRate,
    @JsonKey(name: 'period') required String period,
    @JsonKey(name: 'date_range') required DateRange dateRange,
  }) = _SalesReport;

  factory SalesReport.fromJson(Map<String, dynamic> json) =>
      _$SalesReportFromJson(json);
}

@freezed
class DateRange with _$DateRange {
  const factory DateRange({
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') required DateTime endDate,
  }) = _DateRange;

  factory DateRange.fromJson(Map<String, dynamic> json) =>
      _$DateRangeFromJson(json);
}

@freezed
class UserActivity with _$UserActivity {
  const factory UserActivity({
    @JsonKey(name: 'total_users') required int totalUsers,
    @JsonKey(name: 'new_users') required int newUsers,
    @JsonKey(name: 'active_users') required int activeUsers,
    @JsonKey(name: 'retention_rate') required double retentionRate,
    @JsonKey(name: 'period') required String period,
  }) = _UserActivity;

  factory UserActivity.fromJson(Map<String, dynamic> json) =>
      _$UserActivityFromJson(json);
}

@freezed
class RevenueChart with _$RevenueChart {
  const factory RevenueChart({
    @JsonKey(name: 'labels') required List<String> labels,
    @JsonKey(name: 'values') required List<double> values,
    @JsonKey(name: 'period') required String period,
  }) = _RevenueChart;

  factory RevenueChart.fromJson(Map<String, dynamic> json) =>
      _$RevenueChartFromJson(json);
}

@freezed
class TrendAnalysis with _$TrendAnalysis {
  const factory TrendAnalysis({
    @JsonKey(name: 'sales_trend') required double salesTrend,
    @JsonKey(name: 'user_trend') required double userTrend,
    @JsonKey(name: 'order_trend') required double orderTrend,
    @JsonKey(name: 'period') required String period,
  }) = _TrendAnalysis;

  factory TrendAnalysis.fromJson(Map<String, dynamic> json) =>
      _$TrendAnalysisFromJson(json);
}

@freezed
class AnalyticsData with _$AnalyticsData {
  const factory AnalyticsData({
    required SalesReport salesReport,
    required UserActivity userActivity,
    required RevenueChart revenueChart,
    required TrendAnalysis trendAnalysis,
  }) = _AnalyticsData;

  factory AnalyticsData.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsDataFromJson(json);
}
