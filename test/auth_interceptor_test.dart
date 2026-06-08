import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

import 'package:banking_platform_user/core/network/auth_interceptor.dart';
import 'package:banking_platform_user/features/auth/data/auth_token_storage.dart';

class MockAuthTokenStorage implements AuthTokenStorage {
  String? accessToken = 'old_token';
  String? refreshToken = 'refresh_token';
  String? userId = 'user_123';
  String? accountId = 'account_456';

  @override
  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required String userId,
    String? accountId,
  }) async {
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
    this.userId = userId;
    this.accountId = accountId;
  }

  @override
  Future<String?> getAccessToken() async => accessToken;

  @override
  Future<String?> getRefreshToken() async => refreshToken;

  @override
  Future<String?> getUserId() async => userId;

  @override
  Future<String?> getAccountId() async => accountId;

  @override
  Future<void> clearSession() async {
    accessToken = null;
    refreshToken = null;
    userId = null;
    accountId = null;
  }
}

void main() {
  late MockAuthTokenStorage mockTokenStorage;
  late Dio dio;
  late List<String> refreshCalls;
  late int mockRouteCallCount;

  setUp(() {
    mockTokenStorage = MockAuthTokenStorage();
    refreshCalls = [];
    mockRouteCallCount = 0;

    final mockInterceptor = InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (options.path == '/api/auth/refresh') {
          refreshCalls.add(options.data['refreshToken'] as String);
          await Future.delayed(const Duration(milliseconds: 50));
          handler.resolve(
            Response(
              requestOptions: options,
              statusCode: 200,
              data: {
                'accessToken': 'new_token',
                'refreshToken': 'new_refresh_token',
                'userId': 'user_123',
                'accountId': 'account_456',
              },
            ),
          );
        } else if (options.path == '/test-data') {
          mockRouteCallCount++;
          final authHeader = options.headers['Authorization'];
          if (authHeader == 'Bearer old_token') {
            handler.reject(
              DioException(
                requestOptions: options,
                response: Response(requestOptions: options, statusCode: 401),
                type: DioExceptionType.badResponse,
              ),
              true,
            );
          } else if (authHeader == 'Bearer new_token') {
            handler.resolve(
              Response(
                requestOptions: options,
                statusCode: 200,
                data: {'success': true},
              ),
            );
          } else {
            handler.reject(
              DioException(
                requestOptions: options,
                response: Response(requestOptions: options, statusCode: 403),
              ),
              true,
            );
          }
        } else {
          handler.next(options);
        }
      },
    );

    final refreshDio = Dio(BaseOptions(baseUrl: 'https://test-api.com'));
    refreshDio.interceptors.add(mockInterceptor);

    dio = Dio(BaseOptions(baseUrl: 'https://test-api.com'));

    // Register the auth interceptor
    dio.interceptors.add(
      AuthInterceptor(mockTokenStorage, () {
        // Logout callback
      }, refreshDio: refreshDio),
    );

    // Register a custom interceptor to mock network calls
    dio.interceptors.add(mockInterceptor);
  });

  group('AuthInterceptor Token Refresh Concurrency Tests', () {
    test(
      'Single 401 request triggers refresh and retries successfully',
      () async {
        final response = await dio.get('/test-data');
        expect(response.statusCode, 200);
        expect(response.data['success'], true);
      },
    );

    test(
      'Concurrent 401 requests trigger exactly one refresh and retry successfully',
      () async {
        // Trigger two concurrent requests
        final Future<Response> future1 = dio.get('/test-data');
        final Future<Response> future2 = dio.get('/test-data');

        final results = await Future.wait([future1, future2]);

        // Assert both completed successfully
        expect(results[0].statusCode, 200);
        expect(results[0].data['success'], true);
        expect(results[1].statusCode, 200);
        expect(results[1].data['success'], true);

        // Verify that /api/auth/refresh was only called exactly ONCE
        expect(refreshCalls.length, 1);
        expect(refreshCalls.first, 'refresh_token');

        // Verify the new token is stored
        expect(mockTokenStorage.accessToken, 'new_token');
        expect(mockTokenStorage.refreshToken, 'new_refresh_token');

        // Total calls to /test-data: 4 (2 original failing with 401, 2 retried succeeding with 200)
        expect(mockRouteCallCount, 4);
      },
    );
  });
}
