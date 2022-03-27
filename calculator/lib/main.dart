import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Calculator';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: _title, home: CalculatorApp());
  }
}

class CalculatorApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalculatorApp();
}

class _CalculatorApp extends State<CalculatorApp> {
  final List _buttonList = ['Add', 'Subtract', 'Multiply', 'Divide'];
  final List<DropdownMenuItem<String>> _dropDownMenuItems =
      List.empty(growable: true);
  String? _buttonText;
  String sum = '';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (var item in _buttonList) {
      _dropDownMenuItems.add(DropdownMenuItem(child: Text(item), value: item));
    }
    _buttonText = _dropDownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Calculator App')),
        body: Center(
            child: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(15),
              child: Text('Result: $sum',
                  style: const TextStyle(fontFamily: 'Sans', fontSize: 20))),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: value1,
              )),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: value2,
              )),
          Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.add),
                      Text(_buttonText!)
                    ],
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber)),
                  onPressed: () {
                    setState(() {
                      var value1Int = double.parse(value1.value.text);
                      var value2Int = double.parse(value2.value.text);
                      var result;

                      if (_buttonText == 'Add') {
                        result = value1Int + value2Int;
                      } else if (_buttonText == 'Subtract') {
                        result = value1Int - value2Int;
                      } else if (_buttonText == 'Multiply') {
                        result = value1Int * value2Int;
                      } else {
                        result = value1Int / value2Int;
                      }
                      sum = '$result';
                    });
                  })),
          Padding(
              padding: const EdgeInsets.all(15),
              child: DropdownButton(
                  items: _dropDownMenuItems,
                  onChanged: (String? value) {
                    setState(() {
                      _buttonText = value;
                    });
                  },
                  value: _buttonText))
        ], mainAxisAlignment: MainAxisAlignment.center)));
  }
}
