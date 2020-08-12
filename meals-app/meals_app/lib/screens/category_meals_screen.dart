import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../dummy_data.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String catTitle;
  List<Meal> catMeals;

  bool _loadedInit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInit) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      catTitle = routeArgs['title'];
      final catId = routeArgs['id'];
      catMeals = DUMMY_MEALS.where((meal) {
        return meal.categories.contains(catId);
      }).toList();
    }
    _loadedInit = true;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _removeItem(String resId) {
    setState(() {
      catMeals.removeWhere((meal) => meal.id == resId);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                afford: catMeals[index].affordability,
                removeItem: _removeItem,
              );
            }));
  }
}
