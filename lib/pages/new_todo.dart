import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miappfeita/dtos/todo.dart';
import 'package:miappfeita/utils/todos.dart';

class NewTodoPage extends StatefulWidget {
  const NewTodoPage({super.key});

  @override
  State<NewTodoPage> createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  bool _loading = false;

  bool _codear = false;
  bool _flojear = false;
  bool _comer = false;
  bool _comprar = false;

  Future<void> _saveTodo(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });

    var todo = Todo.empty();

    todo.title = _taskTitleController.value.text;
    todo.description = _taskDescriptionController.value.text;
    todo.startDate = DateTime.parse(_startDateController.value.text);
    todo.endDate = DateTime.parse(_endDateController.value.text);

    if (_codear) {
      todo.labels.add('codear');
    }
    if (_flojear) {
      todo.labels.add('flojear');
    }
    if (_comer) {
      todo.labels.add('comer');
    }
    if (_comprar) {
      todo.labels.add('comprar');
    }

    try {
      await Todos().createTodo(todo);

      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todo creado exitosamente'),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      final message = e.toString().substring(11);

      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al crear el todo: $message'),
        ),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New TODO'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: TextFormField(
                        controller: _startDateController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Fecha de inicio",
                        ),
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Fecha requerida';
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);

                            setState(() {
                              _startDateController.text =
                                  formattedDate; //set foratted date to TextField value.
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextFormField(
                        controller: _endDateController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Fecha de término",
                        ),
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Fecha requerida';
                          }

                          var startDate =
                              DateTime.parse(_startDateController.value.text);
                          var endDate =
                              DateTime.parse(_endDateController.value.text);

                          if (endDate.isBefore(startDate)) {
                            return 'Rango inválido';
                          }

                          return null;
                        },
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);

                            setState(() {
                              _endDateController.text =
                                  formattedDate; //set foratted date to TextField value.
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Checkbox(
                        value: _codear,
                        onChanged: (value) {
                          setState(() {
                            _codear = value!;
                          });
                        },
                        activeColor: Colors.orange,
                      ),
                      const Text('Codear'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Checkbox(
                        value: _flojear,
                        onChanged: (value) {
                          setState(() {
                            _flojear = value!;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      const Text('Flojear'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Checkbox(
                        value: _comer,
                        onChanged: (value) {
                          setState(() {
                            _comer = value!;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                      const Text('Comer'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Checkbox(
                        value: _comprar,
                        onChanged: (value) {
                          setState(() {
                            _comprar = value!;
                          });
                        },
                        activeColor: Colors.grey,
                      ),
                      const Text('Comprar'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : () => _saveTodo(context),
              child:
                  _loading ? const Text("Guardando...") : const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
