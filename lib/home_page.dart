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
  bool _isObscure = true;
  int _imageIndex = 0;
  bool _isDarkTheme = false;
  bool _isLoading = false;
  final List<String> _todoList = [];
  final TextEditingController _todoController = TextEditingController();
  String? _errorText;

  final List<String> _images = [
    'images/OIP.webp',
    'images/nail-salon.png',
    'images/demon_salyer.jpg',
  ];

  void _onThemeChanged(bool value) => setState(() => _isDarkTheme = value);
  void _nextImage() =>
      setState(() => _imageIndex = (_imageIndex + 1) % _images.length);
  void _togglePassword() => setState(() => _isObscure = !_isObscure);

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

  Future<void> _simulateLoading() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
  }

  void _addTask() {
    if (_todoController.text.isNotEmpty) {
      setState(() {
        _todoList.add(_todoController.text);
        _todoController.clear();
      });
    }
  }

  void _removeTask(int index) {
    setState(() => _todoList.removeAt(index));
  }

  void _incrementCounter() => setState(() => _counter++);
  void _decreaseCounter() => setState(() {
    if (_counter > 0) _counter--;
  });

  @override
  Widget build(BuildContext context) {
    final currentBgColor = _isDarkTheme ? Colors.grey[900] : _backgroundColor;
    final textColor = _isDarkTheme ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: currentBgColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.wb_sunny,
                        color: _isDarkTheme ? Colors.grey : Colors.orange,
                      ),
                      Switch(value: _isDarkTheme, onChanged: _onThemeChanged),
                      Icon(
                        Icons.nightlight_round,
                        color: _isDarkTheme ? Colors.blue : Colors.grey,
                      ),
                    ],
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _simulateLoading,
                          child: const Text("Load"),
                        ),
                ],
              ),
              const Divider(),

              GestureDetector(
                onTap: _nextImage,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    _images[_imageIndex],
                    height: 150,
                    width: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, e, s) => Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                obscureText: _isObscure,
                onChanged: (val) => setState(
                  () => _errorText = val.length < 6 ? "Too short" : null,
                ),
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  labelText: "Password",
                  errorText: _errorText,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _togglePassword,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _todoController,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: "Add a task...",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add_box),
                    onPressed: _addTask,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _todoList[index],
                      style: TextStyle(color: textColor),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeTask(index),
                    ),
                  );
                },
              ),
              const Divider(),

              Text(
                'Counter: $_counter',
                style: TextStyle(
                  fontSize: 24,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.small(
                    heroTag: "b1",
                    onPressed: _decreaseCounter,
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton.small(
                    heroTag: "b2",
                    onPressed: _incrementCounter,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _changeColor,
                icon: const Icon(Icons.palette),
                label: const Text("Random BG Color"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
