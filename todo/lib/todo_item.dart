import 'package:flutter/material.dart';

class ToDoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('ToDo Item')),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(controller: controller, keyboardType: TextInputType.text),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(controller.value.text);
              },
              child: const Text('Save Item'),
            ),
          ],
        ),
      ),
    );
  }
}
