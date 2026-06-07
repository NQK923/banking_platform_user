import 'dart:async';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fake_async/fake_async.dart';

import 'package:banking_platform_user/core/error/app_exception.dart';
import 'package:banking_platform_user/features/auth/data/auth_repository.dart';
import 'package:banking_platform_user/features/auth/domain/auth_models.dart';
import 'package:banking_platform_user/features/history/data/history_repository.dart';
import 'package:banking_platform_user/features/history/domain/wallet_transaction.dart';
import 'package:banking_platform_user/features/transfer/data/transfer_repository.dart';
import 'package:banking_platform_user/features/transfer/domain/transfer_models.dart';
import 'package:banking_platform_user/features/transfer/domain/transfer_notifier.dart';
import 'package:banking_platform_user/features/transfer/domain/transfer_state.dart';
import 'package:banking_platform_user/features/wallet/data/wallet_repository.dart';
import 'package:banking_platform_user/features/wallet/domain/balance_provider.dart';
import 'package:banking_platform_user/features/wallet/domain/wallet_models.dart';

class MockAuthRepository implements AuthRepository {
  String currentAccountId = 'sender-account-id';

  @override
  Future<String?> getAccountId() async => currentAccountId;

  @override
  Future<String?> getUserId() async => 'sender-user-id';

  @override
  Future<bool> hasSession() async => true;

  @override
  Future<void> logout() async {}

  @override
  Future<AuthResponse> login(String identifier, String password) async {
    return const AuthResponse(
      accessToken: 'token',
      refreshToken: 'refresh',
      userId: 'sender-user-id',
      accountId: 'sender-account-id',
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
      userId: 'sender-user-id',
      accountId: 'sender-account-id',
      roles: {'ROLE_USER'},
    );
  }

  @override
  Future<bool> verifyPin(String pin) async => pin == '123456';

  @override
  Future<void> changePin(String currentPin, String newPin) async {}

  @override
  Future<String?> getOriginalPin() async => '123456';
}

class MockTransferRepository implements TransferRepository {
  AccountRecord? lookupResult;
  AppException? lookupError;
  WalletTransaction? transferResult;
  AppException? transferError;

  @override
  Future<AccountRecord> lookupRecipient({String? email, String? phone}) async {
    if (lookupError != null) {
      throw lookupError!;
    }
    if (lookupResult != null) {
      return lookupResult!;
    }
    throw const AppException(code: 'RECIPIENT_NOT_FOUND', message: 'Not found');
  }

  @override
  Future<WalletTransaction> initiateTransfer(TransferRequest request) async {
    if (transferError != null) {
      throw transferError!;
    }
    if (transferResult != null) {
      return transferResult!;
    }
    throw const AppException(code: 'INTERNAL', message: 'Transfer initiation failed');
  }
}

class MockHistoryRepository implements HistoryRepository {
  final Map<String, WalletTransaction> transactions = {};
  int getDetailCallCount = 0;

  @override
  Future<List<WalletTransaction>> getHistory() async => transactions.values.toList();

  @override
  Future<WalletTransaction> getTransactionDetail(String transactionId) async {
    getDetailCallCount++;
    final tx = transactions[transactionId];
    if (tx != null) {
      return tx;
    }
    throw const AppException(code: 'TRANSACTION_NOT_FOUND', message: 'Transaction not found');
  }
}

class MockWalletRepository implements WalletRepository {
  int getBalanceCallCount = 0;
  Decimal balanceValue = Decimal.parse('1000000.0000');

  @override
  Future<BalanceResponse> getBalance() async {
    getBalanceCallCount++;
    return BalanceResponse(
      accountId: 'sender-account-id',
      balance: balanceValue,
      currency: 'VND',
    );
  }

  @override
  Future<AccountRecord> getAccountDetails() async {
    return AccountRecord(
      id: 'sender-account-id',
      userId: 'sender-user-id',
      code: 'sender@email.com',
      currency: 'VND',
      kind: AccountKind.USER,
      status: AccountStatus.ACTIVE,
      version: 1,
      createdAt: '2026-06-07T00:00:00Z',
    );
  }

