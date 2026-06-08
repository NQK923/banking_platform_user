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
  Future<void> clearSession() async {
    _storage.clear();
  }
}

class MockAuthApi implements AuthApi {
  String? lastCurrentPin;
  String? lastNewPin;
  bool changePinCalled = false;
  bool shouldChangePinFail = false;

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

  @override
  Future<void> changePin(String currentPin, String newPin) async {
    lastCurrentPin = currentPin;
    lastNewPin = newPin;
    changePinCalled = true;
    if (shouldChangePinFail) {
      throw const AppException(
        code: 'PIN_INVALID',
        message: 'Mã PIN hiện tại không chính xác. Vui lòng thử lại.',
      );
    }
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

  group('Profile & PIN Change Tests', () {
    test('changePin delegates to AuthApi and verifies payload', () async {
      final container = createContainer();
      final authRepo = container.read(authRepositoryProvider);

      await authRepo.changePin('123456', '654321');

      expect(mockAuthApi.changePinCalled, isTrue);
      expect(mockAuthApi.lastCurrentPin, '123456');
      expect(mockAuthApi.lastNewPin, '654321');
    });

    test('changePin propagates AuthApi PIN_INVALID exception', () async {
      final container = createContainer();
      final authRepo = container.read(authRepositoryProvider);

      mockAuthApi.shouldChangePinFail = true;

      expect(
        () => authRepo.changePin('999999', '654321'),
        throwsA(
          isA<AppException>().having((e) => e.code, 'code', 'PIN_INVALID'),
        ),
      );
    });

    test(
      'verifyPin delegates directly to AuthApi without local fakes',
      () async {
        final container = createContainer();
        final authRepo = container.read(authRepositoryProvider);

        await mockAuthTokenStorage.saveSession(
          accessToken: 'access',
          refreshToken: 'refresh',
          userId: 'test-user-id',
        );

        final success = await authRepo.verifyPin('123456');
        expect(success, isTrue);

        final fail = await authRepo.verifyPin('999999');
        expect(fail, isFalse);
      },
    );
  });
}
