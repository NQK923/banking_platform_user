import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/error/app_exception.dart';
import '../data/wallet_repository.dart';
import 'balance_provider.dart';
import 'wallet_models.dart';

part 'deposit_notifier.g.dart';

enum DepositStatus {
  idle,
  submitting,
  success,
  error,
}

class DepositState {
  final DepositStatus status;
  final MovementResponse? response;
  final String? errorMessage;

  const DepositState({
    required this.status,
    this.response,
    this.errorMessage,
  });

  factory DepositState.idle() => const DepositState(status: DepositStatus.idle);
  factory DepositState.submitting() => const DepositState(status: DepositStatus.submitting);
  factory DepositState.success(MovementResponse response) => DepositState(status: DepositStatus.success, response: response);
  factory DepositState.error(String message) => DepositState(status: DepositStatus.error, errorMessage: message);
}

@riverpod
class DepositNotifier extends _$DepositNotifier {
  late final WalletRepository _walletRepository;

  @override
  DepositState build() {
    _walletRepository = ref.watch(walletRepositoryProvider);
    return DepositState.idle();
  }

  Future<void> submitDeposit(String amount) async {
    state = DepositState.submitting();
    try {
      final res = await _walletRepository.deposit(amount);
      state = DepositState.success(res);
      // Automatically refresh the balance locally on success
      ref.read(balanceProvider.notifier).refreshBalance();
    } on AppException catch (e) {
      state = DepositState.error(e.userFriendlyMessage);
    } catch (e) {
      state = DepositState.error(e.toString());
    }
  }

  void reset() {
    state = DepositState.idle();
  }
}
