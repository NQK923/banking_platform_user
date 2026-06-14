import 'package:banking_platform_user/features/auth/data/auth_api.dart';
import 'package:banking_platform_user/features/auth/data/auth_repository.dart';
import 'package:banking_platform_user/features/auth/data/auth_token_storage.dart';
import 'package:banking_platform_user/features/auth/domain/auth_models.dart';
import 'package:banking_platform_user/features/auth/presentation/forgot_password_screen.dart';
import 'package:banking_platform_user/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('forgot password submits reset payload and returns to login', (
    tester,
  ) async {
    final repository = RecordingAuthRepository();
    final router = GoRouter(
      initialLocation: '/forgot-password',
      routes: [
        GoRoute(
          path: '/forgot-password',
          builder: (_, __) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (_, __) => const Scaffold(body: Text('Login route')),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email or phone'),
      'reset-user@example.test',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Transaction PIN'),
      '123456',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'New password'),
      'NewPassword123!',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Confirm password'),
      'NewPassword123!',
    );

    await tester.ensureVisible(
      find.widgetWithText(FilledButton, 'Reset password'),
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Reset password'));
    await tester.pumpAndSettle();

    expect(repository.identifier, 'reset-user@example.test');
    expect(repository.pin, '123456');
    expect(repository.newPassword, 'NewPassword123!');
    expect(find.text('Login route'), findsOneWidget);
  });
}

class RecordingAuthRepository extends AuthRepository {
  String? identifier;
  String? pin;
  String? newPassword;

  RecordingAuthRepository() : super(_NoopAuthApi(), _NoopAuthTokenStorage());

  @override
  Future<void> resetPassword({
    required String identifier,
    required String pin,
    required String newPassword,
  }) async {
    this.identifier = identifier;
    this.pin = pin;
    this.newPassword = newPassword;
  }
}

class _NoopAuthApi implements AuthApi {
  @override
  Future<AuthResponse> login(LoginRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<AuthResponse> refresh(RefreshRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword({
    required String identifier,
    required String pin,
    required String newPassword,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> changePin(String currentPin, String newPin) {
    throw UnimplementedError();
  }

  @override
  Future<bool> verifyPin(PinVerifyRequest request) {
    throw UnimplementedError();
  }
}

class _NoopAuthTokenStorage implements AuthTokenStorage {
  @override
  Future<void> clearSession() async {}

  @override
  Future<String?> getAccessToken() async => null;

  @override
  Future<String?> getAccountId() async => null;

  @override
  Future<String?> getRefreshToken() async => null;

  @override
  Future<String?> getUserId() async => null;

  @override
  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String userId,
    String? accountId,
  }) async {}
}
