import 'package:flutter/material.dart';
import 'package:meals/widgets/filter_switch_item.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  final Map<String, bool> itemSetsMap = {
    'gluten-free': false,
    'lactose-free': false,
    'vegeterian': false,
    'vegan':false,
  };

  void _checkitem(bool isCheck, String key) {
    setState(() {
      itemSetsMap[key] = isCheck;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(itemSetsMap);
          return false;
        },
        child: Column(
          children: [
            FilterSwitchItem(
              title: 'Gluten-Free',
              itemSet: itemSetsMap['gluten-free']!,
              onCheckitem: _checkitem,
            ),
            FilterSwitchItem(
              title: 'Lactose-Free',
              itemSet: itemSetsMap['lactose-free']!,
              onCheckitem: _checkitem,
            ),
            FilterSwitchItem(
              title: 'Vegeterian',
              itemSet: itemSetsMap['vegeterian']!,
              onCheckitem: _checkitem,
            ),
            FilterSwitchItem(
              title: 'Vegan',
              itemSet: itemSetsMap['vegan']!,
              onCheckitem: _checkitem,
            ),
          ],
        ),
      ),
    );
  }
}
