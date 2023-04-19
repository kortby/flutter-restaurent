import 'package:flutter/material.dart';
import 'package:meal/widgets/meal_item.dart';

import '../models/meal.dart';

class Favorites extends StatelessWidget {
  final List<Meal>? favoriteMeals;
  const Favorites({Key? key, this.favoriteMeals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals!.isEmpty) {
      return const Center(
        child: Text('You have no favorites.'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, idx) {
          return MealItem(
            id: favoriteMeals![idx].id,
            title: favoriteMeals![idx].title,
            imageUrl: favoriteMeals![idx].imageUrl,
            duration: favoriteMeals![idx].duration.toString(),
            complexity: favoriteMeals![idx].complexity.toString(),
            affordability: favoriteMeals![idx].affordability.toString(),
          );
        },
        itemCount: favoriteMeals!.length,
      );
    }
  }
}
