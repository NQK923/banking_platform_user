import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/error/app_exception.dart';
import '../data/wallet_repository.dart';
import 'balance_provider.dart';
import 'wallet_models.dart';

part 'withdraw_notifier.g.dart';

enum WithdrawStatus {
  idle,
  submitting,
  success,
  error,
}

class WithdrawState {
  final WithdrawStatus status;
  final MovementResponse? response;
  final String? errorMessage;

  const WithdrawState({
    required this.status,
    this.response,
    this.errorMessage,
  });

  factory WithdrawState.idle() => const WithdrawState(status: WithdrawStatus.idle);
  factory WithdrawState.submitting() => const WithdrawState(status: WithdrawStatus.submitting);
  factory WithdrawState.success(MovementResponse response) => WithdrawState(status: WithdrawStatus.success, response: response);
  factory WithdrawState.error(String message) => WithdrawState(status: WithdrawStatus.error, errorMessage: message);
}

@riverpod
class WithdrawNotifier extends _$WithdrawNotifier {
  late final WalletRepository _walletRepository;

  @override
  WithdrawState build() {
    _walletRepository = ref.watch(walletRepositoryProvider);
    return WithdrawState.idle();
  }

  Future<void> submitWithdraw(String amount) async {
    state = WithdrawState.submitting();
    try {
      final res = await _walletRepository.withdraw(amount);
      state = WithdrawState.success(res);
      // Automatically refresh the balance locally on success
      ref.read(balanceProvider.notifier).refreshBalance();
    } on AppException catch (e) {
      state = WithdrawState.error(e.userFriendlyMessage);
    } catch (e) {
      state = WithdrawState.error(e.toString());
    }
  }

  void reset() {
    state = WithdrawState.idle();
  }
}
