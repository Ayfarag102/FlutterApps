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
        // appBar: AppBar(title: Text(loadedProduct.name)),
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(loadedProduct.name),
            background: Hero(
              tag: loadedProduct.id,
              child: Image.network(loadedProduct.imageUrl, fit: BoxFit.cover),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 10),
            Text(
              '\$${loadedProduct.price}',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(loadedProduct.description,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                  softWrap: true),
            ),
            SizedBox(
              height: 800,
            ),
          ]),
        ),
      ],
    )

        // ,
        );
  }
}