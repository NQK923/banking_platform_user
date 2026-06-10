import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/money/money.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/validator.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/money_field.dart';
import '../../../shared/widgets/pin_entry_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/skeleton.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../history/domain/wallet_transaction.dart';
import '../../wallet/domain/balance_provider.dart';
import '../domain/transfer_notifier.dart';

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

    Decimal availableBalance = Decimal.zero;
    String walletCurrency = 'VND';
    balanceState.whenData((data) {
      availableBalance = data.balance;
      walletCurrency = data.currency;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Send money'),
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            ref.read(transferProvider.notifier).reset();
            context.pop();
          },
        ),
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: transferState.when(
            idle: (error) => _buildRecipientStep(error),
            recipientChecking: () => const _LoadingStep(
              title: 'Finding recipient',
              message: 'Checking the wallet directory...',
            ),
            recipientChecked: (recipient) => _buildAmountStep(
              recipient.code,
              availableBalance,
              walletCurrency,
            ),
            review: (recipient, amount, note, key) =>
                _buildReviewStep(recipient.code, amount, walletCurrency, note),
            submitting: () => const _LoadingStep(
              title: 'Authorizing transfer',
              message: 'Keeping your PIN and transfer request secure...',
            ),
            processing: (tx, count) => _buildProcessingState(tx, count),
            completed: (tx) => _buildCompletedState(tx),
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
                  reason,
                  wasRefunded,
                  tx,
                  recipient != null,
                ),
            timeout: (tx) => _buildTimeoutState(tx),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipientStep(String? errorMessage) {
    final theme = Theme.of(context);
    return Form(
      key: _recipientFormKey,
      child: ListView(
        key: const ValueKey('recipient'),
        padding: const EdgeInsets.all(AppSpacing.l),
        children: [
          const _StepHeader(
            step: 'Step 1 of 3',
            title: 'Choose a recipient',
            subtitle:
                'Use an email address or phone number linked to a wallet.',
          ),
          const SizedBox(height: AppSpacing.xl),
          if (errorMessage != null) ...[
            _InlineError(message: errorMessage),
            const SizedBox(height: AppSpacing.l),
          ],
          AppCard(
            child: TextFormField(
              controller: _recipientController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email or phone',
                prefixIcon: Icon(Icons.person_search_rounded),
                hintText: 'user@email.com or +84123456789',
              ),
              validator: Validator.validateIdentifier,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            text: 'Continue',
            icon: Icons.arrow_forward_rounded,
            onPressed: _onRecipientSubmit,
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            'Transfers are sent only after PIN confirmation on the review step.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountStep(
    String recipientCode,
    Decimal availableBalance,
    String currency,
  ) {
    final theme = Theme.of(context);
    final money = Money(amount: availableBalance, currency: currency);
    return Form(
      key: _amountFormKey,
      child: ListView(
        key: const ValueKey('amount'),
        padding: const EdgeInsets.all(AppSpacing.l),
        children: [
          const _StepHeader(
            step: 'Step 2 of 3',
            title: 'Enter amount',
            subtitle: 'Confirm the recipient and choose how much to send.',
          ),
          const SizedBox(height: AppSpacing.xl),
          AppCard(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Icon(
                    Icons.person_rounded,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recipient', style: theme.textTheme.bodySmall),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        recipientCode,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.m),
          AppCard(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.42),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Available',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Text(money.formatDisplay(), style: theme.textTheme.titleMedium),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.l),
          AppCard(
            child: Column(
              children: [
                MoneyField(
                  controller: _amountController,
                  currency: currency,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter an amount.';
                    }
                    final amountVal = Decimal.tryParse(value.trim());
                    if (amountVal == null || amountVal <= Decimal.zero) {
                      return 'Amount must be greater than 0.';
                    }
                    if (amountVal > availableBalance) {
                      return 'Available balance is not enough.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.m),
                TextFormField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    labelText: 'Message (optional)',
                    prefixIcon: Icon(Icons.notes_rounded),
                    hintText: 'Add a short note',
                  ),
                  maxLength: 50,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            text: 'Review transfer',
            icon: Icons.receipt_long_rounded,
            onPressed: () => _onAmountSubmit(availableBalance, currency),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStep(
    String recipientCode,
    String amountStr,
    String currency,
    String? note,
  ) {
    final money = Money.parse(amountStr, currency);
    return Form(
      key: _pinFormKey,
      child: ListView(
        key: const ValueKey('review'),
        padding: const EdgeInsets.all(AppSpacing.l),
        children: [
          const _StepHeader(
            step: 'Step 3 of 3',
            title: 'Review and authorize',
            subtitle: 'Check details, then confirm with your transaction PIN.',
          ),
          const SizedBox(height: AppSpacing.xl),
          AppCard(
            child: Column(
              children: [
                _ReviewRow(
                  label: 'Recipient',
                  value: recipientCode,
                  emphatic: true,
                ),
                const Divider(),
                _ReviewRow(
                  label: 'Amount',
                  value: money.formatDisplay(),
                  emphatic: true,
                ),
                const _ReviewRow(label: 'Fee', value: 'Free (0 VND)'),
                if (note != null && note.isNotEmpty) ...[
                  const Divider(),
                  _ReviewRow(label: 'Message', value: note),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.l),
          AppCard(
            child: PinEntryField(
              controller: _pinController,
              labelText: 'Transaction PIN',
              validator: Validator.validatePin,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            text: 'Confirm transfer',
            icon: Icons.lock_rounded,
            onPressed: _onPinSubmit,
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingState(WalletTransaction tx, int count) {
    final theme = Theme.of(context);
    final money = Money(amount: tx.amount, currency: tx.currency);
    return _ResultShell(
      key: const ValueKey('processing'),
      icon: Icons.sync_rounded,
      color: AppTheme.info,
      title: 'Transfer processing',
      message:
          'The saga is applying debit and credit entries. Keep this screen open if you want live status.',
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: const LinearProgressIndicator(minHeight: 6),
          ),
          const SizedBox(height: AppSpacing.l),
          AppCard(
            child: Column(
              children: [
                _ReviewRow(label: 'Transaction', value: _short(tx.id)),
                _ReviewRow(label: 'Amount', value: money.formatDisplay()),
                _ReviewRow(label: 'Status check', value: '$count/10'),
                const SizedBox(height: AppSpacing.s),
                StatusChip(status: tx.status.name),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            'Polling continues on the existing cadence.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedState(WalletTransaction tx) {
    final money = Money(amount: tx.amount, currency: tx.currency);
    return _ResultShell(
      key: const ValueKey('completed'),
      icon: Icons.check_circle_rounded,
      color: AppTheme.success,
      title: 'Transfer completed',
      message: 'The recipient wallet has been credited.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCard(
            child: Column(
              children: [
                _ReviewRow(label: 'Transaction', value: _short(tx.id)),
                _ReviewRow(
                  label: 'Total',
                  value: money.formatDisplay(),
                  emphatic: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            text: 'View transaction',
            icon: Icons.receipt_long_rounded,
            onPressed: () {
              ref.read(transferProvider.notifier).reset();
              context.replace('/transactions/${tx.id}');
            },
          ),
          const SizedBox(height: AppSpacing.m),
          SecondaryButton(
            text: 'Back to home',
            icon: Icons.home_rounded,
            onPressed: () {
              ref.read(transferProvider.notifier).reset();
              context.replace('/home');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFailedState(
    String reason,
    bool wasRefunded,
    WalletTransaction? tx,
    bool canRetry,
  ) {
    return _ResultShell(
      key: const ValueKey('failed'),
      icon: wasRefunded ? Icons.assignment_return_rounded : Icons.error_rounded,
      color: wasRefunded
          ? AppTheme.success
          : Theme.of(context).colorScheme.error,
      title: wasRefunded ? 'Transfer failed, refunded' : 'Transfer failed',
      message: reason,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (wasRefunded)
            AppCard(
              color: AppTheme.success.withValues(alpha: 0.10),
              child: const Row(
                children: [
                  Icon(Icons.verified_user_rounded, color: AppTheme.success),
                  SizedBox(width: AppSpacing.m),
                  Expanded(
                    child: Text(
                      'Refunded: the sender balance was restored after compensation.',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
          if (tx != null) ...[
            if (wasRefunded) const SizedBox(height: AppSpacing.m),
            AppCard(
              child: Column(
                children: [
                  _ReviewRow(label: 'Transaction', value: _short(tx.id)),
                  StatusChip(status: tx.status.name),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          if (canRetry) ...[
            PrimaryButton(
              text: 'Retry transfer',
              icon: Icons.refresh_rounded,
              onPressed: _showRetryPinDialog,
            ),
            const SizedBox(height: AppSpacing.m),
          ],
          SecondaryButton(
            text: 'New transfer',
            icon: Icons.add_rounded,
            onPressed: () {
              ref.read(transferProvider.notifier).reset();
              _recipientController.clear();
              _amountController.clear();
              _noteController.clear();
              _pinController.clear();
            },
          ),
          const SizedBox(height: AppSpacing.m),
          TextButton(
            onPressed: () {
              ref.read(transferProvider.notifier).reset();
              context.replace('/home');
            },
            child: const Text('Back to home'),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeoutState(WalletTransaction tx) {
    return _ResultShell(
      key: const ValueKey('timeout'),
      icon: Icons.schedule_rounded,
      color: AppTheme.warning,
      title: 'Still processing',
      message:
          'No final saga result was returned yet. The transaction can still complete in the background.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCard(
            child: Column(
              children: [
                _ReviewRow(label: 'Transaction', value: _short(tx.id)),
                StatusChip(status: tx.status.name),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            text: 'Check again',
            icon: Icons.refresh_rounded,
            onPressed: () =>
                ref.read(transferProvider.notifier).retryPolling(tx),
          ),
          const SizedBox(height: AppSpacing.m),
          SecondaryButton(
            text: 'Go to history',
            icon: Icons.receipt_long_rounded,
            onPressed: () {
              ref.read(transferProvider.notifier).reset();
              context.replace('/history');
            },
          ),
          const SizedBox(height: AppSpacing.m),
          TextButton(
            onPressed: () {
              ref.read(transferProvider.notifier).reset();
              context.replace('/home');
            },
            child: const Text('Back to home'),
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
          icon: const Icon(Icons.lock_reset_rounded),
          title: const Text('Retry with PIN'),
          content: Form(
            key: pinFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Enter your transaction PIN to retry with the same idempotency key.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.l),
                PinEntryField(
                  controller: pinController,
                  validator: Validator.validatePin,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (pinFormKey.currentState?.validate() ?? false) {
                  Navigator.of(ctx).pop();
                  ref
                      .read(transferProvider.notifier)
                      .retryTransfer(pinController.text);
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  String _short(String value) {
    if (value.length <= 14) return value;
    return '${value.substring(0, 10)}...';
  }
}

class _StepHeader extends StatelessWidget {
  final String step;
  final String title;
  final String subtitle;

  const _StepHeader({
    required this.step,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          step,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        Text(title, style: theme.textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.s),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _LoadingStep extends StatelessWidget {
  final String title;
  final String message;

  const _LoadingStep({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      key: ValueKey(title),
      padding: const EdgeInsets.all(AppSpacing.l),
      children: [
        _StepHeader(step: 'In progress', title: title, subtitle: message),
        const SizedBox(height: AppSpacing.xl),
        const AppCard(
          child: Column(
            children: [
              SkeletonBox(height: 18, width: double.infinity),
              SizedBox(height: AppSpacing.m),
              SkeletonBox(height: 18, width: double.infinity),
              SizedBox(height: AppSpacing.m),
              SkeletonBox(height: 18, width: 180),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        LinearProgressIndicator(
          minHeight: 5,
          borderRadius: BorderRadius.circular(999),
          color: theme.colorScheme.primary,
        ),
      ],
    );
  }
}

class _InlineError extends StatelessWidget {
  final String message;

  const _InlineError({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      color: theme.colorScheme.errorContainer.withValues(alpha: 0.32),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: theme.colorScheme.error),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  final String label;
  final String value;
  final bool emphatic;

  const _ReviewRow({
    required this.label,
    required this.value,
    this.emphatic = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style:
                  (emphatic
                          ? theme.textTheme.titleMedium
                          : theme.textTheme.bodyMedium)
                      ?.copyWith(fontWeight: emphatic ? FontWeight.w900 : null),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultShell extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final Widget child;

  const _ResultShell({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.l),
      children: [
        const SizedBox(height: AppSpacing.xl),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.86, end: 1),
          duration: const Duration(milliseconds: 220),
          builder: (context, scale, animatedChild) =>
              Transform.scale(scale: scale, child: animatedChild),
          child: CircleAvatar(
            radius: 42,
            backgroundColor: color.withValues(alpha: 0.14),
            child: Icon(icon, color: color, size: 46),
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(color: color),
        ),
        const SizedBox(height: AppSpacing.s),
        Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        child,
      ],
    );
  }
}
