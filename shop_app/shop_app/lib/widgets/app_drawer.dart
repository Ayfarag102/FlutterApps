import 'package:flutter/material.dart';
import '../screens/orders_screen.dart';

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
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            }),
      ],
    ));
  }
}
