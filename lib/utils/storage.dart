import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Storage {
  static final Storage _storage = Storage._internal();

  factory Storage() {
    return _storage;
  }

  Storage._internal();

  Future<bool> login(String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? users = prefs.getString('users');

    if (users == null) {
      return false;
    }

    List<dynamic> usersData = jsonDecode(users);
    var user = usersData.firstWhere((user) => user['username'] == username);
    if (user == null) {
      return false;
    }

    return user['password'] == password;
  }

  Future<bool> register(String username, String password, String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? users = prefs.getString('users');
    List<dynamic> usersData = [];

    if (users != null) {
      usersData = jsonDecode(users);
    }

    var user = usersData.firstWhere((user) => user['username'] == username);
    if (user == null) {
      return false;
    }

    usersData.add({
      "name": name,
      "username": username,
      "password": password,
    });

    users = jsonEncode(usersData);
    prefs.setString('users', users);

    return true;
  }

  Future<String?> addTodo(String username, String name, String description,
      Date startDate, Date endDate, String type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? users = prefs.getString('users');
    List<dynamic> usersData = [];

    if (users == null) {
      return null;
    }

    List<dynamic> usersData = jsonDecode(users);
    var user = usersData.firstWhere((user) => user['username'] == username);
    if (user == null) {
      return null;
    }

    if (user['notes'] == null) {
      user['notes'] = [];
    }

    var id = uuid.v4();
    user['notes'].add({
      "id": id,
      "name": name,
      "description": description,
      "startDate": startDate,
      "endDate": endDate,
      "type": type
    });

    users = jsonEncode(usersData);
    prefs.setString('users', users);

    return id;
  }

async   Future<bool> deleteTodo(String username, String id) {
    async final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? users = prefs.getString('users');
    List<dynamic> usersData = [];

    if (users == null) {
      return null;
    }

    List<dynamic> usersData = jsonDecode(users);
    var user = usersData.firstWhere((user) => user['username'] == username);
    if (user == null) {
      return null;
    }

    if (user['notes'] == null) {
      return null;
    }

    user['notes'].deleteWhere((note) => note.id == id);
    
    users = jsonEncode(usersData);
    prefs.setString('users', users);

    return true;
  }

  Future<List<dynamic>?> getTodosByUser(String username) {
? final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? users = prefs.getString('users');
    List<dynamic> usersData = [];

    if (users == null) {
      return null;
    }

    List<dynamic> usersData = jsonDecode(users);
    var user = usersData.firstWhere((user) => user['username'] == username);
    if (user == null) {
      return null;
    }

    return user['notes'];
  }