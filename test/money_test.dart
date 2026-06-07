import 'package:flutter_test/flutter_test.dart';
import 'package:decimal/decimal.dart';
import 'package:banking_platform_user/core/money/money.dart';

void main() {
  group('Money Value Object Tests', () {
    test('Parse and toDecimalString', () {
      final money = Money.parse('150000', 'VND');
      expect(money.amount, Decimal.parse('150000'));
      expect(money.currency, 'VND');
      expect(money.toDecimalString(), '150000');
    });

    test('VND Formatting (0 decimals)', () {
      final money = Money.parse('1000000', 'VND');
      expect(money.formatDisplay(), '1.000.000 ₫');
      
      final money2 = Money.parse('500', 'VND');
      expect(money2.formatDisplay(), '500 ₫');
    });

    test('USD Formatting (2 decimals)', () {
      final money = Money.parse('1250.50', 'USD');
      expect(money.formatDisplay(), '\$1,250.50');
      
      final money2 = Money.parse('5', 'USD');
      expect(money2.formatDisplay(), '\$5.00');
    });

    test('Addition & Subtraction', () {
      final m1 = Money.parse('150.50', 'USD');
      final m2 = Money.parse('50.25', 'USD');

      final sum = m1.add(m2);
      expect(sum.amount, Decimal.parse('200.75'));
      expect(sum.currency, 'USD');

      final diff = m1.subtract(m2);
      expect(diff.amount, Decimal.parse('100.25'));
      expect(diff.currency, 'USD');
    });

    test('Currency mismatch throws ArgumentError', () {
      final vnd = Money.parse('100000', 'VND');
      final usd = Money.parse('5', 'USD');

      expect(() => vnd.add(usd), throwsArgumentError);
      expect(() => vnd.subtract(usd), throwsArgumentError);
    });

    test('Comparison operations', () {
      final m1 = Money.parse('10', 'USD');
      final m2 = Money.parse('20', 'USD');

      expect(m1.isLessThan(m2), isTrue);
      expect(m2.isGreaterThan(m1), isTrue);
      expect(m1 == Money.parse('10', 'USD'), isTrue);
    });
  });
}
