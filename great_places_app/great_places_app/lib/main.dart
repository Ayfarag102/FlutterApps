import 'package:flutter/material.dart';
import 'package:great_places_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

import './providers/great_places.dart';
import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Great Places',
          theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.green[400],
          ),
          home: PlacesListScreen(),
          routes: {
            AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
            PlaceDetailsScreen.routeName: (ctx) => PlaceDetailsScreen(),
          }),
    );
  }
}
