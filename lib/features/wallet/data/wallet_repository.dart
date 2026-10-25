import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../domain/wallet_models.dart';
import '../../auth/data/auth_repository.dart';
import '../../transfer/domain/transfer_models.dart';

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return WalletRepository(
    ref.watch(apiClientProvider),
    ref.watch(authRepositoryProvider),
  );
});

class WalletRepository {
  final ApiClient _apiClient;
  final AuthRepository _authRepository;

  WalletRepository(this._apiClient, this._authRepository);

  Future<BalanceResponse> getBalance() async {
    final accountId = await _authRepository.getAccountId();
    if (accountId == null || accountId.isEmpty) {
      throw Exception('No active wallet account found. Please register a wallet.');
    }

    final response = await _apiClient.get('/api/accounts/$accountId/balance');
    return BalanceResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<AccountRecord> getAccountDetails() async {
    final accountId = await _authRepository.getAccountId();
    if (accountId == null || accountId.isEmpty) {
      throw Exception('No active wallet account found.');
    }
    final response = await _apiClient.get('/api/accounts/$accountId');
    return AccountRecord.fromJson(response.data as Map<String, dynamic>);
  }

  Future<MovementResponse> withdraw(
    String amount,
    String pin,
    String idempotencyKey,
  ) async {
    final accountId = await _authRepository.getAccountId();
    if (accountId == null || accountId.isEmpty) {
      throw Exception('No active wallet account found.');
    }

    final response = await _apiClient.post(
      '/api/accounts/$accountId/withdraw',
      data: {'amount': amount, 'pin': pin},
      options: Options(headers: {'Idempotency-Key': idempotencyKey}),
    );
    return MovementResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
