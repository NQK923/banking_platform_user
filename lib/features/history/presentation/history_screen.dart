import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/amount_text.dart';
import '../../../shared/widgets/error_view.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../auth/domain/auth_notifier.dart';
import '../../auth/domain/auth_state.dart';
import '../domain/history_provider.dart';

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
    final theme = Theme.of(context);
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
      appBar: AppBar(title: const Text('Lịch sử giao dịch')),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: _buildBody(theme, historyState, currentUserAccountId),
      ),
    );
  }

  Widget _buildBody(
    ThemeData theme,
    HistoryState historyState,
    String currentUserAccountId,
  ) {
    if (historyState.isLoading && historyState.transactions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (historyState.errorMessage != null &&
        historyState.transactions.isEmpty) {
      return ErrorView(
        error: historyState.errorMessage!,
        onRetry: () => ref.read(historyProvider.notifier).refresh(),
      );
    }

    if (historyState.transactions.isEmpty) {
      return _buildEmptyState(theme);
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppSpacing.m),
      itemCount:
          historyState.transactions.length + (historyState.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == historyState.transactions.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.m),
            child: Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }

        final tx = historyState.transactions[index];
        final isDebit = tx.senderId == currentUserAccountId;
        final txTitle = isDebit ? 'Chuyển tiền' : 'Nhận tiền';
        final txIcon = isDebit ? Icons.arrow_outward : Icons.arrow_downward;
        final iconColor = isDebit ? theme.colorScheme.error : Colors.green;

        // Counterparty info: the other party's account ID
        final counterpartyId = isDebit ? tx.receiverId : tx.senderId;

        return Card(
          margin: const EdgeInsets.only(bottom: AppSpacing.s),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: iconColor.withOpacity(0.08),
              child: Icon(txIcon, color: iconColor),
            ),
            title: Text(
              txTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2),
                Text(
                  'Đối tác: ${counterpartyId.substring(0, 8)}...',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatDateTime(tx.createdAt),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.4),
                  ),
                ),
              ],
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
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.history,
                size: 64,
                color: theme.colorScheme.onBackground.withOpacity(0.2),
              ),
              const SizedBox(height: AppSpacing.m),
              Text(
                'Chưa có lịch sử giao dịch',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Thực hiện các giao dịch chuyển tiền, nạp tiền để xem ở đây.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onBackground.withOpacity(0.4),
                ),
                textAlign: TextAlign.center,
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
