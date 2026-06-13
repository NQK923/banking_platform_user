import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:banking_platform_user/features/auth/data/auth_repository.dart';
import 'package:banking_platform_user/features/auth/domain/auth_notifier.dart';
import 'package:banking_platform_user/features/auth/domain/auth_state.dart';
import 'package:banking_platform_user/features/auth/domain/auth_models.dart';

class MockAuthRepository implements AuthRepository {
  bool shouldSucceed = true;
  bool sessionExists = false;
  String userId = 'user-123';
  String accountId = 'account-456';
  String? errorMessage;
  Completer<bool>? hasSessionCompleter;

  @override
  Future<AuthResponse> login(String identifier, String password) async {
    if (shouldSucceed) {
      return AuthResponse(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
        userId: userId,
        accountId: accountId,
        roles: {'ROLE_USER'},
      );
    } else {
      throw Exception(errorMessage ?? 'Invalid credentials');
    }
  }

  @override
  Future<AuthResponse> register({
    required String email,
    String? phone,
    required String password,
    required String pin,
    String? currency,
  }) async {
    if (shouldSucceed) {
      return AuthResponse(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
        userId: userId,
        accountId: accountId,
        roles: {'ROLE_USER'},
      );
    } else {
      throw Exception(errorMessage ?? 'Registration failed');
    }
  }

  @override
  Future<bool> verifyPin(String pin) async => pin == '123456';

  @override
  Future<bool> hasSession() async {
    final completer = hasSessionCompleter;
    if (completer != null) {
      return completer.future;
    }
    return sessionExists;
  }

  @override
  Future<String?> getUserId() async => userId;

  @override
  Future<String?> getAccountId() async => accountId;

  @override
  Future<void> logout() async {
    sessionExists = false;
  }

  @override
  Future<void> changePin(String currentPin, String newPin) async {}

  Future<String?> getOriginalPin() async => '123456';
}

void main() {
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(mockRepository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  Future<AuthState> waitForNextState(ProviderContainer container) async {
    final completer = Completer<AuthState>();
    final sub = container.listen<AuthState>(authNotifierProvider, (
      previous,
      next,
    ) {
      if (next is! AuthStateInitializing) {
        if (!completer.isCompleted) {
          completer.complete(next);
        }
      }
    }, fireImmediately: true);
    final result = await completer.future;
    sub.close();
    return result;
  }

  group('AuthNotifier State Transition Tests', () {
    test('Initializes to unauthenticated when no session exists', () async {
      mockRepository.sessionExists = false;
      final container = createContainer();

      // Read initial state
      expect(
        container.read(authNotifierProvider),
        const AuthState.initializing(),
      );

      // Wait for initialization to complete
      final nextState = await waitForNextState(container);
      expect(nextState, const AuthState.unauthenticated());
    });

    test('Initializes to authenticated when session exists', () async {
      mockRepository.sessionExists = true;
      final container = createContainer();

      expect(
        container.read(authNotifierProvider),
        const AuthState.initializing(),
      );

      final nextState = await waitForNextState(container);
      expect(
        nextState,
        const AuthState.authenticated(
          userId: 'user-123',
          accountId: 'account-456',
        ),
      );
    });

    test('Login happy path transitions', () async {
      final container = createContainer();
      await waitForNextState(container); // wait for initialization

      expect(
        container.read(authNotifierProvider),
        const AuthState.unauthenticated(),
      );

      // Trigger login
      final future = container
          .read(authNotifierProvider.notifier)
          .login('test@email.com', 'password123');

      // Check for intermediate authenticating state
      expect(
        container.read(authNotifierProvider),
        const AuthState.authenticating(),
      );

      await future;

      // Check for authenticated state
      expect(
        container.read(authNotifierProvider),
        const AuthState.authenticated(
          userId: 'user-123',
          accountId: 'account-456',
        ),
      );
    });

    test('Login sad path transitions', () async {
      mockRepository.shouldSucceed = false;
      mockRepository.errorMessage = 'Wrong credentials';
      final container = createContainer();
      await waitForNextState(container);

      final future = container
          .read(authNotifierProvider.notifier)
          .login('test@email.com', 'wrong_pass');

      expect(
        container.read(authNotifierProvider),
        const AuthState.authenticating(),
      );

      await future;

      // Transitions back to unauthenticated with error
      expect(
        container.read(authNotifierProvider),
        const AuthState.unauthenticated(
          errorMessage: 'Exception: Wrong credentials',
        ),
      );
    });

    test('Login error is not cleared by late session initialization', () async {
      mockRepository.shouldSucceed = false;
      mockRepository.errorMessage = 'Wrong credentials';
      mockRepository.hasSessionCompleter = Completer<bool>();
      final container = createContainer();
      final sub = container.listen<AuthState>(
        authNotifierProvider,
        (previous, next) {},
        fireImmediately: true,
      );
      addTearDown(sub.close);

      final future = container
          .read(authNotifierProvider.notifier)
          .login('test@email.com', 'wrong_pass');

      await future;

      expect(
        container.read(authNotifierProvider),
        const AuthState.unauthenticated(
          errorMessage: 'Exception: Wrong credentials',
        ),
      );

      mockRepository.hasSessionCompleter!.complete(false);
      await Future<void>.delayed(Duration.zero);

      expect(
        container.read(authNotifierProvider),
        const AuthState.unauthenticated(
          errorMessage: 'Exception: Wrong credentials',
        ),
      );
    });

    test('Registration happy path transitions', () async {
      final container = createContainer();
      await waitForNextState(container);

      final future = container
          .read(authNotifierProvider.notifier)
          .register(
            email: 'new@email.com',
            password: 'password123',
            pin: '123456',
          );

      expect(
        container.read(authNotifierProvider),
        const AuthState.authenticating(),
      );

      await future;

      expect(
        container.read(authNotifierProvider),
        const AuthState.authenticated(
          userId: 'user-123',
          accountId: 'account-456',
        ),
      );
    });

    test('Logout transitions', () async {
      mockRepository.sessionExists = true;
      final container = createContainer();
      await waitForNextState(container);

      expect(
        container.read(authNotifierProvider),
        const AuthState.authenticated(
          userId: 'user-123',
          accountId: 'account-456',
        ),
      );

      await container.read(authNotifierProvider.notifier).logout();

      expect(
        container.read(authNotifierProvider),
        const AuthState.unauthenticated(),
      );
    });
  });
}
