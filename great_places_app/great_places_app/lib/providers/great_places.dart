import 'package:flutter/foundation.dart';
import 'dart:io';
import './models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
    String pickedName,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
      pickedLocation.latitude,
      pickedLocation.longitude,
    );
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      name: pickedName,
      image: pickedImage,
      location: updatedLocation,
    );

    _items.add(newPlace);
    notifyListeners();

    DBHelper.create('user_places', {
      'id': newPlace.id,
      'name': newPlace.name,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.read('user_places');
    _items = dataList
        .map(
          (place) => Place(
            id: place['id'],
            name: place['name'],
            image: File(
              place['image'],
            ),
            location: PlaceLocation(
              latitude: place['loc_lat'],
              longitude: place['loc_lng'],
              address: place['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
