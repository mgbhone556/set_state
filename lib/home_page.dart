import 'package:flutter/material.dart';
import 'dart:math';

class SetStateHomePage extends StatefulWidget {
  const SetStateHomePage({super.key, required this.title});

  final String title;

  @override
  State<SetStateHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<SetStateHomePage> {
  int _counter = 0;
  Color _backgroundColor = Colors.white;

  void _changeColor() {
    setState(() {
      _backgroundColor = Color.fromARGB(
        255,
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
      );
    });
  }

  void _decreaseCounter() {
    setState(() {
      _counter--;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text(
              'Press the button to change background!',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeColor,
              child: const Text("Change Color"),
            ),
            const SizedBox(height: 40),
            const Text('This is the sample fo the setState'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _decreaseCounter,
                  tooltip: 'Decrease',
                  heroTag: "btn1",
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Increment',
                  heroTag: "btn2",
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
