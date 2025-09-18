// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Appointment {
  String get id => throw _privateConstructorUsedError;
  String get serviceId => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  DateTime get start => throw _privateConstructorUsedError;
  DateTime get end => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentCopyWith<Appointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentCopyWith<$Res> {
  factory $AppointmentCopyWith(
          Appointment value, $Res Function(Appointment) then) =
      _$AppointmentCopyWithImpl<$Res, Appointment>;
  @useResult
  $Res call(
      {String id,
      String serviceId,
      String? userId,
      DateTime start,
      DateTime end,
      String status,
      String? notes});
}

/// @nodoc
class _$AppointmentCopyWithImpl<$Res, $Val extends Appointment>
    implements $AppointmentCopyWith<$Res> {
  _$AppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serviceId = null,
    Object? userId = freezed,
    Object? start = null,
    Object? end = null,
    Object? status = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppointmentImplCopyWith<$Res>
    implements $AppointmentCopyWith<$Res> {
  factory _$$AppointmentImplCopyWith(
          _$AppointmentImpl value, $Res Function(_$AppointmentImpl) then) =
      __$$AppointmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String serviceId,
      String? userId,
      DateTime start,
      DateTime end,
      String status,
      String? notes});
}

/// @nodoc
class __$$AppointmentImplCopyWithImpl<$Res>
    extends _$AppointmentCopyWithImpl<$Res, _$AppointmentImpl>
    implements _$$AppointmentImplCopyWith<$Res> {
  __$$AppointmentImplCopyWithImpl(
      _$AppointmentImpl _value, $Res Function(_$AppointmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serviceId = null,
    Object? userId = freezed,
    Object? start = null,
    Object? end = null,
    Object? status = null,
    Object? notes = freezed,
  }) {
    return _then(_$AppointmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AppointmentImpl implements _Appointment {
  const _$AppointmentImpl(
      {required this.id,
      required this.serviceId,
      this.userId,
      required this.start,
      required this.end,
      required this.status,
      this.notes});

  @override
  final String id;
  @override
  final String serviceId;
  @override
  final String? userId;
  @override
  final DateTime start;
  @override
  final DateTime end;
  @override
  final String status;
  @override
  final String? notes;

  @override
  String toString() {
    return 'Appointment(id: $id, serviceId: $serviceId, userId: $userId, start: $start, end: $end, status: $status, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, serviceId, userId, start, end, status, notes);

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentImplCopyWith<_$AppointmentImpl> get copyWith =>
      __$$AppointmentImplCopyWithImpl<_$AppointmentImpl>(this, _$identity);
}

abstract class _Appointment implements Appointment {
  const factory _Appointment(
      {required final String id,
      required final String serviceId,
      final String? userId,
      required final DateTime start,
      required final DateTime end,
      required final String status,
      final String? notes}) = _$AppointmentImpl;

  @override
  String get id;
  @override
  String get serviceId;
  @override
  String? get userId;
  @override
  DateTime get start;
  @override
  DateTime get end;
  @override
  String get status;
  @override
  String? get notes;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentImplCopyWith<_$AppointmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AppointmentWithDetails {
  String get id => throw _privateConstructorUsedError;
  String get serviceId => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  DateTime get start => throw _privateConstructorUsedError;
  DateTime get end => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  ServiceBrief? get service => throw _privateConstructorUsedError;
  UserBrief? get user => throw _privateConstructorUsedError;

  /// Create a copy of AppointmentWithDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentWithDetailsCopyWith<AppointmentWithDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentWithDetailsCopyWith<$Res> {
  factory $AppointmentWithDetailsCopyWith(AppointmentWithDetails value,
          $Res Function(AppointmentWithDetails) then) =
      _$AppointmentWithDetailsCopyWithImpl<$Res, AppointmentWithDetails>;
  @useResult
  $Res call(
      {String id,
      String serviceId,
      String? userId,
      DateTime start,
      DateTime end,
      String status,
      String? notes,
      ServiceBrief? service,
      UserBrief? user});

  $ServiceBriefCopyWith<$Res>? get service;
  $UserBriefCopyWith<$Res>? get user;
}

/// @nodoc
class _$AppointmentWithDetailsCopyWithImpl<$Res,
        $Val extends AppointmentWithDetails>
    implements $AppointmentWithDetailsCopyWith<$Res> {
  _$AppointmentWithDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppointmentWithDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serviceId = null,
    Object? userId = freezed,
    Object? start = null,
    Object? end = null,
    Object? status = null,
    Object? notes = freezed,
    Object? service = freezed,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as ServiceBrief?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserBrief?,
    ) as $Val);
  }

  /// Create a copy of AppointmentWithDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceBriefCopyWith<$Res>? get service {
    if (_value.service == null) {
      return null;
    }

    return $ServiceBriefCopyWith<$Res>(_value.service!, (value) {
      return _then(_value.copyWith(service: value) as $Val);
    });
  }

  /// Create a copy of AppointmentWithDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserBriefCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserBriefCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppointmentWithDetailsImplCopyWith<$Res>
    implements $AppointmentWithDetailsCopyWith<$Res> {
  factory _$$AppointmentWithDetailsImplCopyWith(
          _$AppointmentWithDetailsImpl value,
          $Res Function(_$AppointmentWithDetailsImpl) then) =
      __$$AppointmentWithDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String serviceId,
      String? userId,
      DateTime start,
      DateTime end,
      String status,
      String? notes,
      ServiceBrief? service,
      UserBrief? user});

  @override
  $ServiceBriefCopyWith<$Res>? get service;
  @override
  $UserBriefCopyWith<$Res>? get user;
}

