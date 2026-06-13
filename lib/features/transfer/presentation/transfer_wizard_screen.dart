import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/locale_provider.dart';
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
import '../domain/transfer_models.dart';
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
        title: Text(context.l10n.sendMoney),
        leading: IconButton(
          tooltip: context.l10n.back,
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
            recipientChecking: () => _LoadingStep(
              title: context.l10n.findingRecipient,
              message: context.l10n.checkingWalletDirectory,
            ),
            recipientChecked: (recipient) => _buildAmountStep(
              recipient.code,
              availableBalance,
              walletCurrency,
            ),
            review: (recipient, amount, note, key) =>
                _buildReviewStep(recipient.code, amount, walletCurrency, note),
            submitting: () => _LoadingStep(
              title: context.l10n.authorizingTransfer,
              message: context.l10n.authorizingTransferMessage,
            ),
            riskWarningRequired: (recipient, amount, note, key, risk) =>
                _buildRiskWarningState(risk),
            stepUpRequired: (recipient, amount, note, key, risk) =>
                _buildStepUpState(risk),
            manualReviewRequired: (risk) => _buildManualReviewState(risk),
            riskBlocked: (risk) => _buildRiskBlockedState(risk),
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
          _StepHeader(
            step: context.l10n.stepOneOfThree,
            title: context.l10n.chooseRecipient,
            subtitle: context.l10n.chooseRecipientSubtitle,
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
              decoration: InputDecoration(
                labelText: context.l10n.emailOrPhone,
                prefixIcon: const Icon(Icons.person_search_rounded),
                hintText: 'user@email.com or +84123456789',
              ),
              validator: Validator.validateIdentifier,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            text: context.l10n.continueAction,
            icon: Icons.arrow_forward_rounded,
            onPressed: _onRecipientSubmit,
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            context.l10n.transferPinReminder,
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
          _StepHeader(
            step: context.l10n.stepTwoOfThree,
            title: context.l10n.enterAmount,
            subtitle: context.l10n.transferAmountSubtitle,
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
                      Text(
                        context.l10n.recipient,
                        style: theme.textTheme.bodySmall,
                      ),
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
                    context.l10n.available,
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
                      return context.l10n.enterAnAmount;
                    }
                    final amountVal = Decimal.tryParse(value.trim());
                    if (amountVal == null || amountVal <= Decimal.zero) {
                      return context.l10n.amountGreaterThanZero;
                    }
                    if (amountVal > availableBalance) {
                      return context.l10n.availableBalanceNotEnough;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.m),
                TextFormField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    labelText: context.l10n.messageOptional,
                    prefixIcon: const Icon(Icons.notes_rounded),
                    hintText: context.l10n.addShortNote,
                  ),
                  maxLength: 50,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            text: context.l10n.reviewTransfer,
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
          _StepHeader(
            step: context.l10n.stepThreeOfThree,
            title: context.l10n.reviewAndAuthorize,
            subtitle: context.l10n.reviewAndAuthorizeSubtitle,
          ),
          const SizedBox(height: AppSpacing.xl),
          AppCard(
            child: Column(
              children: [
                _ReviewRow(
                  label: context.l10n.recipient,
                  value: recipientCode,
                  emphatic: true,
                ),
                const Divider(),
                _ReviewRow(
                  label: context.l10n.amount,
                  value: money.formatDisplay(),
                  emphatic: true,
                ),
                _ReviewRow(
                  label: context.l10n.fee,
                  value: context.l10n.freeFee,
                ),
                if (note != null && note.isNotEmpty) ...[
                  const Divider(),
                  _ReviewRow(label: context.l10n.message, value: note),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.l),
          AppCard(
            child: PinEntryField(
              controller: _pinController,
              labelText: context.l10n.transactionPin,
              validator: Validator.validatePin,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            text: context.l10n.confirmTransfer,
            icon: Icons.lock_rounded,
            onPressed: _onPinSubmit,
          ),
        ],
      ),
    );
  }

  Widget _buildRiskWarningState(TransferRiskResponse risk) {
    return _ResultShell(
      key: const ValueKey('risk-warning'),
      icon: Icons.warning_amber_rounded,
      color: AppTheme.warning,
      title: context.l10n.reviewTransferCarefully,
      message: risk.message,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _RiskReasonList(reasons: risk.reasons),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            text: context.l10n.understandContinue,
            icon: Icons.verified_user_rounded,
            onPressed: () => _showRiskPinDialog(
              title: context.l10n.confirmWarning,
              message: context.l10n.confirmWarningMessage,
              onSubmit: (pin) => ref
                  .read(transferProvider.notifier)
                  .acknowledgeRiskWarning(pin),
            ),
          ),
          const SizedBox(height: AppSpacing.m),
          SecondaryButton(
            text: context.l10n.cancelTransfer,
            icon: Icons.close_rounded,
            onPressed: () => ref.read(transferProvider.notifier).reset(),
          ),
        ],
      ),
    );
  }

  Widget _buildStepUpState(TransferRiskResponse risk) {
    return _ResultShell(
      key: const ValueKey('risk-step-up'),
      icon: Icons.lock_person_rounded,
      color: AppTheme.info,
      title: context.l10n.additionalVerificationRequired,
      message: risk.message,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _RiskReasonList(reasons: risk.reasons),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            text: context.l10n.verifyAndContinue,
            icon: Icons.lock_rounded,
            onPressed: () => _showRiskPinDialog(
              title: context.l10n.verifyTransfer,
              message: context.l10n.verifyTransferMessage,
              onSubmit: (pin) =>
                  ref.read(transferProvider.notifier).submitStepUp(pin, pin),
            ),
          ),
          const SizedBox(height: AppSpacing.m),
          SecondaryButton(
            text: context.l10n.cancelTransfer,
            icon: Icons.close_rounded,
            onPressed: () => ref.read(transferProvider.notifier).reset(),
          ),
        ],
      ),
    );
  }

  Widget _buildManualReviewState(TransferRiskResponse risk) {
    return _ResultShell(
      key: const ValueKey('risk-manual-review'),
      icon: Icons.manage_search_rounded,
      color: AppTheme.warning,
      title: context.l10n.transferUnderReview,
      message: context.l10n.moneyNotDebited,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCard(
            child: Column(
              children: [
                _ReviewRow(
                  label: context.l10n.reference,
                  value: _short(risk.traceId),
                ),
                if (risk.transactionId != null)
                  _ReviewRow(
                    label: context.l10n.transaction,
                    value: _short(risk.transactionId!),
                  ),
                _ReviewRow(
                  label: context.l10n.riskLevel,
                  value: risk.riskLevel,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.m),
          _RiskReasonList(reasons: risk.reasons),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            text: context.l10n.backToHome,
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

  Widget _buildRiskBlockedState(TransferRiskResponse risk) {
    return _ResultShell(
      key: const ValueKey('risk-blocked'),
      icon: Icons.block_rounded,
      color: Theme.of(context).colorScheme.error,
      title: context.l10n.transferBlocked,
      message: risk.message,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _RiskReasonList(reasons: risk.reasons),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            text: context.l10n.newTransfer,
            icon: Icons.add_rounded,
            onPressed: () => ref.read(transferProvider.notifier).reset(),
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
      title: context.l10n.transferProcessing,
      message: context.l10n.transferProcessingMessage,
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
                _ReviewRow(
                  label: context.l10n.transaction,
                  value: _short(tx.id),
                ),
                _ReviewRow(
                  label: context.l10n.amount,
                  value: money.formatDisplay(),
                ),
                _ReviewRow(label: context.l10n.statusCheck, value: '$count/10'),
                const SizedBox(height: AppSpacing.s),
                StatusChip(status: tx.status.name),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            context.l10n.pollingContinues,
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
      title: context.l10n.transferCompleted,
      message: context.l10n.transferCompletedMessage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCard(
            child: Column(
              children: [
                _ReviewRow(
                  label: context.l10n.transaction,
                  value: _short(tx.id),
                ),
                _ReviewRow(
                  label: context.l10n.total,
                  value: money.formatDisplay(),
                  emphatic: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            text: context.l10n.viewTransaction,
            icon: Icons.receipt_long_rounded,
            onPressed: () {
              ref.read(transferProvider.notifier).reset();
              context.replace('/transactions/${tx.id}');
            },
          ),
          const SizedBox(height: AppSpacing.m),
          SecondaryButton(
            text: context.l10n.backToHome,
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
      title: wasRefunded
          ? context.l10n.transferFailedRefunded
          : context.l10n.transferFailed,
      message: reason,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (wasRefunded)
            AppCard(
              color: AppTheme.success.withValues(alpha: 0.10),
              child: Row(
                children: [
                  const Icon(
                    Icons.verified_user_rounded,
                    color: AppTheme.success,
                  ),
                  const SizedBox(width: AppSpacing.m),
                  Expanded(
                    child: Text(
                      context.l10n.refundedSenderBalanceRestored,
                      style: const TextStyle(fontWeight: FontWeight.w800),
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
                  _ReviewRow(
                    label: context.l10n.transaction,
                    value: _short(tx.id),
                  ),
                  StatusChip(status: tx.status.name),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          if (canRetry) ...[
            PrimaryButton(
              text: context.l10n.retryTransfer,
              icon: Icons.refresh_rounded,
              onPressed: _showRetryPinDialog,
            ),
            const SizedBox(height: AppSpacing.m),
          ],
          SecondaryButton(
            text: context.l10n.newTransfer,
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
            child: Text(context.l10n.backToHome),
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
      title: context.l10n.stillProcessing,
      message: context.l10n.stillProcessingMessage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCard(
            child: Column(
              children: [
                _ReviewRow(
                  label: context.l10n.transaction,
                  value: _short(tx.id),
                ),
                StatusChip(status: tx.status.name),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            text: context.l10n.checkAgain,
            icon: Icons.refresh_rounded,
            onPressed: () =>
                ref.read(transferProvider.notifier).retryPolling(tx),
          ),
          const SizedBox(height: AppSpacing.m),
          SecondaryButton(
            text: context.l10n.goToHistory,
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
            child: Text(context.l10n.backToHome),
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
          title: Text(context.l10n.retryWithPin),
          content: Form(
            key: pinFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.retryWithPinMessage,
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
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(context.l10n.cancel),
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
              child: Text(context.l10n.confirm),
            ),
          ],
        );
      },
    );
  }

  void _showRiskPinDialog({
    required String title,
    required String message,
    required ValueChanged<String> onSubmit,
  }) {
    final pinController = TextEditingController();
    final pinFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return AlertDialog(
          icon: const Icon(Icons.verified_user_rounded),
          title: Text(title),
          content: Form(
            key: pinFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message, textAlign: TextAlign.center),
                  const SizedBox(height: AppSpacing.l),
                  PinEntryField(
                    controller: pinController,
                    validator: Validator.validatePin,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(context.l10n.cancel),
            ),
            FilledButton(
              onPressed: () {
                if (pinFormKey.currentState?.validate() ?? false) {
                  Navigator.of(ctx).pop();
                  onSubmit(pinController.text);
                }
              },
              child: Text(context.l10n.confirm),
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
        _StepHeader(
          step: context.l10n.inProgress,
          title: title,
          subtitle: message,
        ),
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

class _RiskReasonList extends StatelessWidget {
  final List<RiskReasonView> reasons;

  const _RiskReasonList({required this.reasons});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (reasons.isEmpty) {
      return const SizedBox.shrink();
    }
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.riskSignals, style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.s),
          ...reasons.map(
            (reason) => Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: AppSpacing.s),
                  Expanded(
                    child: Text(
                      reason.message,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
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
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 330 || textScale > 1.25;
          final labelText = Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          );
          final valueText = Text(
            value,
            maxLines: stacked ? 4 : 2,
            overflow: TextOverflow.ellipsis,
            textAlign: stacked ? TextAlign.start : TextAlign.end,
            style:
                (emphatic
                        ? theme.textTheme.titleMedium
                        : theme.textTheme.bodyMedium)
                    ?.copyWith(fontWeight: emphatic ? FontWeight.w900 : null),
          );

          if (stacked) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelText,
                const SizedBox(height: AppSpacing.xs),
                valueText,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: labelText),
              Flexible(child: valueText),
            ],
          );
        },
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
        Semantics(
          liveRegion: true,
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        child,
      ],
    );
  }
}
