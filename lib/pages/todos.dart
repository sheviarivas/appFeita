import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miappfeita/dtos/todo.dart';
import 'package:miappfeita/shared/barra_lateral.dart';
import 'package:miappfeita/utils/todos.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: BarraLateral(),
      ),
      appBar: AppBar(
        title: const Text("Mi app feita TODO LIST"),
      ),
      body: FutureBuilder(
        future: Todos().getTodos(),
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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children:
                        snapshot.data!.map((e) => ItemWidget(todo: e)).toList(),
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: Text("Hubo un error al obtener los todos"),
          );
        },
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.todo,
  });

  final Todo todo;

  Future<void> _deleteTask(BuildContext context) async {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Card(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(DateFormat('MMM d').format(todo.startDate)),
                ),
              ),
              Card(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(DateFormat('MMM d').format(todo.startDate)),
                ),
              ),
            ],
          ),
          Card(
              child: SizedBox(
            height: 100,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todo.title,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          todo.description,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RawMaterialButton(
                            shape: const CircleBorder(),
                            onPressed: () => _deleteTask(context),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                              size: 40,
                            )),
                        Row(
                          children: [
                            Icon(
                              todo.labels.any((label) => label == 'codear')
                                  ? Icons.circle
                                  : Icons.circle_outlined,
                              color: Colors.orange,
                              size: 20,
                            ),
                            Icon(
                              todo.labels.any((label) => label == 'flojear')
                                  ? Icons.circle
                                  : Icons.circle_outlined,
                              color: Colors.green,
                              size: 20,
                            ),
                            Icon(
                              todo.labels.any((label) => label == 'comer')
                                  ? Icons.circle
                                  : Icons.circle_outlined,
                              color: Colors.blue,
                              size: 20,
                            ),
                            Icon(
                              todo.labels.any((label) => label == 'comprar')
                                  ? Icons.circle
                                  : Icons.circle_outlined,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