/// @nodoc
class __$$AppointmentWithDetailsImplCopyWithImpl<$Res>
    extends _$AppointmentWithDetailsCopyWithImpl<$Res,
        _$AppointmentWithDetailsImpl>
    implements _$$AppointmentWithDetailsImplCopyWith<$Res> {
  __$$AppointmentWithDetailsImplCopyWithImpl(
      _$AppointmentWithDetailsImpl _value,
      $Res Function(_$AppointmentWithDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppointmentWithDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serviceId = null,
    Object? userId = freezed,
    Object? start = null,
    Object? end = null,
    Object? status = null,
    Object? notes = freezed,
    Object? service = freezed,
    Object? user = freezed,
  }) {
    return _then(_$AppointmentWithDetailsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as ServiceBrief?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserBrief?,
    ));
  }
}

/// @nodoc

class _$AppointmentWithDetailsImpl implements _AppointmentWithDetails {
  const _$AppointmentWithDetailsImpl(
      {required this.id,
      required this.serviceId,
      this.userId,
      required this.start,
      required this.end,
      required this.status,
      this.notes,
      this.service,
      this.user});

  @override
  final String id;
  @override
  final String serviceId;
  @override
  final String? userId;
  @override
  final DateTime start;
  @override
  final DateTime end;
  @override
  final String status;
  @override
  final String? notes;
  @override
  final ServiceBrief? service;
  @override
  final UserBrief? user;

  @override
  String toString() {
    return 'AppointmentWithDetails(id: $id, serviceId: $serviceId, userId: $userId, start: $start, end: $end, status: $status, notes: $notes, service: $service, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentWithDetailsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, serviceId, userId, start,
      end, status, notes, service, user);

  /// Create a copy of AppointmentWithDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentWithDetailsImplCopyWith<_$AppointmentWithDetailsImpl>
      get copyWith => __$$AppointmentWithDetailsImplCopyWithImpl<
          _$AppointmentWithDetailsImpl>(this, _$identity);
}

abstract class _AppointmentWithDetails implements AppointmentWithDetails {
  const factory _AppointmentWithDetails(
      {required final String id,
      required final String serviceId,
      final String? userId,
      required final DateTime start,
      required final DateTime end,
      required final String status,
      final String? notes,
      final ServiceBrief? service,
      final UserBrief? user}) = _$AppointmentWithDetailsImpl;

  @override
  String get id;
  @override
  String get serviceId;
  @override
  String? get userId;
  @override
  DateTime get start;
  @override
  DateTime get end;
  @override
  String get status;
  @override
  String? get notes;
  @override
  ServiceBrief? get service;
  @override
  UserBrief? get user;

  /// Create a copy of AppointmentWithDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentWithDetailsImplCopyWith<_$AppointmentWithDetailsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ServiceBrief {
  String get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;

  /// Create a copy of ServiceBrief
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceBriefCopyWith<ServiceBrief> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceBriefCopyWith<$Res> {
  factory $ServiceBriefCopyWith(
          ServiceBrief value, $Res Function(ServiceBrief) then) =
      _$ServiceBriefCopyWithImpl<$Res, ServiceBrief>;
  @useResult
  $Res call({String id, String? title, double? price});
}

/// @nodoc
class _$ServiceBriefCopyWithImpl<$Res, $Val extends ServiceBrief>
    implements $ServiceBriefCopyWith<$Res> {
  _$ServiceBriefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceBrief
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? price = freezed,
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
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceBriefImplCopyWith<$Res>
    implements $ServiceBriefCopyWith<$Res> {
  factory _$$ServiceBriefImplCopyWith(
          _$ServiceBriefImpl value, $Res Function(_$ServiceBriefImpl) then) =
      __$$ServiceBriefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? title, double? price});
}

