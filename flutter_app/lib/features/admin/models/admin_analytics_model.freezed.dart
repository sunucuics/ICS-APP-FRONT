// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_analytics_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SalesReport _$SalesReportFromJson(Map<String, dynamic> json) {
  return _SalesReport.fromJson(json);
}

/// @nodoc
mixin _$SalesReport {
  @JsonKey(name: 'total_sales')
  double get totalSales => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_orders')
  int get totalOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_order_value')
  double get averageOrderValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversion_rate')
  double get conversionRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'period')
  String get period => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_range')
  DateRange get dateRange => throw _privateConstructorUsedError;

  /// Serializes this SalesReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalesReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesReportCopyWith<SalesReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesReportCopyWith<$Res> {
  factory $SalesReportCopyWith(
          SalesReport value, $Res Function(SalesReport) then) =
      _$SalesReportCopyWithImpl<$Res, SalesReport>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_sales') double totalSales,
      @JsonKey(name: 'total_orders') int totalOrders,
      @JsonKey(name: 'average_order_value') double averageOrderValue,
      @JsonKey(name: 'conversion_rate') double conversionRate,
      @JsonKey(name: 'period') String period,
      @JsonKey(name: 'date_range') DateRange dateRange});

  $DateRangeCopyWith<$Res> get dateRange;
}

/// @nodoc
class _$SalesReportCopyWithImpl<$Res, $Val extends SalesReport>
    implements $SalesReportCopyWith<$Res> {
  _$SalesReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSales = null,
    Object? totalOrders = null,
    Object? averageOrderValue = null,
    Object? conversionRate = null,
    Object? period = null,
    Object? dateRange = null,
  }) {
    return _then(_value.copyWith(
      totalSales: null == totalSales
          ? _value.totalSales
          : totalSales // ignore: cast_nullable_to_non_nullable
              as double,
      totalOrders: null == totalOrders
          ? _value.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      averageOrderValue: null == averageOrderValue
          ? _value.averageOrderValue
          : averageOrderValue // ignore: cast_nullable_to_non_nullable
              as double,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as double,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      dateRange: null == dateRange
          ? _value.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as DateRange,
    ) as $Val);
  }

  /// Create a copy of SalesReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DateRangeCopyWith<$Res> get dateRange {
    return $DateRangeCopyWith<$Res>(_value.dateRange, (value) {
      return _then(_value.copyWith(dateRange: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SalesReportImplCopyWith<$Res>
    implements $SalesReportCopyWith<$Res> {
  factory _$$SalesReportImplCopyWith(
          _$SalesReportImpl value, $Res Function(_$SalesReportImpl) then) =
      __$$SalesReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_sales') double totalSales,
      @JsonKey(name: 'total_orders') int totalOrders,
      @JsonKey(name: 'average_order_value') double averageOrderValue,
      @JsonKey(name: 'conversion_rate') double conversionRate,
      @JsonKey(name: 'period') String period,
      @JsonKey(name: 'date_range') DateRange dateRange});

  @override
  $DateRangeCopyWith<$Res> get dateRange;
}

/// @nodoc
class __$$SalesReportImplCopyWithImpl<$Res>
    extends _$SalesReportCopyWithImpl<$Res, _$SalesReportImpl>
    implements _$$SalesReportImplCopyWith<$Res> {
  __$$SalesReportImplCopyWithImpl(
      _$SalesReportImpl _value, $Res Function(_$SalesReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSales = null,
    Object? totalOrders = null,
    Object? averageOrderValue = null,
    Object? conversionRate = null,
    Object? period = null,
    Object? dateRange = null,
  }) {
    return _then(_$SalesReportImpl(
      totalSales: null == totalSales
          ? _value.totalSales
          : totalSales // ignore: cast_nullable_to_non_nullable
              as double,
      totalOrders: null == totalOrders
          ? _value.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      averageOrderValue: null == averageOrderValue
          ? _value.averageOrderValue
          : averageOrderValue // ignore: cast_nullable_to_non_nullable
              as double,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as double,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      dateRange: null == dateRange
          ? _value.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as DateRange,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesReportImpl implements _SalesReport {
  const _$SalesReportImpl(
      {@JsonKey(name: 'total_sales') required this.totalSales,
      @JsonKey(name: 'total_orders') required this.totalOrders,
      @JsonKey(name: 'average_order_value') required this.averageOrderValue,
      @JsonKey(name: 'conversion_rate') required this.conversionRate,
      @JsonKey(name: 'period') required this.period,
      @JsonKey(name: 'date_range') required this.dateRange});

  factory _$SalesReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesReportImplFromJson(json);

  @override
  @JsonKey(name: 'total_sales')
  final double totalSales;
  @override
  @JsonKey(name: 'total_orders')
  final int totalOrders;
  @override
  @JsonKey(name: 'average_order_value')
  final double averageOrderValue;
  @override
  @JsonKey(name: 'conversion_rate')
  final double conversionRate;
  @override
  @JsonKey(name: 'period')
  final String period;
  @override
  @JsonKey(name: 'date_range')
  final DateRange dateRange;

  @override
  String toString() {
    return 'SalesReport(totalSales: $totalSales, totalOrders: $totalOrders, averageOrderValue: $averageOrderValue, conversionRate: $conversionRate, period: $period, dateRange: $dateRange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesReportImpl &&
            (identical(other.totalSales, totalSales) ||
                other.totalSales == totalSales) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.averageOrderValue, averageOrderValue) ||
                other.averageOrderValue == averageOrderValue) &&
            (identical(other.conversionRate, conversionRate) ||
                other.conversionRate == conversionRate) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.dateRange, dateRange) ||
                other.dateRange == dateRange));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalSales, totalOrders,
      averageOrderValue, conversionRate, period, dateRange);

  /// Create a copy of SalesReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesReportImplCopyWith<_$SalesReportImpl> get copyWith =>
      __$$SalesReportImplCopyWithImpl<_$SalesReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesReportImplToJson(
      this,
    );
  }
}

