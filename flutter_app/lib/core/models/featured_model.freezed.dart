// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'featured_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FeaturedItem _$FeaturedItemFromJson(Map<String, dynamic> json) {
  return _FeaturedItem.fromJson(json);
}

/// @nodoc
mixin _$FeaturedItem {
  String get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_upcoming')
  bool? get isUpcoming => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this FeaturedItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeaturedItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeaturedItemCopyWith<FeaturedItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeaturedItemCopyWith<$Res> {
  factory $FeaturedItemCopyWith(
          FeaturedItem value, $Res Function(FeaturedItem) then) =
      _$FeaturedItemCopyWithImpl<$Res, FeaturedItem>;
  @useResult
  $Res call(
      {String id,
      String? title,
      String? description,
      String? image,
      @JsonKey(name: 'is_upcoming') bool? isUpcoming,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class _$FeaturedItemCopyWithImpl<$Res, $Val extends FeaturedItem>
    implements $FeaturedItemCopyWith<$Res> {
  _$FeaturedItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeaturedItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? isUpcoming = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      isUpcoming: freezed == isUpcoming
          ? _value.isUpcoming
          : isUpcoming // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeaturedItemImplCopyWith<$Res>
    implements $FeaturedItemCopyWith<$Res> {
  factory _$$FeaturedItemImplCopyWith(
          _$FeaturedItemImpl value, $Res Function(_$FeaturedItemImpl) then) =
      __$$FeaturedItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? title,
      String? description,
      String? image,
      @JsonKey(name: 'is_upcoming') bool? isUpcoming,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class __$$FeaturedItemImplCopyWithImpl<$Res>
    extends _$FeaturedItemCopyWithImpl<$Res, _$FeaturedItemImpl>
    implements _$$FeaturedItemImplCopyWith<$Res> {
  __$$FeaturedItemImplCopyWithImpl(
      _$FeaturedItemImpl _value, $Res Function(_$FeaturedItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeaturedItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? isUpcoming = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$FeaturedItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      isUpcoming: freezed == isUpcoming
          ? _value.isUpcoming
          : isUpcoming // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeaturedItemImpl implements _FeaturedItem {
  const _$FeaturedItemImpl(
      {required this.id,
      this.title,
      this.description,
      this.image,
      @JsonKey(name: 'is_upcoming') this.isUpcoming,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$FeaturedItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeaturedItemImplFromJson(json);

  @override
  final String id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? image;
  @override
  @JsonKey(name: 'is_upcoming')
  final bool? isUpcoming;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'FeaturedItem(id: $id, title: $title, description: $description, image: $image, isUpcoming: $isUpcoming, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeaturedItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.isUpcoming, isUpcoming) ||
                other.isUpcoming == isUpcoming) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, description, image, isUpcoming, createdAt);

  /// Create a copy of FeaturedItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeaturedItemImplCopyWith<_$FeaturedItemImpl> get copyWith =>
      __$$FeaturedItemImplCopyWithImpl<_$FeaturedItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeaturedItemImplToJson(
      this,
    );
  }
}

abstract class _FeaturedItem implements FeaturedItem {
  const factory _FeaturedItem(
          {required final String id,
          final String? title,
          final String? description,
          final String? image,
          @JsonKey(name: 'is_upcoming') final bool? isUpcoming,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$FeaturedItemImpl;

  factory _FeaturedItem.fromJson(Map<String, dynamic> json) =
      _$FeaturedItemImpl.fromJson;

  @override
  String get id;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get image;
  @override
  @JsonKey(name: 'is_upcoming')
  bool? get isUpcoming;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of FeaturedItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeaturedItemImplCopyWith<_$FeaturedItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeaturedProduct _$FeaturedProductFromJson(Map<String, dynamic> json) {
  return _FeaturedProduct.fromJson(json);
}

/// @nodoc
mixin _$FeaturedProduct {
  String get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'final_price')
  double? get finalPrice => throw _privateConstructorUsedError;
  int? get stock => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_upcoming')
  bool? get isUpcoming => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this FeaturedProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeaturedProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeaturedProductCopyWith<FeaturedProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeaturedProductCopyWith<$Res> {
  factory $FeaturedProductCopyWith(
          FeaturedProduct value, $Res Function(FeaturedProduct) then) =
      _$FeaturedProductCopyWithImpl<$Res, FeaturedProduct>;
  @useResult
  $Res call(
      {String id,
      String? title,
      String? description,
      double? price,
      @JsonKey(name: 'final_price') double? finalPrice,
      int? stock,
      @JsonKey(name: 'is_upcoming') bool? isUpcoming,
      @JsonKey(name: 'category_name') String? categoryName,
      List<String> images,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class _$FeaturedProductCopyWithImpl<$Res, $Val extends FeaturedProduct>
    implements $FeaturedProductCopyWith<$Res> {
  _$FeaturedProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeaturedProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? price = freezed,
    Object? finalPrice = freezed,
    Object? stock = freezed,
    Object? isUpcoming = freezed,
    Object? categoryName = freezed,
    Object? images = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      finalPrice: freezed == finalPrice
          ? _value.finalPrice
          : finalPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      stock: freezed == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int?,
      isUpcoming: freezed == isUpcoming
          ? _value.isUpcoming
          : isUpcoming // ignore: cast_nullable_to_non_nullable
              as bool?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeaturedProductImplCopyWith<$Res>
    implements $FeaturedProductCopyWith<$Res> {
  factory _$$FeaturedProductImplCopyWith(_$FeaturedProductImpl value,
          $Res Function(_$FeaturedProductImpl) then) =
      __$$FeaturedProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? title,
      String? description,
      double? price,
      @JsonKey(name: 'final_price') double? finalPrice,
      int? stock,
      @JsonKey(name: 'is_upcoming') bool? isUpcoming,
      @JsonKey(name: 'category_name') String? categoryName,
      List<String> images,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class __$$FeaturedProductImplCopyWithImpl<$Res>
    extends _$FeaturedProductCopyWithImpl<$Res, _$FeaturedProductImpl>
    implements _$$FeaturedProductImplCopyWith<$Res> {
  __$$FeaturedProductImplCopyWithImpl(
      _$FeaturedProductImpl _value, $Res Function(_$FeaturedProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeaturedProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? price = freezed,
    Object? finalPrice = freezed,
    Object? stock = freezed,
    Object? isUpcoming = freezed,
    Object? categoryName = freezed,
    Object? images = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$FeaturedProductImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      finalPrice: freezed == finalPrice
          ? _value.finalPrice
          : finalPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      stock: freezed == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int?,
      isUpcoming: freezed == isUpcoming
          ? _value.isUpcoming
          : isUpcoming // ignore: cast_nullable_to_non_nullable
              as bool?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeaturedProductImpl implements _FeaturedProduct {
  const _$FeaturedProductImpl(
      {required this.id,
      this.title,
      this.description,
      this.price,
      @JsonKey(name: 'final_price') this.finalPrice,
      this.stock,
      @JsonKey(name: 'is_upcoming') this.isUpcoming,
      @JsonKey(name: 'category_name') this.categoryName,
      final List<String> images = const [],
      @JsonKey(name: 'created_at') this.createdAt})
      : _images = images;

  factory _$FeaturedProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeaturedProductImplFromJson(json);

  @override
  final String id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final double? price;
  @override
  @JsonKey(name: 'final_price')
  final double? finalPrice;
  @override
  final int? stock;
  @override
  @JsonKey(name: 'is_upcoming')
  final bool? isUpcoming;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'FeaturedProduct(id: $id, title: $title, description: $description, price: $price, finalPrice: $finalPrice, stock: $stock, isUpcoming: $isUpcoming, categoryName: $categoryName, images: $images, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeaturedProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.finalPrice, finalPrice) ||
                other.finalPrice == finalPrice) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.isUpcoming, isUpcoming) ||
                other.isUpcoming == isUpcoming) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      price,
      finalPrice,
      stock,
      isUpcoming,
      categoryName,
      const DeepCollectionEquality().hash(_images),
      createdAt);

  /// Create a copy of FeaturedProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeaturedProductImplCopyWith<_$FeaturedProductImpl> get copyWith =>
      __$$FeaturedProductImplCopyWithImpl<_$FeaturedProductImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeaturedProductImplToJson(
      this,
    );
  }
}

abstract class _FeaturedProduct implements FeaturedProduct {
  const factory _FeaturedProduct(
          {required final String id,
          final String? title,
          final String? description,
          final double? price,
          @JsonKey(name: 'final_price') final double? finalPrice,
          final int? stock,
          @JsonKey(name: 'is_upcoming') final bool? isUpcoming,
          @JsonKey(name: 'category_name') final String? categoryName,
          final List<String> images,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$FeaturedProductImpl;

  factory _FeaturedProduct.fromJson(Map<String, dynamic> json) =
      _$FeaturedProductImpl.fromJson;

  @override
  String get id;
  @override
  String? get title;
  @override
  String? get description;
  @override
  double? get price;
  @override
  @JsonKey(name: 'final_price')
  double? get finalPrice;
  @override
  int? get stock;
  @override
  @JsonKey(name: 'is_upcoming')
  bool? get isUpcoming;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  List<String> get images;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of FeaturedProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeaturedProductImplCopyWith<_$FeaturedProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeaturedService _$FeaturedServiceFromJson(Map<String, dynamic> json) {
  return _FeaturedService.fromJson(json);
}

/// @nodoc
mixin _$FeaturedService {
  String get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_upcoming')
  bool? get isUpcoming => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_deleted')
  bool? get isDeleted => throw _privateConstructorUsedError;
  String? get kind => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this FeaturedService to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeaturedService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeaturedServiceCopyWith<FeaturedService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeaturedServiceCopyWith<$Res> {
  factory $FeaturedServiceCopyWith(
          FeaturedService value, $Res Function(FeaturedService) then) =
      _$FeaturedServiceCopyWithImpl<$Res, FeaturedService>;
  @useResult
  $Res call(
      {String id,
      String? title,
      String? description,
      String? image,
      @JsonKey(name: 'is_upcoming') bool? isUpcoming,
      @JsonKey(name: 'is_deleted') bool? isDeleted,
      String? kind,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class _$FeaturedServiceCopyWithImpl<$Res, $Val extends FeaturedService>
    implements $FeaturedServiceCopyWith<$Res> {
  _$FeaturedServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeaturedService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? isUpcoming = freezed,
    Object? isDeleted = freezed,
    Object? kind = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      isUpcoming: freezed == isUpcoming
          ? _value.isUpcoming
          : isUpcoming // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDeleted: freezed == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      kind: freezed == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeaturedServiceImplCopyWith<$Res>
    implements $FeaturedServiceCopyWith<$Res> {
  factory _$$FeaturedServiceImplCopyWith(_$FeaturedServiceImpl value,
          $Res Function(_$FeaturedServiceImpl) then) =
      __$$FeaturedServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? title,
      String? description,
      String? image,
      @JsonKey(name: 'is_upcoming') bool? isUpcoming,
      @JsonKey(name: 'is_deleted') bool? isDeleted,
      String? kind,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class __$$FeaturedServiceImplCopyWithImpl<$Res>
    extends _$FeaturedServiceCopyWithImpl<$Res, _$FeaturedServiceImpl>
    implements _$$FeaturedServiceImplCopyWith<$Res> {
  __$$FeaturedServiceImplCopyWithImpl(
      _$FeaturedServiceImpl _value, $Res Function(_$FeaturedServiceImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeaturedService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? isUpcoming = freezed,
    Object? isDeleted = freezed,
    Object? kind = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$FeaturedServiceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      isUpcoming: freezed == isUpcoming
          ? _value.isUpcoming
          : isUpcoming // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDeleted: freezed == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      kind: freezed == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeaturedServiceImpl implements _FeaturedService {
  const _$FeaturedServiceImpl(
      {required this.id,
      this.title,
      this.description,
      this.image,
      @JsonKey(name: 'is_upcoming') this.isUpcoming,
      @JsonKey(name: 'is_deleted') this.isDeleted,
      this.kind,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$FeaturedServiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeaturedServiceImplFromJson(json);

  @override
  final String id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? image;
  @override
  @JsonKey(name: 'is_upcoming')
  final bool? isUpcoming;
  @override
  @JsonKey(name: 'is_deleted')
  final bool? isDeleted;
  @override
  final String? kind;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'FeaturedService(id: $id, title: $title, description: $description, image: $image, isUpcoming: $isUpcoming, isDeleted: $isDeleted, kind: $kind, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeaturedServiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.isUpcoming, isUpcoming) ||
                other.isUpcoming == isUpcoming) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, image,
      isUpcoming, isDeleted, kind, createdAt);

  /// Create a copy of FeaturedService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeaturedServiceImplCopyWith<_$FeaturedServiceImpl> get copyWith =>
      __$$FeaturedServiceImplCopyWithImpl<_$FeaturedServiceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeaturedServiceImplToJson(
      this,
    );
  }
}

abstract class _FeaturedService implements FeaturedService {
  const factory _FeaturedService(
          {required final String id,
          final String? title,
          final String? description,
          final String? image,
          @JsonKey(name: 'is_upcoming') final bool? isUpcoming,
          @JsonKey(name: 'is_deleted') final bool? isDeleted,
          final String? kind,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$FeaturedServiceImpl;

  factory _FeaturedService.fromJson(Map<String, dynamic> json) =
      _$FeaturedServiceImpl.fromJson;

  @override
  String get id;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get image;
  @override
  @JsonKey(name: 'is_upcoming')
  bool? get isUpcoming;
  @override
  @JsonKey(name: 'is_deleted')
  bool? get isDeleted;
  @override
  String? get kind;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of FeaturedService
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeaturedServiceImplCopyWith<_$FeaturedServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeaturedListResponse _$FeaturedListResponseFromJson(Map<String, dynamic> json) {
  return _FeaturedListResponse.fromJson(json);
}

/// @nodoc
mixin _$FeaturedListResponse {
  List<FeaturedProduct> get products => throw _privateConstructorUsedError;
  List<FeaturedService> get services => throw _privateConstructorUsedError;

  /// Serializes this FeaturedListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeaturedListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeaturedListResponseCopyWith<FeaturedListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeaturedListResponseCopyWith<$Res> {
  factory $FeaturedListResponseCopyWith(FeaturedListResponse value,
          $Res Function(FeaturedListResponse) then) =
      _$FeaturedListResponseCopyWithImpl<$Res, FeaturedListResponse>;
  @useResult
  $Res call({List<FeaturedProduct> products, List<FeaturedService> services});
}

/// @nodoc
class _$FeaturedListResponseCopyWithImpl<$Res,
        $Val extends FeaturedListResponse>
    implements $FeaturedListResponseCopyWith<$Res> {
  _$FeaturedListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeaturedListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? services = null,
  }) {
    return _then(_value.copyWith(
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<FeaturedProduct>,
      services: null == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<FeaturedService>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeaturedListResponseImplCopyWith<$Res>
    implements $FeaturedListResponseCopyWith<$Res> {
  factory _$$FeaturedListResponseImplCopyWith(_$FeaturedListResponseImpl value,
          $Res Function(_$FeaturedListResponseImpl) then) =
      __$$FeaturedListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FeaturedProduct> products, List<FeaturedService> services});
}

/// @nodoc
class __$$FeaturedListResponseImplCopyWithImpl<$Res>
    extends _$FeaturedListResponseCopyWithImpl<$Res, _$FeaturedListResponseImpl>
    implements _$$FeaturedListResponseImplCopyWith<$Res> {
  __$$FeaturedListResponseImplCopyWithImpl(_$FeaturedListResponseImpl _value,
      $Res Function(_$FeaturedListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeaturedListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? services = null,
  }) {
    return _then(_$FeaturedListResponseImpl(
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<FeaturedProduct>,
      services: null == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<FeaturedService>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeaturedListResponseImpl implements _FeaturedListResponse {
  const _$FeaturedListResponseImpl(
      {final List<FeaturedProduct> products = const [],
      final List<FeaturedService> services = const []})
      : _products = products,
        _services = services;

  factory _$FeaturedListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeaturedListResponseImplFromJson(json);

  final List<FeaturedProduct> _products;
  @override
  @JsonKey()
  List<FeaturedProduct> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<FeaturedService> _services;
  @override
  @JsonKey()
  List<FeaturedService> get services {
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  @override
  String toString() {
    return 'FeaturedListResponse(products: $products, services: $services)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeaturedListResponseImpl &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(other._services, _services));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_services));

  /// Create a copy of FeaturedListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeaturedListResponseImplCopyWith<_$FeaturedListResponseImpl>
      get copyWith =>
          __$$FeaturedListResponseImplCopyWithImpl<_$FeaturedListResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeaturedListResponseImplToJson(
      this,
    );
  }
}

abstract class _FeaturedListResponse implements FeaturedListResponse {
  const factory _FeaturedListResponse(
      {final List<FeaturedProduct> products,
      final List<FeaturedService> services}) = _$FeaturedListResponseImpl;

  factory _FeaturedListResponse.fromJson(Map<String, dynamic> json) =
      _$FeaturedListResponseImpl.fromJson;

  @override
  List<FeaturedProduct> get products;
  @override
  List<FeaturedService> get services;

  /// Create a copy of FeaturedListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeaturedListResponseImplCopyWith<_$FeaturedListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

FeaturedProductListResponse _$FeaturedProductListResponseFromJson(
    Map<String, dynamic> json) {
  return _FeaturedProductListResponse.fromJson(json);
}

/// @nodoc
mixin _$FeaturedProductListResponse {
  List<FeaturedProduct> get products => throw _privateConstructorUsedError;

  /// Serializes this FeaturedProductListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeaturedProductListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeaturedProductListResponseCopyWith<FeaturedProductListResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeaturedProductListResponseCopyWith<$Res> {
  factory $FeaturedProductListResponseCopyWith(
          FeaturedProductListResponse value,
          $Res Function(FeaturedProductListResponse) then) =
      _$FeaturedProductListResponseCopyWithImpl<$Res,
          FeaturedProductListResponse>;
  @useResult
  $Res call({List<FeaturedProduct> products});
}

/// @nodoc
class _$FeaturedProductListResponseCopyWithImpl<$Res,
        $Val extends FeaturedProductListResponse>
    implements $FeaturedProductListResponseCopyWith<$Res> {
  _$FeaturedProductListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeaturedProductListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
  }) {
    return _then(_value.copyWith(
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<FeaturedProduct>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeaturedProductListResponseImplCopyWith<$Res>
    implements $FeaturedProductListResponseCopyWith<$Res> {
  factory _$$FeaturedProductListResponseImplCopyWith(
          _$FeaturedProductListResponseImpl value,
          $Res Function(_$FeaturedProductListResponseImpl) then) =
      __$$FeaturedProductListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FeaturedProduct> products});
}

/// @nodoc
class __$$FeaturedProductListResponseImplCopyWithImpl<$Res>
    extends _$FeaturedProductListResponseCopyWithImpl<$Res,
        _$FeaturedProductListResponseImpl>
    implements _$$FeaturedProductListResponseImplCopyWith<$Res> {
  __$$FeaturedProductListResponseImplCopyWithImpl(
      _$FeaturedProductListResponseImpl _value,
      $Res Function(_$FeaturedProductListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeaturedProductListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
  }) {
    return _then(_$FeaturedProductListResponseImpl(
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<FeaturedProduct>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeaturedProductListResponseImpl
    implements _FeaturedProductListResponse {
  const _$FeaturedProductListResponseImpl(
      {final List<FeaturedProduct> products = const []})
      : _products = products;

  factory _$FeaturedProductListResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$FeaturedProductListResponseImplFromJson(json);

  final List<FeaturedProduct> _products;
  @override
  @JsonKey()
  List<FeaturedProduct> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'FeaturedProductListResponse(products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeaturedProductListResponseImpl &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_products));

  /// Create a copy of FeaturedProductListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeaturedProductListResponseImplCopyWith<_$FeaturedProductListResponseImpl>
      get copyWith => __$$FeaturedProductListResponseImplCopyWithImpl<
          _$FeaturedProductListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeaturedProductListResponseImplToJson(
      this,
    );
  }
}

abstract class _FeaturedProductListResponse
    implements FeaturedProductListResponse {
  const factory _FeaturedProductListResponse(
          {final List<FeaturedProduct> products}) =
      _$FeaturedProductListResponseImpl;

  factory _FeaturedProductListResponse.fromJson(Map<String, dynamic> json) =
      _$FeaturedProductListResponseImpl.fromJson;

  @override
  List<FeaturedProduct> get products;

  /// Create a copy of FeaturedProductListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeaturedProductListResponseImplCopyWith<_$FeaturedProductListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

FeaturedServiceListResponse _$FeaturedServiceListResponseFromJson(
    Map<String, dynamic> json) {
  return _FeaturedServiceListResponse.fromJson(json);
}

/// @nodoc
mixin _$FeaturedServiceListResponse {
  List<FeaturedService> get services => throw _privateConstructorUsedError;

  /// Serializes this FeaturedServiceListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeaturedServiceListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeaturedServiceListResponseCopyWith<FeaturedServiceListResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeaturedServiceListResponseCopyWith<$Res> {
  factory $FeaturedServiceListResponseCopyWith(
          FeaturedServiceListResponse value,
          $Res Function(FeaturedServiceListResponse) then) =
      _$FeaturedServiceListResponseCopyWithImpl<$Res,
          FeaturedServiceListResponse>;
  @useResult
  $Res call({List<FeaturedService> services});
}

/// @nodoc
class _$FeaturedServiceListResponseCopyWithImpl<$Res,
        $Val extends FeaturedServiceListResponse>
    implements $FeaturedServiceListResponseCopyWith<$Res> {
  _$FeaturedServiceListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeaturedServiceListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? services = null,
  }) {
    return _then(_value.copyWith(
      services: null == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<FeaturedService>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeaturedServiceListResponseImplCopyWith<$Res>
    implements $FeaturedServiceListResponseCopyWith<$Res> {
  factory _$$FeaturedServiceListResponseImplCopyWith(
          _$FeaturedServiceListResponseImpl value,
          $Res Function(_$FeaturedServiceListResponseImpl) then) =
      __$$FeaturedServiceListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FeaturedService> services});
}

/// @nodoc
class __$$FeaturedServiceListResponseImplCopyWithImpl<$Res>
    extends _$FeaturedServiceListResponseCopyWithImpl<$Res,
        _$FeaturedServiceListResponseImpl>
    implements _$$FeaturedServiceListResponseImplCopyWith<$Res> {
  __$$FeaturedServiceListResponseImplCopyWithImpl(
      _$FeaturedServiceListResponseImpl _value,
      $Res Function(_$FeaturedServiceListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeaturedServiceListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? services = null,
  }) {
    return _then(_$FeaturedServiceListResponseImpl(
      services: null == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<FeaturedService>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeaturedServiceListResponseImpl
    implements _FeaturedServiceListResponse {
  const _$FeaturedServiceListResponseImpl(
      {final List<FeaturedService> services = const []})
      : _services = services;

  factory _$FeaturedServiceListResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$FeaturedServiceListResponseImplFromJson(json);

  final List<FeaturedService> _services;
  @override
  @JsonKey()
  List<FeaturedService> get services {
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  @override
  String toString() {
    return 'FeaturedServiceListResponse(services: $services)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeaturedServiceListResponseImpl &&
            const DeepCollectionEquality().equals(other._services, _services));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_services));

  /// Create a copy of FeaturedServiceListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeaturedServiceListResponseImplCopyWith<_$FeaturedServiceListResponseImpl>
      get copyWith => __$$FeaturedServiceListResponseImplCopyWithImpl<
          _$FeaturedServiceListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeaturedServiceListResponseImplToJson(
      this,
    );
  }
}

abstract class _FeaturedServiceListResponse
    implements FeaturedServiceListResponse {
  const factory _FeaturedServiceListResponse(
          {final List<FeaturedService> services}) =
      _$FeaturedServiceListResponseImpl;

  factory _FeaturedServiceListResponse.fromJson(Map<String, dynamic> json) =
      _$FeaturedServiceListResponseImpl.fromJson;

  @override
  List<FeaturedService> get services;

  /// Create a copy of FeaturedServiceListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeaturedServiceListResponseImplCopyWith<_$FeaturedServiceListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

FeaturedManagementRequest _$FeaturedManagementRequestFromJson(
    Map<String, dynamic> json) {
  return _FeaturedManagementRequest.fromJson(json);
}

/// @nodoc
mixin _$FeaturedManagementRequest {
  String get itemId => throw _privateConstructorUsedError;
  FeaturedItemType get itemType => throw _privateConstructorUsedError;
  FeaturedActionType get action => throw _privateConstructorUsedError;

  /// Serializes this FeaturedManagementRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeaturedManagementRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeaturedManagementRequestCopyWith<FeaturedManagementRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeaturedManagementRequestCopyWith<$Res> {
  factory $FeaturedManagementRequestCopyWith(FeaturedManagementRequest value,
          $Res Function(FeaturedManagementRequest) then) =
      _$FeaturedManagementRequestCopyWithImpl<$Res, FeaturedManagementRequest>;
  @useResult
  $Res call(
      {String itemId, FeaturedItemType itemType, FeaturedActionType action});
}

/// @nodoc
class _$FeaturedManagementRequestCopyWithImpl<$Res,
        $Val extends FeaturedManagementRequest>
    implements $FeaturedManagementRequestCopyWith<$Res> {
  _$FeaturedManagementRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeaturedManagementRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? itemType = null,
    Object? action = null,
  }) {
    return _then(_value.copyWith(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      itemType: null == itemType
          ? _value.itemType
          : itemType // ignore: cast_nullable_to_non_nullable
              as FeaturedItemType,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as FeaturedActionType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeaturedManagementRequestImplCopyWith<$Res>
    implements $FeaturedManagementRequestCopyWith<$Res> {
  factory _$$FeaturedManagementRequestImplCopyWith(
          _$FeaturedManagementRequestImpl value,
          $Res Function(_$FeaturedManagementRequestImpl) then) =
      __$$FeaturedManagementRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String itemId, FeaturedItemType itemType, FeaturedActionType action});
}

/// @nodoc
class __$$FeaturedManagementRequestImplCopyWithImpl<$Res>
    extends _$FeaturedManagementRequestCopyWithImpl<$Res,
        _$FeaturedManagementRequestImpl>
    implements _$$FeaturedManagementRequestImplCopyWith<$Res> {
  __$$FeaturedManagementRequestImplCopyWithImpl(
      _$FeaturedManagementRequestImpl _value,
      $Res Function(_$FeaturedManagementRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeaturedManagementRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? itemType = null,
    Object? action = null,
  }) {
    return _then(_$FeaturedManagementRequestImpl(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      itemType: null == itemType
          ? _value.itemType
          : itemType // ignore: cast_nullable_to_non_nullable
              as FeaturedItemType,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as FeaturedActionType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeaturedManagementRequestImpl implements _FeaturedManagementRequest {
  const _$FeaturedManagementRequestImpl(
      {required this.itemId, required this.itemType, required this.action});

  factory _$FeaturedManagementRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeaturedManagementRequestImplFromJson(json);

  @override
  final String itemId;
  @override
  final FeaturedItemType itemType;
  @override
  final FeaturedActionType action;

  @override
  String toString() {
    return 'FeaturedManagementRequest(itemId: $itemId, itemType: $itemType, action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeaturedManagementRequestImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.itemType, itemType) ||
                other.itemType == itemType) &&
            (identical(other.action, action) || other.action == action));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, itemId, itemType, action);

  /// Create a copy of FeaturedManagementRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeaturedManagementRequestImplCopyWith<_$FeaturedManagementRequestImpl>
      get copyWith => __$$FeaturedManagementRequestImplCopyWithImpl<
          _$FeaturedManagementRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeaturedManagementRequestImplToJson(
      this,
    );
  }
}

abstract class _FeaturedManagementRequest implements FeaturedManagementRequest {
  const factory _FeaturedManagementRequest(
          {required final String itemId,
          required final FeaturedItemType itemType,
          required final FeaturedActionType action}) =
      _$FeaturedManagementRequestImpl;

  factory _FeaturedManagementRequest.fromJson(Map<String, dynamic> json) =
      _$FeaturedManagementRequestImpl.fromJson;

  @override
  String get itemId;
  @override
  FeaturedItemType get itemType;
  @override
  FeaturedActionType get action;

  /// Create a copy of FeaturedManagementRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeaturedManagementRequestImplCopyWith<_$FeaturedManagementRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

FeaturedStatistics _$FeaturedStatisticsFromJson(Map<String, dynamic> json) {
  return _FeaturedStatistics.fromJson(json);
}

/// @nodoc
mixin _$FeaturedStatistics {
  int get totalProducts => throw _privateConstructorUsedError;
  int get totalServices => throw _privateConstructorUsedError;
  int get upcomingProducts => throw _privateConstructorUsedError;
  int get upcomingServices => throw _privateConstructorUsedError;
  int get deletedServices => throw _privateConstructorUsedError;

  /// Serializes this FeaturedStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeaturedStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeaturedStatisticsCopyWith<FeaturedStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeaturedStatisticsCopyWith<$Res> {
  factory $FeaturedStatisticsCopyWith(
          FeaturedStatistics value, $Res Function(FeaturedStatistics) then) =
      _$FeaturedStatisticsCopyWithImpl<$Res, FeaturedStatistics>;
  @useResult
  $Res call(
      {int totalProducts,
      int totalServices,
      int upcomingProducts,
      int upcomingServices,
      int deletedServices});
}

/// @nodoc
class _$FeaturedStatisticsCopyWithImpl<$Res, $Val extends FeaturedStatistics>
    implements $FeaturedStatisticsCopyWith<$Res> {
  _$FeaturedStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeaturedStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalProducts = null,
    Object? totalServices = null,
    Object? upcomingProducts = null,
    Object? upcomingServices = null,
    Object? deletedServices = null,
  }) {
    return _then(_value.copyWith(
      totalProducts: null == totalProducts
          ? _value.totalProducts
          : totalProducts // ignore: cast_nullable_to_non_nullable
              as int,
      totalServices: null == totalServices
          ? _value.totalServices
          : totalServices // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingProducts: null == upcomingProducts
          ? _value.upcomingProducts
          : upcomingProducts // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingServices: null == upcomingServices
          ? _value.upcomingServices
          : upcomingServices // ignore: cast_nullable_to_non_nullable
              as int,
      deletedServices: null == deletedServices
          ? _value.deletedServices
          : deletedServices // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeaturedStatisticsImplCopyWith<$Res>
    implements $FeaturedStatisticsCopyWith<$Res> {
  factory _$$FeaturedStatisticsImplCopyWith(_$FeaturedStatisticsImpl value,
          $Res Function(_$FeaturedStatisticsImpl) then) =
      __$$FeaturedStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalProducts,
      int totalServices,
      int upcomingProducts,
      int upcomingServices,
      int deletedServices});
}

/// @nodoc
class __$$FeaturedStatisticsImplCopyWithImpl<$Res>
    extends _$FeaturedStatisticsCopyWithImpl<$Res, _$FeaturedStatisticsImpl>
    implements _$$FeaturedStatisticsImplCopyWith<$Res> {
  __$$FeaturedStatisticsImplCopyWithImpl(_$FeaturedStatisticsImpl _value,
      $Res Function(_$FeaturedStatisticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeaturedStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalProducts = null,
    Object? totalServices = null,
    Object? upcomingProducts = null,
    Object? upcomingServices = null,
    Object? deletedServices = null,
  }) {
    return _then(_$FeaturedStatisticsImpl(
      totalProducts: null == totalProducts
          ? _value.totalProducts
          : totalProducts // ignore: cast_nullable_to_non_nullable
              as int,
      totalServices: null == totalServices
          ? _value.totalServices
          : totalServices // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingProducts: null == upcomingProducts
          ? _value.upcomingProducts
          : upcomingProducts // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingServices: null == upcomingServices
          ? _value.upcomingServices
          : upcomingServices // ignore: cast_nullable_to_non_nullable
              as int,
      deletedServices: null == deletedServices
          ? _value.deletedServices
          : deletedServices // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeaturedStatisticsImpl implements _FeaturedStatistics {
  const _$FeaturedStatisticsImpl(
      {this.totalProducts = 0,
      this.totalServices = 0,
      this.upcomingProducts = 0,
      this.upcomingServices = 0,
      this.deletedServices = 0});

  factory _$FeaturedStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeaturedStatisticsImplFromJson(json);

  @override
  @JsonKey()
  final int totalProducts;
  @override
  @JsonKey()
  final int totalServices;
  @override
  @JsonKey()
  final int upcomingProducts;
  @override
  @JsonKey()
  final int upcomingServices;
  @override
  @JsonKey()
  final int deletedServices;

  @override
  String toString() {
    return 'FeaturedStatistics(totalProducts: $totalProducts, totalServices: $totalServices, upcomingProducts: $upcomingProducts, upcomingServices: $upcomingServices, deletedServices: $deletedServices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeaturedStatisticsImpl &&
            (identical(other.totalProducts, totalProducts) ||
                other.totalProducts == totalProducts) &&
            (identical(other.totalServices, totalServices) ||
                other.totalServices == totalServices) &&
            (identical(other.upcomingProducts, upcomingProducts) ||
                other.upcomingProducts == upcomingProducts) &&
            (identical(other.upcomingServices, upcomingServices) ||
                other.upcomingServices == upcomingServices) &&
            (identical(other.deletedServices, deletedServices) ||
                other.deletedServices == deletedServices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalProducts, totalServices,
      upcomingProducts, upcomingServices, deletedServices);

  /// Create a copy of FeaturedStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeaturedStatisticsImplCopyWith<_$FeaturedStatisticsImpl> get copyWith =>
      __$$FeaturedStatisticsImplCopyWithImpl<_$FeaturedStatisticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeaturedStatisticsImplToJson(
      this,
    );
  }
}

abstract class _FeaturedStatistics implements FeaturedStatistics {
  const factory _FeaturedStatistics(
      {final int totalProducts,
      final int totalServices,
      final int upcomingProducts,
      final int upcomingServices,
      final int deletedServices}) = _$FeaturedStatisticsImpl;

  factory _FeaturedStatistics.fromJson(Map<String, dynamic> json) =
      _$FeaturedStatisticsImpl.fromJson;

  @override
  int get totalProducts;
  @override
  int get totalServices;
  @override
  int get upcomingProducts;
  @override
  int get upcomingServices;
  @override
  int get deletedServices;

  /// Create a copy of FeaturedStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeaturedStatisticsImplCopyWith<_$FeaturedStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
