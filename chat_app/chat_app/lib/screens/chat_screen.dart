import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chat/messages.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (m) {
      print(m);
      return;
    }, onLaunch: (m) {
      print(m);
      return;
    }, onResume: (m) {
      print(m);
      return;
    });
    //fbm.getToken();
    fbm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Column(children: <Widget>[
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ]),
      ),
    );
  }
}

// body: StreamBuilder(
//   stream: Firestore.instance
//       .collection('chats/3UxnxQKQ8MRnrFfJbxt5/messages')
//       .snapshots(),
//   builder: (ctx, streamSnapshot) {
//     if (streamSnapshot.connectionState == ConnectionState.waiting) {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     final docs = streamSnapshot.data.documents;
//     return ListView.builder(
//       itemCount: docs.length,
//       itemBuilder: (ctx, i) => Container(
//         padding: EdgeInsets.all(8),
//         child: Text(docs[i]['text']),
//       ),
//     );
//   },
// ),
//     );
//   },
// ),
