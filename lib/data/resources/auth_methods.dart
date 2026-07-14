import 'package:cawil/data/offline/hive_storage.dart';
import 'package:cawil/data/remote/dio_client.dart';
import 'package:cawil/model/login.dart';
import 'package:cawil/model/register.dart';
import 'package:cawil/model/user.dart' as model;

class AuthMethods {
  static Future<bool> hasSavedSession() async {
    return AuthMethods().restoreSavedSession();
  }

  Future<model.User> getUserDetails() async {
    await _ensureAccessToken();
    final response = await DioClient().get('/auth/me');
    final data = Map<String, dynamic>.from(response as Map);
    final user = model.User.fromJson(
      Map<String, dynamic>.from(data['user'] as Map),
    );
    await HiveStorage.cacheUser(user);
    return user;
  }

  Future<bool> restoreSavedSession() async {
    if (!await HiveStorage.hasSavedSession()) {
      return false;
    }

    try {
      await getUserDetails();
      return true;
    } catch (_) {
      final refreshed = await refreshSession();
      if (!refreshed) {
        await HiveStorage.clearSession();
        return false;
      }
    }

    try {
      await getUserDetails();
      return true;
    } catch (_) {
      await HiveStorage.clearSession();
      return false;
    }
  }

  Future<bool> refreshSession() async {
    final refreshToken = await HiveStorage.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    try {
      final response = await DioClient().post(
        '/auth/refresh',
        {'refresh_token': refreshToken},
        requiresAuth: false,
      );
      final data = Map<String, dynamic>.from(response as Map);
      await HiveStorage.saveTokens(
        accessToken: data['access_token'] as String,
        refreshToken: data['refresh_token'] as String,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        final request = RegisterModel(
          username: username,
          email: email,
          password: password,
        );
        final response = await DioClient().post(
          '/auth/register',
          request.toJson(),
          requiresAuth: false,
        );
        await HiveStorage.saveAuthResponse(response);
        await getUserDetails();
        res = 'success';
      } else {
        res = 'Please fill all the fields';
      }
    } catch (error) {
      res = error.toString();
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
        final request = LoginModel(
          email: email,
          password: password,
        );
        final response = await DioClient().post(
          '/auth/login',
          request.toJson(),
          requiresAuth: false,
        );
        await HiveStorage.saveAuthResponse(response);
        await getUserDetails();
        res = 'success';
      } else {
        res = 'Please fill all the fields';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await HiveStorage.clearSession();
  }

  Future<model.User?> cachedUser() async {
    return HiveStorage.cachedUser();
  }

  Future<void> _ensureAccessToken() async {
    final accessToken = await HiveStorage.accessToken;
    if (accessToken != null && accessToken.isNotEmpty) {
      return;
    }

    final refreshed = await refreshSession();
    if (!refreshed) {
      throw StateError('No saved login session. Please log in again.');
    }
  }
}
