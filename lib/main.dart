import 'package:flutter/material.dart';
import 'package:meal/data.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/screens/categories.dart';
import 'package:meal/screens/category_meals.dart';
import 'package:meal/screens/filters.dart';
import 'package:meal/screens/meal_detail.dart';
import 'package:meal/screens/tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegetarian': false,
    'vegan': false,
    'lactose-free': false,
  };

  List<Meal> _availableMeals = MEALS;
  List<Meal> _favoritesMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['lactose-free']! && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existIdx = _favoritesMeals.indexWhere((meal) => meal.id == mealId);
    if (existIdx >= 0) {
      setState(() {
        _favoritesMeals.removeAt(existIdx);
      });
    } else {
      setState(() {
        _favoritesMeals.add(MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoritesMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DealMeal',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleLarge: const TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: const Categories(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => Tabs(
              favoriteMeals: _favoritesMeals,
            ),
        CategoryMeals.routeName: (ctx) => CategoryMeals(
              availableMeals: _availableMeals,
            ),
        MealDetail.routeName: (ctx) => MealDetail(
              toggleFavorite: _toggleFavorite,
              isFavorite: _isMealFavorite,
            ),
        Filters.routeName: (ctx) => Filters(
              saveFilters: _setFilters,
              currentFilters: _filters,
            ),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx) => Categories());
      // },
      onUnknownRoute: (setting) =>
          MaterialPageRoute(builder: (ctx) => const Categories()),
    );
  }
}