abstract class _SalesReport implements SalesReport {
  const factory _SalesReport(
      {@JsonKey(name: 'total_sales') required final double totalSales,
      @JsonKey(name: 'total_orders') required final int totalOrders,
      @JsonKey(name: 'average_order_value')
      required final double averageOrderValue,
      @JsonKey(name: 'conversion_rate') required final double conversionRate,
      @JsonKey(name: 'period') required final String period,
      @JsonKey(name: 'date_range')
      required final DateRange dateRange}) = _$SalesReportImpl;

  factory _SalesReport.fromJson(Map<String, dynamic> json) =
      _$SalesReportImpl.fromJson;

  @override
  @JsonKey(name: 'total_sales')
  double get totalSales;
  @override
  @JsonKey(name: 'total_orders')
  int get totalOrders;
  @override
  @JsonKey(name: 'average_order_value')
  double get averageOrderValue;
  @override
  @JsonKey(name: 'conversion_rate')
  double get conversionRate;
  @override
  @JsonKey(name: 'period')
  String get period;
  @override
  @JsonKey(name: 'date_range')
  DateRange get dateRange;

  /// Create a copy of SalesReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesReportImplCopyWith<_$SalesReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DateRange _$DateRangeFromJson(Map<String, dynamic> json) {
  return _DateRange.fromJson(json);
}

/// @nodoc
mixin _$DateRange {
  @JsonKey(name: 'start_date')
  DateTime get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  DateTime get endDate => throw _privateConstructorUsedError;

  /// Serializes this DateRange to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DateRange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DateRangeCopyWith<DateRange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateRangeCopyWith<$Res> {
  factory $DateRangeCopyWith(DateRange value, $Res Function(DateRange) then) =
      _$DateRangeCopyWithImpl<$Res, DateRange>;
  @useResult
  $Res call(
      {@JsonKey(name: 'start_date') DateTime startDate,
      @JsonKey(name: 'end_date') DateTime endDate});
}

/// @nodoc
class _$DateRangeCopyWithImpl<$Res, $Val extends DateRange>
    implements $DateRangeCopyWith<$Res> {
  _$DateRangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DateRange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_value.copyWith(
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DateRangeImplCopyWith<$Res>
    implements $DateRangeCopyWith<$Res> {
  factory _$$DateRangeImplCopyWith(
          _$DateRangeImpl value, $Res Function(_$DateRangeImpl) then) =
      __$$DateRangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'start_date') DateTime startDate,
      @JsonKey(name: 'end_date') DateTime endDate});
}

