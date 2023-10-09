import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static final Auth _storage = Auth._internal();

  factory Auth() {
    return _storage;
  }

  Auth._internal();

  Future<void> login(
      {required String username, required String password}) async {
    try {
      Response response = await Dio().post(
        'http://10.0.2.2:5000/api/v1/login',
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      if (!response.data['success']) {
        throw Exception(response.data['message']);
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.data['access_token']);
    } catch (e) {
      if (e is DioException) {
        throw Exception('Hubo un error al iniciar sesión. Intente más tarde');
      }

      rethrow;
    }
  }

  Future<void> register(
      {required String username,
      required String password,
      required String name}) async {
    try {
      Response response = await Dio().post(
        'http://10.0.2.2:5000/api/v1/users',
        data: {
          'name': name,
          'username': username,
          'password': password,
        },
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      if (!response.data['success']) {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception('Hubo un error al registrarse. Intente más tarde');
      }

      rethrow;
    }
  }
}
