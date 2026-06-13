import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../domain/transfer_models.dart';
import '../../history/domain/wallet_transaction.dart';

final transferRepositoryProvider = Provider<TransferRepository>((ref) {
  return TransferRepository(ref.watch(apiClientProvider));
});

class TransferRepository {
  final ApiClient _apiClient;

  TransferRepository(this._apiClient);

  Future<AccountRecord> lookupRecipient({String? email, String? phone}) async {
    final queryParams = <String, dynamic>{};
    if (email != null && email.isNotEmpty) {
      queryParams['email'] = email;
    }
    if (phone != null && phone.isNotEmpty) {
      queryParams['phone'] = phone;
    }

    final response = await _apiClient.get(
      '/api/accounts/lookup',
      queryParameters: queryParams,
    );
    return AccountRecord.fromJson(response.data as Map<String, dynamic>);
  }

  Future<TransferSubmissionResult> initiateTransfer(
    TransferRequest request,
  ) async {
    final response = await _apiClient.post(
      '/api/transactions/transfer',
      data: request.toJson(),
      options: Options(headers: {'Idempotency-Key': request.idempotencyKey}),
    );
    final data = response.data as Map<String, dynamic>;
    if (data.containsKey('result') && data.containsKey('riskEvaluationId')) {
      return TransferRiskRequired(TransferRiskResponse.fromJson(data));
    }
    return TransferSubmitted(WalletTransaction.fromJson(data));
  }
}
