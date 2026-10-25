import 'package:banking_platform_user/features/history/domain/wallet_transaction.dart';
import 'package:banking_platform_user/features/wallet/domain/wallet_models.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('money JSON preserves all NUMERIC(19,4) digits', () {
    final balance = BalanceResponse.fromJson({
      'accountId': 'wallet',
      'balance': '999999999999999.9999',
      'currency': 'USD',
    });
    expect(balance.balance, Decimal.parse('999999999999999.9999'));
    expect(balance.toJson()['balance'], '999999999999999.9999');
  });

  for (final invalid in <Object?>[
    null,
    100,
    0.1,
    true,
    '',
    'NaN',
    '1e3',
    ' 100 ',
    '1,000',
  ]) {
    test('rejects non-contract money JSON: $invalid', () {
      expect(
        () => const DecimalConverter().fromJson(invalid),
        throwsFormatException,
      );
    });
  }
}
