import 'package:banking_platform_user/features/transfer/domain/transfer_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AccountRecord', () {
    test('accepts null contact code from account detail responses', () {
      final account = AccountRecord.fromJson({
        'id': 'account-1',
        'userId': 'user-1',
        'code': null,
        'currency': 'VND',
        'kind': 'USER',
        'status': 'ACTIVE',
        'version': 0,
        'createdAt': '2026-06-10T14:42:23.860473Z',
      });

      expect(account.code, isEmpty);
      expect(account.kind, AccountKind.USER);
      expect(account.status, AccountStatus.ACTIVE);
    });
  });
}
