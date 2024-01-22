import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';

class MultiSelectSegmentedButton<T extends IMenuItem> extends StatelessWidget {

  final List<T> items;
  final Set<T> selectedItems;
  final void Function(Set<T> selectedItems) onSelectedItems;
  final bool showSelectedIcon;
  final bool showIcons;
  final Widget? selectedIcon;
  final bool multiSelectionEnabled;

  const MultiSelectSegmentedButton({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.onSelectedItems,
    this.showSelectedIcon = false,
    this.showIcons = false,
    this.selectedIcon,
    this.multiSelectionEnabled = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<T>(
      selected: selectedItems.toSet(),
      showSelectedIcon: showSelectedIcon,
      emptySelectionAllowed: multiSelectionEnabled,
      multiSelectionEnabled: multiSelectionEnabled,
      segments: getSegments(),
      onSelectionChanged: onSelectedItems,
    );
  }

  List<ButtonSegment<T>> getSegments(){
    return items.map((e){
      return ButtonSegment<T>(
        value: e,
        label: Text(e.title),
        icon: showIcons ? e.iconInfo?.toIcon() : null
      );
    }).toList();
  }

}

class SingleSelectSegmentedButton<T extends IMenuItem> extends StatelessWidget {

  final List<T> items;
  final T selectedItem;
  final void Function(T selectedItem) onSelected;
  final bool showSelectedIcon;
  final Widget? selectedIcon;
  final bool showIcons;

  const SingleSelectSegmentedButton({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
    this.showSelectedIcon = false,
    this.selectedIcon,
    this.showIcons = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSelectSegmentedButton(
      items: items,
      selectedItems: {selectedItem},
      showSelectedIcon: showSelectedIcon,
      showIcons: showIcons,
      multiSelectionEnabled: false,
      selectedIcon: selectedIcon,
      onSelectedItems: (selectedItems){
        final selected = selectedItems.firstOrNull;
        if(selected!=null){
          onSelected(selected);
        }
      },
    );
  }
}
