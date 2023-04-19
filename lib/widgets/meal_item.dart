import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/screens/meal_detail.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String duration;
  final String complexity;
  final String affordability;
  final Function? removeItem;

  const MealItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
    this.removeItem,
  }) : super(key: key);

  String? get complexityText {
    if (complexity == Complexity.Simple.toString()) {
      return 'Simple';
    }
    if (complexity == Complexity.Challenging.toString()) {
      return 'Challenging';
    }
    if (complexity == Complexity.Hard.toString()) {
      return 'Hard';
    }
    return 'Unknown';
  }

  String? get affordabilityText {
    if (affordability == Affordability.Affordable.toString()) {
      return 'Affordable';
    }
    if (affordability == Affordability.Pricey.toString()) {
      return 'Pricey';
    }
    if (affordability == Affordability.Luxurious.toString()) {
      return 'Luxurious';
    }
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    void selectMeal(context) {
      Navigator.of(context)
          .pushNamed(
            MealDetail.routeName,
            arguments: id,
          )
          .then((result) => {
                if (result != null) {removeItem!(result)}
              });
    }

    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    width: 220,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.schedule,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text('$duration min'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.work,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(complexityText!),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.attach_money,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(affordabilityText!),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
