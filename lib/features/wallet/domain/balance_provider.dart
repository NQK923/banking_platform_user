import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/wallet_repository.dart';
import 'wallet_models.dart';
import '../../transfer/domain/transfer_models.dart';

part 'balance_provider.g.dart';

@riverpod
class Balance extends _$Balance {
  late final WalletRepository _walletRepository;

  @override
  FutureOr<BalanceResponse> build() async {
    _walletRepository = ref.watch(walletRepositoryProvider);
    return _walletRepository.getBalance();
  }

  Future<void> refreshBalance() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _walletRepository.getBalance());
  }
}

@riverpod
Future<AccountRecord> accountDetails(AccountDetailsRef ref) {
  return ref.watch(walletRepositoryProvider).getAccountDetails();
}
