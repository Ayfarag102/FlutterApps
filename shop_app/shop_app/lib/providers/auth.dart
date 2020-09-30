// Dart
import 'dart:convert';
import 'dart:async';

// Flutter Packages
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Application files
import 'models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userID;
  Timer _authTimer;
  static const API_KEY = 'AIzaSyBoFIB7yLOGylybwlq8wis0hioKtvsJI6k';

  bool get isAuth {
    return token != null;
  }

  String get userID {
    return _userID;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      //   print(_token);
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

  Future<void> logout() async {
    _token = null;
    _userID = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final loadedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    final expiryDate = DateTime.parse(loadedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = loadedUserData['token'];
    _userID = loadedUserData['userId'];
    _expiryDate = expiryDate;

    notifyListeners();
    _autoLogout();
    return true;
    // if (_authTimer != null) {
    //   _authTimer.cancel();
    // }
    // final timeToExpire = _expiryDate.difference(DateTime.now()).inSeconds;
    // _authTimer = Timer(Duration(seconds: timeToExpire), logout);
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpire = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpire), logout);
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
      //  print('Response:\n $responseData');
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      //  print('Response:\n $responseData \n');
      _token = responseData['idToken'];
      //  print('Token:\n $_token \n');

      _userID = responseData['localId'];
      //   print('User ID:\n $_userID \n');

      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      //   print('Expiry Date:\n $_expiryDate \n');
      debugPrint(response.body);
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userID,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
