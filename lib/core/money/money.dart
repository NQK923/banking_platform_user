import 'package:decimal/decimal.dart';

class Money {
  final Decimal amount;
  final String currency;

  const Money({required this.amount, required this.currency});

  factory Money.parse(String amountStr, String currency) {
    try {
      final parsed = Decimal.parse(amountStr);
      return Money(amount: parsed, currency: currency.toUpperCase());
    } catch (_) {
      throw FormatException(
        'Invalid decimal string representation: $amountStr',
      );
    }
  }

  factory Money.zero(String currency) {
    return Money(amount: Decimal.zero, currency: currency.toUpperCase());
  }

  int get scale {
    switch (currency) {
      case 'VND':
        return 0;
      case 'USD':
        return 2;
      case 'BTC':
        return 8;
      default:
        return 4;
    }
  }

  String toDecimalString() {
    return amount.toString();
  }

  String formatDisplay() {
    final scaleVal = scale;
    final fixedStr = amount.toStringAsFixed(scaleVal);

    if (currency == 'VND') {
      return '${_formatInteger(fixedStr.split('.').first, '.')} VND';
    }

    if (currency == 'USD') {
      final parts = fixedStr.split('.');
      final integerPart = _formatInteger(parts.first, ',');
      final decimalPart = parts.length > 1 ? '.${parts[1]}' : '';
      return '\$$integerPart$decimalPart';
    }

    return '$fixedStr $currency';
  }

  Money add(Money other) {
    _checkCurrency(other);
    return Money(amount: amount + other.amount, currency: currency);
  }

  Money subtract(Money other) {
    _checkCurrency(other);
    return Money(amount: amount - other.amount, currency: currency);
  }

  bool isLessThan(Money other) {
    _checkCurrency(other);
    return amount < other.amount;
  }

  bool isGreaterThan(Money other) {
    _checkCurrency(other);
    return amount > other.amount;
  }

  bool isNegative() {
    return amount < Decimal.zero;
  }

  String _formatInteger(String integerPart, String separator) {
    final buffer = StringBuffer();
    final len = integerPart.length;
    for (int i = 0; i < len; i++) {
      buffer.write(integerPart[i]);
      if ((len - i - 1) % 3 == 0 && i != len - 1) {
        buffer.write(separator);
      }
    }
    return buffer.toString();
  }

  void _checkCurrency(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('Currency mismatch: $currency vs ${other.currency}');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Money && amount == other.amount && currency == other.currency;

  @override
  int get hashCode => amount.hashCode ^ currency.hashCode;

  @override
  String toString() => '$amount $currency';
}