/// @nodoc
class __$$DateRangeImplCopyWithImpl<$Res>
    extends _$DateRangeCopyWithImpl<$Res, _$DateRangeImpl>
    implements _$$DateRangeImplCopyWith<$Res> {
  __$$DateRangeImplCopyWithImpl(
      _$DateRangeImpl _value, $Res Function(_$DateRangeImpl) _then)
      : super(_value, _then);

  /// Create a copy of DateRange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_$DateRangeImpl(
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DateRangeImpl implements _DateRange {
  const _$DateRangeImpl(
      {@JsonKey(name: 'start_date') required this.startDate,
      @JsonKey(name: 'end_date') required this.endDate});

  factory _$DateRangeImpl.fromJson(Map<String, dynamic> json) =>
      _$$DateRangeImplFromJson(json);

  @override
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @override
  @JsonKey(name: 'end_date')
  final DateTime endDate;

  @override
  String toString() {
    return 'DateRange(startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DateRangeImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate);

  /// Create a copy of DateRange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DateRangeImplCopyWith<_$DateRangeImpl> get copyWith =>
      __$$DateRangeImplCopyWithImpl<_$DateRangeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DateRangeImplToJson(
      this,
    );
  }
}

abstract class _DateRange implements DateRange {
  const factory _DateRange(
          {@JsonKey(name: 'start_date') required final DateTime startDate,
          @JsonKey(name: 'end_date') required final DateTime endDate}) =
      _$DateRangeImpl;

  factory _DateRange.fromJson(Map<String, dynamic> json) =
      _$DateRangeImpl.fromJson;

  @override
  @JsonKey(name: 'start_date')
  DateTime get startDate;
  @override
  @JsonKey(name: 'end_date')
  DateTime get endDate;

  /// Create a copy of DateRange
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DateRangeImplCopyWith<_$DateRangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserActivity _$UserActivityFromJson(Map<String, dynamic> json) {
  return _UserActivity.fromJson(json);
}

/// @nodoc
mixin _$UserActivity {
  @JsonKey(name: 'total_users')
  int get totalUsers => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_users')
  int get newUsers => throw _privateConstructorUsedError;
  @JsonKey(name: 'active_users')
  int get activeUsers => throw _privateConstructorUsedError;
  @JsonKey(name: 'retention_rate')
  double get retentionRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'period')
  String get period => throw _privateConstructorUsedError;

  /// Serializes this UserActivity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserActivityCopyWith<UserActivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserActivityCopyWith<$Res> {
  factory $UserActivityCopyWith(
          UserActivity value, $Res Function(UserActivity) then) =
      _$UserActivityCopyWithImpl<$Res, UserActivity>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_users') int totalUsers,
      @JsonKey(name: 'new_users') int newUsers,
      @JsonKey(name: 'active_users') int activeUsers,
      @JsonKey(name: 'retention_rate') double retentionRate,
      @JsonKey(name: 'period') String period});
}

