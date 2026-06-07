import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String email,
    String? phone,
    required String password,
    required String pin,
    String? currency,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String identifier,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

@freezed
class RefreshRequest with _$RefreshRequest {
  const factory RefreshRequest({
    required String userId,
    required String refreshToken,
  }) = _RefreshRequest;

  factory RefreshRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshRequestFromJson(json);
}

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String accessToken,
    required String refreshToken,
    required String userId,
    String? accountId,
    required Set<String> roles,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

@freezed
class PinVerifyRequest with _$PinVerifyRequest {
  const factory PinVerifyRequest({
    required String userId,
    required String pin,
  }) = _PinVerifyRequest;

  factory PinVerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$PinVerifyRequestFromJson(json);
}
