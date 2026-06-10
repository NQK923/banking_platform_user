import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/validator.dart';
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

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final accountState = ref.watch(accountDetailsProvider);
    final themeMode = ref.watch(themeModeProvider);

    String userId = '';
    if (authState is AuthStateAuthenticated) {
      userId = authState.userId;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            accountState.when(
              data: (account) => _ProfileHeader(
                account: account,
                userId: userId,
                maskPhone: _maskPhone,
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
            const SectionHeader(title: 'Settings'),
            const SizedBox(height: AppSpacing.s),
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _SettingsTile(
                    icon: Icons.password_rounded,
                    title: 'Change transaction PIN',
                    subtitle: 'Update the 6-digit PIN used for transfers.',
                    onTap: () => _showChangePinDialog(context),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.m),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.contrast_rounded),
                            const SizedBox(width: AppSpacing.m),
                            Text(
                              'Appearance',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.m),
                        SegmentedButton<ThemeMode>(
                          segments: const [
                            ButtonSegment(
                              value: ThemeMode.system,
                              icon: Icon(Icons.settings_suggest_rounded),
                              label: Text('System'),
                            ),
                            ButtonSegment(
                              value: ThemeMode.light,
                              icon: Icon(Icons.light_mode_rounded),
                              label: Text('Light'),
                            ),
                            ButtonSegment(
                              value: ThemeMode.dark,
                              icon: Icon(Icons.dark_mode_rounded),
                              label: Text('Dark'),
                            ),
                          ],
                          selected: {themeMode},
                          onSelectionChanged: (selection) {
                            ref.read(themeModeProvider.notifier).state =
                                selection.first;
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  _SettingsTile(
                    icon: Icons.language_rounded,
                    title: 'Language',
                    subtitle: 'English',
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _SettingsTile(
                    icon: Icons.logout_rounded,
                    title: 'Sign out',
                    subtitle: 'End this secure session.',
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
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final AccountRecord account;
  final String userId;
  final String Function(String phone) maskPhone;

  const _ProfileHeader({
    required this.account,
    required this.userId,
    required this.maskPhone,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final code = account.code;
    final isEmail = code.contains('@');
    final emailDisplay = isEmail ? code : 'Not added';
    final phoneDisplay = !isEmail ? maskPhone(code) : 'Not added';
    final displayName = isEmail ? code.split('@')[0] : 'E-Wallet user';

    return AppCard(
      child: Column(
        children: [
          CircleAvatar(
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
          const SizedBox(height: AppSpacing.l),
          Text(displayName, style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'ID: $userId',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.l),
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
    return Container(
      constraints: const BoxConstraints(minHeight: 36),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.s,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: AppSpacing.s),
          Text(label),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool danger;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.danger = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = danger ? theme.colorScheme.error : theme.colorScheme.primary;
    return ListTile(
      minVerticalPadding: AppSpacing.m,
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.12),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: danger ? theme.colorScheme.error : null,
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: danger ? theme.colorScheme.error : null,
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
          const SnackBar(content: Text('Transaction PIN changed.')),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      icon: const Icon(Icons.password_rounded),
      title: const Text('Change transaction PIN'),
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
                  const Text('Updating PIN...'),
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
                          alpha: 0.32,
                        ),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.m),
                    ],
                    PinEntryField(
                      controller: _currentPinController,
                      labelText: 'Current PIN',
                      validator: Validator.validatePin,
                    ),
                    const SizedBox(height: AppSpacing.m),
                    PinEntryField(
                      controller: _newPinController,
                      labelText: 'New PIN',
                      validator: Validator.validatePin,
                    ),
                    const SizedBox(height: AppSpacing.m),
                    PinEntryField(
                      controller: _confirmPinController,
                      labelText: 'Confirm new PIN',
                      validator: (value) {
                        final valErr = Validator.validatePin(value);
                        if (valErr != null) return valErr;
                        if (value != _newPinController.text) {
                          return 'PIN confirmation does not match.';
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
                child: const Text('Cancel'),
              ),
              FilledButton(onPressed: _onSubmit, child: const Text('Save')),
            ],
    );
  }
}
