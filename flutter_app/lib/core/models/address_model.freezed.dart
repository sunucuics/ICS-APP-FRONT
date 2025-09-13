// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Address _$AddressFromJson(Map<String, dynamic> json) {
  return _Address.fromJson(json);
}

/// @nodoc
mixin _$Address {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get district => throw _privateConstructorUsedError;
  String? get neighborhood => throw _privateConstructorUsedError;
  String? get street => throw _privateConstructorUsedError;
  String? get buildingNo => throw _privateConstructorUsedError;
  String? get apartment => throw _privateConstructorUsedError;
  String? get floor => throw _privateConstructorUsedError;
  String? get zipCode => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_current')
  bool? get isCurrent => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? label,
      String? city,
      String? district,
      String? neighborhood,
      String? street,
      String? buildingNo,
      String? apartment,
      String? floor,
      String? zipCode,
      String? note,
      @JsonKey(name: 'is_current') bool? isCurrent,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? label = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? neighborhood = freezed,
    Object? street = freezed,
    Object? buildingNo = freezed,
    Object? apartment = freezed,
    Object? floor = freezed,
    Object? zipCode = freezed,
    Object? note = freezed,
    Object? isCurrent = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      neighborhood: freezed == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      buildingNo: freezed == buildingNo
          ? _value.buildingNo
          : buildingNo // ignore: cast_nullable_to_non_nullable
              as String?,
      apartment: freezed == apartment
          ? _value.apartment
          : apartment // ignore: cast_nullable_to_non_nullable
              as String?,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String?,
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      isCurrent: freezed == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool?,
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
abstract class _$$AddressImplCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$AddressImplCopyWith(
          _$AddressImpl value, $Res Function(_$AddressImpl) then) =
      __$$AddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? label,
      String? city,
      String? district,
      String? neighborhood,
      String? street,
      String? buildingNo,
      String? apartment,
      String? floor,
      String? zipCode,
      String? note,
      @JsonKey(name: 'is_current') bool? isCurrent,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$AddressImplCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$AddressImpl>
    implements _$$AddressImplCopyWith<$Res> {
  __$$AddressImplCopyWithImpl(
      _$AddressImpl _value, $Res Function(_$AddressImpl) _then)
      : super(_value, _then);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? label = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? neighborhood = freezed,
    Object? street = freezed,
    Object? buildingNo = freezed,
    Object? apartment = freezed,
    Object? floor = freezed,
    Object? zipCode = freezed,
    Object? note = freezed,
    Object? isCurrent = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$AddressImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      neighborhood: freezed == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      buildingNo: freezed == buildingNo
          ? _value.buildingNo
          : buildingNo // ignore: cast_nullable_to_non_nullable
              as String?,
      apartment: freezed == apartment
          ? _value.apartment
          : apartment // ignore: cast_nullable_to_non_nullable
              as String?,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String?,
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      isCurrent: freezed == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool?,
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
class _$AddressImpl implements _Address {
  const _$AddressImpl(
      {this.id,
      this.name,
      this.label,
      this.city,
      this.district,
      this.neighborhood,
      this.street,
      this.buildingNo,
      this.apartment,
      this.floor,
      this.zipCode,
      this.note,
      @JsonKey(name: 'is_current') this.isCurrent,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$AddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? label;
  @override
  final String? city;
  @override
  final String? district;
  @override
  final String? neighborhood;
  @override
  final String? street;
  @override
  final String? buildingNo;
  @override
  final String? apartment;
  @override
  final String? floor;
  @override
  final String? zipCode;
  @override
  final String? note;
  @override
  @JsonKey(name: 'is_current')
  final bool? isCurrent;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Address(id: $id, name: $name, label: $label, city: $city, district: $district, neighborhood: $neighborhood, street: $street, buildingNo: $buildingNo, apartment: $apartment, floor: $floor, zipCode: $zipCode, note: $note, isCurrent: $isCurrent, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.neighborhood, neighborhood) ||
                other.neighborhood == neighborhood) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.buildingNo, buildingNo) ||
                other.buildingNo == buildingNo) &&
            (identical(other.apartment, apartment) ||
                other.apartment == apartment) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
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
      name,
      label,
      city,
      district,
      neighborhood,
      street,
      buildingNo,
      apartment,
      floor,
      zipCode,
      note,
      isCurrent,
      createdAt,
      updatedAt);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      __$$AddressImplCopyWithImpl<_$AddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressImplToJson(
      this,
    );
  }
}

