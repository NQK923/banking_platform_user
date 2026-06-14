import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fake_async/fake_async.dart';

import 'package:banking_platform_user/core/error/app_exception.dart';
import 'package:banking_platform_user/features/auth/data/auth_repository.dart';
import 'package:banking_platform_user/features/auth/domain/auth_models.dart';
import 'package:banking_platform_user/features/history/data/history_repository.dart';
import 'package:banking_platform_user/features/history/domain/history_models.dart';
import 'package:banking_platform_user/features/history/domain/wallet_transaction.dart';
import 'package:banking_platform_user/features/transfer/data/transfer_repository.dart';
import 'package:banking_platform_user/features/transfer/domain/transfer_models.dart';
import 'package:banking_platform_user/features/transfer/domain/transfer_notifier.dart';
import 'package:banking_platform_user/features/transfer/domain/transfer_state.dart';
import 'package:banking_platform_user/features/wallet/data/wallet_repository.dart';
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

class MockTransferRepository implements TransferRepository {
  AccountRecord? lookupResult;
  AppException? lookupError;
  WalletTransaction? transferResult;
  TransferRiskResponse? riskResult;
  AppException? transferError;

  final List<TransferRequest> initiatedRequests = [];

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
  Future<TransferSubmissionResult> initiateTransfer(TransferRequest request) async {
    initiatedRequests.add(request);
    if (transferError != null) {
      throw transferError!;
    }
    if (riskResult != null) {
      return TransferRiskRequired(riskResult!);
    }
    if (transferResult != null) {
      return TransferSubmitted(transferResult!);
    }
    throw const AppException(
      code: 'INTERNAL',
      message: 'Transfer initiation failed',
    );
  }
}

class MockHistoryRepository implements HistoryRepository {
  final Map<String, WalletTransaction> transactions = {};
  int getDetailCallCount = 0;

  @override
  Future<PaginatedHistoryResponse> getHistory({
    required int page,
    required int size,
  }) async {
    return PaginatedHistoryResponse(
      items: transactions.values.toList(),
      page: page,
      size: size,
      totalElements: transactions.length,
      totalPages: 1,
    );
  }

  @override
  Future<WalletTransaction> getTransactionDetail(String transactionId) async {
    getDetailCallCount++;
    final tx = transactions[transactionId];
    if (tx != null) {
      return tx;
    }
    throw const AppException(
      code: 'TRANSACTION_NOT_FOUND',
      message: 'Transaction not found',
    );
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
    return const AccountRecord(
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
  Future<MovementResponse> deposit(String amount, String idempotencyKey) async {
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
  Future<MovementResponse> withdraw(
    String amount,
    String pin,
    String idempotencyKey,
  ) async {
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
      const recipient = AccountRecord(
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
        const TransferState.recipientChecked(recipient: recipient),
      );
    });

    test(
      'Self-transfer lookup transitions to idle with error message',
      () async {
        final container = createContainer();
        const recipient = AccountRecord(
          id: 'sender-account-id',
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
            errorMessage:
                'Không thể chuyển tiền cho tài khoản ví của chính mình.',
          ),
        );
      },
    );

    test('setAmountAndNote transitions to review state', () async {
      final container = createContainer();
      const recipient = AccountRecord(
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
        const recipient = AccountRecord(
          id: 'recipient-account-id',
          userId: 'recipient-user-id',
          code: 'recipient@email.com',
          currency: 'VND',
          kind: AccountKind.USER,
          status: AccountStatus.ACTIVE,
          version: 1,
          createdAt: '2026-06-07T00:00:00Z',
        );

        const txId = 'tx-123';
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

        notifier.lookupRecipient('recipient@email.com');
        async.elapse(const Duration(milliseconds: 10));
        notifier.setAmountAndNote('50000', 'Test');

        expect(container.read(transferProvider), isA<TransferStateReview>());

        notifier.submitTransfer('123456');
        async.elapse(const Duration(milliseconds: 10));

        expect(
          container.read(transferProvider),
          isA<TransferStateProcessing>(),
        );

        async.elapse(const Duration(milliseconds: 1500));

        var state = container.read(transferProvider);
        expect(state, isA<TransferStateProcessing>());
        expect((state as TransferStateProcessing).pollCount, 1);

        final completedTx = initialTx.copyWith(
          status: TransactionStatus.COMPLETED,
          updatedAt: '2026-06-07T00:00:05Z',
        );
        mockHistoryRepository.transactions[txId] = completedTx;

        async.elapse(const Duration(milliseconds: 1500));

        expect(
          container.read(transferProvider),
          TransferState.completed(transaction: completedTx),
        );

        expect(mockWalletRepository.getBalanceCallCount, 2);
      });
    });

