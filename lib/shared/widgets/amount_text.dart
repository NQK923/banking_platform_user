import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import '../../core/money/money.dart';
import '../../features/history/domain/wallet_transaction.dart';

class AmountText extends StatelessWidget {
  final Decimal amount;
  final String currency;
  final bool isDebit;
  final TextStyle? style;

  const AmountText({
    super.key,
    required this.amount,
    required this.currency,
    required this.isDebit,
    this.style,
  });

  factory AmountText.forTransaction({
    Key? key,
    required WalletTransaction transaction,
    required String currentUserAccountId,
    TextStyle? style,
  }) {
    final isDebit = transaction.senderId == currentUserAccountId;
    return AmountText(
      key: key,
      amount: transaction.amount,
      currency: transaction.currency,
      isDebit: isDebit,
      style: style,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final money = Money(amount: amount, currency: currency);
    final displayValue = money.formatDisplay();

    final prefix = isDebit ? '-' : '+';
    final Color textColor = isDebit ? theme.colorScheme.error : Colors.green;

    return Text(
      '$prefix$displayValue',
      style: (style ?? theme.textTheme.titleMedium)?.copyWith(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
