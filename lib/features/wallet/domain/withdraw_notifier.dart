import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/error/app_exception.dart';
import '../../history/domain/history_provider.dart';
import '../data/wallet_repository.dart';
import 'balance_provider.dart';
import 'wallet_models.dart';

part 'withdraw_notifier.g.dart';

enum WithdrawStatus { idle, submitting, success, error }

class WithdrawState {
  final WithdrawStatus status;
  final MovementResponse? response;
  final String? errorMessage;
  final String? amount;
  final String? pin;
  final String? idempotencyKey;

  const WithdrawState({
    required this.status,
    this.response,
    this.errorMessage,
    this.amount,
    this.pin,
    this.idempotencyKey,
  });

  factory WithdrawState.idle() =>
      const WithdrawState(status: WithdrawStatus.idle);
  factory WithdrawState.submitting({
    String? amount,
    String? pin,
    String? idempotencyKey,
  }) => WithdrawState(
    status: WithdrawStatus.submitting,
    amount: amount,
    pin: pin,
    idempotencyKey: idempotencyKey,
  );
  factory WithdrawState.success(MovementResponse response) =>
      WithdrawState(status: WithdrawStatus.success, response: response);
  factory WithdrawState.error(
    String message, {
    String? amount,
    String? pin,
    String? idempotencyKey,
  }) => WithdrawState(
    status: WithdrawStatus.error,
    errorMessage: message,
    amount: amount,
    pin: pin,
    idempotencyKey: idempotencyKey,
  );
}

@riverpod
class WithdrawNotifier extends _$WithdrawNotifier {
  late WalletRepository _walletRepository;
  int _revision = 0;
  bool _disposed = false;

  @override
  WithdrawState build() {
    _walletRepository = ref.watch(walletRepositoryProvider);
    _disposed = false;
    ref.onDispose(() {
      _disposed = true;
      _revision++;
    });
    return WithdrawState.idle();
  }

  Future<void> submitWithdraw(String amount, String pin) async {
    if (state.status == WithdrawStatus.submitting) return;
    final revision = ++_revision;
    final key = state.status == WithdrawStatus.error && state.amount == amount
        ? state.idempotencyKey ?? const Uuid().v4()
        : const Uuid().v4();
    state = WithdrawState.submitting(
      amount: amount,
      pin: pin,
      idempotencyKey: key,
    );
    try {
      final res = await _walletRepository.withdraw(amount, pin, key);
      if (_disposed || revision != _revision) return;
      state = WithdrawState.success(res);
      ref.read(balanceProvider.notifier).refreshBalance();
      if (ref.exists(historyProvider)) ref.invalidate(historyProvider);
    } on AppException catch (e) {
      if (_disposed || revision != _revision) return;
      state = WithdrawState.error(
        e.userFriendlyMessage,
        amount: amount,
        pin: pin,
        idempotencyKey: key,
      );
    } catch (e) {
      if (_disposed || revision != _revision) return;
      state = WithdrawState.error(
        e.toString(),
        amount: amount,
        pin: pin,
        idempotencyKey: key,
      );
    }
  }

  Future<void> retryWithdraw() async {
    if (state.status != WithdrawStatus.error) return;
    final amt = state.amount;
    final p = state.pin;
    final key = state.idempotencyKey;
    if (amt == null || p == null || key == null) return;

    await submitWithdraw(amt, p);
  }

  void reset() {
    _revision++;
    state = WithdrawState.idle();
  }
}
