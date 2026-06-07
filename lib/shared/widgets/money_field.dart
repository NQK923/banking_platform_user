import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoneyField extends StatelessWidget {
  final TextEditingController controller;
  final String currency;
  final String labelText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const MoneyField({
    super.key,
    required this.controller,
    required this.currency,
    this.labelText = 'Số tiền',
    this.validator,
    this.onChanged,
  });

  // Determines the decimals scale allowed for this currency input
  int get _currencyScale {
    switch (currency.toUpperCase()) {
      case 'VND':
        return 0;
      case 'USD':
        return 2;
      case 'BTC':
        return 8;
      default:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scale = _currencyScale;

    // Build the list of text input formatters
    final formatters = <TextInputFormatter>[
      // Allow only numbers and optionally one dot/comma based on the scale
      if (scale == 0)
        FilteringTextInputFormatter.digitsOnly
      else
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      
      // Enforce the decimal precision limit
      if (scale > 0)
        _DecimalLimitFormatter(scale),
    ];

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(
        decimal: scale > 0,
      ),
      inputFormatters: formatters,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: scale > 0 ? '0.${'0' * scale}' : '0',
        prefixIcon: const Icon(Icons.monetization_on_outlined),
        suffixText: currency.toUpperCase(),
        suffixStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}

class _DecimalLimitFormatter extends TextInputFormatter {
  final int maxDecimals;

  _DecimalLimitFormatter(this.maxDecimals);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.contains('.')) {
      final parts = text.split('.');
      if (parts.length > 2) {
        // More than one dot, reject change
        return oldValue;
      }
      final decimals = parts[1];
      if (decimals.length > maxDecimals) {
        // Exceeds decimals, truncate or reject
        return oldValue;
      }
    }
    return newValue;
  }
}
