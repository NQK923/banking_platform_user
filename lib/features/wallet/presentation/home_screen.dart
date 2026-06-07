import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/money/money.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/amount_text.dart';
import '../../../shared/widgets/error_view.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../auth/domain/auth_notifier.dart';
import '../../auth/domain/auth_state.dart';
import '../domain/balance_provider.dart';
import '../../history/domain/history_provider.dart';
import '../../history/domain/wallet_transaction.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authNotifierProvider);
    final balanceState = ref.watch(balanceProvider);
    final historyState = ref.watch(historyProvider);

    String currentUserAccountId = '';
    if (authState is AuthStateAuthenticated) {
      currentUserAccountId = authState.accountId ?? '';
    }

    Future<void> onRefresh() async {
      await Future.wait([
        ref.read(balanceProvider.notifier).refreshBalance(),
        ref.read(historyProvider.notifier).refresh(),
      ]);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Wallet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: onRefresh,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Balance Section
              balanceState.when(
                loading: () => const _CardLoadingStub(),
                error: (err, stack) => ErrorView(
                  error: err,
                  onRetry: () => ref.read(balanceProvider.notifier).refreshBalance(),
                  inline: true,
                ),
                data: (balanceData) {
                  final money = Money(
                    amount: balanceData.balance,
                    currency: balanceData.currency,
                  );
                  return Card(
                    color: theme.colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.l),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tài khoản chính',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onPrimary.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            money.formatDisplay(),
                            style: theme.textTheme.headlineLarge?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.m),
                          Divider(color: theme.colorScheme.onPrimary.withOpacity(0.2)),
                          const SizedBox(height: AppSpacing.s),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ID Ví:',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onPrimary.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                balanceData.accountId,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onPrimary,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.l),

              // Quick Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _QuickActionButton(
                    icon: Icons.send_outlined,
                    label: 'Chuyển tiền',
                    onTap: () => context.push('/transfer'),
                  ),
                  _QuickActionButton(
                    icon: Icons.add_circle_outline,
                    label: 'Nạp tiền',
                    onTap: () => context.push('/deposit'),
                  ),
                  _QuickActionButton(
                    icon: Icons.arrow_downward_outlined,
                    label: 'Rút tiền',
                    onTap: () => context.push('/withdraw'),
                  ),
                  _QuickActionButton(
                    icon: Icons.history_outlined,
                    label: 'Lịch sử',
                    onTap: () => GoRouter.of(context).go('/history'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Recent Transactions Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Giao dịch gần đây',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => GoRouter.of(context).go('/history'),
                    child: const Text('Xem tất cả'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s),

              // Recent Transactions List
              if (historyState.isLoading && historyState.transactions.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.l),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (historyState.errorMessage != null && historyState.transactions.isEmpty)
                ErrorView(
                  error: historyState.errorMessage!,
                  onRetry: () => ref.read(historyProvider.notifier).refresh(),
                  inline: true,
                )
              else if (historyState.transactions.isEmpty)
                _EmptyTransactionsStub()
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: math.min(5, historyState.transactions.length),
                  separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.s),
                  itemBuilder: (context, index) {
                    final tx = historyState.transactions[index];
                    final isDebit = tx.senderId == currentUserAccountId;
                    final txTitle = isDebit ? 'Chuyển tiền' : 'Nhận tiền';
                    final txIcon = isDebit ? Icons.arrow_outward : Icons.arrow_downward;
                    final iconColor = isDebit ? theme.colorScheme.error : Colors.green;

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: iconColor.withOpacity(0.08),
                          child: Icon(txIcon, color: iconColor),
                        ),
                        title: Text(
                          txTitle,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          _formatDateTime(tx.createdAt),
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AmountText.forTransaction(
                              transaction: tx,
                              currentUserAccountId: currentUserAccountId,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            StatusChip(status: tx.status.name),
                          ],
                        ),
                        onTap: () {
                          context.push('/transactions/${tx.id}');
                        },
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} - ${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    } catch (e) {
      return isoString;
    }
  }
}

class _CardLoadingStub extends StatelessWidget {
  const _CardLoadingStub();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.primary.withOpacity(0.5),
      child: const SizedBox(
        height: 150,
        child: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}

class _EmptyTransactionsStub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.l),
        border: Border.all(color: theme.colorScheme.onSurface.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 48,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            'Chưa có giao dịch nào',
            style: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
