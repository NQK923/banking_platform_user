import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:banking_platform_user/shared/widgets/status_chip.dart';

void main() {
  group('StatusChip Widget Tests', () {
    testWidgets('COMPLETED status mapping', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusChip(status: 'COMPLETED')),
        ),
      );
      expect(find.text('Thành công'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('Thành công'));
      expect(textWidget.style?.color, Colors.green);
    });

    testWidgets('PENDING status mapping', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusChip(status: 'PENDING')),
        ),
      );
      expect(find.text('Đang xử lý'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('Đang xử lý'));
      expect(textWidget.style?.color, Colors.orange);
    });

    testWidgets('COMPENSATING status mapping', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusChip(status: 'COMPENSATING')),
        ),
      );
      expect(find.text('Đang hoàn tiền'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('Đang hoàn tiền'));
      expect(textWidget.style?.color, Colors.purple);
    });

    testWidgets('FAILED status mapping', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusChip(status: 'FAILED')),
        ),
      );
      expect(find.text('Thất bại'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('Thất bại'));
      expect(textWidget.style?.color, isNotNull);
    });

    testWidgets('CANCELLED status mapping', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: StatusChip(status: 'CANCELLED')),
        ),
      );
      expect(find.text('Đã hủy'), findsOneWidget);
      final textWidget = tester.widget<Text>(find.text('Đã hủy'));
      expect(textWidget.style?.color, isNotNull);
    });
  });
}
