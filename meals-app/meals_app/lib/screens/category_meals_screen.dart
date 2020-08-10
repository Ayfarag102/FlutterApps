import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../dummy_data.dart';
import '../models/meal.dart';

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
    final catMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(catId);
    }).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '\'$catTitle\'',
          ),
        ),
        body: ListView.builder(
            itemCount: catMeals.length,
            itemBuilder: (ctx, index) {
              return MealItem(
                  id: catMeals[index].id,
                  title: catMeals[index].title,
                  imageurl: catMeals[index].imageURL,
                  duration: catMeals[index].duration,
                  complex: catMeals[index].complexity,
                  afford: catMeals[index].affordability);
            }));
  }
}
