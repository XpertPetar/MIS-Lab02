// import 'package:flutter/material.dart';
// import '../services/api_services.dart';
// import 'favorites.dart';
//
// class JokesByTypeScreen extends StatefulWidget {
//   final String type;
//
//   JokesByTypeScreen({required this.type});
//
//   @override
//   _JokesByTypeScreenState createState() => _JokesByTypeScreenState();
// }
//
// class _JokesByTypeScreenState extends State<JokesByTypeScreen> {
//   final ApiService apiService = ApiService();
//   final Set<Map<String, dynamic>> favoriteJokes = {}; // Store favorite jokes
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${widget.type} Jokes'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.favorite),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => FavoritesScreen(favorites: favoriteJokes),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: apiService.fetchJokesByType(widget.type),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final jokes = snapshot.data ?? [];
//             return ListView.builder(
//               itemCount: jokes.length,
//               itemBuilder: (context, index) {
//                 final joke = jokes[index];
//                 final isFavorite = favoriteJokes.contains(joke);
//
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   elevation: 5,
//                   child: ListTile(
//                     title: Text(
//                       joke['setup'],
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(joke['punchline']),
//                     trailing: IconButton(
//                       icon: Icon(
//                         isFavorite ? Icons.favorite : Icons.favorite_border,
//                         color: isFavorite ? Colors.red : null,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           if (isFavorite) {
//                             favoriteJokes.remove(joke);
//                           } else {
//                             favoriteJokes.add(joke);
//                           }
//                         });
//                       },
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../services/api_services.dart';

class JokesByTypeScreen extends StatelessWidget {
  final String type;
  final ApiService apiService = ApiService();

  JokesByTypeScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$type Jokes')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: apiService.fetchJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final jokes = snapshot.data ?? [];
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                final isFavorite = context.watch<FavoritesProvider>().isFavorite(joke);

                return Card(
                  child: ListTile(
                    title: Text(joke['setup'], style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(joke['punchline']),
                    trailing: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
                        if (isFavorite) {
                          context.read<FavoritesProvider>().removeFavorite(joke);
                        } else {
                          context.read<FavoritesProvider>().addFavorite(joke);
                        }
                      },
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

