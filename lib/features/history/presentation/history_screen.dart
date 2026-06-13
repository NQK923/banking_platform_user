import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/error_view.dart';
import '../../../shared/widgets/skeleton.dart';
import '../../../shared/widgets/transaction_row.dart';
import '../../auth/domain/auth_notifier.dart';
import '../../auth/domain/auth_state.dart';
import '../domain/history_provider.dart';
import '../domain/wallet_transaction.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(historyProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final historyState = ref.watch(historyProvider);

    String currentUserAccountId = '';
    if (authState is AuthStateAuthenticated) {
      currentUserAccountId = authState.accountId ?? '';
    }

    Future<void> onRefresh() async {
      await ref.read(historyProvider.notifier).refresh();
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.history)),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: _buildBody(historyState, currentUserAccountId),
      ),
    );
  }

  Widget _buildBody(HistoryState historyState, String currentUserAccountId) {
    if (historyState.isLoading && historyState.transactions.isEmpty) {
      return const SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(AppSpacing.l),
        child: AppCard(child: TransactionSkeletonList(itemCount: 8)),
      );
    }

    if (historyState.errorMessage != null &&
        historyState.transactions.isEmpty) {
      return ErrorView(
        error: historyState.errorMessage!,
        onRetry: () => ref.read(historyProvider.notifier).refresh(),
      );
    }

    if (historyState.transactions.isEmpty) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.l),
        child: EmptyState(
          icon: Icons.history_rounded,
          title: context.l10n.noTransactionHistory,
          message: context.l10n.transactionHistoryEmptyMessage,
          actionLabel: context.l10n.refresh,
          onAction: () => ref.read(historyProvider.notifier).refresh(),
        ),
      );
    }

    final grouped = _groupByDate(context, historyState.transactions);
    final entries = grouped.entries.toList();

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.l,
        AppSpacing.s,
        AppSpacing.l,
        AppSpacing.xxl,
      ),
      itemCount: entries.length + (historyState.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == entries.length) {
          return const Padding(
            padding: EdgeInsets.only(top: AppSpacing.m),
            child: AppCard(child: TransactionSkeletonList(itemCount: 2)),
          );
        }

        final group = entries[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group.key,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.s),
              AppCard(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
                child: Column(
                  children: List.generate(group.value.length, (txIndex) {
                    final tx = group.value[txIndex];
                    return Column(
                      children: [
                        TransactionRow(
                          transaction: tx,
                          currentUserAccountId: currentUserAccountId,
                          onTap: () => context.push('/transactions/${tx.id}'),
                        ),
                        if (txIndex != group.value.length - 1)
                          Divider(
                            height: 1,
                            indent: 72,
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Map<String, List<WalletTransaction>> _groupByDate(
    BuildContext context,
    List<WalletTransaction> transactions,
  ) {
    final groups = <String, List<WalletTransaction>>{};
    for (final tx in transactions) {
      final key = _formatDate(context, tx.createdAt);
      groups.putIfAbsent(key, () => []).add(tx);
    }
    return groups;
  }

  String _formatDate(BuildContext context, String isoString) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final txDay = DateTime(dateTime.year, dateTime.month, dateTime.day);
      if (txDay == today) return context.l10n.today;
      if (txDay == today.subtract(const Duration(days: 1))) {
        return context.l10n.yesterday;
      }
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    } catch (_) {
      return isoString;
    }
  }
}
