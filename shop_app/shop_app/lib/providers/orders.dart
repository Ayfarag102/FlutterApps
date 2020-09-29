import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './cart.dart';
//import '../widgets/order_item.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  Orders(this.authToken, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        'https://flutter-course-shop-app-734d5.firebaseio.com/orders.json?auth=$authToken';
    final timestamp = DateTime.now();

    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cartp) => {
                  'id': cartp.id,
                  'name': cartp.name,
                  'quantity': cartp.quantity,
                  'price': cartp.price
                })
            .toList()
      }),
    );
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            dateTime: timestamp,
            products: cartProducts));

    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://flutter-course-shop-app-734d5.firebaseio.com/orders.json?auth=$authToken';
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final getData = json.decode(response.body) as Map<String, dynamic>;
      final List<OrderItem> tempOrders = [];
      if (getData == null) {
        return;
      }
      getData.forEach((orderId, orderData) {
        tempOrders.add(OrderItem(
            id: orderId,
            amount: orderData['amount'],
            products: (orderData['products'] as List<dynamic>)
                .map((item) => CartItem(
                      id: item['id'],
                      price: item['price'],
                      quantity: item['quantity'],
                      name: item['name'],
                    ))
                .toList(),
            dateTime: DateTime.parse(orderData['dateTime'])));
      });
      _orders = tempOrders.reversed.toList();
      notifyListeners();
      // print(json.decode(response.body));
    } catch (er) {
      throw (er);
    }
  }
}
