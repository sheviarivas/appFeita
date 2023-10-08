import 'package:flutter/material.dart';

class NewTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New To do"),
      ),
      body: Center(
        child: Text('cositas pa un nuevo to do'),
      ),
    );
  }
}
