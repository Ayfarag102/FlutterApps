import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/splash_screen.dart';
import './screens/chat_screen.dart';
import './screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Room',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.green[400],
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.green[800],
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (userSnapshot.hasData) {
            return ChatScreen();
          }

          return AuthScreen();
        },
      ),
    );
  }
}
