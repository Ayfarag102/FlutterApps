//  Dart
//import 'dart:io';

//  Flutter
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import './models/grocery.dart';
import './models/item.dart';
import '../helpers/db_helper.dart';

class GroceryManagement with ChangeNotifier {
  List<Grocery> _lists = [];

  List<Grocery> get lists {
    return [..._lists];
  }

  Grocery findById(String id) {
    return _lists.firstWhere((grocery) => grocery.id == id);
  }

  Future<void> addGrocery(
    String inputGroceryName,
    DateTime inputDateTime,
    Item items,
  ) async {
    final newGrocery = Grocery(
      id: DateTime.now().toString(),
      groceryShopName: inputGroceryName,
      dateTime: inputDateTime,

      // itemName: inputItemName,
      // itemQuantity: inputItemQuantity,
      // imageUrl: inputImage,
    );

    _lists.add(newGrocery);
    notifyListeners();

    DBHelper.createList('user_groceries', {
      'id': newGrocery.id,
      'store_name': newGrocery.groceryShopName,
      'created_on': newGrocery.dateTime,
    });

    Future<void> fetchAndSetGroceries() async {
      final dataList = await DBHelper.read("user_groceries");

      _lists = dataList
          .map(
            (grocery) => Grocery(
              id: grocery['id'],
              groceryShopName: grocery['shop_name'],
              dateTime: grocery['created_on'],

              // itemName: grocery['item_name'],
              // itemQuantity: grocery['item_quantity'],
              // imageUrl: grocery['imageUrl'],
            ),
          )
          .toList();

      notifyListeners();
    }
  }
}
