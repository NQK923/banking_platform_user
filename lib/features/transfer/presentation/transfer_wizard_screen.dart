import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/money/money.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/validator.dart';
import '../../../shared/widgets/amount_text.dart';
import '../../../shared/widgets/error_view.dart';
import '../../../shared/widgets/money_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../auth/domain/auth_notifier.dart';
import '../../auth/domain/auth_state.dart';
import '../../wallet/domain/balance_provider.dart';
import '../../history/domain/wallet_transaction.dart';
import '../domain/transfer_notifier.dart';
import '../domain/transfer_state.dart';

class TransferWizardScreen extends ConsumerStatefulWidget {
  const TransferWizardScreen({super.key});

  @override
  ConsumerState<TransferWizardScreen> createState() =>
      _TransferWizardScreenState();
}

class _TransferWizardScreenState extends ConsumerState<TransferWizardScreen> {
  final _recipientFormKey = GlobalKey<FormState>();
  final _amountFormKey = GlobalKey<FormState>();
  final _pinFormKey = GlobalKey<FormState>();

  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _onRecipientSubmit() {
    if (_recipientFormKey.currentState?.validate() ?? false) {
      ref
          .read(transferProvider.notifier)
          .lookupRecipient(_recipientController.text.trim());
    }
  }

  void _onAmountSubmit(Decimal availableBalance, String currency) {
    if (_amountFormKey.currentState?.validate() ?? false) {
      ref
          .read(transferProvider.notifier)
          .setAmountAndNote(
            _amountController.text.trim(),
            _noteController.text.trim().isEmpty
                ? null
                : _noteController.text.trim(),
          );
    }
  }

