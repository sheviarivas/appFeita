import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:miappfeita/dtos/todo.dart';
import 'package:miappfeita/utils/auth.dart';

class Todos {
  static final Todos _todos = Todos._internal();

  factory Todos() {
    return _todos;
  }

  Todos._internal();

  Future<List<Todo>> getTodos() async {
    try {
      var accessToken = await Auth().getAccessToken();

      Response response = await Dio().get(
        '${dotenv.env['API_URL']}/todos',
        options: Options(validateStatus: (status) => status! < 500, headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );

      // TODO: Si retorna 401, redirigir a login

      if (!response.data['success']) {
        throw Exception(response.data['message']);
      }

      var todos = (response.data['todos'] as List)
          .map((e) => Todo.fromJson(e))
          .toList();

      return todos;
    } catch (e) {
      if (e is DioException) {
        throw Exception(
            'Hubo un error al obtener los todos. Intente más tarde');
      }

      rethrow;
    }
  }

  Future<void> createTodo(Todo todo) async {}

  Future<Todo?> getTodo(String id) async {
    return null;
  }

  Future<Todo?> updateTodo(Todo todo) async {
    return null;
  }

  Future<void> deleteTodo(String id) async {}
}
