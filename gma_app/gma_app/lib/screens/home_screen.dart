import 'package:flutter/material.dart';
import '../widgets/home.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grocery Management Application")),
      body: Center(
        child: Text(
            "This is the home screen\n Here we will add 3 buttons 1 for add, 1 for current, 1 for completed."),
      ),
    );
  }
}
