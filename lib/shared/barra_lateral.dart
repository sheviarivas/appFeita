import 'package:flutter/material.dart';
import 'package:miappfeita/pages/about.dart';
import 'package:miappfeita/pages/new_todo.dart';

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
              accountEmail: Text("holi@mail.com"),
            ),
            ListTile(
              leading: Icon(Icons.add_box_rounded), //border_color
              title: Text("Nueva tarea"),
              onTap: () {
                //debe cerrar la barra lateral y luego abrir la pagina
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewTodoPage();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel),
              title: Text("Borrar todo"),
              onTap: () {
                // Navigator.pop(context);
                // mostrar pop up "Está seguro?"
                // icons check y cancel
              },
            ),
            ListTile(
              leading: Icon(Icons.group_rounded),
              title: Text("Acerca de"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AboutPage();
                }));
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
