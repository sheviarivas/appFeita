import 'package:flutter/material.dart';
import 'package:miappfeita/shared/barra_lateral.dart';

class TodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: BarraLateral(),
      ),
      appBar: AppBar(
        title: const Text("Mi app feita TODO LISTaaaa"),
      ),
      body: SafeArea(
        child: Center(
          child: Text('Tasks'),
        ),
      ),
    );
  }
}

class Task extends StatelessWidget {
  // const Task({required this.color});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "Nombre1",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            Text(
              "Descripcion1",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        )
      ],
    );
  }
}