/// @nodoc
class _$UserActivityCopyWithImpl<$Res, $Val extends UserActivity>
    implements $UserActivityCopyWith<$Res> {
  _$UserActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalUsers = null,
    Object? newUsers = null,
    Object? activeUsers = null,
    Object? retentionRate = null,
    Object? period = null,
  }) {
    return _then(_value.copyWith(
      totalUsers: null == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      newUsers: null == newUsers
          ? _value.newUsers
          : newUsers // ignore: cast_nullable_to_non_nullable
              as int,
      activeUsers: null == activeUsers
          ? _value.activeUsers
          : activeUsers // ignore: cast_nullable_to_non_nullable
              as int,
      retentionRate: null == retentionRate
          ? _value.retentionRate
          : retentionRate // ignore: cast_nullable_to_non_nullable
              as double,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserActivityImplCopyWith<$Res>
    implements $UserActivityCopyWith<$Res> {
  factory _$$UserActivityImplCopyWith(
          _$UserActivityImpl value, $Res Function(_$UserActivityImpl) then) =
      __$$UserActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_users') int totalUsers,
      @JsonKey(name: 'new_users') int newUsers,
      @JsonKey(name: 'active_users') int activeUsers,
      @JsonKey(name: 'retention_rate') double retentionRate,
      @JsonKey(name: 'period') String period});
}

/// @nodoc
class __$$UserActivityImplCopyWithImpl<$Res>
    extends _$UserActivityCopyWithImpl<$Res, _$UserActivityImpl>
    implements _$$UserActivityImplCopyWith<$Res> {
  __$$UserActivityImplCopyWithImpl(
      _$UserActivityImpl _value, $Res Function(_$UserActivityImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalUsers = null,
    Object? newUsers = null,
    Object? activeUsers = null,
    Object? retentionRate = null,
    Object? period = null,
  }) {
    return _then(_$UserActivityImpl(
      totalUsers: null == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      newUsers: null == newUsers
          ? _value.newUsers
          : newUsers // ignore: cast_nullable_to_non_nullable
              as int,
      activeUsers: null == activeUsers
          ? _value.activeUsers
          : activeUsers // ignore: cast_nullable_to_non_nullable
              as int,
      retentionRate: null == retentionRate
          ? _value.retentionRate
          : retentionRate // ignore: cast_nullable_to_non_nullable
              as double,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserActivityImpl implements _UserActivity {
  const _$UserActivityImpl(
      {@JsonKey(name: 'total_users') required this.totalUsers,
      @JsonKey(name: 'new_users') required this.newUsers,
      @JsonKey(name: 'active_users') required this.activeUsers,
      @JsonKey(name: 'retention_rate') required this.retentionRate,
      @JsonKey(name: 'period') required this.period});

  factory _$UserActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserActivityImplFromJson(json);

  @override
  @JsonKey(name: 'total_users')
  final int totalUsers;
  @override
  @JsonKey(name: 'new_users')
  final int newUsers;
  @override
  @JsonKey(name: 'active_users')
  final int activeUsers;
  @override
  @JsonKey(name: 'retention_rate')
  final double retentionRate;
  @override
  @JsonKey(name: 'period')
  final String period;

  @override
  String toString() {
    return 'UserActivity(totalUsers: $totalUsers, newUsers: $newUsers, activeUsers: $activeUsers, retentionRate: $retentionRate, period: $period)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserActivityImpl &&
            (identical(other.totalUsers, totalUsers) ||
                other.totalUsers == totalUsers) &&
            (identical(other.newUsers, newUsers) ||
                other.newUsers == newUsers) &&
            (identical(other.activeUsers, activeUsers) ||
                other.activeUsers == activeUsers) &&
            (identical(other.retentionRate, retentionRate) ||
                other.retentionRate == retentionRate) &&
            (identical(other.period, period) || other.period == period));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, totalUsers, newUsers, activeUsers, retentionRate, period);

  /// Create a copy of UserActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserActivityImplCopyWith<_$UserActivityImpl> get copyWith =>
      __$$UserActivityImplCopyWithImpl<_$UserActivityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserActivityImplToJson(
      this,
    );
  }
}

abstract class _UserActivity implements UserActivity {
  const factory _UserActivity(
          {@JsonKey(name: 'total_users') required final int totalUsers,
          @JsonKey(name: 'new_users') required final int newUsers,
          @JsonKey(name: 'active_users') required final int activeUsers,
          @JsonKey(name: 'retention_rate') required final double retentionRate,
          @JsonKey(name: 'period') required final String period}) =
      _$UserActivityImpl;

  factory _UserActivity.fromJson(Map<String, dynamic> json) =
      _$UserActivityImpl.fromJson;

  @override
  @JsonKey(name: 'total_users')
  int get totalUsers;
  @override
  @JsonKey(name: 'new_users')
  int get newUsers;
  @override
  @JsonKey(name: 'active_users')
  int get activeUsers;
  @override
  @JsonKey(name: 'retention_rate')
  double get retentionRate;
  @override
  @JsonKey(name: 'period')
  String get period;

  /// Create a copy of UserActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserActivityImplCopyWith<_$UserActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RevenueChart _$RevenueChartFromJson(Map<String, dynamic> json) {
  return _RevenueChart.fromJson(json);
}

/// @nodoc
mixin _$RevenueChart {
  @JsonKey(name: 'labels')
  List<String> get labels => throw _privateConstructorUsedError;
  @JsonKey(name: 'values')
  List<double> get values => throw _privateConstructorUsedError;
  @JsonKey(name: 'period')
  String get period => throw _privateConstructorUsedError;

  /// Serializes this RevenueChart to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RevenueChart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RevenueChartCopyWith<RevenueChart> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevenueChartCopyWith<$Res> {
  factory $RevenueChartCopyWith(
          RevenueChart value, $Res Function(RevenueChart) then) =
      _$RevenueChartCopyWithImpl<$Res, RevenueChart>;
  @useResult
  $Res call(
      {@JsonKey(name: 'labels') List<String> labels,
      @JsonKey(name: 'values') List<double> values,
      @JsonKey(name: 'period') String period});
}

/// @nodoc
class _$RevenueChartCopyWithImpl<$Res, $Val extends RevenueChart>
    implements $RevenueChartCopyWith<$Res> {
  _$RevenueChartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RevenueChart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? labels = null,
    Object? values = null,
    Object? period = null,
  }) {
    return _then(_value.copyWith(
      labels: null == labels
          ? _value.labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      values: null == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<double>,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RevenueChartImplCopyWith<$Res>
    implements $RevenueChartCopyWith<$Res> {
  factory _$$RevenueChartImplCopyWith(
          _$RevenueChartImpl value, $Res Function(_$RevenueChartImpl) then) =
      __$$RevenueChartImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'labels') List<String> labels,
      @JsonKey(name: 'values') List<double> values,
      @JsonKey(name: 'period') String period});
}

/// @nodoc
class __$$RevenueChartImplCopyWithImpl<$Res>
    extends _$RevenueChartCopyWithImpl<$Res, _$RevenueChartImpl>
    implements _$$RevenueChartImplCopyWith<$Res> {
  __$$RevenueChartImplCopyWithImpl(
      _$RevenueChartImpl _value, $Res Function(_$RevenueChartImpl) _then)
      : super(_value, _then);

  /// Create a copy of RevenueChart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? labels = null,
    Object? values = null,
    Object? period = null,
  }) {
    return _then(_$RevenueChartImpl(
      labels: null == labels
          ? _value._labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<double>,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RevenueChartImpl implements _RevenueChart {
  const _$RevenueChartImpl(
      {@JsonKey(name: 'labels') required final List<String> labels,
      @JsonKey(name: 'values') required final List<double> values,
      @JsonKey(name: 'period') required this.period})
      : _labels = labels,
        _values = values;

  factory _$RevenueChartImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevenueChartImplFromJson(json);

  final List<String> _labels;
  @override
  @JsonKey(name: 'labels')
  List<String> get labels {
    if (_labels is EqualUnmodifiableListView) return _labels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_labels);
  }

  final List<double> _values;
  @override
  @JsonKey(name: 'values')
  List<double> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  @JsonKey(name: 'period')
  final String period;

  @override
  String toString() {
    return 'RevenueChart(labels: $labels, values: $values, period: $period)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevenueChartImpl &&
            const DeepCollectionEquality().equals(other._labels, _labels) &&
            const DeepCollectionEquality().equals(other._values, _values) &&
            (identical(other.period, period) || other.period == period));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_labels),
      const DeepCollectionEquality().hash(_values),
      period);

  /// Create a copy of RevenueChart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RevenueChartImplCopyWith<_$RevenueChartImpl> get copyWith =>
      __$$RevenueChartImplCopyWithImpl<_$RevenueChartImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RevenueChartImplToJson(
      this,
    );
  }
}

