// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_discount_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminDiscount _$AdminDiscountFromJson(Map<String, dynamic> json) {
  return _AdminDiscount.fromJson(json);
}

/// @nodoc
mixin _$AdminDiscount {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_type')
  String get targetType =>
      throw _privateConstructorUsedError; // 'product' or 'category'
  @JsonKey(name: 'target_id')
  String? get targetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'percent')
  double get percent =>
      throw _privateConstructorUsedError; // Changed from percentage to match backend
  bool get active => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_at')
  DateTime? get startAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_at')
  DateTime? get endAt => throw _privateConstructorUsedError;
  String? get targetName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AdminDiscount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminDiscount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminDiscountCopyWith<AdminDiscount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminDiscountCopyWith<$Res> {
  factory $AdminDiscountCopyWith(
          AdminDiscount value, $Res Function(AdminDiscount) then) =
      _$AdminDiscountCopyWithImpl<$Res, AdminDiscount>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'target_type') String targetType,
      @JsonKey(name: 'target_id') String? targetId,
      @JsonKey(name: 'percent') double percent,
      bool active,
      @JsonKey(name: 'start_at') DateTime? startAt,
      @JsonKey(name: 'end_at') DateTime? endAt,
      String? targetName,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$AdminDiscountCopyWithImpl<$Res, $Val extends AdminDiscount>
    implements $AdminDiscountCopyWith<$Res> {
  _$AdminDiscountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminDiscount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? targetType = null,
    Object? targetId = freezed,
    Object? percent = null,
    Object? active = null,
    Object? startAt = freezed,
    Object? endAt = freezed,
    Object? targetName = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      targetType: null == targetType
          ? _value.targetType
          : targetType // ignore: cast_nullable_to_non_nullable
              as String,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String?,
      percent: null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      startAt: freezed == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endAt: freezed == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetName: freezed == targetName
          ? _value.targetName
          : targetName // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminDiscountImplCopyWith<$Res>
    implements $AdminDiscountCopyWith<$Res> {
  factory _$$AdminDiscountImplCopyWith(
          _$AdminDiscountImpl value, $Res Function(_$AdminDiscountImpl) then) =
      __$$AdminDiscountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'target_type') String targetType,
      @JsonKey(name: 'target_id') String? targetId,
      @JsonKey(name: 'percent') double percent,
      bool active,
      @JsonKey(name: 'start_at') DateTime? startAt,
      @JsonKey(name: 'end_at') DateTime? endAt,
      String? targetName,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$AdminDiscountImplCopyWithImpl<$Res>
    extends _$AdminDiscountCopyWithImpl<$Res, _$AdminDiscountImpl>
    implements _$$AdminDiscountImplCopyWith<$Res> {
  __$$AdminDiscountImplCopyWithImpl(
      _$AdminDiscountImpl _value, $Res Function(_$AdminDiscountImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminDiscount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? targetType = null,
    Object? targetId = freezed,
    Object? percent = null,
    Object? active = null,
    Object? startAt = freezed,
    Object? endAt = freezed,
    Object? targetName = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$AdminDiscountImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      targetType: null == targetType
          ? _value.targetType
          : targetType // ignore: cast_nullable_to_non_nullable
              as String,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String?,
      percent: null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      startAt: freezed == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endAt: freezed == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetName: freezed == targetName
          ? _value.targetName
          : targetName // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminDiscountImpl implements _AdminDiscount {
  const _$AdminDiscountImpl(
      {required this.id,
      @JsonKey(name: 'target_type') required this.targetType,
      @JsonKey(name: 'target_id') this.targetId,
      @JsonKey(name: 'percent') required this.percent,
      this.active = true,
      @JsonKey(name: 'start_at') this.startAt,
      @JsonKey(name: 'end_at') this.endAt,
      this.targetName,
      this.description,
      this.createdAt,
      this.updatedAt});

  factory _$AdminDiscountImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminDiscountImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'target_type')
  final String targetType;
// 'product' or 'category'
  @override
  @JsonKey(name: 'target_id')
  final String? targetId;
  @override
  @JsonKey(name: 'percent')
  final double percent;
// Changed from percentage to match backend
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey(name: 'start_at')
  final DateTime? startAt;
  @override
  @JsonKey(name: 'end_at')
  final DateTime? endAt;
  @override
  final String? targetName;
  @override
  final String? description;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'AdminDiscount(id: $id, targetType: $targetType, targetId: $targetId, percent: $percent, active: $active, startAt: $startAt, endAt: $endAt, targetName: $targetName, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminDiscountImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.targetType, targetType) ||
                other.targetType == targetType) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.percent, percent) || other.percent == percent) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt) &&
            (identical(other.targetName, targetName) ||
                other.targetName == targetName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      targetType,
      targetId,
      percent,
      active,
      startAt,
      endAt,
      targetName,
      description,
      createdAt,
      updatedAt);

  /// Create a copy of AdminDiscount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminDiscountImplCopyWith<_$AdminDiscountImpl> get copyWith =>
      __$$AdminDiscountImplCopyWithImpl<_$AdminDiscountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminDiscountImplToJson(
      this,
    );
  }
}

