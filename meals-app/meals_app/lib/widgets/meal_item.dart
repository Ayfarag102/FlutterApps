import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String title;
  final String imageurl;
  final int duration;
  final Complexity complex;
  final Affordability afford;
  MealItem(
      {@required this.title,
      @required this.imageurl,
      @required this.duration,
      @required this.complex,
      @required this.afford});

  void selectMeal() {}
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectMeal,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: Image.network(
                        imageurl,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )),
                ],
              ),
            ],
          )),
    );
  }
}
