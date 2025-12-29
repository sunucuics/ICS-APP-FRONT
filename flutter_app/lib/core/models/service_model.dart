import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_model.freezed.dart';

@freezed
class Service with _$Service {
  const factory Service({
    required String id,
    required String title,
    required String description,
    String? image, // Geri uyumluluk için
    @Default([]) List<String> images, // YENİ: 0-3 görsel array
    @Default(false) bool isUpcoming,
    @Default(false) bool isDeleted,
    DateTime? createdAt,
    @Default('service') String kind,
  }) = _Service;

  factory Service.fromJson(Map<String, dynamic> json) {
    // Manual parsing to avoid freezed conflicts
    // images array'i parse et
    List<String> imagesList = [];
    if (json['images'] != null && json['images'] is List) {
      imagesList = (json['images'] as List)
          .whereType<String>()
          .where((url) => url.isNotEmpty)
          .toList();
    }
    // Geri uyumluluk: image varsa ve images boşsa, image'ı ekle
    if (imagesList.isEmpty && json['image'] != null) {
      final imageUrl = json['image'] as String;
      if (imageUrl.isNotEmpty) {
        imagesList = [imageUrl];
      }
    }
    
    // image field: images array'in ilk elemanı veya json'dan gelen image
    final imageField = imagesList.isNotEmpty 
        ? imagesList.first 
        : json['image'] as String?;
    
    return Service(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: imageField,
      images: imagesList,
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
