import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Integrantes", style: TextStyle(fontSize: 55)),
            Text("", style: TextStyle(fontSize: 8)),
            Text("Jorge Jara Inostroza", style: TextStyle(fontSize: 24)),
            Text("Sebastian Hevia Rivas", style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
