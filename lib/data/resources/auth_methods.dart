import 'package:cawil/model/user.dart' as model;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthMethods {
  static const String _authBoxName = 'auth';
  static const String _profileBoxName = 'user_profile';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user';
  static String _baseUrl = dotenv.env['BASE_URL'] ?? '';

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  )..interceptors.add(_authInterceptor);

  static final Dio _refreshDio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  static QueuedInterceptorsWrapper get _authInterceptor {
    return QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await accessToken;
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode != 401 ||
            error.requestOptions.path == '/auth/refresh') {
          handler.next(error);
          return;
        }

        final refreshed = await _refreshTokens();
        if (!refreshed) {
          await _clearSession();
          handler.next(error);
          return;
        }

        try {
          final token = await accessToken;
          final options = error.requestOptions;
          options.headers['Authorization'] = 'Bearer $token';
          final response = await _dio.fetch<dynamic>(options);
          handler.resolve(response);
        } catch (_) {
          handler.next(error);
        }
      },
    );
  }

  static Future<Box<dynamic>> get _authBox async {
    if (Hive.isBoxOpen(_authBoxName)) {
      return Hive.box<dynamic>(_authBoxName);
    }
    return Hive.openBox<dynamic>(_authBoxName);
  }

  static Future<Box<dynamic>> get _profileBox async {
    if (Hive.isBoxOpen(_profileBoxName)) {
      return Hive.box<dynamic>(_profileBoxName);
    }
    return Hive.openBox<dynamic>(_profileBoxName);
  }

  static Future<String?> get accessToken async {
    final box = await _authBox;
    return box.get(_accessTokenKey) as String?;
  }

  static Future<bool> hasSavedSession() async {
    final token = await accessToken;
    return token != null && token.isNotEmpty;
  }

  Future<model.User> getUserDetails() async {
    final response = await _dio.get<dynamic>('/auth/me');
    final data = Map<String, dynamic>.from(response.data as Map);
    final user = model.User.fromJson(
      Map<String, dynamic>.from(data['user'] as Map),
    );
    await _cacheUser(user);
    return user;
  }

  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        final response = await _dio.post<dynamic>('/auth/register', data: {
          'username': username,
          'email': email,
          'password': password,
        });
        await _saveAuthResponse(response.data);
        res = 'success';
      } else {
        res = 'Please fill all the fields';
      }
    } catch (error) {
      res = _errorMessage(error);
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        final response = await _dio.post<dynamic>('/auth/login', data: {
          'email': email,
          'password': password,
        });
        await _saveAuthResponse(response.data);
        res = 'success';
      } else {
        res = 'Please fill all the fields';
      }
    } catch (error) {
      res = _errorMessage(error);
    }
    return res;
  }

  Future<void> signOut() async {
    await _clearSession();
  }

  Future<model.User?> cachedUser() async {
    final box = await _profileBox;
    final rawUser = box.get(_userKey);
    if (rawUser is Map) {
      return model.User.fromJson(Map<String, dynamic>.from(rawUser));
    }
    return null;
  }

  static Future<void> _saveAuthResponse(dynamic responseData) async {
    final data = Map<String, dynamic>.from(responseData as Map);
    final authBox = await _authBox;
    await authBox.put(_accessTokenKey, data['access_token'] as String);
    await authBox.put(_refreshTokenKey, data['refresh_token'] as String);

    final user = model.User.fromJson(
      Map<String, dynamic>.from(data['user'] as Map),
    );
    await _cacheUser(user);
  }

  static Future<void> _cacheUser(model.User user) async {
    final box = await _profileBox;
    await box.put(_userKey, user.toJson());
  }

  static Future<bool> _refreshTokens() async {
    final authBox = await _authBox;
    final refreshToken = authBox.get(_refreshTokenKey) as String?;
    if (refreshToken == null || refreshToken.isEmpty) return false;

    try {
      final response = await _refreshDio.post<dynamic>(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );
      final data = Map<String, dynamic>.from(response.data as Map);
      await authBox.put(_accessTokenKey, data['access_token'] as String);
      await authBox.put(_refreshTokenKey, data['refresh_token'] as String);
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<void> _clearSession() async {
    final authBox = await _authBox;
    final profileBox = await _profileBox;
    await authBox.clear();
    await profileBox.clear();
  }

  static String _errorMessage(Object error) {
    if (error is DioException) {
      final responseData = error.response?.data;
      if (responseData is Map && responseData['error'] != null) {
        return responseData['error'].toString();
      }
      return error.message ?? 'Unable to reach the CaWil backend';
    }
    return error.toString();
  }
}
