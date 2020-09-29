import 'package:flutter/material.dart';
import '../providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  // var _isLoading = false;

  // @override
  Future<void> _refreshOrders(BuildContext context) async {
    await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  Widget build(BuildContext context) {
    print('building orders');
    //   final orderData = Provider.of<Orders>(context);
    //Future _ordersFuture;
    ///Future _obtainOrdersFuture()
    ///{
    ///return  Provider.of<Orders>(context, listen: false).fetchAndSetOrders();}
    ///
    ///@override
    ///void initState()
    ///{
    ///_ordersFuture = _obtainOrdersFuture();
    ///super.initState();}
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Your Orders',
          ),
        ),
        drawer: AppDrawer(),
        body: RefreshIndicator(
            onRefresh: () => _refreshOrders(context),
            child: FutureBuilder(
                future: Provider.of<Orders>(context, listen: false)
                    .fetchAndSetOrders(),
                builder: (ctx, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (dataSnapshot.error != null) {
                    return Center(
                      child: Text('An error occurred!'),
                    );
                  } else {
                    return Consumer<Orders>(
                        builder: (ctx, orderData, child) => ListView.builder(
                            itemCount: orderData.orders.length,
                            itemBuilder: (ctx, i) =>
                                OrderItem(orderData.orders[i])));
                  }
                })));
  }
}
