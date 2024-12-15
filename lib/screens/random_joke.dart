import 'package:flutter/material.dart';
import '../services/api_services.dart';

class RandomJokeScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Random Joke')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: apiService.fetchRandomJoke(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final joke = snapshot.data ?? {};
            return ListTile(
              title: Text(joke['setup'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(joke['punchline']),
            );
          }
        },
      ),
    );
  }
}