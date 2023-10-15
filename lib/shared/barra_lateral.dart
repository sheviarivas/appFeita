import 'package:flutter/material.dart';
import 'package:miappfeita/pages/about.dart';
import 'package:miappfeita/pages/new_todo.dart';
import 'package:miappfeita/utils/auth.dart';

class BarraLateral extends StatefulWidget {
  const BarraLateral({Key? key}) : super(key: key);

  @override
  State<BarraLateral> createState() => _BarraLateralState();
}

class _BarraLateralState extends State<BarraLateral> {
  Future<Map<String, dynamic>?> _getMe(BuildContext context) async {
    try {
      return await Auth().getMe();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.amber,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            FutureBuilder(
                future: _getMe(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Hubo un error al obtener los todos"),
                      );
                    }
                    return UserAccountsDrawerHeader(
                      accountName: Text(snapshot.data!["name"]),
                      accountEmail: Text(snapshot.data!["username"]),
                    );
                  }

                  return const UserAccountsDrawerHeader(
                    accountName: Text("Name"),
                    accountEmail: Text("Username"),
                  );
                }),
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
