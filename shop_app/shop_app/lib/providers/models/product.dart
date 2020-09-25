import 'package:flutter/foundation.dart';
//import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  void _setFav(bool newVal) {
    isFav = newVal;
    notifyListeners();
  }

  Future<void> toggleFav() async {
    final oldStatus = isFav;

    isFav = !isFav;

    notifyListeners();
    final url =
        'https://flutter-course-shop-app-734d5.firebaseio.com/products/$id.json';
    try {
      final response = await http.patch(url,
          body: json.encode({
            'isFav': isFav,
          }));
      if (response.statusCode >= 400) {
        _setFav(oldStatus);
        notifyListeners();
      }
    } catch (err) {
      _setFav(oldStatus);
      notifyListeners();
      // print(err);
      // throw err;
    }
  }
}
