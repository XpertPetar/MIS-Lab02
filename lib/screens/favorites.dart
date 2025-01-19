// import 'package:flutter/material.dart';
//
// class FavoritesScreen extends StatelessWidget {
//   final Set<Map<String, dynamic>> favorites;
//
//   FavoritesScreen({required this.favorites});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorite Jokes'),
//       ),
//       body: favorites.isEmpty
//           ? Center(child: Text('No favorite jokes yet!'))
//           : ListView(
//         children: favorites.map((joke) {
//           return Card(
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             elevation: 5,
//             child: ListTile(
//               title: Text(
//                 joke['setup'],
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(joke['punchline']),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      appBar: AppBar(title: Text('Favorite Jokes')),
      body: favorites.isEmpty
          ? Center(child: Text('No favorite jokes yet!'))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final joke = favorites[index];
          return Card(
            child: ListTile(
              title: Text(joke['setup'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(joke['punchline']),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  context.read<FavoritesProvider>().removeFavorite(joke);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
