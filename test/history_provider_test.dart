import 'dart:async';

import 'package:banking_platform_user/features/history/data/history_repository.dart';
import 'package:banking_platform_user/features/history/domain/history_models.dart';
import 'package:banking_platform_user/features/history/domain/history_provider.dart';
import 'package:banking_platform_user/features/history/domain/wallet_transaction.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _HistoryRepository implements HistoryRepository {
  final requests = <({int page, Completer<PaginatedHistoryResponse> result})>[];

  @override
  Future<PaginatedHistoryResponse> getHistory({
    required int page,
    required int size,
  }) {
    final result = Completer<PaginatedHistoryResponse>();
    requests.add((page: page, result: result));
    return result.future;
  }

  @override
  Future<WalletTransaction> getTransactionDetail(String transactionId) =>
      throw UnimplementedError(
        'History pagination does not fetch individual transactions',
      );
}

WalletTransaction _transaction(String id) => WalletTransaction(
  id: id,
  senderId: 'sender',
  receiverId: 'receiver',
  amount: Decimal.one,
  currency: 'VND',
  status: TransactionStatus.COMPLETED,
  idempotencyKey: id,
  createdAt: '2026-10-25T00:00:00Z',
  updatedAt: '2026-10-25T00:00:00Z',
  debitApplied: true,
);

PaginatedHistoryResponse _page(String id, {int page = 0, int totalPages = 2}) =>
    PaginatedHistoryResponse(
      items: [_transaction(id)],
      page: page,
      size: 10,
      totalElements: totalPages,
      totalPages: totalPages,
    );

void main() {
  late _HistoryRepository repository;
  late ProviderContainer container;
  setUp(() {
    repository = _HistoryRepository();
    container = ProviderContainer(
      overrides: [historyRepositoryProvider.overrideWithValue(repository)],
    );
    container.listen(historyProvider, (previous, next) {});
  });
  tearDown(() => container.dispose());

  test('refresh discards an older first page response', () async {
    final refresh = container.read(historyProvider.notifier).refresh();
    repository.requests[1].result.complete(_page('new'));
    await refresh;
    repository.requests[0].result.complete(_page('old'));
    await Future<void>.delayed(Duration.zero);
    expect(container.read(historyProvider).transactions.single.id, 'new');
  });

  test('invalidating observed history safely rebuilds its notifier', () async {
    repository.requests[0].result.complete(_page('initial'));
    await Future<void>.delayed(Duration.zero);
    container.invalidate(historyProvider);
    expect(container.read(historyProvider).isLoading, isTrue);
    repository.requests[1].result.complete(_page('updated'));
    await Future<void>.delayed(Duration.zero);
    expect(container.read(historyProvider).transactions.single.id, 'updated');
  });

  test('refresh discards an in-flight pagination response', () async {
    repository.requests[0].result.complete(_page('initial'));
    await Future<void>.delayed(Duration.zero);
    final notifier = container.read(historyProvider.notifier);
    final more = notifier.loadMore();
    expect(repository.requests[1].page, 1);
    final refresh = notifier.refresh();
    repository.requests[2].result.complete(_page('refreshed'));
    await refresh;
    repository.requests[1].result.complete(_page('stale-page', page: 1));
    await more;
    final state = container.read(historyProvider);
    expect(state.transactions.map((tx) => tx.id), ['refreshed']);
    expect(state.currentPage, 0);
    expect(state.isLoadingMore, isFalse);
  });

  test(
    'late failure from pagination does not overwrite refreshed state',
    () async {
      repository.requests[0].result.complete(_page('initial'));
      await Future<void>.delayed(Duration.zero);
      final notifier = container.read(historyProvider.notifier);
      final more = notifier.loadMore();
      final refresh = notifier.refresh();
      repository.requests[2].result.complete(_page('refreshed'));
      await refresh;
      repository.requests[1].result.completeError(
        StateError('obsolete failure'),
      );
      await more;
      expect(container.read(historyProvider).errorMessage, isNull);
    },
  );
}
