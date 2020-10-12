import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMsg = '';
  final _controller = TextEditingController();
  void _sendMsg() async {
    FocusScope.of(context).unfocus();
    final currUser = await FirebaseAuth.instance.currentUser();
    final currUserData = await Firestore.instance
        .collection('users')
        .document(currUser.uid)
        .get();
    Firestore.instance.collection('chat').add({
      'text': _enteredMsg,
      'createdAt': Timestamp.now(),
      'userId': currUser.uid,
      'username': currUserData['username'],
      'userImage': currUserData['image_url'],
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Send a message...',
              ),
              onChanged: (v) {
                setState(() {
                  _enteredMsg = v;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enteredMsg.trim().isEmpty ? null : _sendMsg,
          ),
        ],
      ),
    );
  }
}
