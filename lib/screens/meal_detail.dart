import 'package:flutter/material.dart';
import 'package:meal/data.dart';

class MealDetail extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;

  const MealDetail(
      {Key? key, required this.toggleFavorite, required this.isFavorite})
      : super(key: key);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, idx) => Card(
                  color: Theme.of(ctx).accentColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      selectedMeal.ingredients[idx],
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (ctx, idx) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('#${idx + 1}'),
                      ),
                      title: Text(selectedMeal.steps[idx]),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorite(mealId),
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
      ),
    );
  }
}