  void _onPinSubmit() {
    if (_pinFormKey.currentState?.validate() ?? false) {
      ref.read(transferProvider.notifier).submitTransfer(_pinController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final transferState = ref.watch(transferProvider);
    final balanceState = ref.watch(balanceProvider);
    final theme = Theme.of(context);

    // Watch balance state for Step 2 amount checks
    Decimal availableBalance = Decimal.zero;
    String walletCurrency = 'VND';
    balanceState.whenData((data) {
      availableBalance = data.balance;
      walletCurrency = data.currency;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuyển tiền'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(transferProvider.notifier).reset();
            context.pop();
          },
        ),
      ),
      body: SafeArea(
        child: transferState.when(
          idle: (error) => _buildRecipientStep(theme, error),
          recipientChecking: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: AppSpacing.m),
                Text('Đang tìm kiếm người nhận...'),
              ],
            ),
          ),
          recipientChecked: (recipient) => _buildAmountStep(
            theme,
            recipient.code,
            availableBalance,
            walletCurrency,
          ),
          review: (recipient, amount, note, key) => _buildReviewStep(
            theme,
            recipient.code,
            amount,
            walletCurrency,
            note,
          ),
          submitting: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: AppSpacing.m),
                Text('Đang xác thực giao dịch...'),
              ],
            ),
          ),
          processing: (tx, count) => _buildProcessingState(theme, tx, count),
          completed: (tx) => _buildCompletedState(theme, tx),
          failed:
              (
                reason,
                wasRefunded,
                tx,
                recipient,
                amount,
                note,
                idempotencyKey,
              ) => _buildFailedState(
                theme,
                reason,
                wasRefunded,
                tx,
                recipient != null,
              ),
          timeout: (tx) => _buildTimeoutState(theme, tx),
        ),
      ),
    );
  }

  // --- STEP 1: RECIPIENT ENTRY ---
  Widget _buildRecipientStep(ThemeData theme, String? errorMessage) {
    return Form(
      key: _recipientFormKey,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.l),
        children: [
          Text(
            'Chuyển tiền cho ai?',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Nhập Email hoặc Số điện thoại người nhận để tiếp tục.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          if (errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.m),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withOpacity(0.08),
                borderRadius: BorderRadius.circular(AppRadius.m),
                border: Border.all(
                  color: theme.colorScheme.error.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: theme.colorScheme.error),
                  const SizedBox(width: AppSpacing.s),
                  Expanded(
                    child: Text(
                      errorMessage,
                      style: TextStyle(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.m),
          ],

          TextFormField(
            controller: _recipientController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email hoặc Số điện thoại',
              prefixIcon: Icon(Icons.person_outline),
              hintText: 'user@email.com hoặc +84123456789',
            ),
            validator: Validator.validateIdentifier,
          ),
          const SizedBox(height: AppSpacing.l),
          PrimaryButton(text: 'Tiếp tục', onPressed: _onRecipientSubmit),
        ],
      ),
    );
  }

  // --- STEP 2: AMOUNT & NOTE ---
  Widget _buildAmountStep(
    ThemeData theme,
    String recipientCode,
    Decimal availableBalance,
    String currency,
  ) {
    final money = Money(amount: availableBalance, currency: currency);

    return Form(
      key: _amountFormKey,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.l),
        children: [
          Text(
            'Nhập số tiền chuyển',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.s),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primary.withOpacity(0.08),
              child: const Icon(Icons.person),
            ),
            title: const Text('Người nhận'),
            subtitle: Text(
              recipientCode,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: AppSpacing.m),
          Container(
            padding: const EdgeInsets.all(AppSpacing.m),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.04),
              borderRadius: BorderRadius.circular(AppRadius.m),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Số dư khả dụng:'),
                Text(
                  money.formatDisplay(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.l),

          MoneyField(
            controller: _amountController,
            currency: currency,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Vui lòng nhập số tiền.';
              }
              final amountVal = Decimal.tryParse(value.trim());
              if (amountVal == null || amountVal <= Decimal.zero) {
                return 'Số tiền phải lớn hơn 0.';
              }
              if (amountVal > availableBalance) {
                return 'Số dư khả dụng không đủ.';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.m),

          TextFormField(
            controller: _noteController,
            decoration: const InputDecoration(
              labelText: 'Lời nhắn (Tùy chọn)',
              prefixIcon: Icon(Icons.rate_review_outlined),
              hintText: 'Nhập nội dung chuyển tiền...',
            ),
            maxLength: 50,
          ),
          const SizedBox(height: AppSpacing.l),

          PrimaryButton(
            text: 'Tiếp tục',
            onPressed: () => _onAmountSubmit(availableBalance, currency),
          ),
        ],
      ),
    );
  }

  // --- STEP 3: REVIEW & PIN AUTHORIZATION ---
  Widget _buildReviewStep(
    ThemeData theme,
    String recipientCode,
    String amountStr,
    String currency,
    String? note,
  ) {
    final money = Money.parse(amountStr, currency);

    return Form(
      key: _pinFormKey,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.l),
        children: [
          Text(
            'Xác nhận thông tin chuyển tiền',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.l),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.m),
              child: Column(
                children: [
                  _buildReviewRow(
                    theme,
                    'Người nhận',
                    recipientCode,
                    isBold: true,
                  ),
                  const Divider(),
                  _buildReviewRow(
                    theme,
                    'Số tiền chuyển',
                    money.formatDisplay(),
                    isBold: true,
                  ),
                  _buildReviewRow(theme, 'Phí giao dịch', 'Miễn phí (0 ₫)'),
                  if (note != null && note.isNotEmpty) ...[
                    const Divider(),
                    _buildReviewRow(theme, 'Lời nhắn', note),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.l),

          // PIN Input Gate
          TextFormField(
            controller: _pinController,
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
              labelText: 'Nhập mã PIN giao dịch',
              counterText: '',
              prefixIcon: Icon(Icons.password_outlined),
            ),
            validator: Validator.validatePin,
          ),
          const SizedBox(height: AppSpacing.l),

          PrimaryButton(text: 'Xác Nhận Chuyển Tiền', onPressed: _onPinSubmit),
        ],
      ),
    );
  }

  Widget _buildReviewRow(
    ThemeData theme,
    String label,
    String value, {
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

  // --- SAGA PROCESSING HUD ---
  Widget _buildProcessingState(
    ThemeData theme,
    WalletTransaction tx,
    int count,
  ) {
    final money = Money(amount: tx.amount, currency: tx.currency);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(strokeWidth: 4),
          const SizedBox(height: AppSpacing.l),
          Text(
            'Đang thực hiện chuyển tiền...',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            'Hệ thống đang thực hiện giao dịch thông qua Saga Orchestrator.\nVui lòng không thoát ứng dụng.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.m),
              child: Column(
                children: [
                  _buildReviewRow(
                    theme,
                    'Mã giao dịch',
                    tx.id.substring(0, 8) + '...',
                  ),
                  _buildReviewRow(theme, 'Số tiền', money.formatDisplay()),
                  _buildReviewRow(theme, 'Lần kiểm tra', '$count/10'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- SAGA COMPLETED RESULT SCREEN ---
  Widget _buildCompletedState(ThemeData theme, WalletTransaction tx) {
    final money = Money(amount: tx.amount, currency: tx.currency);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green, size: 80),
          const SizedBox(height: AppSpacing.m),
          Text(
            'Chuyển tiền thành công!',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.m),
              child: Column(
                children: [
                  _buildReviewRow(
                    theme,
                    'Giao dịch ID',
                    tx.id.substring(0, 8) + '...',
                  ),
                  _buildReviewRow(
                    theme,
                    'Tổng tiền',
                    money.formatDisplay(),
                    isBold: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          PrimaryButton(
            text: 'Xem Chi Tiết Giao Dịch',
            onPressed: () {
              ref.read(transferProvider.notifier).reset();
              context.replace('/transactions/${tx.id}');
            },
          ),
          const SizedBox(height: AppSpacing.m),
          OutlinedButton(
            onPressed: () {
              ref.read(transferProvider.notifier).reset();
              context.replace('/home');
            },
            child: const Text('Quay lại Trang Chủ'),
          ),
        ],
      ),
    );
  }

  void _showRetryPinDialog() {
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
            'Nhập mã PIN để thử lại',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: pinFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Vui lòng nhập mã PIN giao dịch để thực hiện lại yêu cầu.',
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
                      .read(transferProvider.notifier)
                      .retryTransfer(pinController.text);
                }
              },
              child: const Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }

  // --- SAGA FAILED RESULT SCREEN ---
  Widget _buildFailedState(
    ThemeData theme,
    String reason,
    bool wasRefunded,
    WalletTransaction? tx,
    bool canRetry,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.cancel_outlined, color: theme.colorScheme.error, size: 80),
          const SizedBox(height: AppSpacing.m),
          Text(
            'Giao dịch thất bại!',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.m),
          Text(
            reason,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.l),

          if (wasRefunded) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.m),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.08),
                borderRadius: BorderRadius.circular(AppRadius.m),
                border: Border.all(color: Colors.green.withOpacity(0.2)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.security, color: Colors.green),
                  SizedBox(width: AppSpacing.s),
                  Expanded(
                    child: Text(
                      'Bảo vệ giao dịch: Số tiền đã được Saga hoàn trả đầy đủ vào tài khoản của bạn.',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],

          if (canRetry) ...[
            PrimaryButton(
              text: 'Thử lại giao dịch',
              onPressed: _showRetryPinDialog,
            ),
            const SizedBox(height: AppSpacing.m),
          ],

          PrimaryButton(
            text: 'Thực Hiện Giao Dịch Mới',
            onPressed: () {
              ref.read(transferProvider.notifier).reset();
              _recipientController.clear();
              _amountController.clear();
              _noteController.clear();
              _pinController.clear();
            },
          ),
          const SizedBox(height: AppSpacing.m),
          OutlinedButton(
            onPressed: () {
              ref.read(transferProvider.notifier).reset();
              context.replace('/home');
            },
            child: const Text('Quay lại Trang Chủ'),
          ),
        ],
      ),
    );
  }

  // --- SAGA POLLING TIMEOUT SCREEN ---
  Widget _buildTimeoutState(ThemeData theme, WalletTransaction tx) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.access_time, color: Colors.orange, size: 80),
          const SizedBox(height: AppSpacing.m),
          Text(
            'Giao dịch đang xử lý lâu...',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.m),
          Text(
            'Hệ thống chưa nhận được kết quả cuối cùng từ Saga. Giao dịch vẫn đang được xử lý trong nền.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),

          PrimaryButton(
            text: 'Tiếp Tục Chờ / Kiểm Tra Lại',
            onPressed: () =>
                ref.read(transferProvider.notifier).retryPolling(tx),
          ),
          const SizedBox(height: AppSpacing.m),
          OutlinedButton(
            onPressed: () {
              ref.read(transferProvider.notifier).reset();
              context.replace('/history');
            },
            child: const Text('Đi tới Lịch sử giao dịch'),
          ),
          const SizedBox(height: AppSpacing.m),
          TextButton(
            onPressed: () {
              ref.read(transferProvider.notifier).reset();
              context.replace('/home');
            },
            child: const Text('Quay lại Trang Chủ'),
          ),
        ],
      ),
    );
  }
}
