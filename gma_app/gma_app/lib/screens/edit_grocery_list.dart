import 'package:flutter/material.dart';

class EditGroceryList extends StatefulWidget {
  static const routeName = '/edit-grocery-list';
  @override
  _EditGroceryListState createState() => _EditGroceryListState();
}

class _EditGroceryListState extends State<EditGroceryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Grocery List"),
      ),
    );
  }
}
