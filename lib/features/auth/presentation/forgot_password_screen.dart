import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../../../shared/widgets/primary_button.dart';
import '../data/auth_repository.dart';
import '../../../l10n/generated/app_localizations.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _otpSent = false;
  String? _errorMessage;

  @override
  void dispose() {
    _identifierController.dispose();
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _requestOtp() async {
    if (_validateIdentifier(_identifierController.text) != null) {
      _formKey.currentState?.validate();
      return;
    }
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await ref
          .read(authRepositoryProvider)
          .requestPasswordResetOtp(
            identifier: _identifierController.text.trim(),
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.passwordResetOtpSent)),
      );
      setState(() {
        _otpSent = true;
      });
    } catch (error) {
      if (!mounted) return;
      final message = error is AppException
          ? error.userFriendlyMessage
          : error.toString();
      setState(() {
        _errorMessage = message;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await ref
          .read(authRepositoryProvider)
          .resetPassword(
            identifier: _identifierController.text.trim(),
            otp: _otpController.text.trim(),
            newPassword: _passwordController.text,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.passwordResetSuccess)),
      );
      context.go('/login');
    } catch (error) {
      if (!mounted) return;
      final message = error is AppException
          ? error.userFriendlyMessage
          : error.toString();
      setState(() {
        _errorMessage = message;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String? _validateIdentifier(String? value) {
    final l10n = context.l10n;
    if (value == null || value.trim().isEmpty) {
      return l10n.validatorIdentifier;
    }
    final input = value.trim();
    if (input.contains('@')) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      return emailRegex.hasMatch(input) ? null : l10n.validatorEmail;
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{9,15}$');
    return phoneRegex.hasMatch(input) ? null : l10n.validatorIdentifier;
  }

  String? _validatePassword(String? value) {
    final l10n = context.l10n;
    if (value == null || value.isEmpty) {
      return l10n.validatorRequired;
    }
    return value.length >= 6 ? null : l10n.validatorPassword;
  }

  String? _validateConfirmPassword(String? value) {
    final baseValidation = _validatePassword(value);
    if (baseValidation != null) return baseValidation;
    return value == _passwordController.text
        ? null
        : context.l10n.passwordConfirmationMismatch;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          tooltip: l10n.back,
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: _isLoading
              ? null
              : () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/login');
                  }
                },
        ),
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        message: _otpSent
            ? l10n.resettingPassword
            : l10n.sendingPasswordResetOtp,
        child: Stack(
          children: [
            const _MeshBackground(),
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
                          const _FadeSlideUp(
                            delay: Duration.zero,
                            child: _ResetPasswordIllustration(),
                          ),
                          const SizedBox(height: AppSpacing.m),
                          _FadeSlideUp(
                            delay: const Duration(milliseconds: 100),
                            child: Text(
                              l10n.resetPasswordTitle,
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
                            delay: const Duration(milliseconds: 150),
                            child: Text(
                              l10n.resetPasswordSubtitle,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                height: 1.4,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          _FadeSlideUp(
                            delay: const Duration(milliseconds: 200),
                            child: _GlassFormCard(
                              isLoading: _isLoading,
                              otpSent: _otpSent,
                              errorMessage: _errorMessage,
                              identifierController: _identifierController,
                              otpController: _otpController,
                              passwordController: _passwordController,
                              confirmPasswordController: _confirmPasswordController,
                              obscurePassword: _obscurePassword,
                              onObscureChanged: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              validateIdentifier: _validateIdentifier,
                              validatePassword: _validatePassword,
                              validateConfirmPassword: _validateConfirmPassword,
                              onSendOtp: _requestOtp,
                              onSubmit: _submit,
                              l10n: l10n,
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

class _ResetPasswordIllustration extends StatelessWidget {
  const _ResetPasswordIllustration();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
            ),
          ),
          Positioned(
            left: 110,
            top: 25,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(seconds: 4),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 5 * math.sin(value * 2 * math.pi)),
                  child: child,
                );
              },
              child: Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFD700),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.key_rounded, size: 13, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            right: 100,
            bottom: 30,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(seconds: 4),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, -5 * math.sin(value * 2 * math.pi)),
                  child: child,
                );
              },
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFF8A65),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.star_rounded, size: 11, color: Colors.white),
              ),
            ),
          ),
          Container(
            width: 76,
            height: 76,
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
                  color: theme.colorScheme.primary.withValues(alpha: isDark ? 0.4 : 0.25),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.lock_reset_rounded,
                size: 36,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassFormCard extends StatelessWidget {
  final bool isLoading;
  final bool otpSent;
  final String? errorMessage;
  final TextEditingController identifierController;
  final TextEditingController otpController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final VoidCallback onObscureChanged;
  final String? Function(String?) validateIdentifier;
  final String? Function(String?) validatePassword;
  final String? Function(String?) validateConfirmPassword;
  final VoidCallback onSendOtp;
  final VoidCallback onSubmit;
  final AppLocalizations l10n;

  const _GlassFormCard({
    required this.isLoading,
    required this.otpSent,
    required this.errorMessage,
    required this.identifierController,
    required this.otpController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.onObscureChanged,
    required this.validateIdentifier,
    required this.validatePassword,
    required this.validateConfirmPassword,
    required this.onSendOtp,
    required this.onSubmit,
    required this.l10n,
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
                controller: identifierController,
                enabled: !isLoading && !otpSent,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: l10n.emailOrPhone,
                  prefixIcon: const Icon(Icons.person_outline_rounded),
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
                validator: (value) => validateIdentifier(identifierController.text),
              ),
              const SizedBox(height: AppSpacing.m),
              if (!otpSent) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                  child: Text(
                    l10n.passwordResetEmailHelp,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.3,
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
                    text: l10n.sendPasswordResetOtp,
                    icon: Icons.mark_email_read_outlined,
                    isLoading: isLoading,
                    onPressed: onSendOtp,
                  ),
                ),
              ] else ...[
                TextFormField(
                  controller: otpController,
                  enabled: !isLoading,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: l10n.passwordResetOtp,
                    counterText: '',
                    prefixIcon: const Icon(Icons.mark_email_read_outlined),
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
                  validator: (value) =>
                      value == null || !RegExp(r'^\d{6}$').hasMatch(value)
                          ? l10n.validatorOtp
                          : null,
                ),
                const SizedBox(height: AppSpacing.s),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                  child: Text(
                    l10n.passwordResetOtpHelp,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.l),
                TextFormField(
                  controller: passwordController,
                  enabled: !isLoading,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: l10n.newPassword,
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
                      onPressed: onObscureChanged,
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                  validator: (value) => validatePassword(passwordController.text),
                ),
                const SizedBox(height: AppSpacing.l),
                TextFormField(
                  controller: confirmPasswordController,
                  enabled: !isLoading,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: l10n.confirmPassword,
                    prefixIcon: const Icon(Icons.lock_reset_rounded),
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
                  validator: (value) => validateConfirmPassword(confirmPasswordController.text),
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
                    text: l10n.resetPassword,
                    icon: Icons.lock_reset_rounded,
                    isLoading: isLoading,
                    onPressed: onSubmit,
                  ),
                ),
                const SizedBox(height: AppSpacing.s),
                TextButton(
                  onPressed: isLoading ? null : onSendOtp,
                  child: Text(l10n.resendPasswordResetOtp),
                ),
              ],
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
