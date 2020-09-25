import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';
//import '../widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Yo\' Cart'),
        ),
        body: Column(
          children: <Widget>[
            Card(
                margin: EdgeInsets.all(15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Total',
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Chip(
                        label: Text('\$${cart.totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .headline6
                                    .color)),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      CheckoutButton(cart: cart)
                    ])),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              //ci.CartItem
              itemBuilder: (ctx, i) => CartItem(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].name,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].price),
              itemCount: cart.items.length,
            ))
          ],
        ));
  }
}

class CheckoutButton extends StatefulWidget {
  const CheckoutButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _CheckoutButtonState createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    //  final cart = Provider.of<Cart>(context);
    return FlatButton(
        child: _isLoading ? CircularProgressIndicator() : Text('Checkout'),
        onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrder(
                    widget.cart.items.values.toList(), widget.cart.totalAmount);
                setState(() {
                  _isLoading = false;
                });
                widget.cart.clearCart();
              },
        textColor: Theme.of(context).primaryColor);
  }
}
