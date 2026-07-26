import 'dart:async';
import 'dart:collection';
import 'package:cawil/data/offline/hive_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TokenInterceptor extends Interceptor {
  final Dio _dio;
  bool _isRefreshing = false;
  late final Queue<PendingRequest> _queue;

  TokenInterceptor(this._dio) {
    _queue = Queue();
    debugPrint('TokenInterceptor initialized');
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint(
        'TokenInterceptor onRequest -> ${options.method} ${options.path}');
    if (options.extra['requiresAuth'] == false) {
      handler.next(options);
      return;
    }

    final token = await HiveStorage.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      debugPrint('Added Authorization header: Bearer $token');
    } else {
      debugPrint('No token found in HiveStorage');
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final status = err.response?.statusCode;
    final responseData = err.response?.data;
    final msg = responseData is Map
        ? responseData['detail'] ?? responseData['error'] ?? responseData
        : responseData;
    debugPrint('TokenInterceptor onError -> status: $status, message: $msg');
    if (_shouldRefreshToken(err, msg)) {
      if (!await HiveStorage.hasRefreshToken()) {
        debugPrint('No refresh token found; clearing saved session');
        await HiveStorage.clearSession();
        handler.next(err);
        return;
      }

      debugPrint('Queueing failed request: ${err.requestOptions.path}');
      _queue.add(PendingRequest(err.requestOptions, handler));
      if (!_isRefreshing) {
        _isRefreshing = true;
        debugPrint('Refreshing token...');
        try {
          await _refreshToken();
          final newToken = await HiveStorage.accessToken;
          debugPrint('New token acquired: $newToken');
          for (final pending in _queue) {
            debugPrint('Retrying request: ${pending.options.path}');
            pending.options.headers['Authorization'] = 'Bearer $newToken';
            final clone = await _dio.request(
              pending.options.path,
              data: pending.options.data,
              queryParameters: pending.options.queryParameters,
              options: Options(
                method: pending.options.method,
                headers: pending.options.headers,
                extra: pending.options.extra,
              ),
            );
            debugPrint('Response for retried request: ${clone.statusCode}');
            pending.handler.resolve(clone);
          }
        } catch (e) {
          debugPrint('Error refreshing token: $e');
          await HiveStorage.clearSession();
          for (final pending in _queue) {
            pending.handler.next(err);
          }
        } finally {
          _queue.clear();
          _isRefreshing = false;
          debugPrint('Token refresh process completed');
        }
      }
    } else if (status == 401 && err.requestOptions.path == '/auth/refresh') {
      await HiveStorage.clearSession();
      handler.next(err);
    } else {
      handler.next(err);
    }
  }

  bool _shouldRefreshToken(DioException err, Object? message) {
    if (err.response?.statusCode != 401) return false;
    if (err.requestOptions.path == '/auth/refresh') return false;
    if (err.requestOptions.extra['requiresAuth'] == false) return false;

    final normalizedMessage = message?.toString().toLowerCase().trim();
    return normalizedMessage == 'authentication required' ||
        normalizedMessage == 'missing or invalid authentication' ||
        normalizedMessage == 'invalid or expired token';
  }

  Future<void> _refreshToken() async {
    debugPrint('TokenInterceptor _refreshToken called');
    final refreshToken = await HiveStorage.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      throw StateError('No refresh token found');
    }

    final response = await _dio.post(
      '/auth/refresh',
      options: Options(extra: {'requiresAuth': false}),
      data: {'refresh_token': refreshToken},
    );
    debugPrint(
        'Refresh token response: ${response.statusCode} ${response.data}');

    final data = Map<String, dynamic>.from(response.data as Map);
    await HiveStorage.saveTokens(
      accessToken: data['access_token'] as String,
      refreshToken: data['refresh_token'] as String,
    );
    debugPrint('Tokens saved to HiveStorage');
  }
}

class PendingRequest {
  final RequestOptions options;
  final ErrorInterceptorHandler handler;
  PendingRequest(this.options, this.handler);
}
