import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('release router does not expose user deposit route', () {
    final routerSource = File('lib/core/router/app_router.dart').readAsStringSync();

    expect(routerSource, isNot(contains("path: '/deposit'")));
    expect(routerSource, isNot(contains('DepositScreen')));
  });
}
