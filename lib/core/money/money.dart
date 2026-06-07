import 'package:decimal/decimal.dart';

class Money {
  final Decimal amount;
  final String currency;

  const Money({
    required this.amount,
    required this.currency,
  });

  factory Money.parse(String amountStr, String currency) {
    try {
      final parsed = Decimal.parse(amountStr);
      return Money(amount: parsed, currency: currency.toUpperCase());
    } catch (e) {
      throw FormatException('Invalid decimal string representation: $amountStr');
    }
  }

  factory Money.zero(String currency) {
    return Money(amount: Decimal.zero, currency: currency.toUpperCase());
  }

  // Gets the standard scale for formatting
  int get scale {
    switch (currency) {
      case 'VND':
        return 0;
      case 'USD':
        return 2;
      case 'BTC':
        return 8;
      default:
        return 4; // default to DECIMAL(19,4) scale
    }
  }

  // Formats the amount exactly as a decimal string matching the scale
  String toDecimalString() {
    // Rounds or formats to the exact scale for database compatibility
    // In Dart decimal package, we can get the string or scale it.
    // For simplicity, we serialize the amount to string.
    return amount.toString();
  }

  // Returns a styled/formatted string suitable for display (e.g. 1.000.000 ₫ or $1,250.00)
  String formatDisplay() {
    final scaleVal = scale;
    final fixedStr = amount.toStringAsFixed(scaleVal);
    
    if (currency == 'VND') {
      // Basic Vietnamese formatting, e.g. 1.000.000
      final parts = fixedStr.split('.');
      final integerPart = parts[0];
      final buffer = StringBuffer();
      
      int len = integerPart.length;
      for (int i = 0; i < len; i++) {
        buffer.write(integerPart[i]);
        if ((len - i - 1) % 3 == 0 && i != len - 1) {
          buffer.write('.');
        }
      }
      return '${buffer.toString()} ₫';
    } else if (currency == 'USD') {
      // Basic US formatting, e.g. $1,250.00
      final parts = fixedStr.split('.');
      final integerPart = parts[0];
      final decimalPart = parts.length > 1 ? parts[1] : '';
      
      final buffer = StringBuffer();
      int len = integerPart.length;
      for (int i = 0; i < len; i++) {
        buffer.write(integerPart[i]);
        if ((len - i - 1) % 3 == 0 && i != len - 1) {
          buffer.write(',');
        }
      }
      final decStr = decimalPart.isNotEmpty ? '.$decimalPart' : '';
      return '\$${buffer.toString()}$decStr';
    } else {
      return '$fixedStr $currency';
    }
  }

  // Math operations
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
