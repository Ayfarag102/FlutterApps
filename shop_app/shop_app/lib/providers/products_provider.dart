import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../providers/models/product.dart';
import '../providers/models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   name: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   name: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   name: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   name: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // var _showFavOnly = false;

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
    const url =
        'https://flutter-course-shop-app-734d5.firebaseio.com/products.json';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFav': product.isFav,
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
    const url =
        'https://flutter-course-shop-app-734d5.firebaseio.com/products.json';

    try {
      final response = await http.get(url);
      final getData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> tempProducts = [];
      if (getData == null) {
        return;
      }
      getData.forEach((prodId, prodData) {
        tempProducts.add(Product(
          id: prodId,
          name: prodData['name'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFav: prodData['isFav'],
        ));
      });
      _items = tempProducts;
      notifyListeners();
      // print(json.decode(response.body));
    } catch (er) {
      throw (er);
    }
  }

//  PATCH Request (ie. Update Operation) => Products
  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);

    if (prodIndex >= 0) {
      final url =
          'https://flutter-course-shop-app-734d5.firebaseio.com/products/$id.json';
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
        'https://flutter-course-shop-app-734d5.firebaseio.com/products/$id.json';
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
