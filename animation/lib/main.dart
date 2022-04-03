import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnimationApp(),
    );
  }
}

class AnimationApp extends StatefulWidget {
  const AnimationApp({Key? key}) : super(key: key);

  @override
  State<AnimationApp> createState() => _AnimationAppState();
}

class _AnimationAppState extends State<AnimationApp>
    with SingleTickerProviderStateMixin {
  double _size = 100;
  double _opacity = 1;
  bool _direction = true;
  AnimationController? _animationController;
  Animation? _rotateAnimation;
  Animation? _scaleAnimation;
  Animation? _transAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _rotateAnimation =
        Tween<double>(begin: 0, end: pi * 6).animate(_animationController!);
    _scaleAnimation =
        Tween<double>(begin: 1.5, end: 0.5).animate(_animationController!);
    _transAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 50))
            .animate(_animationController!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(seconds: 1),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeIn,
                      color: Colors.amber,
                      width: _size,
                      height: _size,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _rotateAnimation!,
                    builder: (context, widget) {
                      return Transform.translate(
                        offset: _transAnimation!.value,
                        child: Transform.rotate(
                          angle: _rotateAnimation!.value,
                          child: Transform.scale(
                            scale: _scaleAnimation!.value,
                            child: Container(
                              color: Colors.teal,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: (() {
                setState(() {
                  var random = Random();
                  _size = random.nextDouble() * 200;
                });
              }),
              child: const Text('Animate1'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _opacity == 1 ? _opacity = 0 : _opacity = 1;
                });
              },
              child: const Text('Opacity'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_direction) {
                  _animationController!.forward();
                  _direction = !_direction;
                } else {
                  _animationController!.reverse();
                  _direction = !_direction;
                }
              },
              child: const Text('Animate2'),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController!.dispose();
  }
}
