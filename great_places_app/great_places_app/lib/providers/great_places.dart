import 'package:flutter/foundation.dart';
import 'dart:io';
import './models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String pickedName,
    File pickedImage,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      name: pickedName,
      image: pickedImage,
      location: null,
    );

    _items.add(newPlace);
    notifyListeners();
  }
}
