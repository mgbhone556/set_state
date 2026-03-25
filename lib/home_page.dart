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

  final List<String> _images = [
    'images/OIP.webp',
    'images/nail-salon.png',
    'images/demon_salyer.jpg',
  ];

  void _onThemeChanged(bool value) {
    setState(() {
      _isDarkTheme = value;
    });
  }

  void _nextImage() {
    setState(() {
      _imageIndex = (_imageIndex + 1) % _images.length;
    });
  }

  void _togglePassword() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

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
      if (_counter > 0) _counter--;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(height: 20),

              const Text(
                "Tap image to change",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _nextImage,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    _images[_imageIndex],
                    height: 180,
                    width: 180,
                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 180,
                      width: 180,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 50),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              TextField(
                obscureText: _isObscure,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  labelText: "Password Field",
                  labelStyle: TextStyle(color: textColor),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _togglePassword,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Text(
                'Background Color Changer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _changeColor,
                icon: const Icon(Icons.color_lens),
                label: const Text("Change Color"),
              ),
              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text('Counter Value:', style: TextStyle(color: textColor)),
                    Text(
                      '$_counter',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(color: textColor),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton.small(
                          onPressed: _decreaseCounter,
                          heroTag: "btn1",
                          child: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 30),
                        FloatingActionButton.small(
                          onPressed: _incrementCounter,
                          heroTag: "btn2",
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
