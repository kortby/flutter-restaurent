import 'package:flutter/material.dart';
import 'package:meal/widgets/category_item.dart';
import 'package:meal/data.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      children: CATEGORIES
          .map((cat) => CategoryItem(
                id: cat.id,
                title: cat.title,
                color: cat.color,
              ))
          .toList(),
    );
  }
}
