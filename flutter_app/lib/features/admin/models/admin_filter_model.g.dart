// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DateFilterImpl _$$DateFilterImplFromJson(Map<String, dynamic> json) =>
    _$DateFilterImpl(
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      preset: json['preset'] as String?,
    );

Map<String, dynamic> _$$DateFilterImplToJson(_$DateFilterImpl instance) =>
    <String, dynamic>{
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'preset': instance.preset,
    };

_$MultiSelectFilterImpl _$$MultiSelectFilterImplFromJson(
        Map<String, dynamic> json) =>
    _$MultiSelectFilterImpl(
      field: json['field'] as String,
      selectedValues: (json['selectedValues'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      options: (json['options'] as List<dynamic>)
          .map((e) => FilterOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MultiSelectFilterImplToJson(
        _$MultiSelectFilterImpl instance) =>
    <String, dynamic>{
      'field': instance.field,
      'selectedValues': instance.selectedValues,
      'options': instance.options,
    };

_$FilterOptionImpl _$$FilterOptionImplFromJson(Map<String, dynamic> json) =>
    _$FilterOptionImpl(
      value: json['value'] as String,
      label: json['label'] as String,
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FilterOptionImplToJson(_$FilterOptionImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'count': instance.count,
    };

_$SavedFilterImpl _$$SavedFilterImplFromJson(Map<String, dynamic> json) =>
    _$SavedFilterImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      filterData: json['filterData'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$SavedFilterImplToJson(_$SavedFilterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'filterData': instance.filterData,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

_$ExportOptionsImpl _$$ExportOptionsImplFromJson(Map<String, dynamic> json) =>
    _$ExportOptionsImpl(
      format: json['format'] as String? ?? 'csv',
      includeHeaders: json['include_headers'] as bool? ?? true,
      dateRange: json['date_range'] == null
          ? null
          : DateFilter.fromJson(json['date_range'] as Map<String, dynamic>),
      filters: json['filters'] as Map<String, dynamic>?,
      columns:
          (json['columns'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ExportOptionsImplToJson(_$ExportOptionsImpl instance) =>
    <String, dynamic>{
      'format': instance.format,
      'include_headers': instance.includeHeaders,
      'date_range': instance.dateRange,
      'filters': instance.filters,
      'columns': instance.columns,
    };

_$FilterStateImpl _$$FilterStateImplFromJson(Map<String, dynamic> json) =>
    _$FilterStateImpl(
      dateFilter: json['date_filter'] == null
          ? null
          : DateFilter.fromJson(json['date_filter'] as Map<String, dynamic>),
      multiSelectFilters: (json['multi_select_filters'] as List<dynamic>?)
              ?.map(
                  (e) => MultiSelectFilter.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      searchQuery: json['search_query'] as String?,
      sortBy: json['sort_by'] as String?,
      sortOrder: json['sort_order'] as String? ?? 'asc',
      page: (json['page'] as num?)?.toInt() ?? 1,
      perPage: (json['per_page'] as num?)?.toInt() ?? 20,
    );

Map<String, dynamic> _$$FilterStateImplToJson(_$FilterStateImpl instance) =>
    <String, dynamic>{
      'date_filter': instance.dateFilter,
      'multi_select_filters': instance.multiSelectFilters,
      'search_query': instance.searchQuery,
      'sort_by': instance.sortBy,
      'sort_order': instance.sortOrder,
      'page': instance.page,
      'per_page': instance.perPage,
    };
