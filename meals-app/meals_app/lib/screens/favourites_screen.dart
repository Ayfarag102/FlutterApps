import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favourites;

  FavouritesScreen(this.favourites);
  @override
  Widget build(BuildContext context) {
    if (favourites.isEmpty) {
      return Center(
        child: Text(
          'You have no favourites yet\n Start adding some 😄',
        ),
      );
    } else {
      return ListView.builder(
          itemCount: favourites.length,
          itemBuilder: (ctx, index) {
            return MealItem(
              id: favourites[index].id,
              title: favourites[index].title,
              imageurl: favourites[index].imageURL,
              duration: favourites[index].duration,
              complex: favourites[index].complexity,
              afford: favourites[index].affordability,
            );
          });
    }
  }
}
