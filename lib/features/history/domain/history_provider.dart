import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/history_repository.dart';
import 'wallet_transaction.dart';

part 'history_provider.freezed.dart';
part 'history_provider.g.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState({
    required List<WalletTransaction> transactions,
    required bool isLoading,
    required bool hasMore,
    required bool isLoadingMore,
    required int currentPage,
    String? errorMessage,
  }) = _HistoryState;
}

@riverpod
class History extends _$History {
  late final HistoryRepository _historyRepository;
  static const int _pageSize = 10;

  @override
  HistoryState build() {
    _historyRepository = ref.watch(historyRepositoryProvider);
    _init();
    return const HistoryState(
      transactions: [],
      isLoading: true,
      hasMore: false,
      isLoadingMore: false,
      currentPage: 0,
    );
  }

  Future<void> _init() async {
    try {
      final response = await _historyRepository.getHistory(
        page: 0,
        size: _pageSize,
      );
      state = HistoryState(
        transactions: response.items,
        isLoading: false,
        hasMore: response.page < response.totalPages - 1,
        isLoadingMore: false,
        currentPage: 0,
      );
    } catch (e) {
      state = HistoryState(
        transactions: [],
        isLoading: false,
        hasMore: false,
        isLoadingMore: false,
        currentPage: 0,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    await _init();
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    // Artificial delay to show the loading shimmer/indicator in a premium way
    await Future.delayed(const Duration(milliseconds: 600));

    final nextPage = state.currentPage + 1;

    try {
      final response = await _historyRepository.getHistory(
        page: nextPage,
        size: _pageSize,
      );
      final newTransactions = [...state.transactions, ...response.items];
      final hasMore = response.page < response.totalPages - 1;

      state = state.copyWith(
        transactions: newTransactions,
        currentPage: nextPage,
        hasMore: hasMore,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, errorMessage: e.toString());
    }
  }
}
