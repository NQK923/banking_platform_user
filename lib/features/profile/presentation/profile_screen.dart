import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/error_view.dart';
import '../../../shared/widgets/pin_entry_field.dart';
import '../../../shared/widgets/skeleton.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/domain/auth_notifier.dart';
import '../../auth/domain/auth_state.dart';
import '../../transfer/domain/transfer_models.dart';
import '../../wallet/domain/balance_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String _maskPhone(String phone) {
    if (phone.length <= 5) return phone;
    if (phone.startsWith('+')) {
      final start = phone.substring(0, 3);
      final end = phone.substring(phone.length - 3);
      return '$start******$end';
    }
    final start = phone.substring(0, 2);
    final end = phone.substring(phone.length - 2);
    return '$start******$end';
  }

  void _showChangePinDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const _ChangePinDialog(),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final currentLocale = ref.read(localeProvider);
    final l10n = context.l10n;
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        title: Text(l10n.language, style: const TextStyle(fontWeight: FontWeight.w900)),
        children: [
          ListTile(
            title: Text(l10n.vietnamese, style: const TextStyle(fontWeight: FontWeight.w600)),
            trailing: currentLocale.languageCode == 'vi'
                ? const Icon(Icons.check_rounded)
                : null,
            onTap: () {
              ref.read(localeProvider.notifier).state = const Locale('vi');
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text(l10n.english, style: const TextStyle(fontWeight: FontWeight.w600)),
            trailing: currentLocale.languageCode == 'en'
                ? const Icon(Icons.check_rounded)
                : null,
            onTap: () {
              ref.read(localeProvider.notifier).state = const Locale('en');
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final accountState = ref.watch(accountDetailsProvider);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    String userId = '';
    if (authState is AuthStateAuthenticated) {
      userId = authState.userId;
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profile)),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [theme.colorScheme.surfaceContainerLowest, theme.colorScheme.surfaceContainerLow]
                : [const Color(0xFFFFFBF9), const Color(0xFFF7F6FF)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              accountState.when(
                data: (account) => _ProfileHeader(
                  account: account,
                  userId: userId,
                  maskPhone: _maskPhone,
                  notAddedLabel: l10n.notAdded,
                  defaultDisplayName: l10n.ewalletUser,
                ),
                loading: () => const AppCard(
                  child: Column(
                    children: [
                      SkeletonBox(
                        height: 80,
                        width: 80,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      SizedBox(height: AppSpacing.l),
                      SkeletonBox(height: 20, width: 160),
                      SizedBox(height: AppSpacing.s),
                      SkeletonBox(height: 14, width: 220),
                    ],
                  ),
                ),
                error: (e, s) => ErrorView(
                  error: e,
                  inline: true,
                  onRetry: () => ref.refresh(accountDetailsProvider),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              SectionHeader(title: l10n.settings),
              const SizedBox(height: AppSpacing.s),
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _SettingsTile(
                      icon: Icons.password_rounded,
                      color: const Color(0xFF6C5DD3),
                      title: l10n.changeTransactionPin,
                      subtitle: l10n.changePinSubtitle,
                      onTap: () => _showChangePinDialog(context),
                    ),
                    const Divider(height: 1, indent: 70, endIndent: 16),
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.m),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                margin: const EdgeInsets.only(left: 4, right: 12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amber.withValues(alpha: 0.12),
                                ),
                                child: const Icon(Icons.contrast_rounded, color: Colors.amber),
                              ),
                              Text(
                                l10n.appearance,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.m),
                          Padding(
                            padding: const EdgeInsets.only(left: 56),
                            child: Theme(
                              data: theme.copyWith(
                                segmentedButtonTheme: SegmentedButtonThemeData(
                                  style: SegmentedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(AppRadius.xl),
                                    ),
                                  ),
                                ),
                              ),
                              child: SegmentedButton<ThemeMode>(
                                segments: [
                                  ButtonSegment(
                                    value: ThemeMode.system,
                                    icon: const Icon(Icons.settings_suggest_rounded, size: 18),
                                    label: Text(l10n.system),
                                  ),
                                  ButtonSegment(
                                    value: ThemeMode.light,
                                    icon: const Icon(Icons.light_mode_rounded, size: 18),
                                    label: Text(l10n.light),
                                  ),
                                  ButtonSegment(
                                    value: ThemeMode.dark,
                                    icon: const Icon(Icons.dark_mode_rounded, size: 18),
                                    label: Text(l10n.dark),
                                  ),
                                ],
                                selected: {themeMode},
                                onSelectionChanged: (selection) {
                                  ref.read(themeModeProvider.notifier).state =
                                      selection.first;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, indent: 70, endIndent: 16),
                    _SettingsTile(
                      icon: Icons.language_rounded,
                      color: Colors.blue,
                      title: l10n.language,
                      subtitle: locale.languageCode == 'vi'
                          ? l10n.vietnamese
                          : l10n.english,
                      onTap: () => _showLanguageDialog(context),
                    ),
                    const Divider(height: 1, indent: 70, endIndent: 16),
                    _SettingsTile(
                      icon: Icons.support_agent_rounded,
                      color: Colors.teal,
                      title: l10n.contactSupport,
                      subtitle: l10n.contactSupportSubtitle,
                      onTap: () => context.go('/support'),
                    ),
                    const Divider(height: 1, indent: 70, endIndent: 16),
                    _SettingsTile(
                      icon: Icons.logout_rounded,
                      color: theme.colorScheme.error,
                      title: l10n.signOut,
                      subtitle: l10n.signOutSubtitle,
                      danger: true,
                      onTap: () {
                        ref.read(authNotifierProvider.notifier).logout();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final AccountRecord account;
  final String userId;
  final String Function(String phone) maskPhone;
  final String notAddedLabel;
  final String defaultDisplayName;

  const _ProfileHeader({
    required this.account,
    required this.userId,
    required this.maskPhone,
    required this.notAddedLabel,
    required this.defaultDisplayName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final email = account.email?.trim() ?? '';
    final phone = account.phone?.trim() ?? '';
    final emailDisplay = email.isNotEmpty ? email : notAddedLabel;
    final phoneDisplay = phone.isNotEmpty ? maskPhone(phone) : notAddedLabel;
    final displayName = email.isNotEmpty ? email.split('@')[0] : defaultDisplayName;

    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.xxl),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.25),
                width: 3,
              ),
            ),
            child: CircleAvatar(
              radius: 42,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text(
                displayName.isEmpty ? 'U' : displayName[0].toUpperCase(),
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.l),
          Text(
            displayName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ID: ',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  userId,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppSpacing.m,
            runSpacing: AppSpacing.s,
            children: [
              _ContactChip(icon: Icons.email_rounded, label: emailDisplay),
              _ContactChip(icon: Icons.phone_rounded, label: phoneDisplay),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ContactChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      constraints: const BoxConstraints(minHeight: 36),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.s,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? theme.colorScheme.surfaceContainerLow
            : theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: AppSpacing.s),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 220),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final bool danger;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    this.danger = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      minVerticalPadding: AppSpacing.m,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.12),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: danger ? theme.colorScheme.error : null,
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text(subtitle, style: const TextStyle(height: 1.25)),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: danger ? theme.colorScheme.error : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
      ),
      onTap: onTap,
    );
  }
}

class _ChangePinDialog extends ConsumerStatefulWidget {
  const _ChangePinDialog();

  @override
  ConsumerState<_ChangePinDialog> createState() => _ChangePinDialogState();
}

class _ChangePinDialogState extends ConsumerState<_ChangePinDialog> {
  final _formKey = GlobalKey<FormState>();
  final _currentPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _currentPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        await ref
            .read(authRepositoryProvider)
            .changePin(_currentPinController.text, _newPinController.text);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.pinChanged)),
        );
        Navigator.of(context).pop();
      } catch (e) {
        setState(() {
          _errorMessage = e
              .toString()
              .replaceAll('Exception: ', '')
              .replaceAll('AppException: ', '');
          _isLoading = false;
        });
      }
    }
  }

  String? _validatePin(String? value) {
    final pinRegex = RegExp(r'^[0-9]{6}$');
    return value != null && pinRegex.hasMatch(value)
        ? null
        : context.l10n.validatorPin;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      icon: const Icon(Icons.password_rounded),
      title: Text(l10n.changeTransactionPin, style: const TextStyle(fontWeight: FontWeight.w900)),
      content: _isLoading
          ? SizedBox(
              height: 112,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearProgressIndicator(
                    minHeight: 5,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  const SizedBox(height: AppSpacing.l),
                  Text(l10n.updatingPin),
                ],
              ),
            )
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_errorMessage != null) ...[
                      AppCard(
                        color: theme.colorScheme.errorContainer.withValues(
                          alpha: 0.12,
                        ),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: theme.colorScheme.error, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.m),
                    ],
                    PinEntryField(
                      controller: _currentPinController,
                      labelText: l10n.currentPin,
                      validator: _validatePin,
                    ),
                    const SizedBox(height: AppSpacing.m),
                    PinEntryField(
                      controller: _newPinController,
                      labelText: l10n.newPin,
                      validator: _validatePin,
                    ),
                    const SizedBox(height: AppSpacing.m),
                    PinEntryField(
                      controller: _confirmPinController,
                      labelText: l10n.confirmNewPin,
                      validator: (value) {
                        final valErr = _validatePin(value);
                        if (valErr != null) return valErr;
                        if (value != _newPinController.text) {
                          return l10n.pinConfirmationMismatch;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
      actions: _isLoading
          ? []
          : [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.cancel),
              ),
              FilledButton(onPressed: _onSubmit, child: Text(l10n.save)),
            ],
    );
  }
}
