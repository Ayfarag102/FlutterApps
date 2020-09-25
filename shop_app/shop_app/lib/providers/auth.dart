import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  static const API_KEY = 'AIzaSyBoFIB7yLOGylybwlq8wis0hioKtvsJI6k';
  // String _token;
  // DateTime _expiryDate;
  // String _userId;

  Future<void> signUp(String email, String pwd) async {
    return _authenticate(email, pwd, 'signUp');

    // const url =
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$API_KEY';

    // final response = await http.post(url,
    //     body: json.encode(
    //       {'email': email, 'password': pwd, 'returnSecureValue': true},
    //     ));
    // print(json.decode(response.body));
  }

  Future<void> _authenticate(
      String email, String pwd, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$API_KEY';

    try {
      final response = await http.post(url,
          body: json.encode(
            {'email': email, 'password': pwd, 'returnSecureValue': true},
          ));
      print(json.decode(response.body));
    } catch (err) {
      throw err;
    }
  }

  Future<void> signIn(String email, String pwd) async {
    return _authenticate(email, pwd, 'signInWithPassword');
    //   const url =
    //       'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$API_KEY';

    //   final response = await http.post(url,
    //       body: json.encode(
    //         {'email': email, 'password': pwd, 'returnSecureValue': true},
    //       ));
    //   print(json.decode(response.body));
    //
  }
}
