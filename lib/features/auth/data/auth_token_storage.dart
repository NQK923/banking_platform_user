import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthTokenStorage {
  final FlutterSecureStorage _secureStorage;

  AuthTokenStorage(this._secureStorage);

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userIdKey = 'user_id';
  static const _accountIdKey = 'account_id';

  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String userId,
    String? accountId,
  }) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
    await _secureStorage.write(key: _userIdKey, value: userId);
    if (accountId != null) {
      await _secureStorage.write(key: _accountIdKey, value: accountId);
    } else {
      await _secureStorage.delete(key: _accountIdKey);
    }
  }

  Future<String?> getAccessToken() => _secureStorage.read(key: _accessTokenKey);
  Future<String?> getRefreshToken() =>
      _secureStorage.read(key: _refreshTokenKey);
  Future<String?> getUserId() => _secureStorage.read(key: _userIdKey);
  Future<String?> getAccountId() => _secureStorage.read(key: _accountIdKey);

  Future<void> clearSession() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
    await _secureStorage.delete(key: _userIdKey);
    await _secureStorage.delete(key: _accountIdKey);
  }
}