  @override
  Future<MovementResponse> deposit(String amount) async {
    return MovementResponse(
      journalId: 'journal-dep',
      balance: BalanceResponse(
        accountId: 'sender-account-id',
        balance: balanceValue,
        currency: 'VND',
      ),
    );
  }

  @override
  Future<MovementResponse> withdraw(String amount) async {
    return MovementResponse(
      journalId: 'journal-with',
      balance: BalanceResponse(
        accountId: 'sender-account-id',
        balance: balanceValue,
        currency: 'VND',
      ),
    );
  }
}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockTransferRepository mockTransferRepository;
  late MockHistoryRepository mockHistoryRepository;
  late MockWalletRepository mockWalletRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockTransferRepository = MockTransferRepository();
    mockHistoryRepository = MockHistoryRepository();
    mockWalletRepository = MockWalletRepository();
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
        transferRepositoryProvider.overrideWithValue(mockTransferRepository),
        historyRepositoryProvider.overrideWithValue(mockHistoryRepository),
        walletRepositoryProvider.overrideWithValue(mockWalletRepository),
      ],
    );
    container.listen(transferProvider, (previous, next) {});
    addTearDown(container.dispose);
    return container;
  }

  group('TransferNotifier State & Polling Tests', () {
    test('Initial state is idle', () {
      final container = createContainer();
      expect(container.read(transferProvider), const TransferState.idle());
    });

    test('Successful recipient lookup transitions to checked', () async {
      final container = createContainer();
      final recipient = AccountRecord(
        id: 'recipient-account-id',
        userId: 'recipient-user-id',
        code: 'recipient@email.com',
        currency: 'VND',
        kind: AccountKind.USER,
        status: AccountStatus.ACTIVE,
        version: 1,
        createdAt: '2026-06-07T00:00:00Z',
      );
      mockTransferRepository.lookupResult = recipient;

      final notifier = container.read(transferProvider.notifier);
      await notifier.lookupRecipient('recipient@email.com');

      expect(
        container.read(transferProvider),
        TransferState.recipientChecked(recipient: recipient),
      );
    });

    test('Self-transfer lookup transitions to idle with error message', () async {
      final container = createContainer();
      final recipient = AccountRecord(
        id: 'sender-account-id', // Same as mockAuthRepository.currentAccountId
        userId: 'sender-user-id',
        code: 'sender@email.com',
        currency: 'VND',
        kind: AccountKind.USER,
        status: AccountStatus.ACTIVE,
        version: 1,
        createdAt: '2026-06-07T00:00:00Z',
      );
      mockTransferRepository.lookupResult = recipient;

      final notifier = container.read(transferProvider.notifier);
      await notifier.lookupRecipient('sender@email.com');

      expect(
        container.read(transferProvider),
        const TransferState.idle(
          errorMessage: 'Không thể chuyển tiền cho tài khoản ví của chính mình.',
        ),
      );
    });

    test('Inactive recipient lookup transitions to idle with error message', () async {
      final container = createContainer();
      final recipient = AccountRecord(
        id: 'recipient-account-id',
        userId: 'recipient-user-id',
        code: 'recipient@email.com',
        currency: 'VND',
        kind: AccountKind.USER,
        status: AccountStatus.SUSPENDED, // Inactive status
        version: 1,
        createdAt: '2026-06-07T00:00:00Z',
      );
      mockTransferRepository.lookupResult = recipient;

      final notifier = container.read(transferProvider.notifier);
      await notifier.lookupRecipient('recipient@email.com');

      expect(
        container.read(transferProvider),
        const TransferState.idle(
          errorMessage: 'Tài khoản người nhận đang bị khóa hoặc không hoạt động.',
        ),
      );
    });

    test('Failed lookup transitions to idle with AppException error message', () async {
      final container = createContainer();
      mockTransferRepository.lookupError = const AppException(
        code: 'RECIPIENT_NOT_FOUND',
        message: 'No recipient exists with code',
      );

      final notifier = container.read(transferProvider.notifier);
      await notifier.lookupRecipient('unknown@email.com');

      expect(
        container.read(transferProvider),
        const TransferState.idle(
          errorMessage: 'Không tìm thấy người nhận thanh toán.',
        ),
      );
    });

    test('setAmountAndNote transitions to review state', () async {
      final container = createContainer();
      final recipient = AccountRecord(
        id: 'recipient-account-id',
        userId: 'recipient-user-id',
        code: 'recipient@email.com',
        currency: 'VND',
        kind: AccountKind.USER,
        status: AccountStatus.ACTIVE,
        version: 1,
        createdAt: '2026-06-07T00:00:00Z',
      );
      mockTransferRepository.lookupResult = recipient;

      final notifier = container.read(transferProvider.notifier);
      await notifier.lookupRecipient('recipient@email.com');
      notifier.setAmountAndNote('50000', 'Quà sinh nhật');

      final state = container.read(transferProvider);
      expect(state, isA<TransferStateReview>());
      final reviewState = state as TransferStateReview;
      expect(reviewState.recipient, recipient);
      expect(reviewState.amount, '50000');
      expect(reviewState.note, 'Quà sinh nhật');
      expect(reviewState.idempotencyKey, isNotEmpty);
    });

    test('submitTransfer and happy path status polling', () {
      fakeAsync((async) {
        final container = createContainer();
        final recipient = AccountRecord(
          id: 'recipient-account-id',
          userId: 'recipient-user-id',
          code: 'recipient@email.com',
          currency: 'VND',
          kind: AccountKind.USER,
          status: AccountStatus.ACTIVE,
          version: 1,
          createdAt: '2026-06-07T00:00:00Z',
        );

        // Prepopulate history for balance check or setup
        final txId = 'tx-123';
        final initialTx = WalletTransaction(
          id: txId,
          senderId: 'sender-account-id',
          receiverId: 'recipient-account-id',
          amount: Decimal.parse('50000'),
          currency: 'VND',
          status: TransactionStatus.PENDING,
          idempotencyKey: 'idemp-key',
          createdAt: '2026-06-07T00:00:00Z',
          updatedAt: '2026-06-07T00:00:00Z',
          debitApplied: true,
        );

        mockTransferRepository.lookupResult = recipient;
        mockTransferRepository.transferResult = initialTx;
        mockHistoryRepository.transactions[txId] = initialTx;

        final notifier = container.read(transferProvider.notifier);

        // Advance to review
        notifier.lookupRecipient('recipient@email.com');
        async.elapse(const Duration(milliseconds: 10));
        notifier.setAmountAndNote('50000', 'Test');

        // Verify we are in review state
        expect(container.read(transferProvider), isA<TransferStateReview>());

        // Submit transfer
        notifier.submitTransfer('123456');
        async.elapse(const Duration(milliseconds: 10));

        // Transitions to submitting, then processing and starts polling
        expect(container.read(transferProvider), isA<TransferStateProcessing>());
        
        // Wait 1.5 seconds for first poll
        async.elapse(const Duration(milliseconds: 1500));
        
        // Status is still PENDING, so it stays in processing
        var state = container.read(transferProvider);
        expect(state, isA<TransferStateProcessing>());
        expect((state as TransferStateProcessing).pollCount, 1);

        // Mock backend finishing transaction to COMPLETED
        final completedTx = initialTx.copyWith(
          status: TransactionStatus.COMPLETED,
          updatedAt: '2026-06-07T00:00:05Z',
        );
        mockHistoryRepository.transactions[txId] = completedTx;

        // Wait another 1.5 seconds for second poll
        async.elapse(const Duration(milliseconds: 1500));

        // Should now transition to completed
        expect(
          container.read(transferProvider),
          TransferState.completed(transaction: completedTx),
        );

        // Verify balance was refreshed on completion
        expect(mockWalletRepository.getBalanceCallCount, 2);
      });
    });

    test('submitTransfer and compensation failed path status polling', () {
      fakeAsync((async) {
        final container = createContainer();
        final recipient = AccountRecord(
          id: 'recipient-account-id',
          userId: 'recipient-user-id',
          code: 'recipient@email.com',
          currency: 'VND',
          kind: AccountKind.USER,
          status: AccountStatus.ACTIVE,
          version: 1,
          createdAt: '2026-06-07T00:00:00Z',
        );

        final txId = 'tx-456';
        final initialTx = WalletTransaction(
          id: txId,
          senderId: 'sender-account-id',
          receiverId: 'recipient-account-id',
          amount: Decimal.parse('100000'),
          currency: 'VND',
          status: TransactionStatus.PENDING,
          idempotencyKey: 'idemp-key',
          createdAt: '2026-06-07T00:00:00Z',
          updatedAt: '2026-06-07T00:00:00Z',
          debitApplied: true, // Debit was applied
        );

        mockTransferRepository.lookupResult = recipient;
        mockTransferRepository.transferResult = initialTx;
        mockHistoryRepository.transactions[txId] = initialTx;

        final notifier = container.read(transferProvider.notifier);

        notifier.lookupRecipient('recipient@email.com');
        async.elapse(const Duration(milliseconds: 10));
        notifier.setAmountAndNote('100000', 'Sad Path B');

        notifier.submitTransfer('123456');
        async.elapse(const Duration(milliseconds: 10));

        expect(container.read(transferProvider), isA<TransferStateProcessing>());

        // Advance poll 1
        async.elapse(const Duration(milliseconds: 1500));

        // Mock backend transitioning to FAILED due to credit rejection, and refunding
        final failedTx = initialTx.copyWith(
          status: TransactionStatus.FAILED,
          updatedAt: '2026-06-07T00:00:05Z',
        );
        mockHistoryRepository.transactions[txId] = failedTx;

        // Advance poll 2
        async.elapse(const Duration(milliseconds: 1500));

        // State should be failed with wasRefunded = true since debitApplied was true
        expect(
          container.read(transferProvider),
          TransferState.failed(
            reason: 'Chuyển tiền thất bại. Giao dịch đã được hủy bỏ và bồi hoàn.',
            wasRefunded: true,
            transaction: failedTx,
          ),
        );

        // Verify balance was refreshed to reflect recovery of funds
        expect(mockWalletRepository.getBalanceCallCount, 2);
      });
    });

    test('submitTransfer and timeout status polling', () {
      fakeAsync((async) {
        final container = createContainer();
        final recipient = AccountRecord(
          id: 'recipient-account-id',
          userId: 'recipient-user-id',
          code: 'recipient@email.com',
          currency: 'VND',
          kind: AccountKind.USER,
          status: AccountStatus.ACTIVE,
          version: 1,
          createdAt: '2026-06-07T00:00:00Z',
        );

        final txId = 'tx-789';
        final initialTx = WalletTransaction(
          id: txId,
          senderId: 'sender-account-id',
          receiverId: 'recipient-account-id',
          amount: Decimal.parse('5000'),
          currency: 'VND',
          status: TransactionStatus.PENDING,
          idempotencyKey: 'idemp-key',
          createdAt: '2026-06-07T00:00:00Z',
          updatedAt: '2026-06-07T00:00:00Z',
          debitApplied: false,
        );

        mockTransferRepository.lookupResult = recipient;
        mockTransferRepository.transferResult = initialTx;
        mockHistoryRepository.transactions[txId] = initialTx;

        final notifier = container.read(transferProvider.notifier);

        notifier.lookupRecipient('recipient@email.com');
        async.elapse(const Duration(milliseconds: 10));
        notifier.setAmountAndNote('5000', 'Timeout Path');

        notifier.submitTransfer('123456');
        async.elapse(const Duration(milliseconds: 10));

        expect(container.read(transferProvider), isA<TransferStateProcessing>());

        // Elapse 10 polls (1.5 seconds each = 15 seconds total)
        for (int i = 0; i < 10; i++) {
          async.elapse(const Duration(milliseconds: 1500));
        }

        // State should be timeout containing the last polled transaction status
        expect(
          container.read(transferProvider),
          TransferState.timeout(transaction: initialTx),
        );
      });
    });
  });
}
