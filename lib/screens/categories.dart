import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationControlle;

  @override
  void initState() {
    super.initState();

    _animationControlle = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 300),
      //owerBound: 0, -- are by default
      //upperBound: 1, -- are by default
    );

    _animationControlle.forward();
  }

  @override
  void dispose() {
    _animationControlle.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
    //Navigator.of(context).push(route); // the same like Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationControlle,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2, // ??
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 100,
        ),
        children: [
          // availableCategories.map((category) => CategoryGridItem( category: category )).toList()
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
      builder: (context, child) => Padding(
          padding: EdgeInsets.only(top: 100 - _animationControlle.value * 100),
          child: child),
    );
  }
}
