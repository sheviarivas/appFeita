import 'package:flutter/material.dart';
import 'package:miappfeita/shared/barra_lateral.dart';

class TodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const items = 10;
    return Scaffold(
        drawer: const Drawer(
          child: BarraLateral(),
        ),
        appBar: AppBar(
          title: const Text("Mi app feita TODO LIST"),
        ),
        body: Container(
            // padding: const EdgeInsets.all(18),
            // child: ListView(children: [
            child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                  items,
                  (index) => ItemWidget(
                        name: 'Item $index',
                        description:
                            'ksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksd hakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjshksdhakjsh',
                      )),
            ),
          );
        })));
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.name,
    required this.description,
  });

  final String name;
  final String description;

  Future<void> _deleteTask(BuildContext context) async {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Card(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("MAR 15"),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("MAR 17"),
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
                          name,
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
                            const Icon(Icons.circle,
                                color: Colors.orange, size: 20),
                            const Icon(Icons.circle,
                                color: Colors.green, size: 20),
                            // const Icon(Icons.circle,
                            //     color: Colors.blue, size: 20),
                            const Text("-"),
                            const Icon(Icons.circle,
                                color: Colors.grey, size: 20),
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
