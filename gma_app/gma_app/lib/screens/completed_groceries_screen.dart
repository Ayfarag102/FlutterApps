import 'package:flutter/material.dart';

class CompletedGroceriesScreen extends StatelessWidget {
  static const routeName = '/completed-groceries';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //    title: Text("Completed Groceries"),
        // ),
        body: Container(child: Text("Your Completed Groceries")));
  }
}
