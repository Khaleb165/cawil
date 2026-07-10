import 'package:cawil/data/offline/hive_storage.dart';
import 'package:cawil/data/remote/dio_client.dart';
import 'package:cawil/model/login.dart';
import 'package:cawil/model/register.dart';
import 'package:cawil/model/user.dart' as model;

class AuthMethods {
  static Future<bool> hasSavedSession() async {
    return HiveStorage.hasSavedSession();
  }

  Future<model.User> getUserDetails() async {
    final response = await DioClient().get('/auth/me');
    final data = Map<String, dynamic>.from(response as Map);
    final user = model.User.fromJson(
      Map<String, dynamic>.from(data['user'] as Map),
    );
    await HiveStorage.cacheUser(user);
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
}
