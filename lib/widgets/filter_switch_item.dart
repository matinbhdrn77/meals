import 'package:flutter/material.dart';

class FilterSwitchItem extends StatelessWidget {
  const FilterSwitchItem({
    super.key,
    required this.title,
    required this.itemSet,
    required this.onCheckitem,
  });

  final String title;
  final bool itemSet;
  final void Function(bool itemState, String key) onCheckitem;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: itemSet,
      onChanged: (isChecked) {
        onCheckitem(isChecked, title.toLowerCase());
      },
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        'Only include ${title.toLowerCase()} meals.',
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
    );
  }
}
