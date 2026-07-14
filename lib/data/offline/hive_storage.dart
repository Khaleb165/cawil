import 'package:cawil/model/user.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  static const String authBoxName = 'auth';
  static const String profileBoxName = 'user_profile';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user';

  static Future<void> init() async {
    await Hive.initFlutter();
    await openBoxes();
  }

  static Future<void> openBoxes() async {
    await authBox;
    await profileBox;
  }

  static Future<Box<dynamic>> get authBox async {
    if (Hive.isBoxOpen(authBoxName)) {
      return Hive.box<dynamic>(authBoxName);
    }
    return Hive.openBox<dynamic>(authBoxName);
  }

  static Future<Box<dynamic>> get profileBox async {
    if (Hive.isBoxOpen(profileBoxName)) {
      return Hive.box<dynamic>(profileBoxName);
    }
    return Hive.openBox<dynamic>(profileBoxName);
  }

  static Future<String?> get accessToken async {
    final box = await authBox;
    return box.get(_accessTokenKey) as String?;
  }

  static Future<String?> get refreshToken async {
    final box = await authBox;
    return box.get(_refreshTokenKey) as String?;
  }

  static Future<bool> hasSavedSession() async {
    final access = await accessToken;
    final refresh = await refreshToken;
    return (access != null && access.isNotEmpty) ||
        (refresh != null && refresh.isNotEmpty);
  }

  static Future<bool> hasRefreshToken() async {
    final token = await refreshToken;
    return token != null && token.isNotEmpty;
  }

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    if (accessToken.isEmpty || refreshToken.isEmpty) {
      throw StateError('Auth response did not include valid tokens');
    }

    final box = await authBox;
    await box.put(_accessTokenKey, accessToken);
    await box.put(_refreshTokenKey, refreshToken);
    await box.flush();
  }

  static Future<void> saveAuthResponse(dynamic responseData) async {
    final data = _authResponseMap(responseData);
    await saveTokens(
      accessToken: _requiredString(data, _accessTokenKey),
      refreshToken: _requiredString(data, _refreshTokenKey),
    );

    final user = User.fromJson(
      Map<String, dynamic>.from(data[_userKey] as Map),
    );
    debugPrint('User details ---- $user');
    await cacheUser(user);
  }

  static Future<void> cacheUser(User user) async {
    final box = await profileBox;
    await box.put(_userKey, user.toJson());
    await box.flush();
  }

  static Future<User?> cachedUser() async {
    final box = await profileBox;
    final rawUser = box.get(_userKey);
    if (rawUser is Map) {
      return User.fromJson(Map<String, dynamic>.from(rawUser));
    }
    return null;
  }

  static Future<void> clearSession() async {
    final auth = await authBox;
    final profile = await profileBox;
    await auth.clear();
    await profile.clear();
  }

  static Map<String, dynamic> _authResponseMap(dynamic responseData) {
    final data = Map<String, dynamic>.from(responseData as Map);
    final wrappedData = data['data'];
    if (wrappedData is Map) {
      return Map<String, dynamic>.from(wrappedData);
    }
    return data;
  }

  static String _requiredString(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is String && value.isNotEmpty) {
      return value;
    }
    throw StateError('Auth response did not include $key');
  }
}
