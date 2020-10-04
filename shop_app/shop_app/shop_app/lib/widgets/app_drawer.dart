import 'package:flutter/material.dart';
import '../helpers/custom_route.dart';
import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';

import 'package:provider/provider.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(
          title: Text('Hello Customas!'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop',
                style:
                    TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Orders',
                style:
                    TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.bold)),
            onTap: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(OrdersScreen.routeName);

              Navigator.of(context).pushReplacement(
                CustomRoute(
                  builder: (ctx) => OrdersScreen(),
                ),
              );
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products',
                style:
                    TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout',
                style:
                    TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
            }),
      ],
    ));
  }
}
