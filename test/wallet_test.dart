import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:banking_platform_user/core/error/app_exception.dart';
import 'package:banking_platform_user/features/auth/data/auth_repository.dart';
import 'package:banking_platform_user/features/auth/domain/auth_models.dart';
import 'package:banking_platform_user/features/wallet/data/wallet_repository.dart';
import 'package:banking_platform_user/features/wallet/domain/wallet_models.dart';
import 'package:banking_platform_user/features/wallet/domain/deposit_notifier.dart';
import 'package:banking_platform_user/features/wallet/domain/withdraw_notifier.dart';
import 'package:banking_platform_user/features/transfer/domain/transfer_models.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Future<String?> getAccountId() async => 'test-account-id';

  @override
  Future<String?> getUserId() async => 'test-user-id';

  @override
  Future<bool> hasSession() async => true;

  @override
  Future<void> logout() async {}

  @override
  Future<AuthResponse> login(String identifier, String password) async {
    return const AuthResponse(
      accessToken: 'token',
      refreshToken: 'refresh',
      userId: 'test-user-id',
      accountId: 'test-account-id',
      roles: {'ROLE_USER'},
    );
  }

  @override
  Future<AuthResponse> register({
    required String email,
    String? phone,
    required String password,
    required String pin,
    String? currency,
  }) async {
    return const AuthResponse(
      accessToken: 'token',
      refreshToken: 'refresh',
      userId: 'test-user-id',
      accountId: 'test-account-id',
      roles: {'ROLE_USER'},
    );
  }

  @override
  Future<void> requestPasswordResetOtp({required String identifier}) async {}

  @override
  Future<void> resetPassword({
    required String identifier,
    required String otp,
    required String newPassword,
  }) async {}

  @override
  Future<bool> verifyPin(String pin) async => pin == '123456';

  @override
  Future<void> changePin(String currentPin, String newPin) async {}
}

class MockWalletRepository implements WalletRepository {
  MovementResponse? movementResult;
  AppException? walletError;
  int balanceCallCount = 0;

  int depositCallCount = 0;
  String? lastDepositKey;

  int withdrawCallCount = 0;
  String? lastWithdrawKey;
  String? lastWithdrawPin;

  @override
  Future<BalanceResponse> getBalance() async {
    balanceCallCount++;
    return BalanceResponse(
      accountId: 'test-account-id',
      balance: Decimal.parse('500000.0000'),
      currency: 'VND',
    );
  }

  @override
  Future<AccountRecord> getAccountDetails() async {
    return const AccountRecord(
      id: 'test-account-id',
      userId: 'test-user-id',
      code: 'test@email.com',
      currency: 'VND',
      kind: AccountKind.USER,
      status: AccountStatus.ACTIVE,
      version: 1,
      createdAt: '2026-06-07T00:00:00Z',
    );
  }

  @override
  Future<MovementResponse> deposit(String amount, String idempotencyKey) async {
    depositCallCount++;
    lastDepositKey = idempotencyKey;
    if (walletError != null) throw walletError!;
    if (movementResult != null) return movementResult!;
    throw const AppException(code: 'INTERNAL', message: 'Deposit failed');
  }

