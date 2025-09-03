import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_model.freezed.dart';

@freezed
class Service with _$Service {
  const factory Service({
    required String id,
    required String title,
    required String description,
    String? image,
    @Default(false) bool isUpcoming,
    @Default(false) bool isDeleted,
    DateTime? createdAt,
    @Default('service') String kind,
  }) = _Service;

  factory Service.fromJson(Map<String, dynamic> json) {
    // Manual parsing to avoid freezed conflicts
    return Service(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: json['image'] as String?,
      isUpcoming: json['is_upcoming'] as bool? ?? false,
      isDeleted: json['is_deleted'] as bool? ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      kind: json['kind'] as String? ?? 'service',
    );
  }
}

@freezed
class ServiceListResponse with _$ServiceListResponse {
  const factory ServiceListResponse({
    @Default([]) List<Service> services,
  }) = _ServiceListResponse;

  factory ServiceListResponse.fromJson(Map<String, dynamic> json) {
    // Manual parsing to avoid freezed conflicts
    final servicesList = json['services'] as List<dynamic>? ?? [];
    final parsedServices = servicesList
        .map((service) => Service.fromJson(service as Map<String, dynamic>))
        .toList();

    return ServiceListResponse(
      services: parsedServices,
    );
  }
}
