// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DateFilter _$DateFilterFromJson(Map<String, dynamic> json) {
  return _DateFilter.fromJson(json);
}

/// @nodoc
mixin _$DateFilter {
  @JsonKey(name: 'start_date')
  DateTime? get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  DateTime? get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'preset')
  String? get preset => throw _privateConstructorUsedError;

  /// Serializes this DateFilter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DateFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DateFilterCopyWith<DateFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateFilterCopyWith<$Res> {
  factory $DateFilterCopyWith(
          DateFilter value, $Res Function(DateFilter) then) =
      _$DateFilterCopyWithImpl<$Res, DateFilter>;
  @useResult
  $Res call(
      {@JsonKey(name: 'start_date') DateTime? startDate,
      @JsonKey(name: 'end_date') DateTime? endDate,
      @JsonKey(name: 'preset') String? preset});
}

/// @nodoc
class _$DateFilterCopyWithImpl<$Res, $Val extends DateFilter>
    implements $DateFilterCopyWith<$Res> {
  _$DateFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DateFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? preset = freezed,
  }) {
    return _then(_value.copyWith(
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preset: freezed == preset
          ? _value.preset
          : preset // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DateFilterImplCopyWith<$Res>
    implements $DateFilterCopyWith<$Res> {
  factory _$$DateFilterImplCopyWith(
          _$DateFilterImpl value, $Res Function(_$DateFilterImpl) then) =
      __$$DateFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'start_date') DateTime? startDate,
      @JsonKey(name: 'end_date') DateTime? endDate,
      @JsonKey(name: 'preset') String? preset});
}

