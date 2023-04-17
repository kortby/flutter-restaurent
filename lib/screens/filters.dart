import 'package:flutter/material.dart';
import 'package:meal/widgets/main_drawer.dart';

class Filters extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  const Filters({
    Key? key,
    required this.saveFilters,
    required this.currentFilters,
  }) : super(key: key);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    // TODO: implement initState
    _glutenFree = widget.currentFilters['gluten']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    _lactoseFree = widget.currentFilters['lactose-free']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
          actions: [
            IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan,
                  'lactose-free': _lactoseFree,
                };
                widget.saveFilters(selectedFilters);
              },
              icon: Icon(Icons.save),
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SwitchListTile(
                    value: _glutenFree,
                    onChanged: (newVal) {
                      setState(() {
                        _glutenFree = newVal;
                      });
                    },
                    title: Text('Gluten Free'),
                    subtitle: Text('Exclude all food with gluten'),
                  ),
                  SwitchListTile(
                    value: _vegetarian,
                    onChanged: (newVal) {
                      setState(() {
                        _vegetarian = newVal;
                      });
                    },
                    title: Text('Vegetarian'),
                    subtitle: Text('Only include vegetarian food'),
                  ),
                  SwitchListTile(
                    value: _vegan,
                    onChanged: (newVal) {
                      setState(() {
                        _vegan = newVal;
                      });
                    },
                    title: Text('Vegan'),
                    subtitle: Text('Only vegan food'),
                  ),
                  SwitchListTile(
                    value: _lactoseFree,
                    onChanged: (newVal) {
                      setState(() {
                        _lactoseFree = newVal;
                      });
                    },
                    title: Text('lactoseFree'),
                    subtitle: Text('Only lactose free'),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
