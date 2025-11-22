import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const FrostedExampleApp());
}

class FrostedExampleApp extends StatefulWidget {
  const FrostedExampleApp({super.key});

  @override
  State<FrostedExampleApp> createState() => _FrostedExampleAppState();
}

class _FrostedExampleAppState extends State<FrostedExampleApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frosted UI Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: ExampleHomePage(onThemeToggle: _toggleTheme),
    );
  }
}
