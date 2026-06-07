import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:banking_platform_user/core/error/app_exception.dart';
import 'package:banking_platform_user/core/network/api_client.dart';
import 'package:banking_platform_user/features/auth/data/auth_repository.dart';
import 'package:banking_platform_user/features/auth/data/auth_token_storage.dart';
import 'package:banking_platform_user/features/auth/data/auth_api.dart';
import 'package:banking_platform_user/features/auth/domain/auth_models.dart';

class MockAuthTokenStorage implements AuthTokenStorage {
  final Map<String, String> _storage = {};

  @override
  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String userId,
    String? accountId,
  }) async {
    _storage['access_token'] = accessToken;
    _storage['refresh_token'] = refreshToken;
    _storage['user_id'] = userId;
    if (accountId != null) {
      _storage['account_id'] = accountId;
    } else {
      _storage.remove('account_id');
    }
  }

  @override
  Future<String?> getAccessToken() async => _storage['access_token'];

  @override
  Future<String?> getRefreshToken() async => _storage['refresh_token'];

  @override
  Future<String?> getUserId() async => _storage['user_id'];

  @override
  Future<String?> getAccountId() async => _storage['account_id'];

  @override
  Future<String?> getSimulatedPin() async => _storage['simulated_pin'];

  @override
  Future<void> saveSimulatedPin(String pin) async {
    _storage['simulated_pin'] = pin;
  }

  @override
  Future<String?> getOriginalPin() async => _storage['original_pin'];

  @override
  Future<void> saveOriginalPin(String pin) async {
    _storage['original_pin'] = pin;
  }

  @override
  Future<void> clearSession() async {
    _storage.clear();
  }
}

class MockAuthApi implements AuthApi {

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    return const AuthResponse(
      accessToken: 'token',
      refreshToken: 'refresh',
      userId: 'test-user-id',
      accountId: 'test-account-id',
      roles: {'ROLE_USER'},
    );
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    return const AuthResponse(
      accessToken: 'token',
      refreshToken: 'refresh',
      userId: 'test-user-id',
      accountId: 'test-account-id',
      roles: {'ROLE_USER'},
    );
  }

  @override
  Future<AuthResponse> refresh(RefreshRequest request) async {
    return const AuthResponse(
      accessToken: 'token',
      refreshToken: 'refresh',
      userId: 'test-user-id',
      accountId: 'test-account-id',
      roles: {'ROLE_USER'},
    );
  }

  @override
  Future<bool> verifyPin(PinVerifyRequest request) async {
    if (request.pin == '123456') {
      return true;
    }
    return false;
  }
}

void main() {
  late MockAuthTokenStorage mockAuthTokenStorage;
  late MockAuthApi mockAuthApi;

  setUp(() {
    mockAuthTokenStorage = MockAuthTokenStorage();
    mockAuthApi = MockAuthApi();
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        tokenStorageProvider.overrideWithValue(mockAuthTokenStorage),
        authApiProvider.overrideWithValue(mockAuthApi),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('Profile & PIN Change Simulated Tests', () {
    test('verifyPin falls back to original registered PIN', () async {
      final container = createContainer();
      final authRepo = container.read(authRepositoryProvider);
      
      // Populate session
      await mockAuthTokenStorage.saveSession(
        accessToken: 'access',
        refreshToken: 'refresh',
        userId: 'test-user-id',
      );
      await mockAuthTokenStorage.saveOriginalPin('123456');

      // Verify original PIN succeeds
      final success = await authRepo.verifyPin('123456');
      expect(success, isTrue);

      // Verify wrong PIN fails
      final fail = await authRepo.verifyPin('000000');
      expect(fail, isFalse);
    });

    test('changePin updates simulated PIN and verifyPin intercepts it', () async {
      final container = createContainer();
      final authRepo = container.read(authRepositoryProvider);

      await mockAuthTokenStorage.saveSession(
        accessToken: 'access',
        refreshToken: 'refresh',
        userId: 'test-user-id',
      );
      await mockAuthTokenStorage.saveOriginalPin('123456');

      // Verify original works initially
      expect(await authRepo.verifyPin('123456'), isTrue);

      // Change PIN to 654321 (verifying 123456 as current)
      await authRepo.changePin('123456', '654321');

      // Verify old PIN no longer works
      expect(await authRepo.verifyPin('123456'), isFalse);

      // Verify new PIN works
      expect(await authRepo.verifyPin('654321'), isTrue);
    });

    test('changePin throws PIN_INVALID if current PIN is incorrect', () async {
      final container = createContainer();
      final authRepo = container.read(authRepositoryProvider);

      await mockAuthTokenStorage.saveSession(
        accessToken: 'access',
        refreshToken: 'refresh',
        userId: 'test-user-id',
      );
      await mockAuthTokenStorage.saveOriginalPin('123456');

      // Attempt PIN change with incorrect current PIN
      expect(
        () => authRepo.changePin('999999', '654321'),
        throwsA(isA<AppException>().having((e) => e.code, 'code', 'PIN_INVALID')),
      );

      // Verify PIN remains unchanged (123456 still works)
      expect(await authRepo.verifyPin('123456'), isTrue);
    });
  });
}