abstract class _Address implements Address {
  const factory _Address(
      {final String? id,
      final String? name,
      final String? label,
      final String? city,
      final String? district,
      final String? neighborhood,
      final String? street,
      final String? buildingNo,
      final String? apartment,
      final String? floor,
      final String? zipCode,
      final String? note,
      @JsonKey(name: 'is_current') final bool? isCurrent,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt}) = _$AddressImpl;

  factory _Address.fromJson(Map<String, dynamic> json) = _$AddressImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get label;
  @override
  String? get city;
  @override
  String? get district;
  @override
  String? get neighborhood;
  @override
  String? get street;
  @override
  String? get buildingNo;
  @override
  String? get apartment;
  @override
  String? get floor;
  @override
  String? get zipCode;
  @override
  String? get note;
  @override
  @JsonKey(name: 'is_current')
  bool? get isCurrent;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddressCreateRequest _$AddressCreateRequestFromJson(Map<String, dynamic> json) {
  return _AddressCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$AddressCreateRequest {
  String get name => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get district => throw _privateConstructorUsedError;
  String? get neighborhood => throw _privateConstructorUsedError;
  String? get street => throw _privateConstructorUsedError;
  String? get buildingNo => throw _privateConstructorUsedError;
  String? get apartment => throw _privateConstructorUsedError;
  String? get floor => throw _privateConstructorUsedError;
  String get zipCode => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this AddressCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddressCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressCreateRequestCopyWith<AddressCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCreateRequestCopyWith<$Res> {
  factory $AddressCreateRequestCopyWith(AddressCreateRequest value,
          $Res Function(AddressCreateRequest) then) =
      _$AddressCreateRequestCopyWithImpl<$Res, AddressCreateRequest>;
  @useResult
  $Res call(
      {String name,
      String label,
      String city,
      String district,
      String? neighborhood,
      String? street,
      String? buildingNo,
      String? apartment,
      String? floor,
      String zipCode,
      String? note});
}

/// @nodoc
class _$AddressCreateRequestCopyWithImpl<$Res,
        $Val extends AddressCreateRequest>
    implements $AddressCreateRequestCopyWith<$Res> {
  _$AddressCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? label = null,
    Object? city = null,
    Object? district = null,
    Object? neighborhood = freezed,
    Object? street = freezed,
    Object? buildingNo = freezed,
    Object? apartment = freezed,
    Object? floor = freezed,
    Object? zipCode = null,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      district: null == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String,
      neighborhood: freezed == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      buildingNo: freezed == buildingNo
          ? _value.buildingNo
          : buildingNo // ignore: cast_nullable_to_non_nullable
              as String?,
      apartment: freezed == apartment
          ? _value.apartment
          : apartment // ignore: cast_nullable_to_non_nullable
              as String?,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String?,
      zipCode: null == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressCreateRequestImplCopyWith<$Res>
    implements $AddressCreateRequestCopyWith<$Res> {
  factory _$$AddressCreateRequestImplCopyWith(_$AddressCreateRequestImpl value,
          $Res Function(_$AddressCreateRequestImpl) then) =
      __$$AddressCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String label,
      String city,
      String district,
      String? neighborhood,
      String? street,
      String? buildingNo,
      String? apartment,
      String? floor,
      String zipCode,
      String? note});
}

/// @nodoc
class __$$AddressCreateRequestImplCopyWithImpl<$Res>
    extends _$AddressCreateRequestCopyWithImpl<$Res, _$AddressCreateRequestImpl>
    implements _$$AddressCreateRequestImplCopyWith<$Res> {
  __$$AddressCreateRequestImplCopyWithImpl(_$AddressCreateRequestImpl _value,
      $Res Function(_$AddressCreateRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddressCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? label = null,
    Object? city = null,
    Object? district = null,
    Object? neighborhood = freezed,
    Object? street = freezed,
    Object? buildingNo = freezed,
    Object? apartment = freezed,
    Object? floor = freezed,
    Object? zipCode = null,
    Object? note = freezed,
  }) {
    return _then(_$AddressCreateRequestImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      district: null == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String,
      neighborhood: freezed == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      buildingNo: freezed == buildingNo
          ? _value.buildingNo
          : buildingNo // ignore: cast_nullable_to_non_nullable
              as String?,
      apartment: freezed == apartment
          ? _value.apartment
          : apartment // ignore: cast_nullable_to_non_nullable
              as String?,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String?,
      zipCode: null == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressCreateRequestImpl implements _AddressCreateRequest {
  const _$AddressCreateRequestImpl(
      {required this.name,
      required this.label,
      required this.city,
      required this.district,
      this.neighborhood,
      this.street,
      this.buildingNo,
      this.apartment,
      this.floor,
      required this.zipCode,
      this.note});

  factory _$AddressCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressCreateRequestImplFromJson(json);

  @override
  final String name;
  @override
  final String label;
  @override
  final String city;
  @override
  final String district;
  @override
  final String? neighborhood;
  @override
  final String? street;
  @override
  final String? buildingNo;
  @override
  final String? apartment;
  @override
  final String? floor;
  @override
  final String zipCode;
  @override
  final String? note;

  @override
  String toString() {
    return 'AddressCreateRequest(name: $name, label: $label, city: $city, district: $district, neighborhood: $neighborhood, street: $street, buildingNo: $buildingNo, apartment: $apartment, floor: $floor, zipCode: $zipCode, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressCreateRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.neighborhood, neighborhood) ||
                other.neighborhood == neighborhood) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.buildingNo, buildingNo) ||
                other.buildingNo == buildingNo) &&
            (identical(other.apartment, apartment) ||
                other.apartment == apartment) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, label, city, district,
      neighborhood, street, buildingNo, apartment, floor, zipCode, note);

  /// Create a copy of AddressCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressCreateRequestImplCopyWith<_$AddressCreateRequestImpl>
      get copyWith =>
          __$$AddressCreateRequestImplCopyWithImpl<_$AddressCreateRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressCreateRequestImplToJson(
      this,
    );
  }
}

abstract class _AddressCreateRequest implements AddressCreateRequest {
  const factory _AddressCreateRequest(
      {required final String name,
      required final String label,
      required final String city,
      required final String district,
      final String? neighborhood,
      final String? street,
      final String? buildingNo,
      final String? apartment,
      final String? floor,
      required final String zipCode,
      final String? note}) = _$AddressCreateRequestImpl;

