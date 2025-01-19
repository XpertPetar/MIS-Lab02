import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../services/api_services.dart';
import 'jokes_type.dart';
import 'favorites.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<List<String>> jokeTypes;

  @override
  void initState() {
    super.initState();
    jokeTypes = apiService.fetchJokeTypes();
  }

  IconData getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'dad':
        return Icons.elderly;
      case 'knock-knock':
        return Icons.doorbell;
      case 'programming':
        return Icons.computer;
      default:
        return Icons.emoji_emotions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke Types'),
        // actions: [
        //   IconButton(
        //     icon: Lottie.asset('assets/laughing_emoji.json'),
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/random_joke');
        //     },
        //   ),
        // ],
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
          IconButton(
            icon: Lottie.asset('assets/laughing_emoji.json'),
            onPressed: () {
              Navigator.pushNamed(context, '/random_joke');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: jokeTypes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final types = snapshot.data ?? [];
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.0,
              ),
              itemCount: types.length,
              itemBuilder: (context, index) {
                String jokeType = types[index];
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JokesByTypeScreen(type: jokeType),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            getIconForType(jokeType),
                            size: 40,
                            color: Colors.yellow,
                          ),
                          SizedBox(height: 10),
                          Text(
                            jokeType,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

