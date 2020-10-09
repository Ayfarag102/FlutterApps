import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  var _isLoading = false;

  void _submitAuthForm(
      String em, String pwd, String um, bool isLogin, BuildContext ctx) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: em,
          password: pwd,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: em,
          password: pwd,
        );
        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData(
          {
            'username': um,
            'email': em,
          },
        );
      }
    } on PlatformException catch (er) {
      var message = 'An error occurred, please check your credentials!';
      if (er.message != null) {
        message = er.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (er) {
      debugPrint(er);

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
