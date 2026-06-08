import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/network/api_client.dart';
import 'auth_api.dart';
import 'auth_token_storage.dart';
import '../domain/auth_models.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi(ref.watch(apiClientProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(authApiProvider),
    ref.watch(tokenStorageProvider),
  );
});

class AuthRepository {
  final AuthApi _authApi;
  final AuthTokenStorage _tokenStorage;

  AuthRepository(this._authApi, this._tokenStorage);

  Future<AuthResponse> login(String identifier, String password) async {
    final response = await _authApi.login(
      LoginRequest(identifier: identifier, password: password),
    );
    await _tokenStorage.saveSession(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
      userId: response.userId,
      accountId: response.accountId,
    );
    return response;
  }

  Future<AuthResponse> register({
    required String email,
    String? phone,
    required String password,
    required String pin,
    String? currency,
  }) async {
    final response = await _authApi.register(
      RegisterRequest(
        email: email,
        phone: phone,
        password: password,
        pin: pin,
        currency: currency,
      ),
    );
    await _tokenStorage.saveSession(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
      userId: response.userId,
      accountId: response.accountId,
    );
    return response;
  }

  Future<bool> verifyPin(String pin) async {
    final userId = await _tokenStorage.getUserId();
    if (userId == null) return false;

    return await _authApi.verifyPin(PinVerifyRequest(userId: userId, pin: pin));
  }

  Future<void> changePin(String currentPin, String newPin) async {
    await _authApi.changePin(currentPin, newPin);
  }

  Future<bool> hasSession() async {
    final token = await _tokenStorage.getAccessToken();
    final userId = await _tokenStorage.getUserId();
    return token != null && userId != null;
  }

  Future<String?> getUserId() => _tokenStorage.getUserId();
  Future<String?> getAccountId() => _tokenStorage.getAccountId();

  Future<void> logout() async {
    await _tokenStorage.clearSession();
  }
}
