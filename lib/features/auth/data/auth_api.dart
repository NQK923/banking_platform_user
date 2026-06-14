import '../../../core/network/api_client.dart';
import '../domain/auth_models.dart';

class AuthApi {
  final ApiClient _apiClient;

  AuthApi(this._apiClient);

  Future<AuthResponse> login(LoginRequest request) async {
    final response = await _apiClient.post(
      '/api/auth/login',
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    final response = await _apiClient.post(
      '/api/auth/register',
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<AuthResponse> refresh(RefreshRequest request) async {
    final response = await _apiClient.post(
      '/api/auth/refresh',
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> resetPassword({
    required String identifier,
    required String pin,
    required String newPassword,
  }) async {
    await _apiClient.post(
      '/api/auth/password/reset',
      data: {'identifier': identifier, 'pin': pin, 'newPassword': newPassword},
    );
  }

  Future<bool> verifyPin(PinVerifyRequest request) async {
    final response = await _apiClient.post(
      '/api/auth/pin/verify',
      data: request.toJson(),
    );
    return response.statusCode == 200;
  }

  Future<void> changePin(String currentPin, String newPin) async {
    await _apiClient.post(
      '/api/accounts/pin/change',
      data: {'currentPin': currentPin, 'newPin': newPin},
    );
  }
}
