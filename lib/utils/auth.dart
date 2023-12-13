import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
        '${dotenv.env['API_URL']}/login',
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
      required String name,
      required String email}) async {
    try {
      Response response = await Dio().post(
        '${dotenv.env['API_URL']}/users',
        data: {
          'name': name,
          'username': username,
          'password': password,
          'email': email,
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

  Future<String> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  Future<Map<String, dynamic>> getMe() async {
    try {
      Response response = await Dio().get(
        '${dotenv.env['API_URL']}/users/me',
        options: Options(
          validateStatus: (status) => status! < 500,
          headers: {
            'Authorization': 'Bearer ${await getAccessToken()}',
          },
        ),
      );

      if (!response.data['success']) {
        throw Exception(response.data['message']);
      }

      return response.data['user'];
    } catch (e) {
      if (e is DioException) {
        throw Exception('Hubo un error al obtener los datos del usuario');
      }

      rethrow;
    }
  }
}
