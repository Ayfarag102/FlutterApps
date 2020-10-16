import 'dart:io';
import 'package:chat_app/widgets/users/avatar_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    File image,
    bool isLogin,
    BuildContext context,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  var _userEmail = '';
  var _userPass = '';
  var _userName = '';
  File _imageFile;

  void _storeImage(File image) {
    _imageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_imageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text('Please pick an image.'),
            backgroundColor: Theme.of(context).errorColor),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState.save();

      widget.submitFn(
        _userEmail.trim(),
        _userPass.trim(),
        _userName.trim(),
        _imageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  if (!_isLogin) UserAvatarImage(_storeImage),
                  TextFormField(
                      key: ValueKey('email'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (val) {
                        if (val.isEmpty || !val.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                      ),
                      onSaved: (val) {
                        _userEmail = val;
                      }),
                  if (!_isLogin)
                    TextFormField(
                        key: ValueKey('username'),
                        autocorrect: true,
                        textCapitalization: TextCapitalization.words,
                        enableSuggestions: false,
                        validator: (val) {
                          if (val.isEmpty || val.length < 4) {
                            return 'Please enter at least 4 characters.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                        onSaved: (val) {
                          _userName = val;
                        }),
                  TextFormField(
                      key: ValueKey('password'),
                      validator: (val) {
                        if (val.isEmpty || val.length < 7) {
                          return 'Password must be at least 7 charaacters long.';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      onSaved: (val) {
                        _userPass = val;
                      }),
                  SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create New Account'
                          : 'I already have an account'),
                    ),
                ]),
              ),
            ),
          )),
    );
  }
}
