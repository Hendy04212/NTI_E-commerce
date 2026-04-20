/// Global favorite manager to share favorites state across the app.
/// Uses a simple singleton pattern with ChangeNotifier for reactivity.
import 'package:flutter/foundation.dart';

class FavoriteItemData {
  final String name;
  final String image;
  final double price;
  final String disc;
  final double rating;
  final String reviews;

  FavoriteItemData({
    required this.name,
    required this.image,
    required this.price,
    required this.disc,
    this.rating = 4.5,
    this.reviews = '0',
  });
}

class FavoriteManager extends ChangeNotifier {
  static final FavoriteManager _instance = FavoriteManager._internal();
  factory FavoriteManager() => _instance;
  FavoriteManager._internal();

  final List<FavoriteItemData> _favorites = [];

  List<FavoriteItemData> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(String name, String image) {
    return _favorites.any((item) => item.name == name && item.image == image);
  }

  void toggleFavorite(FavoriteItemData item) {
    final index = _favorites.indexWhere(
        (e) => e.name == item.name && e.image == item.image);
    if (index != -1) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(item);
    }
    notifyListeners();
  }

  void removeFromFavorites(int index) {
    if (index >= 0 && index < _favorites.length) {
      _favorites.removeAt(index);
      notifyListeners();
    }
  }
}
