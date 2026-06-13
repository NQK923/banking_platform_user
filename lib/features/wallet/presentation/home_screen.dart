import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/money/money.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/amount_text.dart';
import '../../../shared/widgets/error_view.dart';
import '../../../shared/widgets/skeleton.dart';
import '../../../shared/widgets/transaction_row.dart';
import '../../auth/domain/auth_notifier.dart';
import '../../auth/domain/auth_state.dart';
import '../../history/domain/history_provider.dart';
import '../domain/balance_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        title: const Text('Wallet'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: onRefresh,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.l,
            AppSpacing.s,
            AppSpacing.l,
            AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              balanceState.when(
                loading: () => const _BalanceSkeleton(),
                error: (err, stack) => ErrorView(
                  error: err,
                  onRetry: () =>
                      ref.read(balanceProvider.notifier).refreshBalance(),
                  inline: true,
                ),
                data: (balanceData) => _BalanceHero(
                  balance: Money(
                    amount: balanceData.balance,
                    currency: balanceData.currency,
                  ),
                  accountId: balanceData.accountId,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              _QuickActionsGrid(
                actions: [
                  _QuickActionData(
                    icon: Icons.send_rounded,
                    label: 'Send',
                    onTap: () => context.push('/transfer'),
                  ),
                  _QuickActionData(
                    icon: Icons.add_card_rounded,
                    label: 'Deposit',
                    onTap: () => context.push('/deposit'),
                  ),
                  _QuickActionData(
                    icon: Icons.south_west_rounded,
                    label: 'Withdraw',
                    onTap: () => context.push('/withdraw'),
                  ),
                  _QuickActionData(
                    icon: Icons.support_agent_rounded,
                    label: 'Support',
                    onTap: () => context.go('/support'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              SectionHeader(
                title: 'Recent activity',
                actionLabel: 'View all',
                onAction: () => GoRouter.of(context).go('/history'),
              ),
              const SizedBox(height: AppSpacing.s),
              if (historyState.isLoading && historyState.transactions.isEmpty)
                const AppCard(child: TransactionSkeletonList(itemCount: 4))
              else if (historyState.errorMessage != null &&
                  historyState.transactions.isEmpty)
                ErrorView(
                  error: historyState.errorMessage!,
                  onRetry: () => ref.read(historyProvider.notifier).refresh(),
                  inline: true,
                )
              else if (historyState.transactions.isEmpty)
                EmptyState(
                  icon: Icons.receipt_long_outlined,
                  title: 'No transactions yet',
                  message:
                      'Your deposits, withdrawals, and transfers will appear here.',
                  actionLabel: 'Make a deposit',
                  onAction: () => context.push('/deposit'),
                )
              else
                AppCard(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
                  child: Column(
                    children: List.generate(
                      math.min(5, historyState.transactions.length),
                      (index) {
                        final tx = historyState.transactions[index];
                        return Column(
                          children: [
                            TransactionRow(
                              transaction: tx,
                              currentUserAccountId: currentUserAccountId,
                              compact: true,
                              onTap: () =>
                                  context.push('/transactions/${tx.id}'),
                            ),
                            if (index !=
                                math.min(5, historyState.transactions.length) -
                                    1)
                              Divider(
                                height: 1,
                                indent: 72,
                                color: Theme.of(
                                  context,
                                ).colorScheme.outlineVariant,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionData {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionData({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

class _QuickActionsGrid extends StatelessWidget {
  final List<_QuickActionData> actions;

  const _QuickActionsGrid({required this.actions});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textScale = MediaQuery.textScalerOf(context).scale(1);
        final columns = constraints.maxWidth < 380 || textScale > 1.25 ? 2 : 3;
        const gap = AppSpacing.m;
        final itemWidth =
            (constraints.maxWidth - (gap * (columns - 1))) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: actions
              .map(
                (action) => SizedBox(
                  width: itemWidth,
                  child: _QuickActionButton(
                    icon: action.icon,
                    label: action.label,
                    onTap: action.onTap,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _BalanceHero extends StatelessWidget {
  final Money balance;
  final String accountId;

  const _BalanceHero({required this.balance, required this.accountId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          colors.primary,
          Color.lerp(colors.primary, colors.secondary, 0.65)!,
          colors.tertiary,
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: colors.onPrimary.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(AppRadius.m),
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: colors.onPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.m,
                  vertical: AppSpacing.s,
                ),
                decoration: BoxDecoration(
                  color: colors.onPrimary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  balance.currency,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Available balance',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onPrimary.withValues(alpha: 0.78),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          AmountText.neutral(
            amount: balance.amount,
            currency: balance.currency,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: colors.onPrimary,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Wallet ID',
            style: theme.textTheme.labelSmall?.copyWith(
              color: colors.onPrimary.withValues(alpha: 0.72),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            _short(accountId),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onPrimary,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  String _short(String value) {
    if (value.length <= 20) return value;
    return '${value.substring(0, 10)}...${value.substring(value.length - 6)}';
  }
}

class _BalanceSkeleton extends StatelessWidget {
  const _BalanceSkeleton();

  @override
  Widget build(BuildContext context) {
    return const AppCard(
      padding: EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(height: 42, width: 42),
          SizedBox(height: AppSpacing.xl),
          SkeletonBox(height: 14, width: 140),
          SizedBox(height: AppSpacing.s),
          SkeletonBox(height: 36, width: 240),
          SizedBox(height: AppSpacing.xl),
          SkeletonBox(height: 12, width: 90),
          SizedBox(height: AppSpacing.s),
          SkeletonBox(height: 14, width: 180),
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
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.l),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.l),
          child: Container(
            constraints: const BoxConstraints(minHeight: 92),
            padding: const EdgeInsets.all(AppSpacing.m),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.l),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: theme.colorScheme.primary, size: 26),
                const SizedBox(height: AppSpacing.s),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
