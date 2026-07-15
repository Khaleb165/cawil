import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:cawil/data/remote/dio_exceptions.dart';
import 'package:cawil/data/remote/interceptor/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  static final DioClient _instance = DioClient.internal();

  factory DioClient() => _instance;

  static late Dio _dio;

  DioClient.internal();

  final serverUrl = dotenv.env['BASE_URL'] ?? '';

  Future<void> initDioClient() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: serverUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    final tokenInterceptor = TokenInterceptor(_dio);

    _dio.interceptors.addAll([
      AwesomeDioInterceptor(logger: print),
      tokenInterceptor,
    ]);
  }

  // get endpoint
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
    Map<String, dynamic>? headers,
  }) async {
    Response response;
    try {
      response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          extra: {'requiresAuth': requiresAuth},
        ),
      );
      return response.data;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw (errorMessage);
    }
  }

  Future<List<int>> getBytes(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get<List<int>>(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          extra: {'requiresAuth': requiresAuth},
          responseType: ResponseType.bytes,
        ),
      );
      return response.data ?? <int>[];
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw (errorMessage);
    }
  }

  // post endpoint
  Future<dynamic> post(
    String endpoint,
    dynamic data, {
    Map<String, dynamic>? headers,
    bool requiresAuth = true,
  }) async {
    Response response;

    try {
      debugPrint("Body: $data");
      Options options = Options(
        headers: headers,
        extra: {'requiresAuth': requiresAuth},
      );

      response = await _dio.post(endpoint, data: data, options: options);

      return response.data;
    } on DioException catch (e) {
      debugPrint("Error Message: ${e.message}");
      if (e.response != null) {
        debugPrint("Error Response Data: ${e.response?.data}");
        debugPrint("Error Response Headers: ${e.response?.headers}");
      }
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw (errorMessage);
    }
  }

  Future<dynamic> patch(
    String endpoint,
    dynamic data, {
    Map<String, dynamic>? headers,
    bool requiresAuth = true,
  }) async {
    try {
      Options options = Options(
        headers: headers,
        extra: {'requiresAuth': requiresAuth},
      );
      final response = await _dio.patch(
        endpoint,
        data: data,
        options: options,
      );
      return response.data;
    } on DioException catch (e) {
      debugPrint("Error Message: ${e.message}");
      if (e.response != null) {
        debugPrint("Error Response Data: ${e.response?.data}");
        debugPrint("Error Response Headers: ${e.response?.headers}");
      }
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw (errorMessage);
    }
  }

  // delete endpoint
  Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? headers,
    bool requiresAuth = true,
  }) async {
    try {
      Options options = Options(
        headers: headers,
        extra: {'requiresAuth': requiresAuth},
      );
      final response = await _dio.delete(endpoint, options: options);
      return response.data;
    } on DioException catch (e) {
      debugPrint("Error Message: ${e.message}");
      if (e.response != null) {
        debugPrint("Error Response Data: ${e.response?.data}");
        debugPrint("Error Response Headers: ${e.response?.headers}");
      }
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw (errorMessage);
    }
  }
}
