import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentGroceriesScreen extends StatelessWidget {
  static const routeName = '/current-groceries';
  @override
//   _CurrentGroceriesScreenState createState() => _CurrentGroceriesScreenState();
// }

// class _CurrentGroceriesScreenState extends State<CurrentGroceriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(title: Text("Current Groceries")),
        body: ListView.builder(
      itemBuilder: (context, index) {
        return Card(
            child: Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
            bottom: 30.0,
            left: 13.0,
            right: 22.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _GroceryTitle(),
              _GroceryList(),
              Icon(Icons.more_vert, semanticLabel: "Share"),
            ],
          ),
        ));
      },
    ));
  }
}

class _GroceryTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Grocery List',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ));
  }
}

class _GroceryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('${DateFormat.yMd().format(DateTime.now())}');
  }
}
