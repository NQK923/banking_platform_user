import 'package:banking_platform_user/core/network/api_client.dart';
import 'package:banking_platform_user/core/network/auth_interceptor.dart';
import 'package:banking_platform_user/features/auth/data/auth_token_storage.dart';
import 'package:banking_platform_user/features/transfer/presentation/transfer_wizard_screen.dart';
import 'package:banking_platform_user/features/wallet/presentation/withdraw_screen.dart';
import 'package:banking_platform_user/l10n/generated/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Only the network boundary and secure storage are substituted. Screens,
// notifiers, repositories, serialization and auth headers use production code.
class _Storage implements AuthTokenStorage {
  @override
  Future<String?> getAccessToken() async => 'access';
  @override
  Future<String?> getRefreshToken() async => 'refresh';
  @override
  Future<String?> getUserId() async => 'sender-user';
  @override
  Future<String?> getAccountId() async => 'sender';
  @override
  Future<void> clearSession() async {}
  @override
  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String userId,
    String? accountId,
  }) async {}
}

class _Network {
  final storage = _Storage();
  final dio = Dio(BaseOptions(baseUrl: 'https://wallet.test'));
  final transfers = <RequestOptions>[];
  final withdrawals = <RequestOptions>[];
  final lookups = <RequestOptions>[];
  String? risk;
  String terminalStatus = 'COMPLETED';
  bool compensated = false;
  int statusReads = 0;

  _Network() {
    dio.interceptors.add(AuthInterceptor(storage, () {}));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          expect(request.headers['Authorization'], 'Bearer access');
          Object data;
          if (request.path.endsWith('/balance')) {
            data = {
              'accountId': 'sender',
              'balance': withdrawals.isEmpty ? '1000' : '900',
              'currency': 'VND',
            };
          } else if (request.path == '/api/accounts/lookup') {
            lookups.add(request);
            data = {
              'id': 'recipient',
              'userId': 'recipient-user',
              'code': 'wallet-code',
              'email': 'recipient@example.test',
              'phone': '+84912345678',
              'currency': 'VND',
              'kind': 'USER',
              'status': 'ACTIVE',
              'version': 1,
              'createdAt': '2026-10-25T00:00:00Z',
            };
          } else if (request.path == '/api/transactions/transfer') {
            transfers.add(request);
            final body = request.data as Map<String, dynamic>;
            expect(body['amount'], isA<String>());
            expect(request.headers['Idempotency-Key'], body['idempotencyKey']);
            final continued =
                body['riskAcknowledged'] == true || body['stepUpPin'] != null;
            data = risk != null && !continued
                ? {
                    'result': risk,
                    'riskEvaluationId': 'risk-ui',
                    'riskScore': 65,
                    'riskLevel': 'HIGH',
                    'recommendedAction': 'STEP_UP_AUTH',
                    'reasons': [
                      {
                        'code': 'NEW_RECIPIENT',
                        'weight': 15,
                        'message': 'New recipient',
                      },
                    ],
                    'modelVersion': 'rules-v1',
                    'policyVersion': 'policy-v1',
                    'evaluatedAt': '2026-10-25T00:00:00Z',
                    'traceId': 'trace-ui',
                    'message': 'Please review this transfer.',
                  }
                : _transaction('PENDING');
          } else if (request.path == '/api/transactions/tx-ui') {
            statusReads++;
            data = _transaction(terminalStatus);
          } else if (request.path == '/api/accounts/sender/withdraw') {
            withdrawals.add(request);
            expect(request.data['amount'], '100');
            expect(request.data['pin'], '123456');
            expect(request.headers['Idempotency-Key'], isNotEmpty);
            data = {
              'journalId': 'journal-ui',
              'balance': {
                'accountId': 'sender',
                'balance': '900',
                'currency': 'VND',
              },
            };
          } else {
            throw StateError(
              'Unexpected request: ${request.method} ${request.path}',
            );
          }
          handler.resolve(
            Response(requestOptions: request, statusCode: 200, data: data),
          );
        },
      ),
    );
  }

  Map<String, dynamic> _transaction(String status) => {
    'id': 'tx-ui',
    'senderId': 'sender',
    'receiverId': 'recipient',
    'amount': '100',
    'currency': 'VND',
    'status': status,
    'idempotencyKey': transfers.last.data['idempotencyKey'],
    'createdAt': '2026-10-25T00:00:00Z',
    'updatedAt': '2026-10-25T00:00:00Z',
    'debitApplied': true,
    'compensated': compensated,
    if (status == 'FAILED')
      'failureReason': compensated ? 'Credit failed' : 'not compensated',
  };

  Widget app(Widget screen) => ProviderScope(
    overrides: [
      dioProvider.overrideWithValue(dio),
      tokenStorageProvider.overrideWithValue(storage),
    ],
    child: MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: screen,
    ),
  );
}

Future<void> _tap(WidgetTester tester, String text) async {
  final button = find.text(text);
  await tester.ensureVisible(button);
  await tester.pumpAndSettle();
  await tester.tap(button);
  await tester.pumpAndSettle();
}

