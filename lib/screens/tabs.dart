import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/screens/categories.dart';
import 'package:meal/screens/favorites.dart';
import 'package:meal/widgets/main_drawer.dart';

class Tabs extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const Tabs({Key? key, required this.favoriteMeals}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  List<Widget> _pages = [];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      const Categories(),
      Favorites(
        favoriteMeals: widget.favoriteMeals,
      ),
    ];
    super.initState();
  }

  void _selectPage(int idx) {
    setState(() {
      _selectedPageIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals'),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(
              Icons.category,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.star,
            ),
            label: 'Favorites',
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
