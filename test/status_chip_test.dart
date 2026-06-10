import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:banking_platform_user/core/theme/app_theme.dart';
import 'package:banking_platform_user/shared/widgets/status_chip.dart';

void main() {
  group('StatusChip Widget Tests', () {
    testWidgets('COMPLETED status mapping', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusChip(status: 'COMPLETED')),
        ),
      );
      expect(find.text('Completed'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('Completed'));
      expect(textWidget.style?.color, AppTheme.success);
    });

    testWidgets('PENDING status mapping', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusChip(status: 'PENDING')),
        ),
      );
      expect(find.text('Pending'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('Pending'));
      expect(textWidget.style?.color, AppTheme.warning);
    });

    testWidgets('PROCESSING status mapping', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusChip(status: 'PROCESSING')),
        ),
      );
      expect(find.text('Processing'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('Processing'));
      expect(textWidget.style?.color, AppTheme.info);
    });

    testWidgets('COMPENSATING status mapping', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusChip(status: 'COMPENSATING')),
        ),
      );
      expect(find.text('Refunding'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('Refunding'));
      expect(textWidget.style?.color, AppTheme.violet);
    });

    testWidgets('FAILED status mapping', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusChip(status: 'FAILED')),
        ),
      );
      expect(find.text('Failed'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('Failed'));
      expect(textWidget.style?.color, isNotNull);
    });

    testWidgets('CANCELLED status mapping', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusChip(status: 'CANCELLED')),
        ),
      );
      expect(find.text('Cancelled'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('Cancelled'));
      expect(textWidget.style?.color, isNotNull);
    });
  });
}
