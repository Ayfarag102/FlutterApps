import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userID;
  static const API_KEY = 'AIzaSyBoFIB7yLOGylybwlq8wis0hioKtvsJI6k';

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      print(_token);
      return _token;
    }
    return null;
  }

  Future<void> signUp(String email, String pwd) async {
    return _authenticate(email, pwd, 'signUp');
  }

  Future<void> signIn(String email, String pwd) async {
    return _authenticate(email, pwd, 'signInWithPassword');
  }

  Future<void> _authenticate(
      String email, String pwd, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$API_KEY';

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'email': email, 'password': pwd, 'returnSecureToken': true},
        ),
      );

      final responseData = json.decode(response.body);
      print('Response:\n $responseData');
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      print('Response:\n $responseData \n');
      _token = responseData['idToken'];
      print('Token:\n $_token \n');

      _userID = responseData['localId'];
      print('User ID:\n $_userID \n');

      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      print('Expiry Date:\n $_expiryDate \n');
      debugPrint(response.body);
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
