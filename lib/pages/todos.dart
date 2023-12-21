import 'dart:async';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:miappfeita/dtos/todo.dart';
import 'package:miappfeita/pages/new_todo.dart';
import 'package:miappfeita/shared/barra_lateral.dart';
import 'package:miappfeita/utils/todos.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  String _search = '';
  Timer? _debounce;

  late AdmobInterstitial interstitialAd;

  @override
  void initState() {
    super.initState();

    interstitialAd = AdmobInterstitial(
      adUnitId: AdmobInterstitial.testAdUnitId,
    );

    interstitialAd.load();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    interstitialAd.dispose();

    super.dispose();
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _search = query;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          onPressed: () {
            //debe cerrar la barra lateral y luego abrir la pagina
            // Navigator.pop(context);

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const NewTodoPage();
            }));
          },
          child: const Icon(Icons.add),
        ),
      ),
      drawer: Drawer(
        child: BarraLateral(
          onCreate: () => setState(() {}),
          onDelete: () => setState(() {}),
        ),
      ),
      appBar: AppBar(
        title: const Text("Mi app feita TODO LIST"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Buscar',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                _onSearchChanged(value);
              },
            ),
          ),
          FutureBuilder(
            future: Todos().getTodos(search: _search),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Hubo un error al obtener los todos"),
                  );
                }

                if (snapshot.data!.isEmpty) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Lottie.asset('assets/lotties/sad_face.json'),
                        const Text(
                          'No hay todos',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                    ),
                  );
                }

                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: snapshot.data!
                          .map((e) => ItemWidget(
                                todo: e,
                                onDelete: () => setState(() async {
                                  final shouldShowAd =
                                      await interstitialAd.isLoaded;
                                  if (shouldShowAd ?? false) {
                                    interstitialAd.show();
                                  }
                                }),
                              ))
                          .toList(),
                    ),
                  ),
                );
              }

              return const Center(
                child: Text("Hubo un error al obtener los todos"),
              );
            },
          ),
          AdmobBanner(
            adUnitId: AdmobBanner.testAdUnitId,
            adSize: AdmobBannerSize.BANNER,
          )
        ],
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.todo,
    this.onDelete,
  });

  final Todo todo;

  final Function? onDelete;

  Future<void> _deleteTask(BuildContext context) async {
    var confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar'),
        content: const Text('¿Está seguro que desea eliminar la tarea?'),
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
      await Todos().deleteTodo(
        todo.id,
      );

      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tarea eliminada'),
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

  Color stringToColor(String inputString) {
    final int hash = inputString.hashCode;
    final int r = (hash & 0xFF0000) >> 16;
    final int g = (hash & 0x00FF00) >> 8;
    final int b = (hash & 0x0000FF);
    return Color.fromRGBO(r, g, b, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    var description = todo.description;

    if (description.isEmpty) {
      description = '(sin descripción)';
    }

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
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  description,
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'delete') {
                                _deleteTask(context);
                              } else if (value == 'edit') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Patente pendiente. Pendiente. Pendiente.'),
                                  ),
                                );
                              }
                            },
                            itemBuilder: (BuildContext bc) {
                              return const [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text("Editar"),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text("Borrar"),
                                ),
                              ];
                            },
                          )
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 8.0, // gap between adjacent chips
                      runSpacing: 4.0, // gap between lines
                      children: todo.labels
                          .map((e) => Chip(
                                label: Text(e),
                                backgroundColor: stringToColor(e),
                                labelStyle: TextStyle(
                                  color:
                                      stringToColor(e).computeLuminance() > 0.5
                                          ? Colors.black
                                          : Colors.white,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
