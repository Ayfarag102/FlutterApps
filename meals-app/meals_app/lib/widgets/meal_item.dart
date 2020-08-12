import 'package:flutter/material.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageurl;
  final int duration;
  final Complexity complex;
  final Affordability afford;
  final Function removeItem;
  MealItem(
      {@required this.id,
      @required this.title,
      @required this.imageurl,
      @required this.duration,
      @required this.complex,
      @required this.afford,
      @required this.removeItem});

  String get complexText {
    switch (complex) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Fire:
        return 'Fire';
        break;
      default:
        return 'Unknown';
    }
  }

  String get affordText {
    switch (afford) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Expensive:
        return 'Expensive';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      default:
        return 'Unknown';
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    )
        .then(
      (result) {
        if (result != null) {
          removeItem(result);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
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
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      width: 250,
                      color: Colors.black54,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.schedule,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text('$duration mins'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.work,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(complexText),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.attach_money,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(affordText),
                        ],
                      )
                    ],
                  )),
            ],
          )),
    );
  }
}
