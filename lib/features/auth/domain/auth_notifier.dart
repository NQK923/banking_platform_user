import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/network/api_client.dart';
import '../data/auth_repository.dart';
import 'auth_state.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final AuthRepository _authRepository;

  @override
  AuthState build() {
    _authRepository = ref.watch(authRepositoryProvider);

    // Watch session expired broadcast and auto-logout
    ref.listen<bool>(sessionExpiredProvider, (previous, next) {
      if (next) {
        logout();
        ref.read(sessionExpiredProvider.notifier).state = false;
      }
    });

    _initSession();

    return const AuthState.initializing();
  }

  Future<void> _initSession() async {
    try {
      final hasSession = await _authRepository.hasSession();
      if (state is! AuthStateInitializing) return;

      if (hasSession) {
        final userId = await _authRepository.getUserId();
        final accountId = await _authRepository.getAccountId();
        if (state is! AuthStateInitializing) return;

        state = AuthState.authenticated(
          userId: userId ?? '',
          accountId: accountId,
        );
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      if (state is AuthStateInitializing) {
        state = const AuthState.unauthenticated();
      }
    }
  }

  Future<void> login(String identifier, String password) async {
    state = const AuthState.authenticating();
    try {
      final response = await _authRepository.login(identifier, password);
      state = AuthState.authenticated(
        userId: response.userId,
        accountId: response.accountId,
      );
    } on AppException catch (e) {
      state = AuthState.unauthenticated(errorMessage: e.userFriendlyMessage);
    } catch (e) {
      state = AuthState.unauthenticated(errorMessage: e.toString());
    }
  }

  Future<void> register({
    required String email,
    String? phone,
    required String password,
    required String pin,
    String? currency,
  }) async {
    state = const AuthState.authenticating();
    try {
      final response = await _authRepository.register(
        email: email,
        phone: phone,
        password: password,
        pin: pin,
        currency: currency,
      );
      state = AuthState.authenticated(
        userId: response.userId,
        accountId: response.accountId,
      );
    } on AppException catch (e) {
      state = AuthState.unauthenticated(errorMessage: e.userFriendlyMessage);
    } catch (e) {
      state = AuthState.unauthenticated(errorMessage: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
    } finally {
      state = const AuthState.unauthenticated();
    }
  }
}