    test('risk warning acknowledgement reuses idempotency key and risk id', () async {
      final container = createContainer();
      const recipient = AccountRecord(
        id: 'recipient-account-id',
        userId: 'recipient-user-id',
        code: 'recipient@email.com',
        currency: 'VND',
        kind: AccountKind.USER,
        status: AccountStatus.ACTIVE,
        version: 1,
        createdAt: '2026-06-07T00:00:00Z',
      );
      const risk = TransferRiskResponse(
        result: 'RISK_WARNING_REQUIRED',
        riskEvaluationId: 'risk-123',
        riskScore: 40,
        riskLevel: 'MEDIUM',
        recommendedAction: 'WARN_USER',
        reasons: [
          RiskReasonView(
            code: 'NEW_RECIPIENT',
            weight: 15,
            message: 'Sender has never transferred to this recipient before',
          ),
        ],
        modelVersion: 'rules-v1.0.0',
        policyVersion: 'risk-policy-v1.0.0',
        evaluatedAt: '2026-06-13T00:00:00Z',
        traceId: 'trace-123',
        message: 'Review this transfer carefully.',
      );

      mockTransferRepository.lookupResult = recipient;
      mockTransferRepository.riskResult = risk;

      final notifier = container.read(transferProvider.notifier);
      await notifier.lookupRecipient('recipient@email.com');
      notifier.setAmountAndNote('50000', 'Risk');
      final reviewState = container.read(transferProvider) as TransferStateReview;

      await notifier.submitTransfer('123456');
      expect(container.read(transferProvider), isA<TransferStateRiskWarningRequired>());
      expect(mockTransferRepository.initiatedRequests.single.idempotencyKey, reviewState.idempotencyKey);

      mockTransferRepository.riskResult = null;
      final tx = WalletTransaction(
        id: 'tx-risk',
        senderId: 'sender-account-id',
        receiverId: 'recipient-account-id',
        amount: Decimal.parse('50000'),
        currency: 'VND',
        status: TransactionStatus.PENDING,
        idempotencyKey: reviewState.idempotencyKey,
        createdAt: '2026-06-07T00:00:00Z',
        updatedAt: '2026-06-07T00:00:00Z',
        debitApplied: false,
      );
      mockTransferRepository.transferResult = tx;
      mockHistoryRepository.transactions[tx.id] = tx;

      await notifier.acknowledgeRiskWarning('123456');

      expect(container.read(transferProvider), isA<TransferStateProcessing>());
      expect(mockTransferRepository.initiatedRequests.length, 2);
      expect(mockTransferRepository.initiatedRequests.last.idempotencyKey, reviewState.idempotencyKey);
      expect(mockTransferRepository.initiatedRequests.last.riskEvaluationId, 'risk-123');
      expect(mockTransferRepository.initiatedRequests.last.riskAcknowledged, isTrue);
    });

    test('submitTransfer and compensation failed path status polling', () {
      fakeAsync((async) {
        final container = createContainer();
        const recipient = AccountRecord(
          id: 'recipient-account-id',
          userId: 'recipient-user-id',
          code: 'recipient@email.com',
          currency: 'VND',
          kind: AccountKind.USER,
          status: AccountStatus.ACTIVE,
          version: 1,
          createdAt: '2026-06-07T00:00:00Z',
        );

        const txId = 'tx-456';
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
          debitApplied: true,
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

        expect(
          container.read(transferProvider),
          isA<TransferStateProcessing>(),
        );

        async.elapse(const Duration(milliseconds: 1500));

        final failedTx = initialTx.copyWith(
          status: TransactionStatus.FAILED,
          failureReason:
              'Credit failed: account suspended', // no longer relies on text matching
          compensated: true,
          updatedAt: '2026-06-07T00:00:05Z',
        );
        mockHistoryRepository.transactions[txId] = failedTx;

        async.elapse(const Duration(milliseconds: 1500));

        expect(
          container.read(transferProvider),
          TransferState.failed(
            reason: 'Credit failed: account suspended',
            wasRefunded: true, // Derived from compensated: true
            transaction: failedTx,
          ),
        );

        expect(mockWalletRepository.getBalanceCallCount, 2);
      });
    });

