import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

// Address Model
@freezed
class Address with _$Address {
  const factory Address({
    String? id,
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
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

// Address Create Request Model
@freezed
class AddressCreateRequest with _$AddressCreateRequest {
  const factory AddressCreateRequest({
    required String name,
    required String label,
    required String city,
    required String district,
    String? neighborhood,
    String? street,
    String? buildingNo,
    String? apartment,
    String? floor,
    required String zipCode,
    String? note,
  }) = _AddressCreateRequest;

  factory AddressCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$AddressCreateRequestFromJson(json);
}

// Address Update Request Model
@freezed
class AddressUpdateRequest with _$AddressUpdateRequest {
  const factory AddressUpdateRequest({
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
  }) = _AddressUpdateRequest;

  factory AddressUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$AddressUpdateRequestFromJson(json);
}

// Address List Response Model
@freezed
class AddressListResponse with _$AddressListResponse {
  const factory AddressListResponse({
    required List<Address> addresses,
    @JsonKey(name: 'current_address') Address? currentAddress,
  }) = _AddressListResponse;

  factory AddressListResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressListResponseFromJson(json);
}

// Address Labels Enum
enum AddressLabel {
  home('Ev'),
  work('İş'),
  other('Diğer');

  const AddressLabel(this.displayName);
  final String displayName;

  static AddressLabel fromString(String label) {
    switch (label.toLowerCase()) {
      case 'ev':
      case 'home':
        return AddressLabel.home;
      case 'iş':
      case 'work':
        return AddressLabel.work;
      default:
        return AddressLabel.other;
    }
  }
}

// Turkish Cities List
class TurkishCities {
  static const List<String> cities = [
    'Adana',
    'Adıyaman',
    'Afyonkarahisar',
    'Ağrı',
    'Amasya',
    'Ankara',
    'Antalya',
    'Artvin',
    'Aydın',
    'Balıkesir',
    'Bilecik',
    'Bingöl',
    'Bitlis',
    'Bolu',
    'Burdur',
    'Bursa',
    'Çanakkale',
    'Çankırı',
    'Çorum',
    'Denizli',
    'Diyarbakır',
    'Edirne',
    'Elazığ',
    'Erzincan',
    'Erzurum',
    'Eskişehir',
    'Gaziantep',
    'Giresun',
    'Gümüşhane',
    'Hakkâri',
    'Hatay',
    'Isparta',
    'Mersin',
    'İstanbul',
    'İzmir',
    'Kars',
    'Kastamonu',
    'Kayseri',
    'Kırklareli',
    'Kırşehir',
    'Kocaeli',
    'Konya',
    'Kütahya',
    'Malatya',
    'Manisa',
    'Kahramanmaraş',
    'Mardin',
    'Muğla',
    'Muş',
    'Nevşehir',
    'Niğde',
    'Ordu',
    'Rize',
    'Sakarya',
    'Samsun',
    'Siirt',
    'Sinop',
    'Sivas',
    'Tekirdağ',
    'Tokat',
    'Trabzon',
    'Tunceli',
    'Şanlıurfa',
    'Uşak',
    'Van',
    'Yozgat',
    'Zonguldak',
    'Aksaray',
    'Bayburt',
    'Karaman',
    'Kırıkkale',
    'Batman',
    'Şırnak',
    'Bartın',
    'Ardahan',
    'Iğdır',
    'Yalova',
    'Karabük',
    'Kilis',
    'Osmaniye',
    'Düzce',
  ];
}
