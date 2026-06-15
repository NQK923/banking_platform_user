import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../../../shared/widgets/primary_button.dart';
import '../domain/auth_notifier.dart';
import '../domain/auth_state.dart';
import '../../../l10n/generated/app_localizations.dart';

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
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const _FadeSlideUp(
                            delay: Duration.zero,
                            child: _SecureIllustration(),
                          ),
                          const SizedBox(height: AppSpacing.m),
                          _FadeSlideUp(
                            delay: const Duration(milliseconds: 100),
                            child: Text(
                              l10n.welcomeBack,
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
                              l10n.loginSubtitle,
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
                              isLoading: isLoading,
                              errorMessage: errorMessage,
                              identifierController: _identifierController,
                              passwordController: _passwordController,
                              obscurePassword: _obscurePassword,
                              onObscureChanged: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              validateIdentifier: _validateIdentifier,
                              validatePassword: _validatePassword,
                              onSubmit: _submit,
                              l10n: l10n,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Top right language switcher
            const Positioned(
              top: 16,
              right: 16,
              child: SafeArea(
                child: _LanguageSelector(),
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

class _SecureIllustration extends StatelessWidget {
  const _SecureIllustration();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background glowing soft warm circle
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
            ),
          ),
          // Decorative floating coin 1 (yellow)
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
                child: const Icon(Icons.attach_money_rounded, size: 14, color: Colors.white),
              ),
            ),
          ),
          // Decorative floating star 2 (coral)
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
          // Main Wallet/Shield Badge
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
                Icons.wallet_rounded,
                size: 34,
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
  final String? errorMessage;
  final TextEditingController identifierController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onObscureChanged;
  final String? Function(String?) validateIdentifier;
  final String? Function(String?) validatePassword;
  final VoidCallback onSubmit;
  final AppLocalizations l10n;

  const _GlassFormCard({
    required this.isLoading,
    required this.errorMessage,
    required this.identifierController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onObscureChanged,
    required this.validateIdentifier,
    required this.validatePassword,
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
                validator: validateIdentifier,
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
              const SizedBox(height: AppSpacing.s),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: isLoading ? null : () => context.push('/forgot-password'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    l10n.forgotPasswordQuestion,
                    style: TextStyle(
                      fontSize: 13,
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
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
                  text: l10n.signIn,
                  icon: Icons.login_rounded,
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

class _LanguageSelector extends ConsumerWidget {
  const _LanguageSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          onTap: () {
            final nextLocale = currentLocale.languageCode == 'vi'
                ? const Locale('en')
                : const Locale('vi');
            ref.read(localeProvider.notifier).state = nextLocale;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.m,
              vertical: AppSpacing.s,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.language_rounded,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.s),
                Text(
                  currentLocale.languageCode == 'vi' ? 'VI' : 'EN',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


