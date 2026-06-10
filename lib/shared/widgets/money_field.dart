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
    this.labelText = 'Amount',
    this.validator,
    this.onChanged,
  });

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
    final formatters = <TextInputFormatter>[
      if (scale == 0)
        FilteringTextInputFormatter.digitsOnly
      else
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      if (scale > 0) _DecimalLimitFormatter(scale),
    ];

    return Semantics(
      label: '$labelText in ${currency.toUpperCase()}',
      textField: true,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: scale > 0),
        inputFormatters: formatters,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w900,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: scale > 0 ? '0.${'0' * scale}' : '0',
          prefixIcon: const Icon(Icons.payments_outlined),
          suffixText: currency.toUpperCase(),
          suffixStyle: const TextStyle(fontWeight: FontWeight.w900),
        ),
        validator: validator,
        onChanged: onChanged,
      ),
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
      if (parts.length > 2) return oldValue;
      if (parts[1].length > maxDecimals) return oldValue;
    }
    return newValue;
  }
}