  @override
  Future<MovementResponse> withdraw(
    String amount,
    String pin,
    String idempotencyKey,
  ) async {
    withdrawCallCount++;
    lastWithdrawPin = pin;
    lastWithdrawKey = idempotencyKey;
    if (walletError != null) throw walletError!;
    if (movementResult != null) return movementResult!;
    throw const AppException(code: 'INTERNAL', message: 'Withdrawal failed');
  }
}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockWalletRepository mockWalletRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockWalletRepository = MockWalletRepository();
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
        walletRepositoryProvider.overrideWithValue(mockWalletRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('DepositNotifier Tests', () {
    test('Initial state is idle', () {
      final container = createContainer();
      final state = container.read(depositNotifierProvider);
      expect(state.status, DepositStatus.idle);
      expect(state.response, isNull);
      expect(state.errorMessage, isNull);
    });

    test('Successful deposit transitions to success', () async {
      final container = createContainer();
      container.listen(depositNotifierProvider, (previous, next) {});

      final successResponse = MovementResponse(
        journalId: 'journal-123',
        balance: BalanceResponse(
          accountId: 'test-account-id',
          balance: Decimal.zero,
          currency: 'VND',
        ),
      );
      mockWalletRepository.movementResult = successResponse;

      final notifier = container.read(depositNotifierProvider.notifier);
      final future = notifier.submitDeposit('100000');

      expect(
        container.read(depositNotifierProvider).status,
        DepositStatus.submitting,
      );
      await future;

      final state = container.read(depositNotifierProvider);
      expect(state.status, DepositStatus.success);
      expect(state.response, successResponse);
      expect(mockWalletRepository.balanceCallCount, 2);
    });

    test(
      'Failed deposit transitions to error, and retry uses the same idempotency key',
      () async {
        final container = createContainer();
        container.listen(depositNotifierProvider, (previous, next) {});

        mockWalletRepository.walletError = const AppException(
          code: 'RATE_LIMITED',
          message: 'Too fast',
        );

        final notifier = container.read(depositNotifierProvider.notifier);
        await notifier.submitDeposit('100000');

        var state = container.read(depositNotifierProvider);
        expect(state.status, DepositStatus.error);
        expect(
          state.errorMessage,
          'Yêu cầu quá nhanh. Vui lòng thử lại sau ít phút.',
        );
        expect(mockWalletRepository.depositCallCount, 1);

        final initialKey = mockWalletRepository.lastDepositKey;
        expect(initialKey, isNotNull);

        // Perform a retry
        mockWalletRepository.walletError = null;
        final successResponse = MovementResponse(
          journalId: 'journal-123',
          balance: BalanceResponse(
            accountId: 'test-account-id',
            balance: Decimal.zero,
            currency: 'VND',
          ),
        );
        mockWalletRepository.movementResult = successResponse;

        await notifier.retryDeposit();

        state = container.read(depositNotifierProvider);
        expect(state.status, DepositStatus.success);
        expect(mockWalletRepository.depositCallCount, 2);
        expect(mockWalletRepository.lastDepositKey, initialKey); // REUSED KEY
      },
    );
  });

  group('WithdrawNotifier Tests', () {
    test('Initial state is idle', () {
      final container = createContainer();
      final state = container.read(withdrawNotifierProvider);
      expect(state.status, WithdrawStatus.idle);
    });

    test('Successful withdraw transitions to success', () async {
      final container = createContainer();
      container.listen(withdrawNotifierProvider, (previous, next) {});

      final successResponse = MovementResponse(
        journalId: 'journal-456',
        balance: BalanceResponse(
          accountId: 'test-account-id',
          balance: Decimal.zero,
          currency: 'VND',
        ),
      );
      mockWalletRepository.movementResult = successResponse;

      final notifier = container.read(withdrawNotifierProvider.notifier);
      final future = notifier.submitWithdraw('50000', '123456');

      expect(
        container.read(withdrawNotifierProvider).status,
        WithdrawStatus.submitting,
      );
      await future;

      final state = container.read(withdrawNotifierProvider);
      expect(state.status, WithdrawStatus.success);
      expect(state.response, successResponse);
      expect(
        mockWalletRepository.lastWithdrawPin,
        '123456',
      ); // PIN passed through
      expect(mockWalletRepository.balanceCallCount, 2);
    });

    test(
      'Failed withdraw transitions to error, and retry uses same PIN and key',
      () async {
        final container = createContainer();
        container.listen(withdrawNotifierProvider, (previous, next) {});

        mockWalletRepository.walletError = const AppException(
          code: 'INSUFFICIENT_FUNDS',
          message: 'No cash',
        );

        final notifier = container.read(withdrawNotifierProvider.notifier);
        await notifier.submitWithdraw('200000', '123456');

        var state = container.read(withdrawNotifierProvider);
        expect(state.status, WithdrawStatus.error);
        expect(
          state.errorMessage,
          'Số dư tài khoản không đủ để thực hiện giao dịch.',
        );
        expect(mockWalletRepository.withdrawCallCount, 1);

        final initialKey = mockWalletRepository.lastWithdrawKey;
        expect(initialKey, isNotNull);

        // Perform a retry
        mockWalletRepository.walletError = null;
        final successResponse = MovementResponse(
          journalId: 'journal-456',
          balance: BalanceResponse(
            accountId: 'test-account-id',
            balance: Decimal.zero,
            currency: 'VND',
          ),
        );
        mockWalletRepository.movementResult = successResponse;

        await notifier.retryWithdraw();

        state = container.read(withdrawNotifierProvider);
        expect(state.status, WithdrawStatus.success);
        expect(mockWalletRepository.withdrawCallCount, 2);
        expect(mockWalletRepository.lastWithdrawPin, '123456'); // PIN retained
        expect(mockWalletRepository.lastWithdrawKey, initialKey); // KEY REUSED
      },
    );
  });
}
