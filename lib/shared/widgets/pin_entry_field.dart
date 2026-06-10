import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_theme.dart';

class PinEntryField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool autofocus;

  const PinEntryField({
    super.key,
    required this.controller,
    this.labelText = 'Transaction PIN',
    this.validator,
    this.autofocus = false,
  });

  @override
  State<PinEntryField> createState() => _PinEntryFieldState();
}

class _PinEntryFieldState extends State<PinEntryField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: widget.controller,
      autofocus: widget.autofocus,
      obscureText: _obscure,
      keyboardType: TextInputType.number,
      maxLength: 6,
      textAlign: TextAlign.center,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w900,
        letterSpacing: 8,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        counterText: '',
        prefixIcon: const Icon(Icons.dialpad_rounded),
        suffixIcon: IconButton(
          tooltip: _obscure ? 'Show PIN' : 'Hide PIN',
          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _obscure = !_obscure),
        ),
      ),
      validator: widget.validator,
    );
  }
}

class PinDots extends StatelessWidget {
  final int length;
  final int maxLength;
  final bool hasError;

  const PinDots({
    super.key,
    required this.length,
    this.maxLength = 6,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = hasError
        ? theme.colorScheme.error
        : theme.colorScheme.primary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxLength, (index) {
        final isFilled = index < length;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 130),
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
          width: isFilled ? 18 : 14,
          height: isFilled ? 18 : 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled
                ? activeColor
                : theme.colorScheme.surfaceContainerHighest,
            border: Border.all(
              color: isFilled ? activeColor : theme.colorScheme.outline,
              width: 1.5,
            ),
          ),
        );
      }),
    );
  }
}
