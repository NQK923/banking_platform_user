import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import '../../core/money/money.dart';
import '../../core/theme/app_theme.dart';
import '../../features/history/domain/wallet_transaction.dart';

enum AmountTone { neutral, positive, negative }

class AmountText extends StatelessWidget {
  final Decimal amount;
  final String currency;
  final bool isDebit;
  final TextStyle? style;
  final AmountTone? tone;

  const AmountText({
    super.key,
    required this.amount,
    required this.currency,
    required this.isDebit,
    this.style,
    this.tone,
  });

  const AmountText.neutral({
    super.key,
    required this.amount,
    required this.currency,
    this.style,
  }) : isDebit = false,
       tone = AmountTone.neutral;

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
    final resolvedTone =
        tone ?? (isDebit ? AmountTone.negative : AmountTone.positive);
    final prefix = resolvedTone == AmountTone.neutral
        ? ''
        : (isDebit ? '-' : '+');
    final color = switch (resolvedTone) {
      AmountTone.neutral => style?.color ?? theme.colorScheme.onSurface,
      AmountTone.positive => AppTheme.success,
      AmountTone.negative => theme.colorScheme.error,
    };

    return Text(
      '$prefix$displayValue',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: (style ?? theme.textTheme.titleMedium)?.copyWith(
        color: color,
        fontWeight: FontWeight.w900,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }
}
