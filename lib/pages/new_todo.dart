import 'package:flutter/material.dart';

// import 'package:miappfeita/pages/register.dart';
// import 'package:miappfeita/pages/todos.dart';
// import 'package:miappfeita/utils/auth.dart';

class NewTodoPage extends StatefulWidget {
  const NewTodoPage({super.key});

  @override
  State<NewTodoPage> createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  // final _formKey = GlobalKey<FormState>();

  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  bool _loading = false;

  Future<void> _saveTask(BuildContext context) async {
    // if (!_formKey.currentState!.validate()) {
    //   return;
    // }

    setState(() {
      _loading = true;
    });

    final taskTitle = _taskTitleController.value.text.toString();
    final taskDescription = _taskDescriptionController.value.text.toString();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New TODO'),
      ),
      body: Form(
        // key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: _taskTitleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Título de la nueva tarea',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Título requerido';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: _taskDescriptionController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descripción',
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Contraseña requerida';
                //   }

                //   return null;
                // },
              ),
            ),
            ElevatedButton(
              onPressed: _loading ? null : () => _saveTask(context),
              child:
                  _loading ? const Text("Guardando...") : const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
