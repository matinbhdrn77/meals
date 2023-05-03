import 'package:flutter/material.dart';
import 'package:meals/widgets/filter_switch_item.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.filterSetsMap});

  final Map<String, bool> filterSetsMap;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Map<String, bool> _itemSetsMap = {};

  @override
  void initState() {
    // TODO: implement initState
    _itemSetsMap = widget.filterSetsMap;
    super.initState();
  }

  void _checkitem(bool isCheck, String key) {
    setState(() {
      _itemSetsMap[key] = isCheck;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(_itemSetsMap);
          return false;
        },
        child: Column(
          children: [
            FilterSwitchItem(
              title: 'Gluten-Free',
              itemSet: _itemSetsMap['gluten-free']!,
              onCheckitem: _checkitem,
            ),
            FilterSwitchItem(
              title: 'Lactose-Free',
              itemSet: _itemSetsMap['lactose-free']!,
              onCheckitem: _checkitem,
            ),
            FilterSwitchItem(
              title: 'Vegeterian',
              itemSet: _itemSetsMap['vegeterian']!,
              onCheckitem: _checkitem,
            ),
            FilterSwitchItem(
              title: 'Vegan',
              itemSet: _itemSetsMap['vegan']!,
              onCheckitem: _checkitem,
            ),
          ],
        ),
      ),
    );
  }
}
