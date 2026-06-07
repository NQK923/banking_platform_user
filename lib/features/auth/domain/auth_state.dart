import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initializing() = AuthStateInitializing;
  const factory AuthState.unauthenticated({String? errorMessage}) = AuthStateUnauthenticated;
  const factory AuthState.authenticating() = AuthStateAuthenticating;
  const factory AuthState.authenticated({
    required String userId,
    String? accountId,
  }) = AuthStateAuthenticated;
}
