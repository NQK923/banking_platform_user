import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/pin_entry_field.dart';
import '../data/auth_repository.dart';

class PinScreen extends ConsumerStatefulWidget {
  final String title;
  final String description;

  const PinScreen({
    super.key,
    this.title = 'Transaction PIN',
    this.description = 'Enter your 6-digit PIN to continue.',
  });

  @override
  ConsumerState<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends ConsumerState<PinScreen> {
  String _pin = '';
  bool _isLoading = false;
  bool _shake = false;
  String? _error;

  void _onNumberTap(int number) {
    if (_pin.length < 6 && !_isLoading) {
      HapticFeedback.selectionClick();
      setState(() {
        _error = null;
        _pin += number.toString();
      });
      if (_pin.length == 6) {
        _verifyPin();
      }
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty && !_isLoading) {
      HapticFeedback.selectionClick();
      setState(() {
        _error = null;
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  Future<void> _verifyPin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final success = await ref.read(authRepositoryProvider).verifyPin(_pin);
      if (success) {
        HapticFeedback.lightImpact();
        if (mounted) context.pop(true);
      } else {
        _showPinError('Transaction PIN is not correct.');
      }
    } catch (e) {
      _showPinError(
        e.toString().contains('PIN_INVALID')
            ? 'Transaction PIN is not correct.'
            : 'PIN verification failed. Try again.',
      );
    }
  }

  void _showPinError(String message) {
    HapticFeedback.mediumImpact();
    setState(() {
      _pin = '';
      _error = message;
      _isLoading = false;
      _shake = true;
    });
    Future<void>.delayed(const Duration(milliseconds: 180), () {
      if (mounted) setState(() => _shake = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.title),
        leading: IconButton(
          tooltip: 'Close',
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(false),
        ),
      ),
      body: Stack(
        children: [
          const _MeshBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.l,
                vertical: AppSpacing.m,
              ),
              child: Column(
                children: [
                  const Spacer(),
                  const _PinHeaderIllustration(),
                  const SizedBox(height: AppSpacing.l),
                  Text(
                    widget.description,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AnimatedSlide(
                    offset: _shake ? const Offset(0.04, 0) : Offset.zero,
                    duration: const Duration(milliseconds: 70),
                    child: PinDots(length: _pin.length, hasError: _error != null),
                  ),
                  const SizedBox(height: AppSpacing.l),
                  SizedBox(
                    height: 44,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 150),
                      child: _isLoading
                          ? LinearProgressIndicator(
                              minHeight: 5,
                              borderRadius: BorderRadius.circular(999),
                            )
                          : _error != null
                              ? Text(
                                  _error!,
                                  key: const ValueKey('pin-error'),
                                  style: TextStyle(
                                    color: theme.colorScheme.error,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : const SizedBox.shrink(),
                    ),
                  ),
                  const Spacer(),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 340),
                    child: Column(
                      children: [
                        for (final row in const [
                          [1, 2, 3],
                          [4, 5, 6],
                          [7, 8, 9],
                        ]) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: row
                                .map(
                                  (number) => _KeypadButton(
                                    number: number,
                                    onTap: () => _onNumberTap(number),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: AppSpacing.m),
                        ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 76, height: 76),
                            _KeypadButton(number: 0, onTap: () => _onNumberTap(0)),
                            _IconKeypadButton(
                              icon: Icons.backspace_outlined,
                              onTap: _onBackspace,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.m),
                ],
              ),
            ),
          ),
        ],
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

class _PinHeaderIllustration extends StatelessWidget {
  const _PinHeaderIllustration();

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
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
            ),
          ),
          Positioned(
            left: 100,
            top: 25,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(seconds: 4),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 4 * math.sin(value * 2 * math.pi)),
                  child: child,
                );
              },
              child: Container(
                width: 20,
                height: 20,
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
                child: const Icon(Icons.star_rounded, size: 12, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            right: 90,
            bottom: 30,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(seconds: 4),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, -4 * math.sin(value * 2 * math.pi)),
                  child: child,
                );
              },
              child: Container(
                width: 16,
                height: 16,
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
                child: const Icon(Icons.security_rounded, size: 10, color: Colors.white),
              ),
            ),
          ),
          Container(
            width: 70,
            height: 70,
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
                Icons.lock_rounded,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KeypadButton extends StatelessWidget {
  final int number;
  final VoidCallback onTap;

  const _KeypadButton({required this.number, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _KeyShell(
      semanticLabel: 'Digit $number',
      onTap: onTap,
      child: Text(
        number.toString(),
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
      ),
    );
  }
}

class _IconKeypadButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconKeypadButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _KeyShell(
      semanticLabel: 'Backspace',
      onTap: onTap,
      child: Icon(icon, size: 26),
    );
  }
}

class _KeyShell extends StatelessWidget {
  final String semanticLabel;
  final Widget child;
  final VoidCallback onTap;

  const _KeyShell({
    required this.semanticLabel,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Semantics(
      button: true,
      label: semanticLabel,
      child: Container(
        width: 76,
        height: 76,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: isDark ? 0.15 : 0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Material(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.white.withValues(alpha: 0.55),
              shape: CircleBorder(
                side: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.white.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: InkWell(
                onTap: onTap,
                customBorder: const CircleBorder(),
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