abstract class _RevenueChart implements RevenueChart {
  const factory _RevenueChart(
          {@JsonKey(name: 'labels') required final List<String> labels,
          @JsonKey(name: 'values') required final List<double> values,
          @JsonKey(name: 'period') required final String period}) =
      _$RevenueChartImpl;

  factory _RevenueChart.fromJson(Map<String, dynamic> json) =
      _$RevenueChartImpl.fromJson;

  @override
  @JsonKey(name: 'labels')
  List<String> get labels;
  @override
  @JsonKey(name: 'values')
  List<double> get values;
  @override
  @JsonKey(name: 'period')
  String get period;

  /// Create a copy of RevenueChart
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RevenueChartImplCopyWith<_$RevenueChartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TrendAnalysis _$TrendAnalysisFromJson(Map<String, dynamic> json) {
  return _TrendAnalysis.fromJson(json);
}

/// @nodoc
mixin _$TrendAnalysis {
  @JsonKey(name: 'sales_trend')
  double get salesTrend => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_trend')
  double get userTrend => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_trend')
  double get orderTrend => throw _privateConstructorUsedError;
  @JsonKey(name: 'period')
  String get period => throw _privateConstructorUsedError;

  /// Serializes this TrendAnalysis to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrendAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrendAnalysisCopyWith<TrendAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrendAnalysisCopyWith<$Res> {
  factory $TrendAnalysisCopyWith(
          TrendAnalysis value, $Res Function(TrendAnalysis) then) =
      _$TrendAnalysisCopyWithImpl<$Res, TrendAnalysis>;
  @useResult
  $Res call(
      {@JsonKey(name: 'sales_trend') double salesTrend,
      @JsonKey(name: 'user_trend') double userTrend,
      @JsonKey(name: 'order_trend') double orderTrend,
      @JsonKey(name: 'period') String period});
}

/// @nodoc
class _$TrendAnalysisCopyWithImpl<$Res, $Val extends TrendAnalysis>
    implements $TrendAnalysisCopyWith<$Res> {
  _$TrendAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrendAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? salesTrend = null,
    Object? userTrend = null,
    Object? orderTrend = null,
    Object? period = null,
  }) {
    return _then(_value.copyWith(
      salesTrend: null == salesTrend
          ? _value.salesTrend
          : salesTrend // ignore: cast_nullable_to_non_nullable
              as double,
      userTrend: null == userTrend
          ? _value.userTrend
          : userTrend // ignore: cast_nullable_to_non_nullable
              as double,
      orderTrend: null == orderTrend
          ? _value.orderTrend
          : orderTrend // ignore: cast_nullable_to_non_nullable
              as double,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrendAnalysisImplCopyWith<$Res>
    implements $TrendAnalysisCopyWith<$Res> {
  factory _$$TrendAnalysisImplCopyWith(
          _$TrendAnalysisImpl value, $Res Function(_$TrendAnalysisImpl) then) =
      __$$TrendAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'sales_trend') double salesTrend,
      @JsonKey(name: 'user_trend') double userTrend,
      @JsonKey(name: 'order_trend') double orderTrend,
      @JsonKey(name: 'period') String period});
}