  factory _AddressCreateRequest.fromJson(Map<String, dynamic> json) =
      _$AddressCreateRequestImpl.fromJson;

  @override
  String get name;
  @override
  String get label;
  @override
  String get city;
  @override
  String get district;
  @override
  String? get neighborhood;
  @override
  String? get street;
  @override
  String? get buildingNo;
  @override
  String? get apartment;
  @override
  String? get floor;
  @override
  String get zipCode;
  @override
  String? get note;

  /// Create a copy of AddressCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressCreateRequestImplCopyWith<_$AddressCreateRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AddressUpdateRequest _$AddressUpdateRequestFromJson(Map<String, dynamic> json) {
  return _AddressUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$AddressUpdateRequest {
  String? get name => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get district => throw _privateConstructorUsedError;
  String? get neighborhood => throw _privateConstructorUsedError;
  String? get street => throw _privateConstructorUsedError;
  String? get buildingNo => throw _privateConstructorUsedError;
  String? get apartment => throw _privateConstructorUsedError;
  String? get floor => throw _privateConstructorUsedError;
  String? get zipCode => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this AddressUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddressUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressUpdateRequestCopyWith<AddressUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressUpdateRequestCopyWith<$Res> {
  factory $AddressUpdateRequestCopyWith(AddressUpdateRequest value,
          $Res Function(AddressUpdateRequest) then) =
      _$AddressUpdateRequestCopyWithImpl<$Res, AddressUpdateRequest>;
  @useResult
  $Res call(
      {String? name,
      String? label,
      String? city,
      String? district,
      String? neighborhood,
      String? street,
      String? buildingNo,
      String? apartment,
      String? floor,
      String? zipCode,
      String? note});
}

/// @nodoc
class _$AddressUpdateRequestCopyWithImpl<$Res,
        $Val extends AddressUpdateRequest>
    implements $AddressUpdateRequestCopyWith<$Res> {
  _$AddressUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? label = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? neighborhood = freezed,
    Object? street = freezed,
    Object? buildingNo = freezed,
    Object? apartment = freezed,
    Object? floor = freezed,
    Object? zipCode = freezed,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      neighborhood: freezed == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      buildingNo: freezed == buildingNo
          ? _value.buildingNo
          : buildingNo // ignore: cast_nullable_to_non_nullable
              as String?,
      apartment: freezed == apartment
          ? _value.apartment
          : apartment // ignore: cast_nullable_to_non_nullable
              as String?,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String?,
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressUpdateRequestImplCopyWith<$Res>
    implements $AddressUpdateRequestCopyWith<$Res> {
  factory _$$AddressUpdateRequestImplCopyWith(_$AddressUpdateRequestImpl value,
          $Res Function(_$AddressUpdateRequestImpl) then) =
      __$$AddressUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? label,
      String? city,
      String? district,
      String? neighborhood,
      String? street,
      String? buildingNo,
      String? apartment,
      String? floor,
      String? zipCode,
      String? note});
}

/// @nodoc
class __$$AddressUpdateRequestImplCopyWithImpl<$Res>
    extends _$AddressUpdateRequestCopyWithImpl<$Res, _$AddressUpdateRequestImpl>
    implements _$$AddressUpdateRequestImplCopyWith<$Res> {
  __$$AddressUpdateRequestImplCopyWithImpl(_$AddressUpdateRequestImpl _value,
      $Res Function(_$AddressUpdateRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddressUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? label = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? neighborhood = freezed,
    Object? street = freezed,
    Object? buildingNo = freezed,
    Object? apartment = freezed,
    Object? floor = freezed,
    Object? zipCode = freezed,
    Object? note = freezed,
  }) {
    return _then(_$AddressUpdateRequestImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      neighborhood: freezed == neighborhood
          ? _value.neighborhood
          : neighborhood // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      buildingNo: freezed == buildingNo
          ? _value.buildingNo
          : buildingNo // ignore: cast_nullable_to_non_nullable
              as String?,
      apartment: freezed == apartment
          ? _value.apartment
          : apartment // ignore: cast_nullable_to_non_nullable
              as String?,
      floor: freezed == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String?,
      zipCode: freezed == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressUpdateRequestImpl implements _AddressUpdateRequest {
  const _$AddressUpdateRequestImpl(
      {this.name,
      this.label,
      this.city,
      this.district,
      this.neighborhood,
      this.street,
      this.buildingNo,
      this.apartment,
      this.floor,
      this.zipCode,
      this.note});

  factory _$AddressUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressUpdateRequestImplFromJson(json);

  @override
  final String? name;
  @override
  final String? label;
  @override
  final String? city;
  @override
  final String? district;
  @override
  final String? neighborhood;
  @override
  final String? street;
  @override
  final String? buildingNo;
  @override
  final String? apartment;
  @override
  final String? floor;
  @override
  final String? zipCode;
  @override
  final String? note;

  @override
  String toString() {
    return 'AddressUpdateRequest(name: $name, label: $label, city: $city, district: $district, neighborhood: $neighborhood, street: $street, buildingNo: $buildingNo, apartment: $apartment, floor: $floor, zipCode: $zipCode, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressUpdateRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.neighborhood, neighborhood) ||
                other.neighborhood == neighborhood) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.buildingNo, buildingNo) ||
                other.buildingNo == buildingNo) &&
            (identical(other.apartment, apartment) ||
                other.apartment == apartment) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, label, city, district,
      neighborhood, street, buildingNo, apartment, floor, zipCode, note);

  /// Create a copy of AddressUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressUpdateRequestImplCopyWith<_$AddressUpdateRequestImpl>
      get copyWith =>
          __$$AddressUpdateRequestImplCopyWithImpl<_$AddressUpdateRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressUpdateRequestImplToJson(
      this,
    );
  }
}

abstract class _AddressUpdateRequest implements AddressUpdateRequest {
  const factory _AddressUpdateRequest(
      {final String? name,
      final String? label,
      final String? city,
      final String? district,
      final String? neighborhood,
      final String? street,
      final String? buildingNo,
      final String? apartment,
      final String? floor,
      final String? zipCode,
      final String? note}) = _$AddressUpdateRequestImpl;

