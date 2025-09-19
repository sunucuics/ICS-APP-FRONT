// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_analytics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SalesReportImpl _$$SalesReportImplFromJson(Map<String, dynamic> json) =>
    _$SalesReportImpl(
      totalSales: (json['total_sales'] as num).toDouble(),
      totalOrders: (json['total_orders'] as num).toInt(),
      averageOrderValue: (json['average_order_value'] as num).toDouble(),
      conversionRate: (json['conversion_rate'] as num).toDouble(),
      period: json['period'] as String,
      dateRange: DateRange.fromJson(json['date_range'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SalesReportImplToJson(_$SalesReportImpl instance) =>
    <String, dynamic>{
      'total_sales': instance.totalSales,
      'total_orders': instance.totalOrders,
      'average_order_value': instance.averageOrderValue,
      'conversion_rate': instance.conversionRate,
      'period': instance.period,
      'date_range': instance.dateRange,
    };

_$DateRangeImpl _$$DateRangeImplFromJson(Map<String, dynamic> json) =>
    _$DateRangeImpl(
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
    );

Map<String, dynamic> _$$DateRangeImplToJson(_$DateRangeImpl instance) =>
    <String, dynamic>{
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
    };

_$UserActivityImpl _$$UserActivityImplFromJson(Map<String, dynamic> json) =>
    _$UserActivityImpl(
      totalUsers: (json['total_users'] as num).toInt(),
      newUsers: (json['new_users'] as num).toInt(),
      activeUsers: (json['active_users'] as num).toInt(),
      retentionRate: (json['retention_rate'] as num).toDouble(),
      period: json['period'] as String,
    );

Map<String, dynamic> _$$UserActivityImplToJson(_$UserActivityImpl instance) =>
    <String, dynamic>{
      'total_users': instance.totalUsers,
      'new_users': instance.newUsers,
      'active_users': instance.activeUsers,
      'retention_rate': instance.retentionRate,
      'period': instance.period,
    };

_$RevenueChartImpl _$$RevenueChartImplFromJson(Map<String, dynamic> json) =>
    _$RevenueChartImpl(
      labels:
          (json['labels'] as List<dynamic>).map((e) => e as String).toList(),
      values: (json['values'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      period: json['period'] as String,
    );

Map<String, dynamic> _$$RevenueChartImplToJson(_$RevenueChartImpl instance) =>
    <String, dynamic>{
      'labels': instance.labels,
      'values': instance.values,
      'period': instance.period,
    };

_$TrendAnalysisImpl _$$TrendAnalysisImplFromJson(Map<String, dynamic> json) =>
    _$TrendAnalysisImpl(
      salesTrend: (json['sales_trend'] as num).toDouble(),
      userTrend: (json['user_trend'] as num).toDouble(),
      orderTrend: (json['order_trend'] as num).toDouble(),
      period: json['period'] as String,
    );

Map<String, dynamic> _$$TrendAnalysisImplToJson(_$TrendAnalysisImpl instance) =>
    <String, dynamic>{
      'sales_trend': instance.salesTrend,
      'user_trend': instance.userTrend,
      'order_trend': instance.orderTrend,
      'period': instance.period,
    };

_$AnalyticsDataImpl _$$AnalyticsDataImplFromJson(Map<String, dynamic> json) =>
    _$AnalyticsDataImpl(
      salesReport:
          SalesReport.fromJson(json['salesReport'] as Map<String, dynamic>),
      userActivity:
          UserActivity.fromJson(json['userActivity'] as Map<String, dynamic>),
      revenueChart:
          RevenueChart.fromJson(json['revenueChart'] as Map<String, dynamic>),
      trendAnalysis:
          TrendAnalysis.fromJson(json['trendAnalysis'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AnalyticsDataImplToJson(_$AnalyticsDataImpl instance) =>
    <String, dynamic>{
      'salesReport': instance.salesReport,
      'userActivity': instance.userActivity,
      'revenueChart': instance.revenueChart,
      'trendAnalysis': instance.trendAnalysis,
    };