/// @nodoc
class __$$TrendAnalysisImplCopyWithImpl<$Res>
    extends _$TrendAnalysisCopyWithImpl<$Res, _$TrendAnalysisImpl>
    implements _$$TrendAnalysisImplCopyWith<$Res> {
  __$$TrendAnalysisImplCopyWithImpl(
      _$TrendAnalysisImpl _value, $Res Function(_$TrendAnalysisImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrendAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? salesTrend = null,
    Object? userTrend = null,
    Object? orderTrend = null,
    Object? period = null,
  }) {
    return _then(_$TrendAnalysisImpl(
      salesTrend: null == salesTrend
          ? _value.salesTrend
          : salesTrend // ignore: cast_nullable_to_non_nullable
              as double,
      userTrend: null == userTrend
          ? _value.userTrend
          : userTrend // ignore: cast_nullable_to_non_nullable
              as double,
      orderTrend: null == orderTrend
          ? _value.orderTrend
          : orderTrend // ignore: cast_nullable_to_non_nullable
              as double,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrendAnalysisImpl implements _TrendAnalysis {
  const _$TrendAnalysisImpl(
      {@JsonKey(name: 'sales_trend') required this.salesTrend,
      @JsonKey(name: 'user_trend') required this.userTrend,
      @JsonKey(name: 'order_trend') required this.orderTrend,
      @JsonKey(name: 'period') required this.period});

  factory _$TrendAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrendAnalysisImplFromJson(json);

  @override
  @JsonKey(name: 'sales_trend')
  final double salesTrend;
  @override
  @JsonKey(name: 'user_trend')
  final double userTrend;
  @override
  @JsonKey(name: 'order_trend')
  final double orderTrend;
  @override
  @JsonKey(name: 'period')
  final String period;

  @override
  String toString() {
    return 'TrendAnalysis(salesTrend: $salesTrend, userTrend: $userTrend, orderTrend: $orderTrend, period: $period)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrendAnalysisImpl &&
            (identical(other.salesTrend, salesTrend) ||
                other.salesTrend == salesTrend) &&
            (identical(other.userTrend, userTrend) ||
                other.userTrend == userTrend) &&
            (identical(other.orderTrend, orderTrend) ||
                other.orderTrend == orderTrend) &&
            (identical(other.period, period) || other.period == period));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, salesTrend, userTrend, orderTrend, period);

  /// Create a copy of TrendAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrendAnalysisImplCopyWith<_$TrendAnalysisImpl> get copyWith =>
      __$$TrendAnalysisImplCopyWithImpl<_$TrendAnalysisImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrendAnalysisImplToJson(
      this,
    );
  }
}

abstract class _TrendAnalysis implements TrendAnalysis {
  const factory _TrendAnalysis(
          {@JsonKey(name: 'sales_trend') required final double salesTrend,
          @JsonKey(name: 'user_trend') required final double userTrend,
          @JsonKey(name: 'order_trend') required final double orderTrend,
          @JsonKey(name: 'period') required final String period}) =
      _$TrendAnalysisImpl;

  factory _TrendAnalysis.fromJson(Map<String, dynamic> json) =
      _$TrendAnalysisImpl.fromJson;

  @override
  @JsonKey(name: 'sales_trend')
  double get salesTrend;
  @override
  @JsonKey(name: 'user_trend')
  double get userTrend;
  @override
  @JsonKey(name: 'order_trend')
  double get orderTrend;
  @override
  @JsonKey(name: 'period')
  String get period;

  /// Create a copy of TrendAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrendAnalysisImplCopyWith<_$TrendAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnalyticsData _$AnalyticsDataFromJson(Map<String, dynamic> json) {
  return _AnalyticsData.fromJson(json);
}

/// @nodoc
mixin _$AnalyticsData {
  SalesReport get salesReport => throw _privateConstructorUsedError;
  UserActivity get userActivity => throw _privateConstructorUsedError;
  RevenueChart get revenueChart => throw _privateConstructorUsedError;
  TrendAnalysis get trendAnalysis => throw _privateConstructorUsedError;

  /// Serializes this AnalyticsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyticsDataCopyWith<AnalyticsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsDataCopyWith<$Res> {
  factory $AnalyticsDataCopyWith(
          AnalyticsData value, $Res Function(AnalyticsData) then) =
      _$AnalyticsDataCopyWithImpl<$Res, AnalyticsData>;
  @useResult
  $Res call(
      {SalesReport salesReport,
      UserActivity userActivity,
      RevenueChart revenueChart,
      TrendAnalysis trendAnalysis});

  $SalesReportCopyWith<$Res> get salesReport;
  $UserActivityCopyWith<$Res> get userActivity;
  $RevenueChartCopyWith<$Res> get revenueChart;
  $TrendAnalysisCopyWith<$Res> get trendAnalysis;
}

/// @nodoc
class _$AnalyticsDataCopyWithImpl<$Res, $Val extends AnalyticsData>
    implements $AnalyticsDataCopyWith<$Res> {
  _$AnalyticsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? salesReport = null,
    Object? userActivity = null,
    Object? revenueChart = null,
    Object? trendAnalysis = null,
  }) {
    return _then(_value.copyWith(
      salesReport: null == salesReport
          ? _value.salesReport
          : salesReport // ignore: cast_nullable_to_non_nullable
              as SalesReport,
      userActivity: null == userActivity
          ? _value.userActivity
          : userActivity // ignore: cast_nullable_to_non_nullable
              as UserActivity,
      revenueChart: null == revenueChart
          ? _value.revenueChart
          : revenueChart // ignore: cast_nullable_to_non_nullable
              as RevenueChart,
      trendAnalysis: null == trendAnalysis
          ? _value.trendAnalysis
          : trendAnalysis // ignore: cast_nullable_to_non_nullable
              as TrendAnalysis,
    ) as $Val);
  }

  /// Create a copy of AnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SalesReportCopyWith<$Res> get salesReport {
    return $SalesReportCopyWith<$Res>(_value.salesReport, (value) {
      return _then(_value.copyWith(salesReport: value) as $Val);
    });
  }

  /// Create a copy of AnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserActivityCopyWith<$Res> get userActivity {
    return $UserActivityCopyWith<$Res>(_value.userActivity, (value) {
      return _then(_value.copyWith(userActivity: value) as $Val);
    });
  }

  /// Create a copy of AnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RevenueChartCopyWith<$Res> get revenueChart {
    return $RevenueChartCopyWith<$Res>(_value.revenueChart, (value) {
      return _then(_value.copyWith(revenueChart: value) as $Val);
    });
  }

  /// Create a copy of AnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TrendAnalysisCopyWith<$Res> get trendAnalysis {
    return $TrendAnalysisCopyWith<$Res>(_value.trendAnalysis, (value) {
      return _then(_value.copyWith(trendAnalysis: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AnalyticsDataImplCopyWith<$Res>
    implements $AnalyticsDataCopyWith<$Res> {
  factory _$$AnalyticsDataImplCopyWith(
          _$AnalyticsDataImpl value, $Res Function(_$AnalyticsDataImpl) then) =
      __$$AnalyticsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SalesReport salesReport,
      UserActivity userActivity,
      RevenueChart revenueChart,
      TrendAnalysis trendAnalysis});

  @override
  $SalesReportCopyWith<$Res> get salesReport;
  @override
  $UserActivityCopyWith<$Res> get userActivity;
  @override
  $RevenueChartCopyWith<$Res> get revenueChart;
  @override
  $TrendAnalysisCopyWith<$Res> get trendAnalysis;
}

/// @nodoc
class __$$AnalyticsDataImplCopyWithImpl<$Res>
    extends _$AnalyticsDataCopyWithImpl<$Res, _$AnalyticsDataImpl>
    implements _$$AnalyticsDataImplCopyWith<$Res> {
  __$$AnalyticsDataImplCopyWithImpl(
      _$AnalyticsDataImpl _value, $Res Function(_$AnalyticsDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? salesReport = null,
    Object? userActivity = null,
    Object? revenueChart = null,
    Object? trendAnalysis = null,
  }) {
    return _then(_$AnalyticsDataImpl(
      salesReport: null == salesReport
          ? _value.salesReport
          : salesReport // ignore: cast_nullable_to_non_nullable
              as SalesReport,
      userActivity: null == userActivity
          ? _value.userActivity
          : userActivity // ignore: cast_nullable_to_non_nullable
              as UserActivity,
      revenueChart: null == revenueChart
          ? _value.revenueChart
          : revenueChart // ignore: cast_nullable_to_non_nullable
              as RevenueChart,
      trendAnalysis: null == trendAnalysis
          ? _value.trendAnalysis
          : trendAnalysis // ignore: cast_nullable_to_non_nullable
              as TrendAnalysis,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyticsDataImpl implements _AnalyticsData {
  const _$AnalyticsDataImpl(
      {required this.salesReport,
      required this.userActivity,
      required this.revenueChart,
      required this.trendAnalysis});

  factory _$AnalyticsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalyticsDataImplFromJson(json);

  @override
  final SalesReport salesReport;
  @override
  final UserActivity userActivity;
  @override
  final RevenueChart revenueChart;
  @override
  final TrendAnalysis trendAnalysis;

  @override
  String toString() {
    return 'AnalyticsData(salesReport: $salesReport, userActivity: $userActivity, revenueChart: $revenueChart, trendAnalysis: $trendAnalysis)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsDataImpl &&
            (identical(other.salesReport, salesReport) ||
                other.salesReport == salesReport) &&
            (identical(other.userActivity, userActivity) ||
                other.userActivity == userActivity) &&
            (identical(other.revenueChart, revenueChart) ||
                other.revenueChart == revenueChart) &&
            (identical(other.trendAnalysis, trendAnalysis) ||
                other.trendAnalysis == trendAnalysis));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, salesReport, userActivity, revenueChart, trendAnalysis);

  /// Create a copy of AnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsDataImplCopyWith<_$AnalyticsDataImpl> get copyWith =>
      __$$AnalyticsDataImplCopyWithImpl<_$AnalyticsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyticsDataImplToJson(
      this,
    );
  }
}

abstract class _AnalyticsData implements AnalyticsData {
  const factory _AnalyticsData(
      {required final SalesReport salesReport,
      required final UserActivity userActivity,
      required final RevenueChart revenueChart,
      required final TrendAnalysis trendAnalysis}) = _$AnalyticsDataImpl;

  factory _AnalyticsData.fromJson(Map<String, dynamic> json) =
      _$AnalyticsDataImpl.fromJson;

  @override
  SalesReport get salesReport;
  @override
  UserActivity get userActivity;
  @override
  RevenueChart get revenueChart;
  @override
  TrendAnalysis get trendAnalysis;

  /// Create a copy of AnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsDataImplCopyWith<_$AnalyticsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
