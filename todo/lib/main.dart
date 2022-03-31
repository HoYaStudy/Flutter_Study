import 'package:flutter/material.dart';
import 'todo_list.dart';
import 'todo_item.dart';
import 'detail_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'ToDo Example';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      initialRoute: '/',
      routes: {
        '/': (context) => ToDoList(),
        '/second': (context) => ToDoItem(),
        '/third': (context) => DetailView()
      },
    );
  }
}
