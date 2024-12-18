import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/random_joke.dart';

void main() {
  runApp(JokesApp());
}

class JokesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Jokes',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/random_joke': (context) => RandomJokeScreen(),
      },
    );
  }
}