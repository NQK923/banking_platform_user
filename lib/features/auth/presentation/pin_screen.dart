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
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          tooltip: 'Close',
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(false),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.l),
          child: Column(
            children: [
              const Spacer(),
              CircleAvatar(
                radius: 40,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Icon(
                  Icons.lock_rounded,
                  size: 38,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: AppSpacing.l),
              Text(
                widget.description,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
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
                        const SizedBox(width: 72, height: 72),
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
            ],
          ),
        ),
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
        style: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
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
    return Semantics(
      button: true,
      label: semanticLabel,
      child: Material(
        color: theme.colorScheme.surfaceContainerLow,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(width: 72, height: 72, child: Center(child: child)),
        ),
      ),
    );
  }
}
