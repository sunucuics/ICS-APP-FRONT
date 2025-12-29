import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    String? name,
    required String email,
    String? phone,
    @Default('customer') String role,
    @Default([]) List<Address> addresses,
    @Default(false) bool isGuest,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    String? id, // Made optional since backend might not return it
    String? label,
    String? name,
    required String city,
    required String zipCode,
    required String district,
    String? neighborhood,
    String? street,
    String? buildingNo,
    String? floor,
    String? apartment,
    String? note,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@freezed
class AddressCreate with _$AddressCreate {
  const factory AddressCreate({
    String? label,
    String? name,
    required String city,
    required String zipCode,
    required String district,
    String? neighborhood,
    String? street,
    String? buildingNo,
    String? floor,
    String? apartment,
    String? note,
  }) = _AddressCreate;

  factory AddressCreate.fromJson(Map<String, dynamic> json) =>
      _$AddressCreateFromJson(json);
}

// Auth related models
@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String name,
    String? phone,
    required String email,
    required String password,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}

@freezed
class ProfileUpdateRequest with _$ProfileUpdateRequest {
  const factory ProfileUpdateRequest({
    String? name,
    String? phone,
    String? email,
  }) = _ProfileUpdateRequest;

  factory ProfileUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateRequestFromJson(json);
}

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String userId,
    required UserProfile user,
    required String idToken,
    required String refreshToken,
    required int expiresIn,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson({
        'userId': json['user_id'],
        'user': json['user'], // This will be set manually in AuthApiService
        'idToken': json['id_token'],
        'refreshToken': json['refresh_token'],
        'expiresIn': json['expires_in'],
      });
}
