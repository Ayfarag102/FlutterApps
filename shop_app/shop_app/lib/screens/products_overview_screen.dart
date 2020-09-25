import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions { Favourites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFav = false;
  var _isLoading = false;
  var _isInit = true;
  @override
  void initState() {
    //Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK ON ITS OWN
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //final productsData = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text("Ma Shopify"), actions: <Widget>[
        PopupMenuButton(
            onSelected: (FilterOptions selectedVal) {
              setState(() {
                if (selectedVal == FilterOptions.Favourites) {
                  _showOnlyFav = true;
                } else {
                  _showOnlyFav = false;
                }
              });
            },
            itemBuilder: (_) => [
                  PopupMenuItem(
                      child: Text('Only Favourites'),
                      value: FilterOptions.Favourites),
                  PopupMenuItem(
                      child: Text('Show All'), value: FilterOptions.All),
                ],
            icon: Icon(
              Icons.more_vert,
            )),
        Consumer<Cart>(
            builder: (_, cart, ch) =>
                Badge(child: ch, value: cart.itemCount.toString()),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                })),
      ]),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductsGrid(_showOnlyFav),
    );
  }
}
