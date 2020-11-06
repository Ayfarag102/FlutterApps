import 'package:flutter/material.dart';
import 'package:gma_app/widgets/nav.dart';
//import './add_groceries_screen.dart';
//import 'package:intl/intl.dart';
//import '../widgets/home.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Grocery Management Application")),
        body: Card(
          elevation: 10,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  child: Text("Logo"),
                ),
                Text(
                  DateTime.now().toIso8601String(),
                ),
                FlatButton.icon(
                    onPressed: () {
                      // Navigator.of(context)
                      //     .pushReplacementNamed(AddGroceriesScreen.routeName);
                      BottomNavBar();
                    },
                    icon: Icon(Icons.add,
                        color: Color.fromRGBO(41, 128, 185, 1.0)),
                    label: Text("Add Grocery Lists")),
                FlatButton.icon(
                    onPressed: () {
                      BottomNavBar();
                    },
                    icon: Icon(Icons.list),
                    label: Text("My Current Lists")),
                FlatButton.icon(
                    onPressed: () {
                      BottomNavBar();
                    },
                    icon: Icon(Icons.check_circle,
                        color: Theme.of(context).accentColor),
                    label: Text("My Completed Grocery Errands")),
              ],
            ),
          ),
        ));
  }
}
