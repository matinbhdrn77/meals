import 'package:flutter/material.dart';
import 'package:meals/data/random_data.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];

  Map<String, bool> _selectedFilters = {
    'gluten-free': false,
    'lactose-free': false,
    'vegeterian': false,
    'vegan': false,
  };

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExist = _favouriteMeals.contains(meal);

    if (isExist) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
      _showInfoMessage('removed from favourites!');
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
      _showInfoMessage('added to favourites');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<String, bool>>(
        MaterialPageRoute(builder: (ctx) {
          return FiltersScreen(filterSetsMap: _selectedFilters);
        }),
      );

      setState(() {
        _selectedFilters = result ?? _selectedFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Meal> availableFilteredMeals = availableMeals.where((meal) {
      if (_selectedFilters['gluten-free']! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters['lactose-free']! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters['vegeterian']! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters['vegan']! && !meal.isGlutenFree) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavourite: _toggleMealFavouriteStatus,
      availableMeals: availableFilteredMeals,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      // as favourite screen
      activePage = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavourite: _toggleMealFavouriteStatus,
      );
      activePageTitle = 'Your Favourite';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(
        onSelectScreen: _selectScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), label: 'Your Favourites')
        ],
      ),
    );
  }
}