    test(
      'submitTransfer and failed path status polling (compensated is false/null -> not wasRefunded)',
      () {
        fakeAsync((async) {
          final container = createContainer();
          const recipient = AccountRecord(
            id: 'recipient-account-id',
            userId: 'recipient-user-id',
            code: 'recipient@email.com',
            currency: 'VND',
            kind: AccountKind.USER,
            status: AccountStatus.ACTIVE,
            version: 1,
            createdAt: '2026-06-07T00:00:00Z',
          );

          const txId = 'tx-456-uncompensated';
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
            debitApplied: true,
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

          expect(
            container.read(transferProvider),
            isA<TransferStateProcessing>(),
          );

          async.elapse(const Duration(milliseconds: 1500));

          final failedTx = initialTx.copyWith(
            status: TransactionStatus.FAILED,
            failureReason: 'Credit failed: account suspended',
            compensated: false,
            updatedAt: '2026-06-07T00:00:05Z',
          );
          mockHistoryRepository.transactions[txId] = failedTx;

          async.elapse(const Duration(milliseconds: 1500));

          expect(
            container.read(transferProvider),
            TransferState.failed(
              reason: 'Credit failed: account suspended',
              wasRefunded: false, // compensated is false, not refunded
              transaction: failedTx,
            ),
          );
        });
      },
    );

    test('submitTransfer fails and retry submission reuses key', () async {
      final container = createContainer();
      const recipient = AccountRecord(
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
      mockTransferRepository.transferError = const AppException(
        code: 'NETWORK_ERROR',
        message: 'No connection',
      );

      final notifier = container.read(transferProvider.notifier);

      await notifier.lookupRecipient('recipient@email.com');
      notifier.setAmountAndNote('20000', 'Retry Test');

      final initialReviewState =
          container.read(transferProvider) as TransferStateReview;
      final initialKey = initialReviewState.idempotencyKey;

      // First submit
      await notifier.submitTransfer('123456');

      final failedState =
          container.read(transferProvider) as TransferStateFailed;
      expect(
        failedState.reason,
        'Lỗi kết nối mạng. Vui lòng kiểm tra lại đường truyền.',
      );
      expect(mockTransferRepository.initiatedRequests.length, 1);
      expect(
        mockTransferRepository.initiatedRequests.first.idempotencyKey,
        initialKey,
      );

      // Retry submission
      mockTransferRepository.transferError = null;
      const txId = 'tx-retry';
      final completedTx = WalletTransaction(
        id: txId,
        senderId: 'sender-account-id',
        receiverId: 'recipient-account-id',
        amount: Decimal.parse('20000'),
        currency: 'VND',
        status: TransactionStatus.COMPLETED,
        idempotencyKey: initialKey,
        createdAt: '2026-06-07T00:00:00Z',
        updatedAt: '2026-06-07T00:00:00Z',
        debitApplied: true,
      );
      mockTransferRepository.transferResult = completedTx;
      mockHistoryRepository.transactions[txId] = completedTx;

      await notifier.retryTransfer('123456');

      expect(container.read(transferProvider), isA<TransferStateProcessing>());
      expect(mockTransferRepository.initiatedRequests.length, 2);
      expect(
        mockTransferRepository.initiatedRequests[1].idempotencyKey,
        initialKey,
      ); // REUSED KEY
    });
    group('Verification limits', () {
      test('submitTransfer and timeout status polling', () {
        fakeAsync((async) {
          final container = createContainer();
          const recipient = AccountRecord(
            id: 'recipient-account-id',
            userId: 'recipient-user-id',
            code: 'recipient@email.com',
            currency: 'VND',
            kind: AccountKind.USER,
            status: AccountStatus.ACTIVE,
            version: 1,
            createdAt: '2026-06-07T00:00:00Z',
          );

          const txId = 'tx-789';
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

          expect(
            container.read(transferProvider),
            isA<TransferStateProcessing>(),
          );

          for (int i = 0; i < 10; i++) {
            async.elapse(const Duration(milliseconds: 1500));
          }

          expect(
            container.read(transferProvider),
            TransferState.timeout(transaction: initialTx),
          );
        });
      });
    });
  });
}
