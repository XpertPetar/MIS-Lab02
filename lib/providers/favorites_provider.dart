import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  void addFavorite(Map<String, dynamic> joke) {
    if (!_favorites.any((fav) => fav['id'] == joke['id'])) {
      _favorites.add(joke);
      notifyListeners();
    }
  }

  void removeFavorite(Map<String, dynamic> joke) {
    _favorites.removeWhere((fav) => fav['id'] == joke['id']);
    notifyListeners();
  }

  bool isFavorite(Map<String, dynamic> joke) {
    return _favorites.any((fav) => fav['id'] == joke['id']);
  }
}
