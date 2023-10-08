import 'package:flutter/material.dart';
import 'package:miappfeita/pages/register.dart';
import 'package:miappfeita/pages/todos.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text("Acceder"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TodosPage();
              }));
            },
          ),
          ElevatedButton(
            child: const Text("Registrar Usuario"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RegisterPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}

class CustomScreen extends StatelessWidget {
  // const CustomScreen({super.key});

  final Color color;

  const CustomScreen({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(children: [
        ElevatedButton(
            child: const Text("To Do List"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TodosPage();
              }));
            })
      ]),
    );
  }
}
