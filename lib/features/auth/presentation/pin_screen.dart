import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../data/auth_repository.dart';

class PinScreen extends ConsumerStatefulWidget {
  final String title;
  final String description;

  const PinScreen({
    super.key,
    this.title = 'Mã PIN Giao Dịch',
    this.description = 'Nhập mã PIN 6 chữ số để xác thực',
  });

  @override
  ConsumerState<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends ConsumerState<PinScreen> {
  String _pin = '';
  bool _isLoading = false;
  String? _error;

  void _onNumberTap(int number) {
    if (_pin.length < 6 && !_isLoading) {
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
        if (mounted) {
          context.pop(true);
        }
      } else {
        setState(() {
          _pin = '';
          _error = 'Mã PIN giao dịch không chính xác.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _pin = '';
        _error = e.toString().contains('PIN_INVALID')
            ? 'Mã PIN giao dịch không chính xác.'
            : 'Đã xảy ra lỗi khi xác thực PIN.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(false),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Text(
              widget.description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onBackground.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.l),
            
            // Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                final isFilled = index < _pin.length;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFilled
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onBackground.withOpacity(0.15),
                    border: Border.all(
                      color: isFilled ? theme.colorScheme.primary : theme.colorScheme.onBackground.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: AppSpacing.m),
            
            // Loading/Error Indicator
            SizedBox(
              height: 30,
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : _error != null
                      ? Text(
                          _error!,
                          style: TextStyle(
                            color: theme.colorScheme.error,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : null,
            ),
            const Spacer(),

            // Keypad
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _KeypadButton(number: 1, onTap: () => _onNumberTap(1)),
                      _KeypadButton(number: 2, onTap: () => _onNumberTap(2)),
                      _KeypadButton(number: 3, onTap: () => _onNumberTap(3)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.m),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _KeypadButton(number: 4, onTap: () => _onNumberTap(4)),
                      _KeypadButton(number: 5, onTap: () => _onNumberTap(5)),
                      _KeypadButton(number: 6, onTap: () => _onNumberTap(6)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.m),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _KeypadButton(number: 7, onTap: () => _onNumberTap(7)),
                      _KeypadButton(number: 8, onTap: () => _onNumberTap(8)),
                      _KeypadButton(number: 9, onTap: () => _onNumberTap(9)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.m),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 70, height: 70), // Empty left placeholder
                      _KeypadButton(number: 0, onTap: () => _onNumberTap(0)),
                      GestureDetector(
                        onTap: _onBackspace,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 70,
                          height: 70,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.backspace_outlined,
                            size: 28,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ],
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

class _KeypadButton extends StatelessWidget {
  final int number;
  final VoidCallback onTap;

  const _KeypadButton({required this.number, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.onBackground.withOpacity(0.05),
        ),
        alignment: Alignment.center,
        child: Text(
          number.toString(),
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
