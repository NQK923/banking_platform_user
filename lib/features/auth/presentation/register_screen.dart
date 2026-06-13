import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../../../shared/widgets/pin_entry_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../domain/auth_notifier.dart';
import '../domain/auth_state.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pinController = TextEditingController();

  bool _obscurePassword = true;
  String _selectedCurrency = 'VND';

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .read(authNotifierProvider.notifier)
          .register(
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim().isEmpty
                ? null
                : _phoneController.text.trim(),
            password: _passwordController.text,
            pin: _pinController.text,
            currency: _selectedCurrency,
          );
    }
  }

  String? _validateEmail(String? value) {
    final l10n = context.l10n;
    if (value == null || value.trim().isEmpty) {
      return l10n.validatorRequired;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value.trim()) ? null : l10n.validatorEmail;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final phoneRegex = RegExp(r'^\+?[0-9]{9,15}$');
    return phoneRegex.hasMatch(value.trim())
        ? null
        : context.l10n.validatorPhone;
  }

  String? _validatePassword(String? value) {
    final l10n = context.l10n;
    if (value == null || value.isEmpty) {
      return l10n.validatorRequired;
    }
    return value.length >= 6 ? null : l10n.validatorPassword;
  }

  String? _validatePin(String? value) {
    final pinRegex = RegExp(r'^[0-9]{6}$');
    return value != null && pinRegex.hasMatch(value)
        ? null
        : context.l10n.validatorPin;
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
      appBar: AppBar(
        title: Text(l10n.createAccount),
        leading: IconButton(
          tooltip: l10n.back,
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        message: l10n.creatingWallet,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.l),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.startSecureWallet,
                      style: theme.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.s),
                    Text(
                      l10n.registerSubtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
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
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: l10n.email,
                              prefixIcon: const Icon(Icons.email_outlined),
                            ),
                            validator: (_) =>
                                _validateEmail(_emailController.text),
                            enabled: !isLoading,
                          ),
                          const SizedBox(height: AppSpacing.m),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: l10n.phoneOptional,
                              prefixIcon: const Icon(Icons.phone_outlined),
                            ),
                            validator: (_) =>
                                _validatePhone(_phoneController.text),
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
                          const SizedBox(height: AppSpacing.m),
                          PinEntryField(
                            controller: _pinController,
                            labelText: l10n.transactionPin,
                            validator: (_) => _validatePin(_pinController.text),
                          ),
                          const SizedBox(height: AppSpacing.m),
                          DropdownButtonFormField<String>(
                            initialValue: _selectedCurrency,
                            decoration: InputDecoration(
                              labelText: l10n.defaultCurrency,
                              prefixIcon: const Icon(Icons.payments_outlined),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'VND',
                                child: Text('VND'),
                              ),
                              DropdownMenuItem(
                                value: 'USD',
                                child: Text('USD'),
                              ),
                            ],
                            onChanged: isLoading
                                ? null
                                : (val) {
                                    if (val != null) {
                                      setState(() => _selectedCurrency = val);
                                    }
                                  },
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          PrimaryButton(
                            text: l10n.createWallet,
                            icon: Icons.person_add_alt_1_rounded,
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
                          l10n.alreadyRegistered,
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.pop(),
                          child: Text(l10n.signIn),
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
