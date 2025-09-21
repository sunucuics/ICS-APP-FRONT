// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminStatsImpl _$$AdminStatsImplFromJson(Map<String, dynamic> json) =>
    _$AdminStatsImpl(
      totalUsers: (json['totalUsers'] as num?)?.toInt() ?? 0,
      totalOrders: (json['totalOrders'] as num?)?.toInt() ?? 0,
      totalRevenue: (json['totalRevenue'] as num?)?.toDouble() ?? 0.0,
      activeDiscounts: (json['activeDiscounts'] as num?)?.toInt() ?? 0,
      pendingComments: (json['pendingComments'] as num?)?.toInt() ?? 0,
      upcomingAppointments:
          (json['upcomingAppointments'] as num?)?.toInt() ?? 0,
      lowStockProducts: (json['lowStockProducts'] as num?)?.toInt() ?? 0,
      totalProducts: (json['totalProducts'] as num?)?.toInt() ?? 0,
      totalServices: (json['totalServices'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AdminStatsImplToJson(_$AdminStatsImpl instance) =>
    <String, dynamic>{
      'totalUsers': instance.totalUsers,
      'totalOrders': instance.totalOrders,
      'totalRevenue': instance.totalRevenue,
      'activeDiscounts': instance.activeDiscounts,
      'pendingComments': instance.pendingComments,
      'upcomingAppointments': instance.upcomingAppointments,
      'lowStockProducts': instance.lowStockProducts,
      'totalProducts': instance.totalProducts,
      'totalServices': instance.totalServices,
    };
