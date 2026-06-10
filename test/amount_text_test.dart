import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:banking_platform_user/core/theme/app_theme.dart';
import 'package:banking_platform_user/shared/widgets/amount_text.dart';

void main() {
  group('AmountText Widget Tests', () {
    testWidgets('Debit displays negative prefix and error color', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(error: Colors.red),
          ),
          home: Scaffold(
            body: AmountText(
              amount: Decimal.parse('150000'),
              currency: 'VND',
              isDebit: true,
            ),
          ),
        ),
      );

      expect(find.text('-150.000 VND'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('-150.000 VND'));
      expect(textWidget.style?.color, Colors.red);
    });

    testWidgets('Credit displays positive prefix and success color', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AmountText(
              amount: Decimal.parse('1250.50'),
              currency: 'USD',
              isDebit: false,
            ),
          ),
        ),
      );

      expect(find.text('+\$1,250.50'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('+\$1,250.50'));
      expect(textWidget.style?.color, AppTheme.success);
    });
  });
}
