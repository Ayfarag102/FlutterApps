import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

//import 'package:shop_app/screens/product_detail_screen.dart';
//import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/orders_screen.dart';
import './screens/cart_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';

import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: null,
          update: (ctx, auth, previous) =>
              Products(auth.token, previous == null ? [] : previous.items),
        ),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null,
          update: (ctx, auth, previous) =>
              Orders(auth.token, previous == null ? [] : previous.orders),
        ),
        //  ChangeNotifierProvider.value(value: Products()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Shopping Centre',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.green[400],
            primaryColorDark: Colors.black87,
            errorColor: Colors.red,

            // canvasColor: Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Lato',
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                  headline2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                  headline6:
                      TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                ),
          ),
          home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          //initialRoute: '/', // default is '/'
          routes: {
            // ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            //  AuthScreen.routeName: (ctx) => AuthScreen(),
          },
        ),
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