Future<void> _submitTransfer(
  WidgetTester tester,
  _Network network, {
  String recipient = 'recipient@example.test',
}) async {
  await tester.pumpWidget(network.app(const TransferWizardScreen()));
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextFormField), recipient);
  await _tap(tester, 'Continue');
  expect(find.text('Enter amount'), findsOneWidget);
  await tester.enterText(find.byType(TextFormField).first, '100');
  await _tap(tester, 'Review transfer');
  await tester.enterText(find.byType(TextFormField), '123456');
  await _tap(tester, 'Confirm transfer');
}

void main() {
  for (final width in [320.0, 1024.0]) {
    testWidgets('email transfer completes without overflow at width $width', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final network = _Network();
      await _submitTransfer(tester, network);
      expect(find.text('Transfer completed'), findsOneWidget);
      expect(network.lookups.single.queryParameters, {
        'email': 'recipient@example.test',
      });
      expect(network.transfers.single.data['amount'], '100');
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('phone lookup submits matched recipient contacts', (
    tester,
  ) async {
    final network = _Network();
    await _submitTransfer(tester, network, recipient: '+84912345678');
    expect(network.lookups.single.queryParameters, {'phone': '+84912345678'});
    expect(
      network.transfers.single.data['recipientEmail'],
      'recipient@example.test',
    );
    expect(network.transfers.single.data['recipientPhone'], '+84912345678');
    expect(find.text('Transfer completed'), findsOneWidget);
  });

  for (final warning in [true, false]) {
    testWidgets(
      '${warning ? 'warning acknowledgement' : 'step up'} requires explicit PIN continuation',
      (tester) async {
        final network = _Network()
          ..risk = warning ? 'RISK_WARNING_REQUIRED' : 'RISK_STEP_UP_REQUIRED';
        await _submitTransfer(tester, network);
        expect(network.transfers, hasLength(1));
        expect(network.statusReads, 0);
        expect(
          find.text(
            warning
                ? 'Review this transfer carefully'
                : 'Additional verification required',
          ),
          findsOneWidget,
        );
        await _tap(
          tester,
          warning ? 'I understand and want to continue' : 'Verify and continue',
        );
        await tester.enterText(find.byType(TextFormField), '123456');
        await _tap(tester, 'Confirm');
        expect(find.text('Transfer completed'), findsOneWidget);
        expect(network.transfers, hasLength(2));
        final first = network.transfers.first.data as Map<String, dynamic>;
        final next = network.transfers.last.data as Map<String, dynamic>;
        expect(next['idempotencyKey'], first['idempotencyKey']);
        expect(next['riskEvaluationId'], 'risk-ui');
        expect(
          next[warning ? 'riskAcknowledged' : 'stepUpPin'],
          warning ? true : '123456',
        );
      },
    );
  }

  for (final review in [true, false]) {
    testWidgets(
      '${review ? 'manual review' : 'blocked risk'} does not start money status polling',
      (tester) async {
        final network = _Network()
          ..risk = review ? 'RISK_MANUAL_REVIEW_REQUIRED' : 'RISK_BLOCKED';
        await _submitTransfer(tester, network);
        expect(
          find.text(review ? 'Transfer under review' : 'Transfer blocked'),
          findsOneWidget,
        );
        if (review) {
          expect(find.text('Your money has not been debited.'), findsOneWidget);
        }
        expect(network.transfers, hasLength(1));
        expect(network.statusReads, 0);
      },
    );
  }

  for (final refunded in [true, false]) {
    testWidgets(
      'failed transfer only shows refund when compensated=$refunded',
      (tester) async {
        final network = _Network()
          ..terminalStatus = 'FAILED'
          ..compensated = refunded;
        await _submitTransfer(tester, network);
        expect(
          find.text(refunded ? 'Transfer failed, refunded' : 'Transfer failed'),
          findsOneWidget,
        );
        expect(
          find.text(
            'Refunded: the sender balance was restored after compensation.',
          ),
          refunded ? findsOneWidget : findsNothing,
        );
      },
    );
  }

  testWidgets(
    'withdraw validates balance and PIN before sending exact amount',
    (tester) async {
      final network = _Network();
      await tester.pumpWidget(network.app(const WithdrawScreen()));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), '1001');
      await _tap(tester, 'Review withdrawal');
      expect(find.text('Available balance is not enough.'), findsOneWidget);
      expect(network.withdrawals, isEmpty);
      await tester.enterText(find.byType(TextFormField), '100');
      await _tap(tester, 'Review withdrawal');
      final pin = find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(TextFormField),
      );
      await tester.enterText(pin, '123');
      await _tap(tester, 'Confirm');
      expect(network.withdrawals, isEmpty);
      await tester.enterText(pin, '123456');
      await _tap(tester, 'Confirm');
      expect(find.text('Withdrawal completed'), findsOneWidget);
      expect(network.withdrawals, hasLength(1));
      expect(tester.takeException(), isNull);
    },
  );
}
