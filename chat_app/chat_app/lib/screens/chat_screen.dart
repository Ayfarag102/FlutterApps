import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, i) => Container(
          padding: EdgeInsets.all(8),
          child: Text('This Works!'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('/chats/3UxnxQKQ8MRnrFfJbxt5/messages/')
              .snapshots()
              .listen((data) {
            data.documents.forEach((doc) {
              debugPrint(
                doc['text'],
              );
            });
          });
        },
      ),
    );
  }
}
