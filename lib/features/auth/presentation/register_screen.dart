import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../../../shared/widgets/pin_entry_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../domain/auth_notifier.dart';
import '../domain/auth_state.dart';
import '../../../l10n/generated/app_localizations.dart';

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
  static const String _selectedCurrency = 'VND';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          tooltip: l10n.back,
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        message: l10n.creatingWallet,
        child: Stack(
          children: [
            // Mesh background with friendly warm pastel shapes
            const _MeshBackground(),

            // Form content
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.l,
                    vertical: AppSpacing.xl,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 440),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _FadeSlideUp(
                            delay: Duration.zero,
                            child: Text(
                              l10n.startSecureWallet,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          _FadeSlideUp(
                            delay: const Duration(milliseconds: 100),
                            child: Text(
                              l10n.registerSubtitle,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                height: 1.4,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          _FadeSlideUp(
                            delay: const Duration(milliseconds: 150),
                            child: _GlassFormCard(
                              isLoading: isLoading,
                              errorMessage: errorMessage,
                              emailController: _emailController,
                              phoneController: _phoneController,
                              passwordController: _passwordController,
                              pinController: _pinController,
                              obscurePassword: _obscurePassword,
                              onObscureChanged: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              validateEmail: _validateEmail,
                              validatePhone: _validatePhone,
                              validatePassword: _validatePassword,
                              validatePin: _validatePin,
                              onSubmit: _submit,
                              l10n: l10n,
                              selectedCurrency: _selectedCurrency,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.l),
                          _FadeSlideUp(
                            delay: const Duration(milliseconds: 300),
                            child: Wrap(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MeshBackground extends StatelessWidget {
  const _MeshBackground();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final primaryGlow = const Color(0xFFFFD4C2).withValues(alpha: isDark ? 0.12 : 0.35);
    final secondaryGlow = const Color(0xFFE2D4FF).withValues(alpha: isDark ? 0.10 : 0.30);

    return Stack(
      children: [
        // Solid background gradient base (Warm peach & vanilla)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      const ui.Color(0xFF0F0E17),
                      const ui.Color(0xFF151421),
                      const ui.Color(0xFF12111A),
                    ]
                  : [
                      const ui.Color(0xFFFFF7F5),
                      const ui.Color(0xFFFFF9F2),
                      const ui.Color(0xFFF3F1FF),
                    ],
            ),
          ),
        ),
        // Glow Blob 1 (Top Left)
        Positioned(
          top: -80,
          left: -80,
          width: 320,
          height: 320,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  primaryGlow,
                  primaryGlow.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
        // Glow Blob 2 (Bottom Right)
        Positioned(
          bottom: -120,
          right: -80,
          width: 400,
          height: 400,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  secondaryGlow,
                  secondaryGlow.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GlassFormCard extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController pinController;
  final bool obscurePassword;
  final VoidCallback onObscureChanged;
  final String? Function(String?) validateEmail;
  final String? Function(String?) validatePhone;
  final String? Function(String?) validatePassword;
  final String? Function(String?) validatePin;
  final VoidCallback onSubmit;
  final AppLocalizations l10n;
  final String selectedCurrency;

  const _GlassFormCard({
    required this.isLoading,
    required this.errorMessage,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.pinController,
    required this.obscurePassword,
    required this.onObscureChanged,
    required this.validateEmail,
    required this.validatePhone,
    required this.validatePassword,
    required this.validatePin,
    required this.onSubmit,
    required this.l10n,
    required this.selectedCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.03)
                : Colors.white.withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.white.withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withValues(alpha: isDark ? 0.25 : 0.08),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (errorMessage != null) ...[
                _AuthError(message: errorMessage!),
                const SizedBox(height: AppSpacing.l),
              ],
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: l10n.email,
                  prefixIcon: const Icon(Icons.email_outlined),
                  filled: true,
                  fillColor: isDark
                      ? Colors.black.withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    borderSide: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    borderSide: BorderSide(color: theme.colorScheme.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
                  ),
                ),
                validator: validateEmail,
                enabled: !isLoading,
              ),
              const SizedBox(height: AppSpacing.l),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: l10n.phoneOptional,
                  prefixIcon: const Icon(Icons.phone_outlined),
                  filled: true,
                  fillColor: isDark
                      ? Colors.black.withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    borderSide: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    borderSide: BorderSide(color: theme.colorScheme.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
                  ),
                ),
                validator: validatePhone,
                enabled: !isLoading,
              ),
              const SizedBox(height: AppSpacing.l),
              TextFormField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: l10n.password,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  filled: true,
                  fillColor: isDark
                      ? Colors.black.withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    borderSide: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    borderSide: BorderSide(color: theme.colorScheme.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
                  ),
                  suffixIcon: IconButton(
                    tooltip: obscurePassword ? l10n.showPassword : l10n.hidePassword,
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20,
                    ),
                    onPressed: onObscureChanged,
                  ),
                ),
                validator: validatePassword,
                enabled: !isLoading,
              ),
              const SizedBox(height: AppSpacing.l),
              PinEntryField(
                controller: pinController,
                labelText: l10n.transactionPin,
                validator: validatePin,
              ),
              const SizedBox(height: AppSpacing.l),
              TextFormField(
                initialValue: selectedCurrency,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: l10n.defaultCurrency,
                  prefixIcon: const Icon(Icons.payments_outlined),
                  filled: true,
                  fillColor: isDark
                      ? Colors.black.withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    borderSide: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
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
                  text: l10n.createWallet,
                  icon: Icons.person_add_alt_1_rounded,
                  onPressed: onSubmit,
                  isLoading: isLoading,
                ),
              ),
            ],
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
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.m),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: theme.colorScheme.error,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.m),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: theme.colorScheme.onErrorContainer,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FadeSlideUp extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _FadeSlideUp({required this.child, required this.delay});

  @override
  State<_FadeSlideUp> createState() => _FadeSlideUpState();
}

class _FadeSlideUpState extends State<_FadeSlideUp> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