/// @nodoc
class __$$ServiceBriefImplCopyWithImpl<$Res>
    extends _$ServiceBriefCopyWithImpl<$Res, _$ServiceBriefImpl>
    implements _$$ServiceBriefImplCopyWith<$Res> {
  __$$ServiceBriefImplCopyWithImpl(
      _$ServiceBriefImpl _value, $Res Function(_$ServiceBriefImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceBrief
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? price = freezed,
  }) {
    return _then(_$ServiceBriefImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$ServiceBriefImpl implements _ServiceBrief {
  const _$ServiceBriefImpl({required this.id, this.title, this.price});

  @override
  final String id;
  @override
  final String? title;
  @override
  final double? price;

  @override
  String toString() {
    return 'ServiceBrief(id: $id, title: $title, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceBriefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, price);

  /// Create a copy of ServiceBrief
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceBriefImplCopyWith<_$ServiceBriefImpl> get copyWith =>
      __$$ServiceBriefImplCopyWithImpl<_$ServiceBriefImpl>(this, _$identity);
}

abstract class _ServiceBrief implements ServiceBrief {
  const factory _ServiceBrief(
      {required final String id,
      final String? title,
      final double? price}) = _$ServiceBriefImpl;

  @override
  String get id;
  @override
  String? get title;
  @override
  double? get price;

  /// Create a copy of ServiceBrief
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceBriefImplCopyWith<_$ServiceBriefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserBrief {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  List<Map<String, dynamic>>? get addresses =>
      throw _privateConstructorUsedError;

  /// Create a copy of UserBrief
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserBriefCopyWith<UserBrief> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserBriefCopyWith<$Res> {
  factory $UserBriefCopyWith(UserBrief value, $Res Function(UserBrief) then) =
      _$UserBriefCopyWithImpl<$Res, UserBrief>;
  @useResult
  $Res call(
      {String id,
      String? name,
      String? phone,
      String? email,
      List<Map<String, dynamic>>? addresses});
}

/// @nodoc
class _$UserBriefCopyWithImpl<$Res, $Val extends UserBrief>
    implements $UserBriefCopyWith<$Res> {
  _$UserBriefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserBrief
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? addresses = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      addresses: freezed == addresses
          ? _value.addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserBriefImplCopyWith<$Res>
    implements $UserBriefCopyWith<$Res> {
  factory _$$UserBriefImplCopyWith(
          _$UserBriefImpl value, $Res Function(_$UserBriefImpl) then) =
      __$$UserBriefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? name,
      String? phone,
      String? email,
      List<Map<String, dynamic>>? addresses});
}

/// @nodoc
class __$$UserBriefImplCopyWithImpl<$Res>
    extends _$UserBriefCopyWithImpl<$Res, _$UserBriefImpl>
    implements _$$UserBriefImplCopyWith<$Res> {
  __$$UserBriefImplCopyWithImpl(
      _$UserBriefImpl _value, $Res Function(_$UserBriefImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserBrief
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? addresses = freezed,
  }) {
    return _then(_$UserBriefImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      addresses: freezed == addresses
          ? _value._addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
    ));
  }
}

/// @nodoc

class _$UserBriefImpl implements _UserBrief {
  const _$UserBriefImpl(
      {required this.id,
      this.name,
      this.phone,
      this.email,
      final List<Map<String, dynamic>>? addresses})
      : _addresses = addresses;

  @override
  final String id;
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final String? email;
  final List<Map<String, dynamic>>? _addresses;
  @override
  List<Map<String, dynamic>>? get addresses {
    final value = _addresses;
    if (value == null) return null;
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserBrief(id: $id, name: $name, phone: $phone, email: $email, addresses: $addresses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserBriefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality()
                .equals(other._addresses, _addresses));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone, email,
      const DeepCollectionEquality().hash(_addresses));

  /// Create a copy of UserBrief
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserBriefImplCopyWith<_$UserBriefImpl> get copyWith =>
      __$$UserBriefImplCopyWithImpl<_$UserBriefImpl>(this, _$identity);
}

abstract class _UserBrief implements UserBrief {
  const factory _UserBrief(
      {required final String id,
      final String? name,
      final String? phone,
      final String? email,
      final List<Map<String, dynamic>>? addresses}) = _$UserBriefImpl;

  @override
  String get id;
  @override
  String? get name;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  List<Map<String, dynamic>>? get addresses;

  /// Create a copy of UserBrief
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserBriefImplCopyWith<_$UserBriefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TimeSlot {
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  String? get appointmentId => throw _privateConstructorUsedError;

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeSlotCopyWith<TimeSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeSlotCopyWith<$Res> {
  factory $TimeSlotCopyWith(TimeSlot value, $Res Function(TimeSlot) then) =
      _$TimeSlotCopyWithImpl<$Res, TimeSlot>;
  @useResult
  $Res call(
      {String startTime,
      String endTime,
      bool isAvailable,
      String? appointmentId});
}

/// @nodoc
class _$TimeSlotCopyWithImpl<$Res, $Val extends TimeSlot>
    implements $TimeSlotCopyWith<$Res> {
  _$TimeSlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? isAvailable = null,
    Object? appointmentId = freezed,
  }) {
    return _then(_value.copyWith(
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      appointmentId: freezed == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeSlotImplCopyWith<$Res>
    implements $TimeSlotCopyWith<$Res> {
  factory _$$TimeSlotImplCopyWith(
          _$TimeSlotImpl value, $Res Function(_$TimeSlotImpl) then) =
      __$$TimeSlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String startTime,
      String endTime,
      bool isAvailable,
      String? appointmentId});
}

/// @nodoc
class __$$TimeSlotImplCopyWithImpl<$Res>
    extends _$TimeSlotCopyWithImpl<$Res, _$TimeSlotImpl>
    implements _$$TimeSlotImplCopyWith<$Res> {
  __$$TimeSlotImplCopyWithImpl(
      _$TimeSlotImpl _value, $Res Function(_$TimeSlotImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? isAvailable = null,
    Object? appointmentId = freezed,
  }) {
    return _then(_$TimeSlotImpl(
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      appointmentId: freezed == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TimeSlotImpl implements _TimeSlot {
  const _$TimeSlotImpl(
      {required this.startTime,
      required this.endTime,
      required this.isAvailable,
      this.appointmentId});

  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final bool isAvailable;
  @override
  final String? appointmentId;

  @override
  String toString() {
    return 'TimeSlot(startTime: $startTime, endTime: $endTime, isAvailable: $isAvailable, appointmentId: $appointmentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeSlotImpl &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, startTime, endTime, isAvailable, appointmentId);

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeSlotImplCopyWith<_$TimeSlotImpl> get copyWith =>
      __$$TimeSlotImplCopyWithImpl<_$TimeSlotImpl>(this, _$identity);
}

abstract class _TimeSlot implements TimeSlot {
  const factory _TimeSlot(
      {required final String startTime,
      required final String endTime,
      required final bool isAvailable,
      final String? appointmentId}) = _$TimeSlotImpl;

  @override
  String get startTime;
  @override
  String get endTime;
  @override
  bool get isAvailable;
  @override
  String? get appointmentId;

  /// Create a copy of TimeSlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeSlotImplCopyWith<_$TimeSlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DayAvailability {
  DateTime get date => throw _privateConstructorUsedError;
  bool get isWorkingDay => throw _privateConstructorUsedError;
  List<TimeSlot> get timeSlots => throw _privateConstructorUsedError;

  /// Create a copy of DayAvailability
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DayAvailabilityCopyWith<DayAvailability> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DayAvailabilityCopyWith<$Res> {
  factory $DayAvailabilityCopyWith(
          DayAvailability value, $Res Function(DayAvailability) then) =
      _$DayAvailabilityCopyWithImpl<$Res, DayAvailability>;
  @useResult
  $Res call({DateTime date, bool isWorkingDay, List<TimeSlot> timeSlots});
}

/// @nodoc
class _$DayAvailabilityCopyWithImpl<$Res, $Val extends DayAvailability>
    implements $DayAvailabilityCopyWith<$Res> {
  _$DayAvailabilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DayAvailability
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? isWorkingDay = null,
    Object? timeSlots = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isWorkingDay: null == isWorkingDay
          ? _value.isWorkingDay
          : isWorkingDay // ignore: cast_nullable_to_non_nullable
              as bool,
      timeSlots: null == timeSlots
          ? _value.timeSlots
          : timeSlots // ignore: cast_nullable_to_non_nullable
              as List<TimeSlot>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DayAvailabilityImplCopyWith<$Res>
    implements $DayAvailabilityCopyWith<$Res> {
  factory _$$DayAvailabilityImplCopyWith(_$DayAvailabilityImpl value,
          $Res Function(_$DayAvailabilityImpl) then) =
      __$$DayAvailabilityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, bool isWorkingDay, List<TimeSlot> timeSlots});
}

/// @nodoc
class __$$DayAvailabilityImplCopyWithImpl<$Res>
    extends _$DayAvailabilityCopyWithImpl<$Res, _$DayAvailabilityImpl>
    implements _$$DayAvailabilityImplCopyWith<$Res> {
  __$$DayAvailabilityImplCopyWithImpl(
      _$DayAvailabilityImpl _value, $Res Function(_$DayAvailabilityImpl) _then)
      : super(_value, _then);

  /// Create a copy of DayAvailability
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? isWorkingDay = null,
    Object? timeSlots = null,
  }) {
    return _then(_$DayAvailabilityImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isWorkingDay: null == isWorkingDay
          ? _value.isWorkingDay
          : isWorkingDay // ignore: cast_nullable_to_non_nullable
              as bool,
      timeSlots: null == timeSlots
          ? _value._timeSlots
          : timeSlots // ignore: cast_nullable_to_non_nullable
              as List<TimeSlot>,
    ));
  }
}

/// @nodoc

class _$DayAvailabilityImpl implements _DayAvailability {
  const _$DayAvailabilityImpl(
      {required this.date,
      required this.isWorkingDay,
      final List<TimeSlot> timeSlots = const []})
      : _timeSlots = timeSlots;

  @override
  final DateTime date;
  @override
  final bool isWorkingDay;
  final List<TimeSlot> _timeSlots;
  @override
  @JsonKey()
  List<TimeSlot> get timeSlots {
    if (_timeSlots is EqualUnmodifiableListView) return _timeSlots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeSlots);
  }

  @override
  String toString() {
    return 'DayAvailability(date: $date, isWorkingDay: $isWorkingDay, timeSlots: $timeSlots)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DayAvailabilityImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isWorkingDay, isWorkingDay) ||
                other.isWorkingDay == isWorkingDay) &&
            const DeepCollectionEquality()
                .equals(other._timeSlots, _timeSlots));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, isWorkingDay,
      const DeepCollectionEquality().hash(_timeSlots));

  /// Create a copy of DayAvailability
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DayAvailabilityImplCopyWith<_$DayAvailabilityImpl> get copyWith =>
      __$$DayAvailabilityImplCopyWithImpl<_$DayAvailabilityImpl>(
          this, _$identity);
}

abstract class _DayAvailability implements DayAvailability {
  const factory _DayAvailability(
      {required final DateTime date,
      required final bool isWorkingDay,
      final List<TimeSlot> timeSlots}) = _$DayAvailabilityImpl;

  @override
  DateTime get date;
  @override
  bool get isWorkingDay;
  @override
  List<TimeSlot> get timeSlots;

  /// Create a copy of DayAvailability
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DayAvailabilityImplCopyWith<_$DayAvailabilityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MonthlyAvailability {
  String get serviceId => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  List<DayAvailability> get days => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyAvailability
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyAvailabilityCopyWith<MonthlyAvailability> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyAvailabilityCopyWith<$Res> {
  factory $MonthlyAvailabilityCopyWith(
          MonthlyAvailability value, $Res Function(MonthlyAvailability) then) =
      _$MonthlyAvailabilityCopyWithImpl<$Res, MonthlyAvailability>;
  @useResult
  $Res call(
      {String serviceId, int year, int month, List<DayAvailability> days});
}

/// @nodoc
class _$MonthlyAvailabilityCopyWithImpl<$Res, $Val extends MonthlyAvailability>
    implements $MonthlyAvailabilityCopyWith<$Res> {
  _$MonthlyAvailabilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyAvailability
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? year = null,
    Object? month = null,
    Object? days = null,
  }) {
    return _then(_value.copyWith(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<DayAvailability>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlyAvailabilityImplCopyWith<$Res>
    implements $MonthlyAvailabilityCopyWith<$Res> {
  factory _$$MonthlyAvailabilityImplCopyWith(_$MonthlyAvailabilityImpl value,
          $Res Function(_$MonthlyAvailabilityImpl) then) =
      __$$MonthlyAvailabilityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String serviceId, int year, int month, List<DayAvailability> days});
}

/// @nodoc
class __$$MonthlyAvailabilityImplCopyWithImpl<$Res>
    extends _$MonthlyAvailabilityCopyWithImpl<$Res, _$MonthlyAvailabilityImpl>
    implements _$$MonthlyAvailabilityImplCopyWith<$Res> {
  __$$MonthlyAvailabilityImplCopyWithImpl(_$MonthlyAvailabilityImpl _value,
      $Res Function(_$MonthlyAvailabilityImpl) _then)
      : super(_value, _then);

  /// Create a copy of MonthlyAvailability
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? year = null,
    Object? month = null,
    Object? days = null,
  }) {
    return _then(_$MonthlyAvailabilityImpl(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      days: null == days
          ? _value._days
          : days // ignore: cast_nullable_to_non_nullable
              as List<DayAvailability>,
    ));
  }
}

/// @nodoc

class _$MonthlyAvailabilityImpl implements _MonthlyAvailability {
  const _$MonthlyAvailabilityImpl(
      {required this.serviceId,
      required this.year,
      required this.month,
      final List<DayAvailability> days = const []})
      : _days = days;

  @override
  final String serviceId;
  @override
  final int year;
  @override
  final int month;
  final List<DayAvailability> _days;
  @override
  @JsonKey()
  List<DayAvailability> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  String toString() {
    return 'MonthlyAvailability(serviceId: $serviceId, year: $year, month: $month, days: $days)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyAvailabilityImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            const DeepCollectionEquality().equals(other._days, _days));
  }

  @override
  int get hashCode => Object.hash(runtimeType, serviceId, year, month,
      const DeepCollectionEquality().hash(_days));

  /// Create a copy of MonthlyAvailability
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyAvailabilityImplCopyWith<_$MonthlyAvailabilityImpl> get copyWith =>
      __$$MonthlyAvailabilityImplCopyWithImpl<_$MonthlyAvailabilityImpl>(
          this, _$identity);
}

abstract class _MonthlyAvailability implements MonthlyAvailability {
  const factory _MonthlyAvailability(
      {required final String serviceId,
      required final int year,
      required final int month,
      final List<DayAvailability> days}) = _$MonthlyAvailabilityImpl;

  @override
  String get serviceId;
  @override
  int get year;
  @override
  int get month;
  @override
  List<DayAvailability> get days;

  /// Create a copy of MonthlyAvailability
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyAvailabilityImplCopyWith<_$MonthlyAvailabilityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AppointmentAdminOut {
  String get id => throw _privateConstructorUsedError;
  DateTime get start => throw _privateConstructorUsedError;
  DateTime get end => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  UserBrief get user => throw _privateConstructorUsedError;
  ServiceBrief get service => throw _privateConstructorUsedError;

  /// Create a copy of AppointmentAdminOut
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentAdminOutCopyWith<AppointmentAdminOut> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentAdminOutCopyWith<$Res> {
  factory $AppointmentAdminOutCopyWith(
          AppointmentAdminOut value, $Res Function(AppointmentAdminOut) then) =
      _$AppointmentAdminOutCopyWithImpl<$Res, AppointmentAdminOut>;
  @useResult
  $Res call(
      {String id,
      DateTime start,
      DateTime end,
      String status,
      UserBrief user,
      ServiceBrief service});

  $UserBriefCopyWith<$Res> get user;
  $ServiceBriefCopyWith<$Res> get service;
}

/// @nodoc
class _$AppointmentAdminOutCopyWithImpl<$Res, $Val extends AppointmentAdminOut>
    implements $AppointmentAdminOutCopyWith<$Res> {
  _$AppointmentAdminOutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppointmentAdminOut
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? start = null,
    Object? end = null,
    Object? status = null,
    Object? user = null,
    Object? service = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserBrief,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as ServiceBrief,
    ) as $Val);
  }

  /// Create a copy of AppointmentAdminOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserBriefCopyWith<$Res> get user {
    return $UserBriefCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of AppointmentAdminOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceBriefCopyWith<$Res> get service {
    return $ServiceBriefCopyWith<$Res>(_value.service, (value) {
      return _then(_value.copyWith(service: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppointmentAdminOutImplCopyWith<$Res>
    implements $AppointmentAdminOutCopyWith<$Res> {
  factory _$$AppointmentAdminOutImplCopyWith(_$AppointmentAdminOutImpl value,
          $Res Function(_$AppointmentAdminOutImpl) then) =
      __$$AppointmentAdminOutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime start,
      DateTime end,
      String status,
      UserBrief user,
      ServiceBrief service});

  @override
  $UserBriefCopyWith<$Res> get user;
  @override
  $ServiceBriefCopyWith<$Res> get service;
}

/// @nodoc
class __$$AppointmentAdminOutImplCopyWithImpl<$Res>
    extends _$AppointmentAdminOutCopyWithImpl<$Res, _$AppointmentAdminOutImpl>
    implements _$$AppointmentAdminOutImplCopyWith<$Res> {
  __$$AppointmentAdminOutImplCopyWithImpl(_$AppointmentAdminOutImpl _value,
      $Res Function(_$AppointmentAdminOutImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppointmentAdminOut
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? start = null,
    Object? end = null,
    Object? status = null,
    Object? user = null,
    Object? service = null,
  }) {
    return _then(_$AppointmentAdminOutImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserBrief,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as ServiceBrief,
    ));
  }
}

/// @nodoc

class _$AppointmentAdminOutImpl implements _AppointmentAdminOut {
  const _$AppointmentAdminOutImpl(
      {required this.id,
      required this.start,
      required this.end,
      required this.status,
      required this.user,
      required this.service});

  @override
  final String id;
  @override
  final DateTime start;
  @override
  final DateTime end;
  @override
  final String status;
  @override
  final UserBrief user;
  @override
  final ServiceBrief service;

  @override
  String toString() {
    return 'AppointmentAdminOut(id: $id, start: $start, end: $end, status: $status, user: $user, service: $service)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentAdminOutImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.service, service) || other.service == service));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, start, end, status, user, service);

  /// Create a copy of AppointmentAdminOut
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentAdminOutImplCopyWith<_$AppointmentAdminOutImpl> get copyWith =>
      __$$AppointmentAdminOutImplCopyWithImpl<_$AppointmentAdminOutImpl>(
          this, _$identity);
}

abstract class _AppointmentAdminOut implements AppointmentAdminOut {
  const factory _AppointmentAdminOut(
      {required final String id,
      required final DateTime start,
      required final DateTime end,
      required final String status,
      required final UserBrief user,
      required final ServiceBrief service}) = _$AppointmentAdminOutImpl;

  @override
  String get id;
  @override
  DateTime get start;
  @override
  DateTime get end;
  @override
  String get status;
  @override
  UserBrief get user;
  @override
  ServiceBrief get service;

  /// Create a copy of AppointmentAdminOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentAdminOutImplCopyWith<_$AppointmentAdminOutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BusySlot _$BusySlotFromJson(Map<String, dynamic> json) {
  return _BusySlot.fromJson(json);
}

/// @nodoc
mixin _$BusySlot {
  @JsonKey(name: 'service_id')
  String? get serviceId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get start => throw _privateConstructorUsedError;
  String get end => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'appointment_id')
  String get appointmentId => throw _privateConstructorUsedError;

  /// Serializes this BusySlot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusySlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusySlotCopyWith<BusySlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusySlotCopyWith<$Res> {
  factory $BusySlotCopyWith(BusySlot value, $Res Function(BusySlot) then) =
      _$BusySlotCopyWithImpl<$Res, BusySlot>;
  @useResult
  $Res call(
      {@JsonKey(name: 'service_id') String? serviceId,
      String date,
      String start,
      String end,
      String status,
      @JsonKey(name: 'appointment_id') String appointmentId});
}

/// @nodoc
class _$BusySlotCopyWithImpl<$Res, $Val extends BusySlot>
    implements $BusySlotCopyWith<$Res> {
  _$BusySlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusySlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = freezed,
    Object? date = null,
    Object? start = null,
    Object? end = null,
    Object? status = null,
    Object? appointmentId = null,
  }) {
    return _then(_value.copyWith(
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusySlotImplCopyWith<$Res>
    implements $BusySlotCopyWith<$Res> {
  factory _$$BusySlotImplCopyWith(
          _$BusySlotImpl value, $Res Function(_$BusySlotImpl) then) =
      __$$BusySlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'service_id') String? serviceId,
      String date,
      String start,
      String end,
      String status,
      @JsonKey(name: 'appointment_id') String appointmentId});
}

/// @nodoc
class __$$BusySlotImplCopyWithImpl<$Res>
    extends _$BusySlotCopyWithImpl<$Res, _$BusySlotImpl>
    implements _$$BusySlotImplCopyWith<$Res> {
  __$$BusySlotImplCopyWithImpl(
      _$BusySlotImpl _value, $Res Function(_$BusySlotImpl) _then)
      : super(_value, _then);

  /// Create a copy of BusySlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = freezed,
    Object? date = null,
    Object? start = null,
    Object? end = null,
    Object? status = null,
    Object? appointmentId = null,
  }) {
    return _then(_$BusySlotImpl(
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusySlotImpl implements _BusySlot {
  const _$BusySlotImpl(
      {@JsonKey(name: 'service_id') this.serviceId,
      required this.date,
      required this.start,
      required this.end,
      required this.status,
      @JsonKey(name: 'appointment_id') required this.appointmentId});

  factory _$BusySlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusySlotImplFromJson(json);

  @override
  @JsonKey(name: 'service_id')
  final String? serviceId;
  @override
  final String date;
  @override
  final String start;
  @override
  final String end;
  @override
  final String status;
  @override
  @JsonKey(name: 'appointment_id')
  final String appointmentId;

  @override
  String toString() {
    return 'BusySlot(serviceId: $serviceId, date: $date, start: $start, end: $end, status: $status, appointmentId: $appointmentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusySlotImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, serviceId, date, start, end, status, appointmentId);

  /// Create a copy of BusySlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusySlotImplCopyWith<_$BusySlotImpl> get copyWith =>
      __$$BusySlotImplCopyWithImpl<_$BusySlotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusySlotImplToJson(
      this,
    );
  }
}

abstract class _BusySlot implements BusySlot {
  const factory _BusySlot(
      {@JsonKey(name: 'service_id') final String? serviceId,
      required final String date,
      required final String start,
      required final String end,
      required final String status,
      @JsonKey(name: 'appointment_id')
      required final String appointmentId}) = _$BusySlotImpl;

  factory _BusySlot.fromJson(Map<String, dynamic> json) =
      _$BusySlotImpl.fromJson;

  @override
  @JsonKey(name: 'service_id')
  String? get serviceId;
  @override
  String get date;
  @override
  String get start;
  @override
  String get end;
  @override
  String get status;
  @override
  @JsonKey(name: 'appointment_id')
  String get appointmentId;

  /// Create a copy of BusySlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusySlotImplCopyWith<_$BusySlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceAvailability _$ServiceAvailabilityFromJson(Map<String, dynamic> json) {
  return _ServiceAvailability.fromJson(json);
}

/// @nodoc
mixin _$ServiceAvailability {
  @JsonKey(name: 'service_id')
  String get serviceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'working_hours')
  Map<String, List<String>> get workingHours =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'break_times')
  List<Map<String, String>> get breakTimes =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'is_available')
  bool get isAvailable => throw _privateConstructorUsedError;

  /// Serializes this ServiceAvailability to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceAvailability
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceAvailabilityCopyWith<ServiceAvailability> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceAvailabilityCopyWith<$Res> {
  factory $ServiceAvailabilityCopyWith(
          ServiceAvailability value, $Res Function(ServiceAvailability) then) =
      _$ServiceAvailabilityCopyWithImpl<$Res, ServiceAvailability>;
  @useResult
  $Res call(
      {@JsonKey(name: 'service_id') String serviceId,
      @JsonKey(name: 'working_hours') Map<String, List<String>> workingHours,
      @JsonKey(name: 'break_times') List<Map<String, String>> breakTimes,
      @JsonKey(name: 'is_available') bool isAvailable});
}

/// @nodoc
class _$ServiceAvailabilityCopyWithImpl<$Res, $Val extends ServiceAvailability>
    implements $ServiceAvailabilityCopyWith<$Res> {
  _$ServiceAvailabilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceAvailability
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? workingHours = null,
    Object? breakTimes = null,
    Object? isAvailable = null,
  }) {
    return _then(_value.copyWith(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      workingHours: null == workingHours
          ? _value.workingHours
          : workingHours // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      breakTimes: null == breakTimes
          ? _value.breakTimes
          : breakTimes // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceAvailabilityImplCopyWith<$Res>
    implements $ServiceAvailabilityCopyWith<$Res> {
  factory _$$ServiceAvailabilityImplCopyWith(_$ServiceAvailabilityImpl value,
          $Res Function(_$ServiceAvailabilityImpl) then) =
      __$$ServiceAvailabilityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'service_id') String serviceId,
      @JsonKey(name: 'working_hours') Map<String, List<String>> workingHours,
      @JsonKey(name: 'break_times') List<Map<String, String>> breakTimes,
      @JsonKey(name: 'is_available') bool isAvailable});
}

/// @nodoc
class __$$ServiceAvailabilityImplCopyWithImpl<$Res>
    extends _$ServiceAvailabilityCopyWithImpl<$Res, _$ServiceAvailabilityImpl>
    implements _$$ServiceAvailabilityImplCopyWith<$Res> {
  __$$ServiceAvailabilityImplCopyWithImpl(_$ServiceAvailabilityImpl _value,
      $Res Function(_$ServiceAvailabilityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceAvailability
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? workingHours = null,
    Object? breakTimes = null,
    Object? isAvailable = null,
  }) {
    return _then(_$ServiceAvailabilityImpl(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      workingHours: null == workingHours
          ? _value._workingHours
          : workingHours // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      breakTimes: null == breakTimes
          ? _value._breakTimes
          : breakTimes // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceAvailabilityImpl implements _ServiceAvailability {
  const _$ServiceAvailabilityImpl(
      {@JsonKey(name: 'service_id') required this.serviceId,
      @JsonKey(name: 'working_hours')
      final Map<String, List<String>> workingHours = const {},
      @JsonKey(name: 'break_times')
      final List<Map<String, String>> breakTimes = const [],
      @JsonKey(name: 'is_available') this.isAvailable = true})
      : _workingHours = workingHours,
        _breakTimes = breakTimes;

  factory _$ServiceAvailabilityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceAvailabilityImplFromJson(json);

  @override
  @JsonKey(name: 'service_id')
  final String serviceId;
  final Map<String, List<String>> _workingHours;
  @override
  @JsonKey(name: 'working_hours')
  Map<String, List<String>> get workingHours {
    if (_workingHours is EqualUnmodifiableMapView) return _workingHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_workingHours);
  }

  final List<Map<String, String>> _breakTimes;
  @override
  @JsonKey(name: 'break_times')
  List<Map<String, String>> get breakTimes {
    if (_breakTimes is EqualUnmodifiableListView) return _breakTimes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_breakTimes);
  }

  @override
  @JsonKey(name: 'is_available')
  final bool isAvailable;

  @override
  String toString() {
    return 'ServiceAvailability(serviceId: $serviceId, workingHours: $workingHours, breakTimes: $breakTimes, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceAvailabilityImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            const DeepCollectionEquality()
                .equals(other._workingHours, _workingHours) &&
            const DeepCollectionEquality()
                .equals(other._breakTimes, _breakTimes) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serviceId,
      const DeepCollectionEquality().hash(_workingHours),
      const DeepCollectionEquality().hash(_breakTimes),
      isAvailable);

  /// Create a copy of ServiceAvailability
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceAvailabilityImplCopyWith<_$ServiceAvailabilityImpl> get copyWith =>
      __$$ServiceAvailabilityImplCopyWithImpl<_$ServiceAvailabilityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceAvailabilityImplToJson(
      this,
    );
  }
}

abstract class _ServiceAvailability implements ServiceAvailability {
  const factory _ServiceAvailability(
      {@JsonKey(name: 'service_id') required final String serviceId,
      @JsonKey(name: 'working_hours')
      final Map<String, List<String>> workingHours,
      @JsonKey(name: 'break_times') final List<Map<String, String>> breakTimes,
      @JsonKey(name: 'is_available')
      final bool isAvailable}) = _$ServiceAvailabilityImpl;

  factory _ServiceAvailability.fromJson(Map<String, dynamic> json) =
      _$ServiceAvailabilityImpl.fromJson;

  @override
  @JsonKey(name: 'service_id')
  String get serviceId;
  @override
  @JsonKey(name: 'working_hours')
  Map<String, List<String>> get workingHours;
  @override
  @JsonKey(name: 'break_times')
  List<Map<String, String>> get breakTimes;
  @override
  @JsonKey(name: 'is_available')
  bool get isAvailable;

  /// Create a copy of ServiceAvailability
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceAvailabilityImplCopyWith<_$ServiceAvailabilityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
