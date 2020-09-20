import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String prodName;
  // final double price;
  // ProductDetailScreen(this.prodName, this.price);

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
        appBar: AppBar(title: Text(loadedProduct.name)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 300,
                  width: double.infinity,
                  child:
                      Image.network(loadedProduct.imageUrl, fit: BoxFit.cover)),
              SizedBox(height: 10),
              Text('\$${loadedProduct.price}',
                  style: Theme.of(context).textTheme.headline2),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(loadedProduct.description,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                    softWrap: true),
              )
            ],
          ),
        )

        // ,
        );
  }
}
