import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/history_repository.dart';
import 'wallet_transaction.dart';

part 'detail_provider.g.dart';

@riverpod
Future<WalletTransaction> transactionDetail(
  TransactionDetailRef ref,
  String id,
) async {
  final repository = ref.watch(historyRepositoryProvider);
  return repository.getTransactionDetail(id);
}
