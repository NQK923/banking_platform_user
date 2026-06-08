import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/money/money.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../../../shared/widgets/money_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../domain/balance_provider.dart';
import '../domain/withdraw_notifier.dart';

class WithdrawScreen extends ConsumerStatefulWidget {
  const WithdrawScreen({super.key});

  @override
  ConsumerState<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends ConsumerState<WithdrawScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _onWithdrawSubmit(Decimal balance, String currency) {
    if (_formKey.currentState?.validate() ?? false) {
      _showPinDialog(balance, currency);
    }
  }

  void _showPinDialog(Decimal balance, String currency) {
    final pinController = TextEditingController();
    final pinFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.l),
          ),
          title: const Text(
            'Nhập mã PIN giao dịch',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: pinFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Vui lòng nhập mã PIN 6 chữ số để xác nhận giao dịch rút tiền.',
                ),
                const SizedBox(height: AppSpacing.m),
                TextFormField(
                  controller: pinController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    letterSpacing: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Mã PIN',
                    counterText: '',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().length != 6) {
                      return 'Mã PIN phải gồm đúng 6 chữ số.';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Mã PIN chỉ chứa chữ số.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                if (pinFormKey.currentState?.validate() ?? false) {
                  Navigator.of(ctx).pop();
                  ref
                      .read(withdrawNotifierProvider.notifier)
                      .submitWithdraw(
                        _amountController.text.trim(),
                        pinController.text,
                      );
                }
              },
              child: const Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(
    BuildContext context,
    String journalId,
    String amount,
    String currency,
  ) {
    final money = Money.parse(amount, currency);
    final theme = Theme.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.l),
          ),
          title: Row(
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 28,
              ),
              const SizedBox(width: AppSpacing.s),
              Text(
                'Rút tiền thành công',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Số tiền đã được trừ khỏi tài khoản ví của bạn và chuyển về tài khoản nguồn.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.m),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Số tiền rút:',
                    style: TextStyle(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    money.formatDisplay(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mã giao dịch:',
                    style: TextStyle(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    journalId.length > 15
                        ? '${journalId.substring(0, 15)}...'
                        : journalId,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(withdrawNotifierProvider.notifier).reset();
                Navigator.of(ctx).pop();
                context.go('/home');
              },
              child: const Text('Quay lại Trang Chủ'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final balanceState = ref.watch(balanceProvider);
    final withdrawState = ref.watch(withdrawNotifierProvider);
    final theme = Theme.of(context);

    // Get current balance details
    Decimal currentBalance = Decimal.zero;
    String currency = 'VND';
    balanceState.whenData((data) {
      currentBalance = data.balance;
      currency = data.currency;
    });

    // Listen for state changes
    ref.listen<WithdrawState>(withdrawNotifierProvider, (previous, next) {
      if (next.status == WithdrawStatus.success && next.response != null) {
        _showSuccessDialog(
          context,
          next.response!.journalId,
          _amountController.text.trim(),
          currency,
        );
      } else if (next.status == WithdrawStatus.error &&
          next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: theme.colorScheme.error,
            action: SnackBarAction(
              label: 'Thử lại',
              textColor: Colors.white,
              onPressed: () {
                ref.read(withdrawNotifierProvider.notifier).retryWithdraw();
              },
            ),
          ),
        );
      }
    });

    final displayMoney = Money(amount: currentBalance, currency: currency);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rút tiền'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(withdrawNotifierProvider.notifier).reset();
            context.pop();
          },
        ),
      ),
      body: LoadingOverlay(
        isLoading: withdrawState.status == WithdrawStatus.submitting,
        message: 'Đang thực hiện rút tiền...',
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.l),
            children: [
              Text(
                'Rút tiền khỏi ví E-Wallet',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.s),
              Text(
                'Giao dịch rút tiền được mô phỏng đối ứng qua tài khoản nguồn CASH_CLEARING.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onBackground.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Available Balance Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.m),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Số dư khả dụng',
                            style: TextStyle(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.6,
                              ),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            displayMoney.formatDisplay(),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: theme.colorScheme.primary.withOpacity(
                          0.08,
                        ),
                        child: Icon(
                          Icons.account_balance_wallet,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.l),

              // Money Field input
              MoneyField(
                controller: _amountController,
                currency: currency,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Vui lòng nhập số tiền.';
                  }
                  final amount = Decimal.tryParse(value.trim());
                  if (amount == null || amount <= Decimal.zero) {
                    return 'Số tiền rút phải lớn hơn 0.';
                  }
                  if (amount > currentBalance) {
                    return 'Số dư khả dụng không đủ.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.xl),

              PrimaryButton(
                text: 'Xác nhận rút tiền',
                onPressed: () => _onWithdrawSubmit(currentBalance, currency),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