  factory _AddressUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$AddressUpdateRequestImpl.fromJson;

  @override
  String? get name;
  @override
  String? get label;
  @override
  String? get city;
  @override
  String? get district;
  @override
  String? get neighborhood;
  @override
  String? get street;
  @override
  String? get buildingNo;
  @override
  String? get apartment;
  @override
  String? get floor;
  @override
  String? get zipCode;
  @override
  String? get note;

  /// Create a copy of AddressUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressUpdateRequestImplCopyWith<_$AddressUpdateRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AddressListResponse _$AddressListResponseFromJson(Map<String, dynamic> json) {
  return _AddressListResponse.fromJson(json);
}

/// @nodoc
mixin _$AddressListResponse {
  List<Address> get addresses => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_address')
  Address? get currentAddress => throw _privateConstructorUsedError;

  /// Serializes this AddressListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddressListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressListResponseCopyWith<AddressListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressListResponseCopyWith<$Res> {
  factory $AddressListResponseCopyWith(
          AddressListResponse value, $Res Function(AddressListResponse) then) =
      _$AddressListResponseCopyWithImpl<$Res, AddressListResponse>;
  @useResult
  $Res call(
      {List<Address> addresses,
      @JsonKey(name: 'current_address') Address? currentAddress});

  $AddressCopyWith<$Res>? get currentAddress;
}

/// @nodoc
class _$AddressListResponseCopyWithImpl<$Res, $Val extends AddressListResponse>
    implements $AddressListResponseCopyWith<$Res> {
  _$AddressListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addresses = null,
    Object? currentAddress = freezed,
  }) {
    return _then(_value.copyWith(
      addresses: null == addresses
          ? _value.addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<Address>,
      currentAddress: freezed == currentAddress
          ? _value.currentAddress
          : currentAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
    ) as $Val);
  }

  /// Create a copy of AddressListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get currentAddress {
    if (_value.currentAddress == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.currentAddress!, (value) {
      return _then(_value.copyWith(currentAddress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddressListResponseImplCopyWith<$Res>
    implements $AddressListResponseCopyWith<$Res> {
  factory _$$AddressListResponseImplCopyWith(_$AddressListResponseImpl value,
          $Res Function(_$AddressListResponseImpl) then) =
      __$$AddressListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Address> addresses,
      @JsonKey(name: 'current_address') Address? currentAddress});

  @override
  $AddressCopyWith<$Res>? get currentAddress;
}

/// @nodoc
class __$$AddressListResponseImplCopyWithImpl<$Res>
    extends _$AddressListResponseCopyWithImpl<$Res, _$AddressListResponseImpl>
    implements _$$AddressListResponseImplCopyWith<$Res> {
  __$$AddressListResponseImplCopyWithImpl(_$AddressListResponseImpl _value,
      $Res Function(_$AddressListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddressListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addresses = null,
    Object? currentAddress = freezed,
  }) {
    return _then(_$AddressListResponseImpl(
      addresses: null == addresses
          ? _value._addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<Address>,
      currentAddress: freezed == currentAddress
          ? _value.currentAddress
          : currentAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressListResponseImpl implements _AddressListResponse {
  const _$AddressListResponseImpl(
      {required final List<Address> addresses,
      @JsonKey(name: 'current_address') this.currentAddress})
      : _addresses = addresses;

  factory _$AddressListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressListResponseImplFromJson(json);

  final List<Address> _addresses;
  @override
  List<Address> get addresses {
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addresses);
  }

  @override
  @JsonKey(name: 'current_address')
  final Address? currentAddress;

  @override
  String toString() {
    return 'AddressListResponse(addresses: $addresses, currentAddress: $currentAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressListResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._addresses, _addresses) &&
            (identical(other.currentAddress, currentAddress) ||
                other.currentAddress == currentAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_addresses), currentAddress);

  /// Create a copy of AddressListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressListResponseImplCopyWith<_$AddressListResponseImpl> get copyWith =>
      __$$AddressListResponseImplCopyWithImpl<_$AddressListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressListResponseImplToJson(
      this,
    );
  }
}

abstract class _AddressListResponse implements AddressListResponse {
  const factory _AddressListResponse(
          {required final List<Address> addresses,
          @JsonKey(name: 'current_address') final Address? currentAddress}) =
      _$AddressListResponseImpl;

  factory _AddressListResponse.fromJson(Map<String, dynamic> json) =
      _$AddressListResponseImpl.fromJson;

  @override
  List<Address> get addresses;
  @override
  @JsonKey(name: 'current_address')
  Address? get currentAddress;

  /// Create a copy of AddressListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressListResponseImplCopyWith<_$AddressListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
