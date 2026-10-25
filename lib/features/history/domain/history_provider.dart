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
  late HistoryRepository _historyRepository;
  static const int _pageSize = 10;
  int _generation = 0;
  bool _disposed = false;

  @override
  HistoryState build() {
    _historyRepository = ref.watch(historyRepositoryProvider);
    _disposed = false;
    ref.onDispose(() {
      _disposed = true;
      _generation++;
    });
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
    final generation = ++_generation;
    try {
      final response = await _historyRepository.getHistory(
        page: 0,
        size: _pageSize,
      );
      if (_disposed || generation != _generation) return;
      state = HistoryState(
        transactions: response.items,
        isLoading: false,
        hasMore: response.page < response.totalPages - 1,
        isLoadingMore: false,
        currentPage: 0,
      );
    } catch (e) {
      if (_disposed || generation != _generation) return;
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
    state = state.copyWith(
      isLoading: true,
      isLoadingMore: false,
      errorMessage: null,
    );
    await _init();
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);
    final generation = _generation;
    final nextPage = state.currentPage + 1;

    try {
      final response = await _historyRepository.getHistory(
        page: nextPage,
        size: _pageSize,
      );
      if (_disposed || generation != _generation) return;
      final newTransactions = [...state.transactions, ...response.items];
      final hasMore = response.page < response.totalPages - 1;

      state = state.copyWith(
        transactions: newTransactions,
        currentPage: nextPage,
        hasMore: hasMore,
        isLoadingMore: false,
      );
    } catch (e) {
      if (_disposed || generation != _generation) return;
      state = state.copyWith(isLoadingMore: false, errorMessage: e.toString());
    }
  }
}
