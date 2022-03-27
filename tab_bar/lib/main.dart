import 'package:flutter/material.dart';
import 'tab_pages/first_page.dart';
import 'tab_pages/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TabBarApp(title: 'Tab Bar Example'),
    );
  }
}

class TabBarApp extends StatefulWidget {
  const TabBarApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TabBarApp> createState() => _TabBarApp();
}

class _TabBarApp extends State<TabBarApp> with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Tab Bar Example')),
        body: TabBarView(
            children: <Widget>[FirstPage(), SecondPage()],
            controller: controller),
        bottomNavigationBar: TabBar(tabs: const <Tab>[
          Tab(icon: Icon(Icons.looks_one, color: Colors.blue)),
          Tab(icon: Icon(Icons.looks_two, color: Colors.blue))
        ], controller: controller));
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
