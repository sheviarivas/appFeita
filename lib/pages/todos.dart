import 'package:flutter/material.dart';

class TodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hola Mundo'),
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
        // Icon(icon, color: color),
        // Container(
        //   margin: const EdgeInsets.only(top: 8),
        //   child: Text(
        //     label,
        //     style: TextStyle(
        //       fontSize: 12,
        //       fontWeight: FontWeight.w400,
        //       color: color,
        //     ),
        //   ),
        // ),
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
