import 'package:flutter/material.dart';

class BarraLateral extends StatelessWidget {
  const BarraLateral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.amber,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Sec"),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Nueva tarea"),
              onTap: () {
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Borrar todo"),
              onTap: () {
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Acerca de"),
              onTap: () {
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