abstract class _AdminDiscount implements AdminDiscount {
  const factory _AdminDiscount(
      {required final String id,
      @JsonKey(name: 'target_type') required final String targetType,
      @JsonKey(name: 'target_id') final String? targetId,
      @JsonKey(name: 'percent') required final double percent,
      final bool active,
      @JsonKey(name: 'start_at') final DateTime? startAt,
      @JsonKey(name: 'end_at') final DateTime? endAt,
      final String? targetName,
      final String? description,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$AdminDiscountImpl;

  factory _AdminDiscount.fromJson(Map<String, dynamic> json) =
      _$AdminDiscountImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'target_type')
  String get targetType; // 'product' or 'category'
  @override
  @JsonKey(name: 'target_id')
  String? get targetId;
  @override
  @JsonKey(name: 'percent')
  double get percent; // Changed from percentage to match backend
  @override
  bool get active;
  @override
  @JsonKey(name: 'start_at')
  DateTime? get startAt;
  @override
  @JsonKey(name: 'end_at')
  DateTime? get endAt;
  @override
  String? get targetName;
  @override
  String? get description;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of AdminDiscount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminDiscountImplCopyWith<_$AdminDiscountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscountCreateRequest _$DiscountCreateRequestFromJson(
    Map<String, dynamic> json) {
  return _DiscountCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$DiscountCreateRequest {
  String get name => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;
  String get targetType => throw _privateConstructorUsedError;
  String? get targetId => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this DiscountCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscountCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscountCreateRequestCopyWith<DiscountCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscountCreateRequestCopyWith<$Res> {
  factory $DiscountCreateRequestCopyWith(DiscountCreateRequest value,
          $Res Function(DiscountCreateRequest) then) =
      _$DiscountCreateRequestCopyWithImpl<$Res, DiscountCreateRequest>;
  @useResult
  $Res call(
      {String name,
      double percentage,
      String targetType,
      String? targetId,
      DateTime startDate,
      DateTime endDate,
      bool isActive,
      String? description});
}

/// @nodoc
class _$DiscountCreateRequestCopyWithImpl<$Res,
        $Val extends DiscountCreateRequest>
    implements $DiscountCreateRequestCopyWith<$Res> {
  _$DiscountCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscountCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? percentage = null,
    Object? targetType = null,
    Object? targetId = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? isActive = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      targetType: null == targetType
          ? _value.targetType
          : targetType // ignore: cast_nullable_to_non_nullable
              as String,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiscountCreateRequestImplCopyWith<$Res>
    implements $DiscountCreateRequestCopyWith<$Res> {
  factory _$$DiscountCreateRequestImplCopyWith(
          _$DiscountCreateRequestImpl value,
          $Res Function(_$DiscountCreateRequestImpl) then) =
      __$$DiscountCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      double percentage,
      String targetType,
      String? targetId,
      DateTime startDate,
      DateTime endDate,
      bool isActive,
      String? description});
}

/// @nodoc
class __$$DiscountCreateRequestImplCopyWithImpl<$Res>
    extends _$DiscountCreateRequestCopyWithImpl<$Res,
        _$DiscountCreateRequestImpl>
    implements _$$DiscountCreateRequestImplCopyWith<$Res> {
  __$$DiscountCreateRequestImplCopyWithImpl(_$DiscountCreateRequestImpl _value,
      $Res Function(_$DiscountCreateRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of DiscountCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? percentage = null,
    Object? targetType = null,
    Object? targetId = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? isActive = null,
    Object? description = freezed,
  }) {
    return _then(_$DiscountCreateRequestImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      targetType: null == targetType
          ? _value.targetType
          : targetType // ignore: cast_nullable_to_non_nullable
              as String,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscountCreateRequestImpl implements _DiscountCreateRequest {
  const _$DiscountCreateRequestImpl(
      {required this.name,
      required this.percentage,
      required this.targetType,
      this.targetId,
      required this.startDate,
      required this.endDate,
      this.isActive = true,
      this.description});

  factory _$DiscountCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscountCreateRequestImplFromJson(json);

  @override
  final String name;
  @override
  final double percentage;
  @override
  final String targetType;
  @override
  final String? targetId;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? description;

  @override
  String toString() {
    return 'DiscountCreateRequest(name: $name, percentage: $percentage, targetType: $targetType, targetId: $targetId, startDate: $startDate, endDate: $endDate, isActive: $isActive, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscountCreateRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.targetType, targetType) ||
                other.targetType == targetType) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, percentage, targetType,
      targetId, startDate, endDate, isActive, description);

  /// Create a copy of DiscountCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscountCreateRequestImplCopyWith<_$DiscountCreateRequestImpl>
      get copyWith => __$$DiscountCreateRequestImplCopyWithImpl<
          _$DiscountCreateRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscountCreateRequestImplToJson(
      this,
    );
  }
}

abstract class _DiscountCreateRequest implements DiscountCreateRequest {
  const factory _DiscountCreateRequest(
      {required final String name,
      required final double percentage,
      required final String targetType,
      final String? targetId,
      required final DateTime startDate,
      required final DateTime endDate,
      final bool isActive,
      final String? description}) = _$DiscountCreateRequestImpl;

  factory _DiscountCreateRequest.fromJson(Map<String, dynamic> json) =
      _$DiscountCreateRequestImpl.fromJson;

  @override
  String get name;
  @override
  double get percentage;
  @override
  String get targetType;
  @override
  String? get targetId;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  bool get isActive;
  @override
  String? get description;

  /// Create a copy of DiscountCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscountCreateRequestImplCopyWith<_$DiscountCreateRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DiscountUpdateRequest _$DiscountUpdateRequestFromJson(
    Map<String, dynamic> json) {
  return _DiscountUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$DiscountUpdateRequest {
  String? get name => throw _privateConstructorUsedError;
  double? get percentage =>
      throw _privateConstructorUsedError; // JSON endpoint uses percentage
  String? get targetType => throw _privateConstructorUsedError;
  String? get targetId => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this DiscountUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscountUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscountUpdateRequestCopyWith<DiscountUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscountUpdateRequestCopyWith<$Res> {
  factory $DiscountUpdateRequestCopyWith(DiscountUpdateRequest value,
          $Res Function(DiscountUpdateRequest) then) =
      _$DiscountUpdateRequestCopyWithImpl<$Res, DiscountUpdateRequest>;
  @useResult
  $Res call(
      {String? name,
      double? percentage,
      String? targetType,
      String? targetId,
      DateTime? startDate,
      DateTime? endDate,
      bool? isActive,
      String? description});
}

/// @nodoc
class _$DiscountUpdateRequestCopyWithImpl<$Res,
        $Val extends DiscountUpdateRequest>
    implements $DiscountUpdateRequestCopyWith<$Res> {
  _$DiscountUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscountUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? percentage = freezed,
    Object? targetType = freezed,
    Object? targetId = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isActive = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      percentage: freezed == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double?,
      targetType: freezed == targetType
          ? _value.targetType
          : targetType // ignore: cast_nullable_to_non_nullable
              as String?,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiscountUpdateRequestImplCopyWith<$Res>
    implements $DiscountUpdateRequestCopyWith<$Res> {
  factory _$$DiscountUpdateRequestImplCopyWith(
          _$DiscountUpdateRequestImpl value,
          $Res Function(_$DiscountUpdateRequestImpl) then) =
      __$$DiscountUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      double? percentage,
      String? targetType,
      String? targetId,
      DateTime? startDate,
      DateTime? endDate,
      bool? isActive,
      String? description});
}

/// @nodoc
class __$$DiscountUpdateRequestImplCopyWithImpl<$Res>
    extends _$DiscountUpdateRequestCopyWithImpl<$Res,
        _$DiscountUpdateRequestImpl>
    implements _$$DiscountUpdateRequestImplCopyWith<$Res> {
  __$$DiscountUpdateRequestImplCopyWithImpl(_$DiscountUpdateRequestImpl _value,
      $Res Function(_$DiscountUpdateRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of DiscountUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? percentage = freezed,
    Object? targetType = freezed,
    Object? targetId = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? isActive = freezed,
    Object? description = freezed,
  }) {
    return _then(_$DiscountUpdateRequestImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      percentage: freezed == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double?,
      targetType: freezed == targetType
          ? _value.targetType
          : targetType // ignore: cast_nullable_to_non_nullable
              as String?,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscountUpdateRequestImpl implements _DiscountUpdateRequest {
  const _$DiscountUpdateRequestImpl(
      {this.name,
      this.percentage,
      this.targetType,
      this.targetId,
      this.startDate,
      this.endDate,
      this.isActive,
      this.description});

  factory _$DiscountUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscountUpdateRequestImplFromJson(json);

  @override
  final String? name;
  @override
  final double? percentage;
// JSON endpoint uses percentage
  @override
  final String? targetType;
  @override
  final String? targetId;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final bool? isActive;
  @override
  final String? description;

  @override
  String toString() {
    return 'DiscountUpdateRequest(name: $name, percentage: $percentage, targetType: $targetType, targetId: $targetId, startDate: $startDate, endDate: $endDate, isActive: $isActive, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscountUpdateRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.targetType, targetType) ||
                other.targetType == targetType) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, percentage, targetType,
      targetId, startDate, endDate, isActive, description);

  /// Create a copy of DiscountUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscountUpdateRequestImplCopyWith<_$DiscountUpdateRequestImpl>
      get copyWith => __$$DiscountUpdateRequestImplCopyWithImpl<
          _$DiscountUpdateRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscountUpdateRequestImplToJson(
      this,
    );
  }
}

abstract class _DiscountUpdateRequest implements DiscountUpdateRequest {
  const factory _DiscountUpdateRequest(
      {final String? name,
      final double? percentage,
      final String? targetType,
      final String? targetId,
      final DateTime? startDate,
      final DateTime? endDate,
      final bool? isActive,
      final String? description}) = _$DiscountUpdateRequestImpl;

  factory _DiscountUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$DiscountUpdateRequestImpl.fromJson;

  @override
  String? get name;
  @override
  double? get percentage; // JSON endpoint uses percentage
  @override
  String? get targetType;
  @override
  String? get targetId;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  bool? get isActive;
  @override
  String? get description;

  /// Create a copy of DiscountUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscountUpdateRequestImplCopyWith<_$DiscountUpdateRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DiscountCreateFormRequest _$DiscountCreateFormRequestFromJson(
    Map<String, dynamic> json) {
  return _DiscountCreateFormRequest.fromJson(json);
}

/// @nodoc
mixin _$DiscountCreateFormRequest {
  String get productId =>
      throw _privateConstructorUsedError; // Form field: product_id
  double get percent =>
      throw _privateConstructorUsedError; // Form field: percent (0-100)
  String? get startDate =>
      throw _privateConstructorUsedError; // Form field: start_date (YYYY-MM-DD format)
  String? get endDate =>
      throw _privateConstructorUsedError; // Form field: end_date (YYYY-MM-DD format)
  bool get active => throw _privateConstructorUsedError;

  /// Serializes this DiscountCreateFormRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscountCreateFormRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscountCreateFormRequestCopyWith<DiscountCreateFormRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscountCreateFormRequestCopyWith<$Res> {
  factory $DiscountCreateFormRequestCopyWith(DiscountCreateFormRequest value,
          $Res Function(DiscountCreateFormRequest) then) =
      _$DiscountCreateFormRequestCopyWithImpl<$Res, DiscountCreateFormRequest>;
  @useResult
  $Res call(
      {String productId,
      double percent,
      String? startDate,
      String? endDate,
      bool active});
}

/// @nodoc
class _$DiscountCreateFormRequestCopyWithImpl<$Res,
        $Val extends DiscountCreateFormRequest>
    implements $DiscountCreateFormRequestCopyWith<$Res> {
  _$DiscountCreateFormRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscountCreateFormRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? percent = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? active = null,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      percent: null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiscountCreateFormRequestImplCopyWith<$Res>
    implements $DiscountCreateFormRequestCopyWith<$Res> {
  factory _$$DiscountCreateFormRequestImplCopyWith(
          _$DiscountCreateFormRequestImpl value,
          $Res Function(_$DiscountCreateFormRequestImpl) then) =
      __$$DiscountCreateFormRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String productId,
      double percent,
      String? startDate,
      String? endDate,
      bool active});
}

/// @nodoc
class __$$DiscountCreateFormRequestImplCopyWithImpl<$Res>
    extends _$DiscountCreateFormRequestCopyWithImpl<$Res,
        _$DiscountCreateFormRequestImpl>
    implements _$$DiscountCreateFormRequestImplCopyWith<$Res> {
  __$$DiscountCreateFormRequestImplCopyWithImpl(
      _$DiscountCreateFormRequestImpl _value,
      $Res Function(_$DiscountCreateFormRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of DiscountCreateFormRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? percent = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? active = null,
  }) {
    return _then(_$DiscountCreateFormRequestImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      percent: null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscountCreateFormRequestImpl implements _DiscountCreateFormRequest {
  const _$DiscountCreateFormRequestImpl(
      {required this.productId,
      required this.percent,
      this.startDate,
      this.endDate,
      this.active = true});

  factory _$DiscountCreateFormRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscountCreateFormRequestImplFromJson(json);

  @override
  final String productId;
// Form field: product_id
  @override
  final double percent;
// Form field: percent (0-100)
  @override
  final String? startDate;
// Form field: start_date (YYYY-MM-DD format)
  @override
  final String? endDate;
// Form field: end_date (YYYY-MM-DD format)
  @override
  @JsonKey()
  final bool active;

  @override
  String toString() {
    return 'DiscountCreateFormRequest(productId: $productId, percent: $percent, startDate: $startDate, endDate: $endDate, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscountCreateFormRequestImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.percent, percent) || other.percent == percent) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, productId, percent, startDate, endDate, active);

  /// Create a copy of DiscountCreateFormRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscountCreateFormRequestImplCopyWith<_$DiscountCreateFormRequestImpl>
      get copyWith => __$$DiscountCreateFormRequestImplCopyWithImpl<
          _$DiscountCreateFormRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscountCreateFormRequestImplToJson(
      this,
    );
  }
}

abstract class _DiscountCreateFormRequest implements DiscountCreateFormRequest {
  const factory _DiscountCreateFormRequest(
      {required final String productId,
      required final double percent,
      final String? startDate,
      final String? endDate,
      final bool active}) = _$DiscountCreateFormRequestImpl;

  factory _DiscountCreateFormRequest.fromJson(Map<String, dynamic> json) =
      _$DiscountCreateFormRequestImpl.fromJson;

  @override
  String get productId; // Form field: product_id
  @override
  double get percent; // Form field: percent (0-100)
  @override
  String? get startDate; // Form field: start_date (YYYY-MM-DD format)
  @override
  String? get endDate; // Form field: end_date (YYYY-MM-DD format)
  @override
  bool get active;

  /// Create a copy of DiscountCreateFormRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscountCreateFormRequestImplCopyWith<_$DiscountCreateFormRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DiscountUpdateFormRequest _$DiscountUpdateFormRequestFromJson(
    Map<String, dynamic> json) {
  return _DiscountUpdateFormRequest.fromJson(json);
}

/// @nodoc
mixin _$DiscountUpdateFormRequest {
  double? get percent =>
      throw _privateConstructorUsedError; // Form field: percent (0-100)
  String? get startDate =>
      throw _privateConstructorUsedError; // Form field: start_date (YYYY-MM-DD format, nullable)
  String? get endDate =>
      throw _privateConstructorUsedError; // Form field: end_date (YYYY-MM-DD format, nullable)
  bool? get active => throw _privateConstructorUsedError;

  /// Serializes this DiscountUpdateFormRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscountUpdateFormRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscountUpdateFormRequestCopyWith<DiscountUpdateFormRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscountUpdateFormRequestCopyWith<$Res> {
  factory $DiscountUpdateFormRequestCopyWith(DiscountUpdateFormRequest value,
          $Res Function(DiscountUpdateFormRequest) then) =
      _$DiscountUpdateFormRequestCopyWithImpl<$Res, DiscountUpdateFormRequest>;
  @useResult
  $Res call(
      {double? percent, String? startDate, String? endDate, bool? active});
}

/// @nodoc
class _$DiscountUpdateFormRequestCopyWithImpl<$Res,
        $Val extends DiscountUpdateFormRequest>
    implements $DiscountUpdateFormRequestCopyWith<$Res> {
  _$DiscountUpdateFormRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscountUpdateFormRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? percent = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? active = freezed,
  }) {
    return _then(_value.copyWith(
      percent: freezed == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiscountUpdateFormRequestImplCopyWith<$Res>
    implements $DiscountUpdateFormRequestCopyWith<$Res> {
  factory _$$DiscountUpdateFormRequestImplCopyWith(
          _$DiscountUpdateFormRequestImpl value,
          $Res Function(_$DiscountUpdateFormRequestImpl) then) =
      __$$DiscountUpdateFormRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? percent, String? startDate, String? endDate, bool? active});
}

/// @nodoc
class __$$DiscountUpdateFormRequestImplCopyWithImpl<$Res>
    extends _$DiscountUpdateFormRequestCopyWithImpl<$Res,
        _$DiscountUpdateFormRequestImpl>
    implements _$$DiscountUpdateFormRequestImplCopyWith<$Res> {
  __$$DiscountUpdateFormRequestImplCopyWithImpl(
      _$DiscountUpdateFormRequestImpl _value,
      $Res Function(_$DiscountUpdateFormRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of DiscountUpdateFormRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? percent = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? active = freezed,
  }) {
    return _then(_$DiscountUpdateFormRequestImpl(
      percent: freezed == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscountUpdateFormRequestImpl implements _DiscountUpdateFormRequest {
  const _$DiscountUpdateFormRequestImpl(
      {this.percent, this.startDate, this.endDate, this.active});

  factory _$DiscountUpdateFormRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscountUpdateFormRequestImplFromJson(json);

  @override
  final double? percent;
// Form field: percent (0-100)
  @override
  final String? startDate;
// Form field: start_date (YYYY-MM-DD format, nullable)
  @override
  final String? endDate;
// Form field: end_date (YYYY-MM-DD format, nullable)
  @override
  final bool? active;

  @override
  String toString() {
    return 'DiscountUpdateFormRequest(percent: $percent, startDate: $startDate, endDate: $endDate, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscountUpdateFormRequestImpl &&
            (identical(other.percent, percent) || other.percent == percent) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, percent, startDate, endDate, active);

  /// Create a copy of DiscountUpdateFormRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscountUpdateFormRequestImplCopyWith<_$DiscountUpdateFormRequestImpl>
      get copyWith => __$$DiscountUpdateFormRequestImplCopyWithImpl<
          _$DiscountUpdateFormRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscountUpdateFormRequestImplToJson(
      this,
    );
  }
}

abstract class _DiscountUpdateFormRequest implements DiscountUpdateFormRequest {
  const factory _DiscountUpdateFormRequest(
      {final double? percent,
      final String? startDate,
      final String? endDate,
      final bool? active}) = _$DiscountUpdateFormRequestImpl;

  factory _DiscountUpdateFormRequest.fromJson(Map<String, dynamic> json) =
      _$DiscountUpdateFormRequestImpl.fromJson;

  @override
  double? get percent; // Form field: percent (0-100)
  @override
  String? get startDate; // Form field: start_date (YYYY-MM-DD format, nullable)
  @override
  String? get endDate; // Form field: end_date (YYYY-MM-DD format, nullable)
  @override
  bool? get active;

  /// Create a copy of DiscountUpdateFormRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscountUpdateFormRequestImplCopyWith<_$DiscountUpdateFormRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
