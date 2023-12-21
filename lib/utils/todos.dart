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

  Future<List<Todo>> getTodos({String search = ''}) async {
    try {
      var accessToken = await Auth().getAccessToken();

      Response response = await Dio().get(
        '${dotenv.env['API_URL']}/todos',
        options: Options(validateStatus: (status) => status! < 500, headers: {
          'Authorization': 'Bearer $accessToken',
        }),
        queryParameters: {
          'search': search,
        },
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
          'Hubo un error al obtener los todos. Intente más tarde',
        );
      }

      rethrow;
    }
  }

  Future<void> createTodo(Todo todo) async {
    try {
      var accessToken = await Auth().getAccessToken();

      Response response = await Dio().post(
        '${dotenv.env['API_URL']}/todos',
        data: todo.toJson(),
        options: Options(validateStatus: (status) => status! < 500, headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );

      if (!response.data['success']) {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception('Hubo un error al crear el todo. Intente más tarde');
      }

      rethrow;
    }
  }

  Future<Todo?> getTodo(String id) async {
    try {
      var accessToken = await Auth().getAccessToken();

      Response response = await Dio().get(
        '${dotenv.env['API_URL']}/todos/$id',
        options: Options(validateStatus: (status) => status! < 500, headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );
      // print("$response");

      if (!response.data['success']) {
        throw Exception(response.data['message']);
      }

      // print(Todo.fromJson(response.data['todo']));

      return Todo.fromJson(response.data['todo']);
    } catch (e) {
      if (e is DioException) {
        throw Exception('Hubo un error al obtener el todo. Intente más tarde');
      }

      rethrow;
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      var accessToken = await Auth().getAccessToken();

      Response response = await Dio().put(
        '${dotenv.env['API_URL']}/todos/${todo.id}',
        data: todo.toJson(),
        options: Options(validateStatus: (status) => status! < 500, headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );

      if (!response.data['success']) {
        throw Exception(response.data['message']);
      }

      // return Todo.fromJson(response.data['todo']);
    } catch (e) {
      if (e is DioException) {
        throw Exception(
            'Hubo un error al actualizar el todo. Intente más tarde');
      }

      rethrow;
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      var accessToken = await Auth().getAccessToken();

      Response response = await Dio().delete(
        '${dotenv.env['API_URL']}/todos/$id',
        options: Options(validateStatus: (status) => status! < 500, headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );

      if (!response.data['success']) {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception('Hubo un error al eliminar el todo. Intente más tarde');
      }

      rethrow;
    }
  }

  Future<void> deleteAllTodos() async {
    try {
      var accessToken = await Auth().getAccessToken();

      Response response = await Dio().delete(
        '${dotenv.env['API_URL']}/todos',
        options: Options(validateStatus: (status) => status! < 500, headers: {
          'Authorization': 'Bearer $accessToken',
        }),
      );

      if (!response.data['success']) {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception(
            'Hubo un error al eliminar los todos. Intente más tarde');
      }

      rethrow;
    }
  }
}
