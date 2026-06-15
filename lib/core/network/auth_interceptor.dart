import 'dart:async';
import 'package:dio/dio.dart';
import '../../features/auth/data/auth_token_storage.dart';
import '../config/app_config.dart';

class AuthInterceptor extends Interceptor {
  final AuthTokenStorage _tokenStorage;
  final void Function() _onLogoutRequired;
  final Dio _refreshDio;

  AuthInterceptor(this._tokenStorage, this._onLogoutRequired, {Dio? refreshDio})
    : _refreshDio =
          refreshDio ??
          Dio(
            BaseOptions(
              baseUrl: AppConfig.apiBaseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  Future<String?>? _refreshFuture;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final path = options.path;
    // Skip attaching tokens for auth endpoints
    if (path.contains('/api/auth/login') ||
        path.contains('/api/auth/register') ||
        path.contains('/api/auth/refresh')) {
      return handler.next(options);
    }

    final accessToken = await _tokenStorage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final response = err.response;
    // Handle 401 Unauthorized errors
    if (response != null && response.statusCode == 401) {
      final requestOptions = err.requestOptions;

      // If we already retried this request once, pass the error along
      if (requestOptions.extra['retried'] == true) {
        return handler.next(err);
      }

      requestOptions.extra['retried'] = true;

      final requestToken = requestOptions.headers['Authorization']?.toString();
      final storedToken = await _tokenStorage.getAccessToken();

      if (storedToken != null && requestToken != 'Bearer $storedToken') {
        requestOptions.headers['Authorization'] = 'Bearer $storedToken';
        try {
          final retryResponse = await _refreshDio.request(
            requestOptions.path,
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
            options: Options(
              method: requestOptions.method,
              headers: requestOptions.headers,
              extra: requestOptions.extra,
            ),
          );
          return handler.resolve(retryResponse);
        } on DioException catch (retryErr) {
          return handler.next(retryErr);
        }
      }

      String? newAccessToken;

      try {
        if (_refreshFuture != null) {
          // Join in-flight refresh request
          newAccessToken = await _refreshFuture;
        } else {
          // Start a new refresh flow
          _refreshFuture = _performRefresh();
          newAccessToken = await _refreshFuture;
          _refreshFuture = null;
        }
      } catch (refreshErr) {
        _refreshFuture = null;
        // If refresh failed, force logout and reject with original error
        await _tokenStorage.clearSession();
        _onLogoutRequired();
        return handler.next(err);
      }

      if (newAccessToken != null) {
        // Retry original request with the new token
        requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        try {
          // Fetch retry using a clean Dio client
          final retryResponse = await _refreshDio.request(
            requestOptions.path,
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
            options: Options(
              method: requestOptions.method,
              headers: requestOptions.headers,
              extra: requestOptions.extra,
            ),
          );
          return handler.resolve(retryResponse);
        } on DioException catch (retryErr) {
          return handler.next(retryErr);
        }
      } else {
        // Refresh returned null (e.g. no credentials available), clear and logout
        await _tokenStorage.clearSession();
        _onLogoutRequired();
        return handler.next(err);
      }
    }

    handler.next(err);
  }

  Future<String?> _performRefresh() async {
    try {
      final refreshToken = await _tokenStorage.getRefreshToken();

      if (refreshToken == null) {
        return null;
      }

      final response = await _refreshDio.post(
        '/api/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final newAccessToken = data['accessToken']?.toString();
        final newRefreshToken = data['refreshToken']?.toString();
        final responseUserId = data['userId']?.toString();
        final responseAccountId = data['accountId']?.toString();

        if (newAccessToken != null &&
            newRefreshToken != null &&
            responseUserId != null) {
          await _tokenStorage.saveSession(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
            userId: responseUserId,
            accountId: responseAccountId,
          );
          return newAccessToken;
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
