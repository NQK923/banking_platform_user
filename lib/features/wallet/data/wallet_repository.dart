import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
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
      throw Exception('Không tìm thấy tài khoản ví hoạt động. Vui lòng đăng ký ví.');
    }
    
    final response = await _apiClient.get('/api/accounts/$accountId/balance');
    return BalanceResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<AccountRecord> getAccountDetails() async {
    final accountId = await _authRepository.getAccountId();
    if (accountId == null || accountId.isEmpty) {
      throw Exception('Không tìm thấy tài khoản ví hoạt động.');
    }
    final response = await _apiClient.get('/api/accounts/$accountId');
    return AccountRecord.fromJson(response.data as Map<String, dynamic>);
  }

  Future<MovementResponse> deposit(String amount) async {
    final accountId = await _authRepository.getAccountId();
    if (accountId == null || accountId.isEmpty) {
      throw Exception('Không tìm thấy tài khoản ví hoạt động.');
    }
    
    final idempotencyKey = const Uuid().v4();
    final response = await _apiClient.post(
      '/api/accounts/$accountId/deposit',
      data: {
        'amount': amount,
      },
      options: Options(
        headers: {
          'Idempotency-Key': idempotencyKey,
        },
      ),
    );
    // TODO: The backend deposit endpoint does not explicitly consume or validate the 
    // Idempotency-Key header at the controller layer yet, but we attach it to adhere to 
    // the system-wide money-moving POST contract.
    return MovementResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<MovementResponse> withdraw(String amount) async {
    final accountId = await _authRepository.getAccountId();
    if (accountId == null || accountId.isEmpty) {
      throw Exception('Không tìm thấy tài khoản ví hoạt động.');
    }
    
    final idempotencyKey = const Uuid().v4();
    final response = await _apiClient.post(
      '/api/accounts/$accountId/withdraw',
      data: {
        'amount': amount,
      },
      options: Options(
        headers: {
          'Idempotency-Key': idempotencyKey,
        },
      ),
    );
    // TODO: The backend withdraw endpoint does not explicitly consume or validate the 
    // Idempotency-Key header at the controller layer yet, but we attach it to adhere to 
    // the system-wide money-moving POST contract.
    return MovementResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
