import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/amount_text.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/error_view.dart';
import '../../../shared/widgets/skeleton.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../auth/domain/auth_notifier.dart';
import '../../auth/domain/auth_state.dart';
import '../domain/detail_provider.dart';
import '../domain/wallet_transaction.dart';

class TransactionDetailScreen extends ConsumerWidget {
  final String transactionId;

  const TransactionDetailScreen({super.key, required this.transactionId});

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authNotifierProvider);
    final detailState = ref.watch(transactionDetailProvider(transactionId));

    String currentUserAccountId = '';
    if (authState is AuthStateAuthenticated) {
      currentUserAccountId = authState.accountId ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: detailState.when(
        loading: () => const SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.l),
          child: AppCard(
            child: Column(
              children: [
                SkeletonBox(
                  height: 72,
                  width: 72,
                  borderRadius: BorderRadius.all(Radius.circular(36)),
                ),
                SizedBox(height: AppSpacing.l),
                SkeletonBox(height: 22, width: 180),
                SizedBox(height: AppSpacing.s),
                SkeletonBox(height: 34, width: 220),
                SizedBox(height: AppSpacing.xl),
                TransactionSkeletonList(itemCount: 4),
              ],
            ),
          ),
        ),
        error: (err, stack) => ErrorView(
          error: err,
          onRetry: () => ref.refresh(transactionDetailProvider(transactionId)),
        ),
        data: (tx) {
          final isDebit = tx.senderId == currentUserAccountId;
          final icon = isDebit
              ? Icons.north_east_rounded
              : Icons.south_west_rounded;
          final iconColor = isDebit
              ? theme.colorScheme.error
              : AppTheme.success;
          final failureText = tx.status == TransactionStatus.FAILED
              ? (tx.failureReason ?? _getFailureMessage(tx.idempotencyKey))
              : null;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppCard(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundColor: iconColor.withValues(alpha: 0.12),
                        child: Icon(icon, color: iconColor, size: 38),
                      ),
                      const SizedBox(height: AppSpacing.l),
                      Text(
                        isDebit ? 'Money sent' : 'Money received',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      AmountText.forTransaction(
                        transaction: tx,
                        currentUserAccountId: currentUserAccountId,
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: AppSpacing.m),
                      StatusChip(status: tx.status.name),
                    ],
                  ),
                ),
                if (failureText != null) ...[
                  const SizedBox(height: AppSpacing.l),
                  AppCard(
                    color: theme.colorScheme.errorContainer.withValues(
                      alpha: 0.32,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          color: theme.colorScheme.error,
                        ),
                        const SizedBox(width: AppSpacing.m),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Failure reason',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: theme.colorScheme.error,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(failureText, softWrap: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.l),
                AppCard(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child: Icon(
                          Icons.support_agent_rounded,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.m),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ask about this transaction',
                              style: theme.textTheme.titleSmall,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'Get a safe explanation of status, refund, failure reason, and traceId.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton.filledTonal(
                        tooltip: 'Ask support',
                        onPressed: () =>
                            context.push('/history/${tx.id}/support'),
                        icon: const Icon(Icons.arrow_forward_rounded),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.l),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Details', style: theme.textTheme.titleMedium),
                      const SizedBox(height: AppSpacing.m),
                      _DetailRow(
                        label: 'Transaction ID',
                        value: tx.id,
                        copyable: true,
                        onCopy: () =>
                            _copyToClipboard(context, tx.id, 'Transaction ID'),
                      ),
                      _DetailRow(
                        label: 'Sender',
                        value: tx.senderId,
                        subValue: tx.senderId == currentUserAccountId
                            ? 'Your wallet'
                            : null,
                        copyable: true,
                        onCopy: () =>
                            _copyToClipboard(context, tx.senderId, 'Sender'),
                      ),
                      _DetailRow(
                        label: 'Receiver',
                        value: tx.receiverId,
                        subValue: tx.receiverId == currentUserAccountId
                            ? 'Your wallet'
                            : null,
                        copyable: true,
                        onCopy: () => _copyToClipboard(
                          context,
                          tx.receiverId,
                          'Receiver',
                        ),
                      ),
                      _DetailRow(
                        label: 'Created',
                        value: _formatDateTime(tx.createdAt),
                      ),
                      _DetailRow(
                        label: 'Updated',
                        value: _formatDateTime(tx.updatedAt),
                      ),
                      _DetailRow(
                        label: 'Idempotency key',
                        value: tx.idempotencyKey,
                        copyable: true,
                        onCopy: () => _copyToClipboard(
                          context,
                          tx.idempotencyKey,
                          'Idempotency key',
                        ),
                      ),
                      if (tx.correlationId != null)
                        _DetailRow(
                          label: 'Correlation ID',
                          value: tx.correlationId!,
                          copyable: true,
                          onCopy: () => _copyToClipboard(
                            context,
                            tx.correlationId!,
                            'Correlation ID',
                          ),
                        ),
                      _DetailRow(
                        label: 'Message',
                        value: tx.note ?? 'E-Wallet transfer',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDateTime(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} - ${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    } catch (_) {
      return isoString;
    }
  }

  String _getFailureMessage(String key) {
    return 'The transfer could not be completed. The recipient account may be inactive or the sender balance may no longer be sufficient.';
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final String? subValue;
  final bool copyable;
  final VoidCallback? onCopy;

  const _DetailRow({
    required this.label,
    required this.value,
    this.subValue,
    this.copyable = false,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: copyable ? FontWeight.w700 : FontWeight.w500,
                    fontFamily: copyable ? 'monospace' : null,
                  ),
                ),
              ),
              if (copyable)
                IconButton(
                  tooltip: 'Copy $label',
                  onPressed: onCopy,
                  icon: const Icon(Icons.copy_rounded, size: 18),
                ),
            ],
          ),
          if (subValue != null)
            Text(
              subValue!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppTheme.success,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }
}
