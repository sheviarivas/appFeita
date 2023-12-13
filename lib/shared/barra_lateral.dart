import 'package:flutter/material.dart';
import 'package:miappfeita/pages/about.dart';
import 'package:miappfeita/pages/new_todo.dart';
import 'package:miappfeita/utils/auth.dart';
import 'package:miappfeita/utils/todos.dart';
import 'package:miappfeita/utils/gravatar.dart';

class BarraLateral extends StatelessWidget {
  final Function? onDelete;
  final Function? onCreate;

  const BarraLateral({Key? key, this.onDelete, this.onCreate})
      : super(key: key);

  Future<Map<String, dynamic>?> _getMe(BuildContext context) async {
    try {
      return await Auth().getMe();
    } catch (e) {
      return null;
    }
  }

  Future<void> _deleteAllTodos(BuildContext context) async {
    Navigator.pop(context);

    var confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar'),
        content:
            const Text('¿Está seguro que desea eliminar todas las tareas?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == null || !confirm) {
      return;
    }

    try {
      await Todos().deleteAllTodos();

      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tareas eliminadas exitosamente'),
        ),
      );

      if (onDelete != null) {
        onDelete!();
      }
    } catch (e) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hubo un error al eliminar la tarea'),
        ),
      );
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

                    var name = snapshot.data!["name"];
                    var email = snapshot.data!["email"];

                    if (email == null) {
                      var username = snapshot.data!["username"];

                      return UserAccountsDrawerHeader(
                        accountName: Text(name),
                        accountEmail: Text("@$username"),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                            name[0],
                            style: const TextStyle(fontSize: 40.0),
                          ),
                        ),
                      );
                    }

                    var emailHash = Gravatar.generateEmailHash(email);

                    return UserAccountsDrawerHeader(
                      accountName: Text(name),
                      accountEmail: Text(email),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://gravatar.com/avatar/$emailHash',
                        ),
                      ),
                    );
                  }

                  return const UserAccountsDrawerHeader(
                    accountName: Text("Name"),
                    accountEmail: Text("Username"),
                  );
                }),
            ListTile(
              leading: const Icon(Icons.add_box_rounded), //border_color
              title: const Text("Nueva tarea"),
              onTap: () {
                //debe cerrar la barra lateral y luego abrir la pagina
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const NewTodoPage();
                })).then(
                  (value) {
                    if (onCreate != null) {
                      onCreate!();
                    }
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text("Borrar todo"),
              onTap: () => _deleteAllTodos(context),
            ),
            ListTile(
              leading: const Icon(Icons.group_rounded),
              title: const Text("Acerca de"),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AboutPage();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
