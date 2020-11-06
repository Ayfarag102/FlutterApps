import 'package:flutter/material.dart';

class NoGroceries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('No Grocery Lists added yet!',
            style: Theme.of(context).textTheme.bodyText1),
        SizedBox(height: 20),
        Container(
            height: 200, child: (Text("Please add some...\n🥺\n👉🏼👈🏼"))),
      ],
    );
  }
}
