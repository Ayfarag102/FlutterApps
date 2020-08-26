import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'Shopping Centre',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.green[400],
            primaryColorDark: Colors.black87,
            // canvasColor: Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Lato',
            textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                headline2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                headline6: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Anton',
                    fontWeight: FontWeight.bold))),
        // home: ProductsOverviewScreen(),
        //initialRoute: '/', // default is '/'
        routes: {
          '/': (ctx) => ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Shopping Centre'),
//       ),
//       body: Center(
//         child: Text('Let\'s go shopping together! 😄🛍'),
//       ),
//     );
//   }
// }
