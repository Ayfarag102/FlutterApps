import 'package:flutter/material.dart';
import '../widgets/home.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Grocery Management Application")),
        body: Card(
          elevation: 10,
          child: Center(
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add,
                        color: Color.fromRGBO(41, 128, 185, 1.0)),
                    label: Text("Add Grocery Lists")),
                FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.list),
                    label: Text("My Current Lists")),
                FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.check_circle,
                        color: Theme.of(context).accentColor),
                    label: Text("My Completed Grocery Errands")),
              ],
            ),
          ),
        ));
  }
}
