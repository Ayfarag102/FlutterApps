import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealsScreen(this.categoryId, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final catTitle = routeArgs['title'];
    final catId = routeArgs['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '\'$catTitle\'',
        ),
      ),
      body: Center(
        child: Text('The Recipes for the Category!'),
      ),
    );
  }
}
