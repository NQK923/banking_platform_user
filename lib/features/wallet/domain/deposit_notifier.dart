import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/error/app_exception.dart';
import '../data/wallet_repository.dart';
import 'balance_provider.dart';
import 'wallet_models.dart';

part 'deposit_notifier.g.dart';

enum DepositStatus { idle, submitting, success, error }

class DepositState {
  final DepositStatus status;
  final MovementResponse? response;
  final String? errorMessage;
  final String? amount;
  final String? idempotencyKey;

  const DepositState({
    required this.status,
    this.response,
    this.errorMessage,
    this.amount,
    this.idempotencyKey,
  });

  factory DepositState.idle() => const DepositState(status: DepositStatus.idle);
  factory DepositState.submitting({String? amount, String? idempotencyKey}) =>
      DepositState(
        status: DepositStatus.submitting,
        amount: amount,
        idempotencyKey: idempotencyKey,
      );
  factory DepositState.success(MovementResponse response) =>
      DepositState(status: DepositStatus.success, response: response);
  factory DepositState.error(
    String message, {
    String? amount,
    String? idempotencyKey,
  }) => DepositState(
    status: DepositStatus.error,
    errorMessage: message,
    amount: amount,
    idempotencyKey: idempotencyKey,
  );
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
    final key = state.idempotencyKey ?? const Uuid().v4();
    state = DepositState.submitting(amount: amount, idempotencyKey: key);
    try {
      final res = await _walletRepository.deposit(amount, key);
      state = DepositState.success(res);
      ref.read(balanceProvider.notifier).refreshBalance();
    } on AppException catch (e) {
      state = DepositState.error(
        e.userFriendlyMessage,
        amount: amount,
        idempotencyKey: key,
      );
    } catch (e) {
      state = DepositState.error(
        e.toString(),
        amount: amount,
        idempotencyKey: key,
      );
    }
  }

  Future<void> retryDeposit() async {
    final amt = state.amount;
    final key = state.idempotencyKey;
    if (amt == null || key == null) return;

    state = DepositState.submitting(amount: amt, idempotencyKey: key);
    try {
      final res = await _walletRepository.deposit(amt, key);
      state = DepositState.success(res);
      ref.read(balanceProvider.notifier).refreshBalance();
    } on AppException catch (e) {
      state = DepositState.error(
        e.userFriendlyMessage,
        amount: amt,
        idempotencyKey: key,
      );
    } catch (e) {
      state = DepositState.error(
        e.toString(),
        amount: amt,
        idempotencyKey: key,
      );
    }
  }

  void reset() {
    state = DepositState.idle();
  }
}
