import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/locale_provider.dart';
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
        content: Text(context.l10n.copiedLabel(label)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final authState = ref.watch(authNotifierProvider);
    final detailState = ref.watch(transactionDetailProvider(transactionId));

    String currentUserAccountId = '';
    if (authState is AuthStateAuthenticated) {
      currentUserAccountId = authState.accountId ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.transactionTitle),
        leading: IconButton(
          tooltip: l10n.back,
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
              ? (tx.failureReason ?? l10n.genericTransferFailureMessage)
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
                        isDebit ? l10n.moneySent : l10n.moneyReceived,
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
                                l10n.failureReason,
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
                              l10n.askAboutTransaction,
                              style: theme.textTheme.titleSmall,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              l10n.askAboutTransactionSubtitle,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton.filledTonal(
                        tooltip: l10n.askSupport,
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
                      Text(l10n.details, style: theme.textTheme.titleMedium),
                      const SizedBox(height: AppSpacing.m),
                      _DetailRow(
                        label: l10n.transactionId,
                        value: tx.id,
                        copyable: true,
                        onCopy: () => _copyToClipboard(
                          context,
                          tx.id,
                          l10n.transactionId,
                        ),
                      ),
                      _DetailRow(
                        label: l10n.sender,
                        value: tx.senderId,
                        subValue: tx.senderId == currentUserAccountId
                            ? l10n.yourWallet
                            : null,
                        copyable: true,
                        onCopy: () =>
                            _copyToClipboard(context, tx.senderId, l10n.sender),
                      ),
                      _DetailRow(
                        label: l10n.receiver,
                        value: tx.receiverId,
                        subValue: tx.receiverId == currentUserAccountId
                            ? l10n.yourWallet
                            : null,
                        copyable: true,
                        onCopy: () => _copyToClipboard(
                          context,
                          tx.receiverId,
                          l10n.receiver,
                        ),
                      ),
                      _DetailRow(
                        label: l10n.created,
                        value: _formatDateTime(tx.createdAt),
                      ),
                      _DetailRow(
                        label: l10n.updated,
                        value: _formatDateTime(tx.updatedAt),
                      ),
                      _DetailRow(
                        label: l10n.idempotencyKey,
                        value: tx.idempotencyKey,
                        copyable: true,
                        onCopy: () => _copyToClipboard(
                          context,
                          tx.idempotencyKey,
                          l10n.idempotencyKey,
                        ),
                      ),
                      if (tx.correlationId != null)
                        _DetailRow(
                          label: l10n.correlationId,
                          value: tx.correlationId!,
                          copyable: true,
                          onCopy: () => _copyToClipboard(
                            context,
                            tx.correlationId!,
                            l10n.correlationId,
                          ),
                        ),
                      _DetailRow(
                        label: l10n.message,
                        value: tx.note ?? l10n.defaultTransferMessage,
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
                  tooltip: context.l10n.copyLabel(label),
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
