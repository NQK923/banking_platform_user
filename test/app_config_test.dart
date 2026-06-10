import 'package:banking_platform_user/core/config/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
  });

  test('uses Android emulator host gateway by default', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    expect(AppConfig.apiBaseUrl, 'http://10.0.2.2:8080');
  });

  test('uses localhost by default on non-Android development targets', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;

    expect(AppConfig.apiBaseUrl, 'http://localhost:8080');
  });
}
