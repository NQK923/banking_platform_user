import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../domain/wallet_transaction.dart';
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

  Future<List<WalletTransaction>> getHistory() async {
    final accountId = await _authRepository.getAccountId();
    if (accountId == null || accountId.isEmpty) {
      throw Exception('Không tìm thấy tài khoản ví hoạt động.');
    }

    final response = await _apiClient.get('/api/accounts/$accountId/history');
    final data = response.data as List<dynamic>;
    
    // Sort transactions by createdAt descending so recent transactions are first
    final list = data
        .map((item) => WalletTransaction.fromJson(item as Map<String, dynamic>))
        .toList();
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  Future<WalletTransaction> getTransactionDetail(String transactionId) async {
    final response = await _apiClient.get('/api/transactions/$transactionId');
    return WalletTransaction.fromJson(response.data as Map<String, dynamic>);
  }
}
