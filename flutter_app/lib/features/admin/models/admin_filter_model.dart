import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_filter_model.freezed.dart';
part 'admin_filter_model.g.dart';

@freezed
class DateFilter with _$DateFilter {
  const factory DateFilter({
    @JsonKey(name: 'start_date') DateTime? startDate,
    @JsonKey(name: 'end_date') DateTime? endDate,
    @JsonKey(name: 'preset')
    String? preset, // 'today', 'week', 'month', 'year', 'custom'
  }) = _DateFilter;

  factory DateFilter.fromJson(Map<String, dynamic> json) =>
      _$DateFilterFromJson(json);
}

@freezed
class MultiSelectFilter with _$MultiSelectFilter {
  const factory MultiSelectFilter({
    required String field,
    required List<String> selectedValues,
    required List<FilterOption> options,
  }) = _MultiSelectFilter;

  factory MultiSelectFilter.fromJson(Map<String, dynamic> json) =>
      _$MultiSelectFilterFromJson(json);
}

@freezed
class FilterOption with _$FilterOption {
  const factory FilterOption({
    required String value,
    required String label,
    @Default(0) int count,
  }) = _FilterOption;

  factory FilterOption.fromJson(Map<String, dynamic> json) =>
      _$FilterOptionFromJson(json);
}

@freezed
class SavedFilter with _$SavedFilter {
  const factory SavedFilter({
    required String id,
    required String name,
    required String description,
    required Map<String, dynamic> filterData,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _SavedFilter;

  factory SavedFilter.fromJson(Map<String, dynamic> json) =>
      _$SavedFilterFromJson(json);
}

@freezed
class ExportOptions with _$ExportOptions {
  const factory ExportOptions({
    @JsonKey(name: 'format')
    @Default('csv')
    String format, // 'csv', 'excel', 'pdf'
    @JsonKey(name: 'include_headers') @Default(true) bool includeHeaders,
    @JsonKey(name: 'date_range') DateFilter? dateRange,
    @JsonKey(name: 'filters') Map<String, dynamic>? filters,
    @JsonKey(name: 'columns') List<String>? columns,
  }) = _ExportOptions;

  factory ExportOptions.fromJson(Map<String, dynamic> json) =>
      _$ExportOptionsFromJson(json);
}

@freezed
class FilterState with _$FilterState {
  const factory FilterState({
    @JsonKey(name: 'date_filter') DateFilter? dateFilter,
    @JsonKey(name: 'multi_select_filters')
    @Default([])
    List<MultiSelectFilter> multiSelectFilters,
    @JsonKey(name: 'search_query') String? searchQuery,
    @JsonKey(name: 'sort_by') String? sortBy,
    @JsonKey(name: 'sort_order') @Default('asc') String sortOrder,
    @JsonKey(name: 'page') @Default(1) int page,
    @JsonKey(name: 'per_page') @Default(20) int perPage,
  }) = _FilterState;

  factory FilterState.fromJson(Map<String, dynamic> json) =>
      _$FilterStateFromJson(json);
}
