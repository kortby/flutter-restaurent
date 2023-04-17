import 'package:flutter/material.dart';
import 'package:meal/widgets/meal_item.dart';
import 'package:meal/models/meal.dart';

class CategoryMeals extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  // final String categoryId;
  // final String categoryTitle;
  const CategoryMeals({
    Key? key,
    required this.availableMeals,
    // required this.categoryId,
    // required this.categoryTitle,
  }) : super(key: key);

  @override
  State<CategoryMeals> createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {
  String? categoryTitle;
  List<Meal> displayedMeals = [];
  bool _loadingInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadingInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title']!;
      displayedMeals = widget.availableMeals
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      _loadingInitData = true;
      super.didChangeDependencies();
    }
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          return MealItem(
            id: displayedMeals[idx].id,
            title: displayedMeals[idx].title,
            imageUrl: displayedMeals[idx].imageUrl,
            duration: displayedMeals[idx].duration.toString(),
            complexity: displayedMeals[idx].complexity.toString(),
            affordability: displayedMeals[idx].affordability.toString(),
            removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
