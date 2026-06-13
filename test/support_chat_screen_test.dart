import 'package:banking_platform_user/features/support/domain/support_chat_provider.dart';
import 'package:banking_platform_user/features/support/domain/support_models.dart';
import 'package:banking_platform_user/features/support/presentation/support_chat_screen.dart';
import 'package:banking_platform_user/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('support chat renders safety reminder and messages', (
    tester,
  ) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      _localizedApp(
        SupportChatView(
          controller: controller,
          state: SupportChatState(
            sessionId: 'session-1',
            transactionId: '12345678-1234-1234-1234-123456789012',
            messages: [
              SupportChatMessage.local(
                sessionId: 'session-1',
                senderType: SupportSenderType.USER,
                message: 'Has my money been refunded?',
              ),
              SupportChatMessage.local(
                sessionId: 'session-1',
                senderType: SupportSenderType.AI,
                message:
                    'I cannot confirm a refund without compensated = true.',
              ),
            ],
            suggestedActions: const [
              SupportSuggestedAction(
                type: 'OPEN_TRANSACTION_DETAIL',
                label: 'Open transaction detail',
                targetId: 'tx-1',
              ),
            ],
          ),
          onSend: (_) {},
          onRetry: () {},
          onHandoff: () {},
          onSuggestedAction: (_) {},
        ),
      ),
    );

    expect(
      find.text('Never share PIN, password, OTP, or tokens.'),
      findsOneWidget,
    );
    expect(find.text('Has my money been refunded?'), findsOneWidget);
    expect(
      find.text('I cannot confirm a refund without compensated = true.'),
      findsOneWidget,
    );
    expect(find.text('Open transaction detail'), findsOneWidget);
  });

  testWidgets('support chat composer sends typed message', (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    String sent = '';

    await tester.pumpWidget(
      _localizedApp(
        SupportChatView(
          controller: controller,
          state: const SupportChatState(),
          onSend: (value) => sent = value,
          onRetry: () {},
          onHandoff: () {},
          onSuggestedAction: (_) {},
        ),
      ),
    );

    await tester.enterText(
      find.byType(TextField),
      'Why is my transfer pending?',
    );
    await tester.tap(find.byTooltip('Send'));
    await tester.pump();

    expect(sent, 'Why is my transfer pending?');
  });
}

Widget _localizedApp(Widget child) {
  return MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: child,
  );
}
