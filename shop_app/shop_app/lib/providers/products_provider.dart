import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../providers/models/product.dart';
import '../providers/models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  // var _showFavOnly = false;

  final String authToken;
  final String userID;

  Products(this.authToken, this.userID, this._items);

  List<Product> get favItems {
    return _items.where((product) => product.isFav).toList();
  }

  List<Product> get items {
    // if (_showFavOnly) {
    //   return _items.where((product) => product.isFav).toList();
    // }
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavOnly() {
  //   _showFavOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavOnly = false;
  //   notifyListeners();
  // }
//  POST Request (Create Operation) => Products
  Future<void> addProduct(Product product) async {
    final url =
        'https://flutter-course-shop-app-734d5.firebaseio.com/products.json?auth=$authToken';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }),
      );
      final newProduct = Product(
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (er) {
      print(er);
      throw er;
    }
    //   print(json.decode(response.body));
  }

  //  GET Request (Read Operation) => Products
  Future<void> fetchAndSetProducts() async {
    var url =
        'https://flutter-course-shop-app-734d5.firebaseio.com/products.json?auth=$authToken';

    try {
      final response = await http.get(url);
      final getData =
          json.decode(response.body.toString()) as Map<String, dynamic>;
      if (getData == null || getData['error'] != null) {
        print('null check');
        return;
      }
      url =
          'https://flutter-course-shop-app-734d5.firebaseio.com/userFavs/$userID.json?auth=$authToken';
      final favResponse = await http.get(url);
      final favData =
          json.decode(favResponse.body.toString()) as Map<String, bool>;
      final List<Product> tempProducts = [];
      getData.forEach((prodId, prodData) {
        tempProducts.add(Product(
          id: prodId,
          name: prodData['name'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFav: favData == null ? false : favData[prodId] ?? false,
        ));
      });
      _items = tempProducts;
      notifyListeners();
      print(json.decode(response.body));
    } catch (er) {
      print(er);
      throw (er);
    }
  }

//  PATCH Request (ie. Update Operation) => Products
  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);

    if (prodIndex >= 0) {
      final url =
          'https://flutter-course-shop-app-734d5.firebaseio.com/products/$id.json?auth=$authToken';
      // try {
      await http.patch(url,
          body: json.encode({
            'name': newProduct.name,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
      // } catch (err) {
      //   print(err);
      //   throw err;
      // }
    } else {
      print('...');
    }
  }

//  DELETE Request (ie Delere Operation) => Products
  Future<void> deleteProduct(String id) async {
    final url =
        'https://flutter-course-shop-app-734d5.firebaseio.com/products/$id.json?auth=$authToken';
    final existProductID = _items.indexWhere((prod) => prod.id == id);
    var existProduct = _items[existProductID];
    _items.removeAt(existProductID);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existProductID, existProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    existProduct = null;
  }
}
