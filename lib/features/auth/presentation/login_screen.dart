import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../../../shared/widgets/primary_button.dart';
import '../domain/auth_notifier.dart';
import '../domain/auth_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .read(authNotifierProvider.notifier)
          .login(_identifierController.text.trim(), _passwordController.text);
    }
  }

  String? _validateIdentifier(String? value) {
    final l10n = context.l10n;
    if (value == null || value.trim().isEmpty) {
      return l10n.validatorIdentifier;
    }
    final input = value.trim();
    if (input.contains('@')) {
      return _validateEmail(input);
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{9,15}$');
    return phoneRegex.hasMatch(input) ? null : l10n.validatorIdentifier;
  }

  String? _validateEmail(String? value) {
    final l10n = context.l10n;
    if (value == null || value.trim().isEmpty) {
      return l10n.validatorRequired;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value.trim()) ? null : l10n.validatorEmail;
  }

  String? _validatePassword(String? value) {
    final l10n = context.l10n;
    if (value == null || value.isEmpty) {
      return l10n.validatorRequired;
    }
    return value.length >= 6 ? null : l10n.validatorPassword;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final isLoading = authState is AuthStateAuthenticating;
    final errorMessage = authState is AuthStateUnauthenticated
        ? authState.errorMessage
        : null;

    return Scaffold(
      body: LoadingOverlay(
        isLoading: isLoading,
        message: l10n.signingIn,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.l),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _AuthHeader(
                        title: l10n.welcomeBack,
                        subtitle: l10n.loginSubtitle,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      AppCard(
                        child: Column(
                          children: [
                            if (errorMessage != null) ...[
                              _AuthError(message: errorMessage),
                              const SizedBox(height: AppSpacing.m),
                            ],
                            TextFormField(
                              controller: _identifierController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: l10n.emailOrPhone,
                                prefixIcon: const Icon(Icons.person_outline_rounded),
                              ),
                              validator: (_) =>
                                  _validateIdentifier(_identifierController.text),
                              enabled: !isLoading,
                            ),
                            const SizedBox(height: AppSpacing.m),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: l10n.password,
                                prefixIcon: const Icon(
                                  Icons.lock_outline_rounded,
                                ),
                                suffixIcon: IconButton(
                                  tooltip: _obscurePassword
                                      ? l10n.showPassword
                                      : l10n.hidePassword,
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (_) =>
                                  _validatePassword(_passwordController.text),
                              enabled: !isLoading,
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            PrimaryButton(
                              text: l10n.signIn,
                              icon: Icons.login_rounded,
                              onPressed: _submit,
                              isLoading: isLoading,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.l),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            l10n.noAccountYet,
                            style: TextStyle(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.push('/register'),
                            child: Text(l10n.createOne),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _AuthHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        CircleAvatar(
          radius: 42,
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(
            Icons.account_balance_wallet_rounded,
            size: 42,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.s),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _AuthError extends StatelessWidget {
  final String message;

  const _AuthError({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(AppRadius.m),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: theme.colorScheme.error),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
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
