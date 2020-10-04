import 'package:flutter/material.dart';
import 'dart:math';
import '../providers/orders.dart' as order;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final order.OrderItem orderItem;

  OrderItem(this.orderItem);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false; //property
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded
          ? min(widget.orderItem.products.length * 20.0 + 110, 200)
          : 95,
      curve: Curves.easeIn,
      child: Card(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                  title: Text('\$${widget.orderItem.amount.toStringAsFixed(2)}',
                      style: TextStyle(fontFamily: 'Lato')),
                  subtitle: Text(
                      DateFormat(
                        'dd/MM/yyyy hh:mm',
                      ).format(widget.orderItem.dateTime),
                      style: TextStyle(
                        fontFamily: 'Lato',
                      )),
                  trailing: IconButton(
                      icon: Icon(
                          _expanded ? Icons.expand_less : Icons.expand_more),
                      onPressed: () {
                        setState(() {
                          _expanded = !_expanded;
                        });
                      })),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: _expanded
                    ? min(widget.orderItem.products.length * 20.0 + 10, 180)
                    : 0,
                child: ListView(
                    children: widget.orderItem.products
                        .map((prod) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      prod.name,
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.fade,
                                      softWrap: true,
                                    ),
                                  ),
                                  Text('${prod.quantity}x \$${prod.price}',
                                      style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 18,
                                          color: Colors.grey))
                                ]))
                        .toList()),
              )
            ],
          )),
    );
  }
}