/// @nodoc
class __$$DateFilterImplCopyWithImpl<$Res>
    extends _$DateFilterCopyWithImpl<$Res, _$DateFilterImpl>
    implements _$$DateFilterImplCopyWith<$Res> {
  __$$DateFilterImplCopyWithImpl(
      _$DateFilterImpl _value, $Res Function(_$DateFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of DateFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? preset = freezed,
  }) {
    return _then(_$DateFilterImpl(
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      preset: freezed == preset
          ? _value.preset
          : preset // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DateFilterImpl implements _DateFilter {
  const _$DateFilterImpl(
      {@JsonKey(name: 'start_date') this.startDate,
      @JsonKey(name: 'end_date') this.endDate,
      @JsonKey(name: 'preset') this.preset});

  factory _$DateFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$DateFilterImplFromJson(json);

  @override
  @JsonKey(name: 'start_date')
  final DateTime? startDate;
  @override
  @JsonKey(name: 'end_date')
  final DateTime? endDate;
  @override
  @JsonKey(name: 'preset')
  final String? preset;

  @override
  String toString() {
    return 'DateFilter(startDate: $startDate, endDate: $endDate, preset: $preset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DateFilterImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.preset, preset) || other.preset == preset));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate, preset);

  /// Create a copy of DateFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DateFilterImplCopyWith<_$DateFilterImpl> get copyWith =>
      __$$DateFilterImplCopyWithImpl<_$DateFilterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DateFilterImplToJson(
      this,
    );
  }
}

abstract class _DateFilter implements DateFilter {
  const factory _DateFilter(
      {@JsonKey(name: 'start_date') final DateTime? startDate,
      @JsonKey(name: 'end_date') final DateTime? endDate,
      @JsonKey(name: 'preset') final String? preset}) = _$DateFilterImpl;

  factory _DateFilter.fromJson(Map<String, dynamic> json) =
      _$DateFilterImpl.fromJson;

  @override
  @JsonKey(name: 'start_date')
  DateTime? get startDate;
  @override
  @JsonKey(name: 'end_date')
  DateTime? get endDate;
  @override
  @JsonKey(name: 'preset')
  String? get preset;

  /// Create a copy of DateFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DateFilterImplCopyWith<_$DateFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MultiSelectFilter _$MultiSelectFilterFromJson(Map<String, dynamic> json) {
  return _MultiSelectFilter.fromJson(json);
}

/// @nodoc
mixin _$MultiSelectFilter {
  String get field => throw _privateConstructorUsedError;
  List<String> get selectedValues => throw _privateConstructorUsedError;
  List<FilterOption> get options => throw _privateConstructorUsedError;

  /// Serializes this MultiSelectFilter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MultiSelectFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MultiSelectFilterCopyWith<MultiSelectFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultiSelectFilterCopyWith<$Res> {
  factory $MultiSelectFilterCopyWith(
          MultiSelectFilter value, $Res Function(MultiSelectFilter) then) =
      _$MultiSelectFilterCopyWithImpl<$Res, MultiSelectFilter>;
  @useResult
  $Res call(
      {String field, List<String> selectedValues, List<FilterOption> options});
}

/// @nodoc
class _$MultiSelectFilterCopyWithImpl<$Res, $Val extends MultiSelectFilter>
    implements $MultiSelectFilterCopyWith<$Res> {
  _$MultiSelectFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MultiSelectFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? selectedValues = null,
    Object? options = null,
  }) {
    return _then(_value.copyWith(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      selectedValues: null == selectedValues
          ? _value.selectedValues
          : selectedValues // ignore: cast_nullable_to_non_nullable
              as List<String>,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<FilterOption>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MultiSelectFilterImplCopyWith<$Res>
    implements $MultiSelectFilterCopyWith<$Res> {
  factory _$$MultiSelectFilterImplCopyWith(_$MultiSelectFilterImpl value,
          $Res Function(_$MultiSelectFilterImpl) then) =
      __$$MultiSelectFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String field, List<String> selectedValues, List<FilterOption> options});
}

/// @nodoc
class __$$MultiSelectFilterImplCopyWithImpl<$Res>
    extends _$MultiSelectFilterCopyWithImpl<$Res, _$MultiSelectFilterImpl>
    implements _$$MultiSelectFilterImplCopyWith<$Res> {
  __$$MultiSelectFilterImplCopyWithImpl(_$MultiSelectFilterImpl _value,
      $Res Function(_$MultiSelectFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of MultiSelectFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? selectedValues = null,
    Object? options = null,
  }) {
    return _then(_$MultiSelectFilterImpl(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      selectedValues: null == selectedValues
          ? _value._selectedValues
          : selectedValues // ignore: cast_nullable_to_non_nullable
              as List<String>,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<FilterOption>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MultiSelectFilterImpl implements _MultiSelectFilter {
  const _$MultiSelectFilterImpl(
      {required this.field,
      required final List<String> selectedValues,
      required final List<FilterOption> options})
      : _selectedValues = selectedValues,
        _options = options;

  factory _$MultiSelectFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$MultiSelectFilterImplFromJson(json);

  @override
  final String field;
  final List<String> _selectedValues;
  @override
  List<String> get selectedValues {
    if (_selectedValues is EqualUnmodifiableListView) return _selectedValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedValues);
  }

  final List<FilterOption> _options;
  @override
  List<FilterOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'MultiSelectFilter(field: $field, selectedValues: $selectedValues, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultiSelectFilterImpl &&
            (identical(other.field, field) || other.field == field) &&
            const DeepCollectionEquality()
                .equals(other._selectedValues, _selectedValues) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      field,
      const DeepCollectionEquality().hash(_selectedValues),
      const DeepCollectionEquality().hash(_options));

  /// Create a copy of MultiSelectFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MultiSelectFilterImplCopyWith<_$MultiSelectFilterImpl> get copyWith =>
      __$$MultiSelectFilterImplCopyWithImpl<_$MultiSelectFilterImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MultiSelectFilterImplToJson(
      this,
    );
  }
}

abstract class _MultiSelectFilter implements MultiSelectFilter {
  const factory _MultiSelectFilter(
      {required final String field,
      required final List<String> selectedValues,
      required final List<FilterOption> options}) = _$MultiSelectFilterImpl;

  factory _MultiSelectFilter.fromJson(Map<String, dynamic> json) =
      _$MultiSelectFilterImpl.fromJson;

  @override
  String get field;
  @override
  List<String> get selectedValues;
  @override
  List<FilterOption> get options;

  /// Create a copy of MultiSelectFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MultiSelectFilterImplCopyWith<_$MultiSelectFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FilterOption _$FilterOptionFromJson(Map<String, dynamic> json) {
  return _FilterOption.fromJson(json);
}

/// @nodoc
mixin _$FilterOption {
  String get value => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  /// Serializes this FilterOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FilterOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilterOptionCopyWith<FilterOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterOptionCopyWith<$Res> {
  factory $FilterOptionCopyWith(
          FilterOption value, $Res Function(FilterOption) then) =
      _$FilterOptionCopyWithImpl<$Res, FilterOption>;
  @useResult
  $Res call({String value, String label, int count});
}

/// @nodoc
class _$FilterOptionCopyWithImpl<$Res, $Val extends FilterOption>
    implements $FilterOptionCopyWith<$Res> {
  _$FilterOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilterOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? label = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FilterOptionImplCopyWith<$Res>
    implements $FilterOptionCopyWith<$Res> {
  factory _$$FilterOptionImplCopyWith(
          _$FilterOptionImpl value, $Res Function(_$FilterOptionImpl) then) =
      __$$FilterOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value, String label, int count});
}

/// @nodoc
class __$$FilterOptionImplCopyWithImpl<$Res>
    extends _$FilterOptionCopyWithImpl<$Res, _$FilterOptionImpl>
    implements _$$FilterOptionImplCopyWith<$Res> {
  __$$FilterOptionImplCopyWithImpl(
      _$FilterOptionImpl _value, $Res Function(_$FilterOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilterOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? label = null,
    Object? count = null,
  }) {
    return _then(_$FilterOptionImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FilterOptionImpl implements _FilterOption {
  const _$FilterOptionImpl(
      {required this.value, required this.label, this.count = 0});

  factory _$FilterOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilterOptionImplFromJson(json);

  @override
  final String value;
  @override
  final String label;
  @override
  @JsonKey()
  final int count;

  @override
  String toString() {
    return 'FilterOption(value: $value, label: $label, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterOptionImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, label, count);

  /// Create a copy of FilterOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterOptionImplCopyWith<_$FilterOptionImpl> get copyWith =>
      __$$FilterOptionImplCopyWithImpl<_$FilterOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilterOptionImplToJson(
      this,
    );
  }
}

abstract class _FilterOption implements FilterOption {
  const factory _FilterOption(
      {required final String value,
      required final String label,
      final int count}) = _$FilterOptionImpl;

  factory _FilterOption.fromJson(Map<String, dynamic> json) =
      _$FilterOptionImpl.fromJson;

  @override
  String get value;
  @override
  String get label;
  @override
  int get count;

  /// Create a copy of FilterOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterOptionImplCopyWith<_$FilterOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SavedFilter _$SavedFilterFromJson(Map<String, dynamic> json) {
  return _SavedFilter.fromJson(json);
}

/// @nodoc
mixin _$SavedFilter {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<String, dynamic> get filterData => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this SavedFilter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SavedFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavedFilterCopyWith<SavedFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedFilterCopyWith<$Res> {
  factory $SavedFilterCopyWith(
          SavedFilter value, $Res Function(SavedFilter) then) =
      _$SavedFilterCopyWithImpl<$Res, SavedFilter>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      Map<String, dynamic> filterData,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class _$SavedFilterCopyWithImpl<$Res, $Val extends SavedFilter>
    implements $SavedFilterCopyWith<$Res> {
  _$SavedFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavedFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? filterData = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      filterData: null == filterData
          ? _value.filterData
          : filterData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SavedFilterImplCopyWith<$Res>
    implements $SavedFilterCopyWith<$Res> {
  factory _$$SavedFilterImplCopyWith(
          _$SavedFilterImpl value, $Res Function(_$SavedFilterImpl) then) =
      __$$SavedFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      Map<String, dynamic> filterData,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class __$$SavedFilterImplCopyWithImpl<$Res>
    extends _$SavedFilterCopyWithImpl<$Res, _$SavedFilterImpl>
    implements _$$SavedFilterImplCopyWith<$Res> {
  __$$SavedFilterImplCopyWithImpl(
      _$SavedFilterImpl _value, $Res Function(_$SavedFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of SavedFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? filterData = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$SavedFilterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      filterData: null == filterData
          ? _value._filterData
          : filterData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SavedFilterImpl implements _SavedFilter {
  const _$SavedFilterImpl(
      {required this.id,
      required this.name,
      required this.description,
      required final Map<String, dynamic> filterData,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt})
      : _filterData = filterData;

  factory _$SavedFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedFilterImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  final Map<String, dynamic> _filterData;
  @override
  Map<String, dynamic> get filterData {
    if (_filterData is EqualUnmodifiableMapView) return _filterData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_filterData);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'SavedFilter(id: $id, name: $name, description: $description, filterData: $filterData, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedFilterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._filterData, _filterData) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description,
      const DeepCollectionEquality().hash(_filterData), createdAt, updatedAt);

  /// Create a copy of SavedFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedFilterImplCopyWith<_$SavedFilterImpl> get copyWith =>
      __$$SavedFilterImplCopyWithImpl<_$SavedFilterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedFilterImplToJson(
      this,
    );
  }
}

abstract class _SavedFilter implements SavedFilter {
  const factory _SavedFilter(
          {required final String id,
          required final String name,
          required final String description,
          required final Map<String, dynamic> filterData,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'updated_at') required final DateTime updatedAt}) =
      _$SavedFilterImpl;

  factory _SavedFilter.fromJson(Map<String, dynamic> json) =
      _$SavedFilterImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  Map<String, dynamic> get filterData;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of SavedFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedFilterImplCopyWith<_$SavedFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExportOptions _$ExportOptionsFromJson(Map<String, dynamic> json) {
  return _ExportOptions.fromJson(json);
}

/// @nodoc
mixin _$ExportOptions {
  @JsonKey(name: 'format')
  String get format =>
      throw _privateConstructorUsedError; // 'csv', 'excel', 'pdf'
  @JsonKey(name: 'include_headers')
  bool get includeHeaders => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_range')
  DateFilter? get dateRange => throw _privateConstructorUsedError;
  @JsonKey(name: 'filters')
  Map<String, dynamic>? get filters => throw _privateConstructorUsedError;
  @JsonKey(name: 'columns')
  List<String>? get columns => throw _privateConstructorUsedError;

  /// Serializes this ExportOptions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExportOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExportOptionsCopyWith<ExportOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExportOptionsCopyWith<$Res> {
  factory $ExportOptionsCopyWith(
          ExportOptions value, $Res Function(ExportOptions) then) =
      _$ExportOptionsCopyWithImpl<$Res, ExportOptions>;
  @useResult
  $Res call(
      {@JsonKey(name: 'format') String format,
      @JsonKey(name: 'include_headers') bool includeHeaders,
      @JsonKey(name: 'date_range') DateFilter? dateRange,
      @JsonKey(name: 'filters') Map<String, dynamic>? filters,
      @JsonKey(name: 'columns') List<String>? columns});

  $DateFilterCopyWith<$Res>? get dateRange;
}

/// @nodoc
class _$ExportOptionsCopyWithImpl<$Res, $Val extends ExportOptions>
    implements $ExportOptionsCopyWith<$Res> {
  _$ExportOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExportOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? format = null,
    Object? includeHeaders = null,
    Object? dateRange = freezed,
    Object? filters = freezed,
    Object? columns = freezed,
  }) {
    return _then(_value.copyWith(
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      includeHeaders: null == includeHeaders
          ? _value.includeHeaders
          : includeHeaders // ignore: cast_nullable_to_non_nullable
              as bool,
      dateRange: freezed == dateRange
          ? _value.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as DateFilter?,
      filters: freezed == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      columns: freezed == columns
          ? _value.columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  /// Create a copy of ExportOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DateFilterCopyWith<$Res>? get dateRange {
    if (_value.dateRange == null) {
      return null;
    }

    return $DateFilterCopyWith<$Res>(_value.dateRange!, (value) {
      return _then(_value.copyWith(dateRange: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExportOptionsImplCopyWith<$Res>
    implements $ExportOptionsCopyWith<$Res> {
  factory _$$ExportOptionsImplCopyWith(
          _$ExportOptionsImpl value, $Res Function(_$ExportOptionsImpl) then) =
      __$$ExportOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'format') String format,
      @JsonKey(name: 'include_headers') bool includeHeaders,
      @JsonKey(name: 'date_range') DateFilter? dateRange,
      @JsonKey(name: 'filters') Map<String, dynamic>? filters,
      @JsonKey(name: 'columns') List<String>? columns});

  @override
  $DateFilterCopyWith<$Res>? get dateRange;
}

/// @nodoc
class __$$ExportOptionsImplCopyWithImpl<$Res>
    extends _$ExportOptionsCopyWithImpl<$Res, _$ExportOptionsImpl>
    implements _$$ExportOptionsImplCopyWith<$Res> {
  __$$ExportOptionsImplCopyWithImpl(
      _$ExportOptionsImpl _value, $Res Function(_$ExportOptionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExportOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? format = null,
    Object? includeHeaders = null,
    Object? dateRange = freezed,
    Object? filters = freezed,
    Object? columns = freezed,
  }) {
    return _then(_$ExportOptionsImpl(
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      includeHeaders: null == includeHeaders
          ? _value.includeHeaders
          : includeHeaders // ignore: cast_nullable_to_non_nullable
              as bool,
      dateRange: freezed == dateRange
          ? _value.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as DateFilter?,
      filters: freezed == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      columns: freezed == columns
          ? _value._columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExportOptionsImpl implements _ExportOptions {
  const _$ExportOptionsImpl(
      {@JsonKey(name: 'format') this.format = 'csv',
      @JsonKey(name: 'include_headers') this.includeHeaders = true,
      @JsonKey(name: 'date_range') this.dateRange,
      @JsonKey(name: 'filters') final Map<String, dynamic>? filters,
      @JsonKey(name: 'columns') final List<String>? columns})
      : _filters = filters,
        _columns = columns;

  factory _$ExportOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExportOptionsImplFromJson(json);

  @override
  @JsonKey(name: 'format')
  final String format;
// 'csv', 'excel', 'pdf'
  @override
  @JsonKey(name: 'include_headers')
  final bool includeHeaders;
  @override
  @JsonKey(name: 'date_range')
  final DateFilter? dateRange;
  final Map<String, dynamic>? _filters;
  @override
  @JsonKey(name: 'filters')
  Map<String, dynamic>? get filters {
    final value = _filters;
    if (value == null) return null;
    if (_filters is EqualUnmodifiableMapView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _columns;
  @override
  @JsonKey(name: 'columns')
  List<String>? get columns {
    final value = _columns;
    if (value == null) return null;
    if (_columns is EqualUnmodifiableListView) return _columns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ExportOptions(format: $format, includeHeaders: $includeHeaders, dateRange: $dateRange, filters: $filters, columns: $columns)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExportOptionsImpl &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.includeHeaders, includeHeaders) ||
                other.includeHeaders == includeHeaders) &&
            (identical(other.dateRange, dateRange) ||
                other.dateRange == dateRange) &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            const DeepCollectionEquality().equals(other._columns, _columns));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      format,
      includeHeaders,
      dateRange,
      const DeepCollectionEquality().hash(_filters),
      const DeepCollectionEquality().hash(_columns));

  /// Create a copy of ExportOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExportOptionsImplCopyWith<_$ExportOptionsImpl> get copyWith =>
      __$$ExportOptionsImplCopyWithImpl<_$ExportOptionsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExportOptionsImplToJson(
      this,
    );
  }
}

abstract class _ExportOptions implements ExportOptions {
  const factory _ExportOptions(
          {@JsonKey(name: 'format') final String format,
          @JsonKey(name: 'include_headers') final bool includeHeaders,
          @JsonKey(name: 'date_range') final DateFilter? dateRange,
          @JsonKey(name: 'filters') final Map<String, dynamic>? filters,
          @JsonKey(name: 'columns') final List<String>? columns}) =
      _$ExportOptionsImpl;

  factory _ExportOptions.fromJson(Map<String, dynamic> json) =
      _$ExportOptionsImpl.fromJson;

  @override
  @JsonKey(name: 'format')
  String get format; // 'csv', 'excel', 'pdf'
  @override
  @JsonKey(name: 'include_headers')
  bool get includeHeaders;
  @override
  @JsonKey(name: 'date_range')
  DateFilter? get dateRange;
  @override
  @JsonKey(name: 'filters')
  Map<String, dynamic>? get filters;
  @override
  @JsonKey(name: 'columns')
  List<String>? get columns;

  /// Create a copy of ExportOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExportOptionsImplCopyWith<_$ExportOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FilterState _$FilterStateFromJson(Map<String, dynamic> json) {
  return _FilterState.fromJson(json);
}

/// @nodoc
mixin _$FilterState {
  @JsonKey(name: 'date_filter')
  DateFilter? get dateFilter => throw _privateConstructorUsedError;
  @JsonKey(name: 'multi_select_filters')
  List<MultiSelectFilter> get multiSelectFilters =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'search_query')
  String? get searchQuery => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_by')
  String? get sortBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  String get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;

  /// Serializes this FilterState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilterStateCopyWith<FilterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterStateCopyWith<$Res> {
  factory $FilterStateCopyWith(
          FilterState value, $Res Function(FilterState) then) =
      _$FilterStateCopyWithImpl<$Res, FilterState>;
  @useResult
  $Res call(
      {@JsonKey(name: 'date_filter') DateFilter? dateFilter,
      @JsonKey(name: 'multi_select_filters')
      List<MultiSelectFilter> multiSelectFilters,
      @JsonKey(name: 'search_query') String? searchQuery,
      @JsonKey(name: 'sort_by') String? sortBy,
      @JsonKey(name: 'sort_order') String sortOrder,
      @JsonKey(name: 'page') int page,
      @JsonKey(name: 'per_page') int perPage});

  $DateFilterCopyWith<$Res>? get dateFilter;
}

/// @nodoc
class _$FilterStateCopyWithImpl<$Res, $Val extends FilterState>
    implements $FilterStateCopyWith<$Res> {
  _$FilterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateFilter = freezed,
    Object? multiSelectFilters = null,
    Object? searchQuery = freezed,
    Object? sortBy = freezed,
    Object? sortOrder = null,
    Object? page = null,
    Object? perPage = null,
  }) {
    return _then(_value.copyWith(
      dateFilter: freezed == dateFilter
          ? _value.dateFilter
          : dateFilter // ignore: cast_nullable_to_non_nullable
              as DateFilter?,
      multiSelectFilters: null == multiSelectFilters
          ? _value.multiSelectFilters
          : multiSelectFilters // ignore: cast_nullable_to_non_nullable
              as List<MultiSelectFilter>,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      sortBy: freezed == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DateFilterCopyWith<$Res>? get dateFilter {
    if (_value.dateFilter == null) {
      return null;
    }

    return $DateFilterCopyWith<$Res>(_value.dateFilter!, (value) {
      return _then(_value.copyWith(dateFilter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FilterStateImplCopyWith<$Res>
    implements $FilterStateCopyWith<$Res> {
  factory _$$FilterStateImplCopyWith(
          _$FilterStateImpl value, $Res Function(_$FilterStateImpl) then) =
      __$$FilterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'date_filter') DateFilter? dateFilter,
      @JsonKey(name: 'multi_select_filters')
      List<MultiSelectFilter> multiSelectFilters,
      @JsonKey(name: 'search_query') String? searchQuery,
      @JsonKey(name: 'sort_by') String? sortBy,
      @JsonKey(name: 'sort_order') String sortOrder,
      @JsonKey(name: 'page') int page,
      @JsonKey(name: 'per_page') int perPage});

  @override
  $DateFilterCopyWith<$Res>? get dateFilter;
}

/// @nodoc
class __$$FilterStateImplCopyWithImpl<$Res>
    extends _$FilterStateCopyWithImpl<$Res, _$FilterStateImpl>
    implements _$$FilterStateImplCopyWith<$Res> {
  __$$FilterStateImplCopyWithImpl(
      _$FilterStateImpl _value, $Res Function(_$FilterStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateFilter = freezed,
    Object? multiSelectFilters = null,
    Object? searchQuery = freezed,
    Object? sortBy = freezed,
    Object? sortOrder = null,
    Object? page = null,
    Object? perPage = null,
  }) {
    return _then(_$FilterStateImpl(
      dateFilter: freezed == dateFilter
          ? _value.dateFilter
          : dateFilter // ignore: cast_nullable_to_non_nullable
              as DateFilter?,
      multiSelectFilters: null == multiSelectFilters
          ? _value._multiSelectFilters
          : multiSelectFilters // ignore: cast_nullable_to_non_nullable
              as List<MultiSelectFilter>,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      sortBy: freezed == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FilterStateImpl implements _FilterState {
  const _$FilterStateImpl(
      {@JsonKey(name: 'date_filter') this.dateFilter,
      @JsonKey(name: 'multi_select_filters')
      final List<MultiSelectFilter> multiSelectFilters = const [],
      @JsonKey(name: 'search_query') this.searchQuery,
      @JsonKey(name: 'sort_by') this.sortBy,
      @JsonKey(name: 'sort_order') this.sortOrder = 'asc',
      @JsonKey(name: 'page') this.page = 1,
      @JsonKey(name: 'per_page') this.perPage = 20})
      : _multiSelectFilters = multiSelectFilters;

  factory _$FilterStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilterStateImplFromJson(json);

  @override
  @JsonKey(name: 'date_filter')
  final DateFilter? dateFilter;
  final List<MultiSelectFilter> _multiSelectFilters;
  @override
  @JsonKey(name: 'multi_select_filters')
  List<MultiSelectFilter> get multiSelectFilters {
    if (_multiSelectFilters is EqualUnmodifiableListView)
      return _multiSelectFilters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_multiSelectFilters);
  }

  @override
  @JsonKey(name: 'search_query')
  final String? searchQuery;
  @override
  @JsonKey(name: 'sort_by')
  final String? sortBy;
  @override
  @JsonKey(name: 'sort_order')
  final String sortOrder;
  @override
  @JsonKey(name: 'page')
  final int page;
  @override
  @JsonKey(name: 'per_page')
  final int perPage;

  @override
  String toString() {
    return 'FilterState(dateFilter: $dateFilter, multiSelectFilters: $multiSelectFilters, searchQuery: $searchQuery, sortBy: $sortBy, sortOrder: $sortOrder, page: $page, perPage: $perPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterStateImpl &&
            (identical(other.dateFilter, dateFilter) ||
                other.dateFilter == dateFilter) &&
            const DeepCollectionEquality()
                .equals(other._multiSelectFilters, _multiSelectFilters) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      dateFilter,
      const DeepCollectionEquality().hash(_multiSelectFilters),
      searchQuery,
      sortBy,
      sortOrder,
      page,
      perPage);

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterStateImplCopyWith<_$FilterStateImpl> get copyWith =>
      __$$FilterStateImplCopyWithImpl<_$FilterStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilterStateImplToJson(
      this,
    );
  }
}

abstract class _FilterState implements FilterState {
  const factory _FilterState(
      {@JsonKey(name: 'date_filter') final DateFilter? dateFilter,
      @JsonKey(name: 'multi_select_filters')
      final List<MultiSelectFilter> multiSelectFilters,
      @JsonKey(name: 'search_query') final String? searchQuery,
      @JsonKey(name: 'sort_by') final String? sortBy,
      @JsonKey(name: 'sort_order') final String sortOrder,
      @JsonKey(name: 'page') final int page,
      @JsonKey(name: 'per_page') final int perPage}) = _$FilterStateImpl;

  factory _FilterState.fromJson(Map<String, dynamic> json) =
      _$FilterStateImpl.fromJson;

  @override
  @JsonKey(name: 'date_filter')
  DateFilter? get dateFilter;
  @override
  @JsonKey(name: 'multi_select_filters')
  List<MultiSelectFilter> get multiSelectFilters;
  @override
  @JsonKey(name: 'search_query')
  String? get searchQuery;
  @override
  @JsonKey(name: 'sort_by')
  String? get sortBy;
  @override
  @JsonKey(name: 'sort_order')
  String get sortOrder;
  @override
  @JsonKey(name: 'page')
  int get page;
  @override
  @JsonKey(name: 'per_page')
  int get perPage;

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterStateImplCopyWith<_$FilterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
