import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Centre',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.green[400],
          primaryColorDark: Colors.black87,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold))),
      //  home: CategoriesScreen(),
      //initialRoute: '/', // default is '/'
      // routes: {
      //   '/': (ctx) => TabsScreen(_favouriteMeals),
      //   CategoryMealsScreen.routeName: (ctx) =>
      //       CategoryMealsScreen(_availableMeals),
      //   MealDetailScreen.routeName: (ctx) =>
      //       MealDetailScreen(_toggleFavourite, _isMealFavourite),
      //   FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      // },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Centre'),
      ),
      body: Center(
        child: Text('Navigation Time!'),
      ),
    );
  }
}
