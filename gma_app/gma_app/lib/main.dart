import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gma_app/screens/completed_groceries_screen.dart';
import 'package:gma_app/screens/current_groceries_screen.dart';
import 'package:gma_app/screens/edit_grocery_list.dart';
import 'package:gma_app/screens/grocery_details_screen.dart';
import 'package:gma_app/widgets/nav.dart';
//import './screens/home_screen.dart';
import './screens/add_groceries_screen.dart';

void main() {
  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //locale: DevicePreview.of(context).locale,
        builder: DevicePreview.appBuilder,
        title: 'Groceries Management Application',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Color.fromRGBO(39, 174, 96, 1.0),
          accentColor: Color.fromRGBO(46, 204, 113, 1.0),
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: HomeScreen(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => BottomNavBar(),
          AddGroceriesScreen.routeName: (ctx) => AddGroceriesScreen(),
          CurrentGroceriesScreen.routeName: (ctx) => CurrentGroceriesScreen(),
          CompletedGroceriesScreen.routeName: (ctx) =>
              CompletedGroceriesScreen(),
          EditGroceryList.routeName: (ctx) => EditGroceryList(),
          GroceryDetailsScreen.routeName: (ctx) => GroceryDetailsScreen(),
        });
  }
}
