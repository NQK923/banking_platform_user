import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../features/history/domain/wallet_transaction.dart';
import 'amount_text.dart';
import 'status_chip.dart';

class TransactionRow extends StatelessWidget {
  final WalletTransaction transaction;
  final String currentUserAccountId;
  final VoidCallback? onTap;
  final bool compact;

  const TransactionRow({
    super.key,
    required this.transaction,
    required this.currentUserAccountId,
    this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDebit = transaction.senderId == currentUserAccountId;
    final color = isDebit ? theme.colorScheme.error : AppTheme.success;
    final counterpartyId = isDebit
        ? transaction.receiverId
        : transaction.senderId;
    final title = isDebit ? 'Money sent' : 'Money received';
    final subtitle =
        '${_shortId(counterpartyId)} - ${_formatTime(transaction.createdAt)}';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.l),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final textScale = MediaQuery.textScalerOf(context).scale(1);
            final stacked = constraints.maxWidth < 360 || textScale > 1.25;
            final leading = CircleAvatar(
              radius: 24,
              backgroundColor: color.withValues(alpha: 0.12),
              child: Text(
                isDebit ? 'S' : 'R',
                style: TextStyle(color: color, fontWeight: FontWeight.w900),
              ),
            );
            final titleBlock = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            );
            final amountBlock = Column(
              crossAxisAlignment: stacked
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                AmountText.forTransaction(
                  transaction: transaction,
                  currentUserAccountId: currentUserAccountId,
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: AppSpacing.xs),
                StatusChip(status: transaction.status.name),
              ],
            );

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? AppSpacing.s : AppSpacing.m,
                vertical: compact ? AppSpacing.s : AppSpacing.m,
              ),
              child: stacked
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            leading,
                            const SizedBox(width: AppSpacing.m),
                            Expanded(child: titleBlock),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.s),
                        Padding(
                          padding: const EdgeInsets.only(left: 60),
                          child: amountBlock,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        leading,
                        const SizedBox(width: AppSpacing.m),
                        Expanded(child: titleBlock),
                        const SizedBox(width: AppSpacing.m),
                        Flexible(child: amountBlock),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  String _shortId(String value) {
    if (value.length <= 10) return value;
    return '${value.substring(0, 6)}...${value.substring(value.length - 2)}';
  }

  String _formatTime(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return isoString;
    }
  }
}
