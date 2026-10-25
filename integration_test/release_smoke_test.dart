import 'package:banking_platform_user/core/localization/locale_provider.dart';
import 'package:banking_platform_user/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('release smoke registers a user and renders wallet home against backend', (tester) async {
    final unique = DateTime.now().microsecondsSinceEpoch;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localeProvider.overrideWith((ref) => const Locale('en')),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.text('Create one'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'release-$unique@example.test');
    await tester.enterText(fields.at(1), '+849${unique.toString().substring(unique.toString().length - 8)}');
    await tester.enterText(fields.at(2), 'Password123!');
    await tester.enterText(fields.at(3), '123456');
    await tester.tap(find.text('Create wallet'));

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('Wallet'), findsWidgets);
    expect(find.text('Send'), findsWidgets);
    expect(find.text('Withdraw'), findsWidgets);
    expect(find.text('Deposit'), findsNothing);
  });
}
