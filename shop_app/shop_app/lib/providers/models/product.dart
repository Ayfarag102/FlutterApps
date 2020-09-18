import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFav;

  Product({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFav = false,
  });

  void toggleFav() {
    isFav = !isFav;

    notifyListeners();
  }
}
