import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  UserProductItem(this.name, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.edit), onPressed: () {}, color: Colors.amber),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
                color: Theme.of(context).errorColor),
          ],
        ),
      ),
    );
  }
}
