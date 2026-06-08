import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../domain/wallet_transaction.dart';
import '../domain/history_models.dart';
import '../../auth/data/auth_repository.dart';

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepository(
    ref.watch(apiClientProvider),
    ref.watch(authRepositoryProvider),
  );
});

class HistoryRepository {
  final ApiClient _apiClient;
  final AuthRepository _authRepository;

  HistoryRepository(this._apiClient, this._authRepository);

  Future<PaginatedHistoryResponse> getHistory({
    required int page,
    required int size,
  }) async {
    final accountId = await _authRepository.getAccountId();
    if (accountId == null || accountId.isEmpty) {
      throw Exception('Không tìm thấy tài khoản ví hoạt động.');
    }

    final response = await _apiClient.get(
      '/api/accounts/$accountId/history',
      queryParameters: {'page': page, 'size': size},
    );
    return PaginatedHistoryResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<WalletTransaction> getTransactionDetail(String transactionId) async {
    final response = await _apiClient.get('/api/transactions/$transactionId');
    return WalletTransaction.fromJson(response.data as Map<String, dynamic>);
  }
}
