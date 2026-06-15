import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/money/money.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/amount_text.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../../../shared/widgets/money_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../domain/balance_provider.dart';
import '../domain/deposit_notifier.dart';

class DepositScreen extends ConsumerStatefulWidget {
  const DepositScreen({super.key});

  @override
  ConsumerState<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends ConsumerState<DepositScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _onDepositSubmit(Decimal balance, String currency) {
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .read(depositNotifierProvider.notifier)
          .submitDeposit(_amountController.text.trim());
    }
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
      builder: (ctx) => PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          icon: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.75, end: 1),
            duration: const Duration(milliseconds: 220),
            builder: (context, scale, child) =>
                Transform.scale(scale: scale, child: child),
            child: const Icon(Icons.check_circle_rounded, size: 58),
          ),
          iconColor: AppTheme.success,
          title: Text(context.l10n.depositCompleted),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.depositCompletedMessage,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.l),
              _ResultRow(
                label: context.l10n.amount,
                value: money.formatDisplay(),
              ),
              _ResultRow(label: context.l10n.journal, value: _short(journalId)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(depositNotifierProvider.notifier).reset();
                Navigator.of(ctx).pop();
                context.go('/home');
              },
              child: Text(context.l10n.backToHome),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final balanceState = ref.watch(balanceProvider);
    final depositState = ref.watch(depositNotifierProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = context.l10n;

    Decimal currentBalance = Decimal.zero;
    String currency = 'VND';
    balanceState.whenData((data) {
      currentBalance = data.balance;
      currency = data.currency;
    });

    ref.listen<DepositState>(depositNotifierProvider, (previous, next) {
      if (next.status == DepositStatus.success && next.response != null) {
        _showSuccessDialog(
          context,
          next.response!.journalId,
          _amountController.text.trim(),
          currency,
        );
      } else if (next.status == DepositStatus.error &&
          next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: theme.colorScheme.error,
            action: SnackBarAction(
              label: l10n.retry,
              textColor: theme.colorScheme.onError,
              onPressed: () {
                ref.read(depositNotifierProvider.notifier).retryDeposit();
              },
            ),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.deposit),
        leading: IconButton(
          tooltip: l10n.back,
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            ref.read(depositNotifierProvider.notifier).reset();
            context.pop();
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [theme.colorScheme.surfaceContainerLowest, theme.colorScheme.surfaceContainerLow]
                : [const Color(0xFFFFF9F7), const Color(0xFFF7F6FF)],
          ),
        ),
        child: LoadingOverlay(
          isLoading: depositState.status == DepositStatus.submitting,
          message: l10n.submittingDeposit,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.l),
              children: [
                _StepHeader(
                  icon: Icons.add_card_rounded,
                  title: l10n.addFunds,
                  subtitle: l10n.addFundsSubtitle,
                ),
                const SizedBox(height: AppSpacing.xl),
                _BalanceCard(balance: currentBalance, currency: currency),
                const SizedBox(height: AppSpacing.l),
                AppCard(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.depositAmount,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.m),
                      Theme(
                        data: theme.copyWith(
                          inputDecorationTheme: theme.inputDecorationTheme.copyWith(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadius.xl),
                              borderSide: BorderSide(
                                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadius.xl),
                              borderSide: BorderSide(
                                color: theme.colorScheme.primary,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        child: MoneyField(
                          controller: _amountController,
                          currency: currency,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return l10n.enterAnAmount;
                            }
                            final amount = Decimal.tryParse(value.trim());
                            if (amount == null || amount <= Decimal.zero) {
                              return l10n.depositAmountGreaterThanZero;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Theme(
                  data: theme.copyWith(
                    filledButtonTheme: FilledButtonThemeData(
                      style: theme.filledButtonTheme.style?.copyWith(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.xl),
                          ),
                        ),
                      ),
                    ),
                  ),
                  child: PrimaryButton(
                    text: l10n.confirmDeposit,
                    icon: Icons.check_rounded,
                    onPressed: () => _onDepositSubmit(currentBalance, currency),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _short(String value) {
    if (value.length <= 16) return value;
    return '${value.substring(0, 12)}...';
  }
}

class _BalanceCard extends StatelessWidget {
  final Decimal balance;
  final String currency;

  const _BalanceCard({required this.balance, required this.currency});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final radius = BorderRadius.circular(AppRadius.xl);

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.15)
            : theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: radius,
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.15),
        ),
      ),
      child: AppCard(
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withValues(alpha: 0.15),
              ),
              child: Icon(
                Icons.account_balance_wallet_rounded,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.currentBalance,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  AmountText.neutral(
                    amount: balance,
                    currency: currency,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _StepHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.secondary,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
        const SizedBox(width: AppSpacing.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;

  const _ResultRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
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
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
