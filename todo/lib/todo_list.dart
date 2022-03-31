import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ToDoList();
}

class _ToDoList extends State<ToDoList> {
  List<String> todoList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    todoList.add('Work 1');
    todoList.add('Work 2');
    todoList.add('Work 3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ToDo Item')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              child: Text(
                todoList[index],
                style: const TextStyle(fontSize: 30),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/third', arguments: todoList[index]);
              },
            ),
          );
        },
        itemCount: todoList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addToDoItem(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addToDoItem(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/second');
    setState(() {
      todoList.add(result as String);
    });
  }
}
