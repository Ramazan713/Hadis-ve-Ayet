import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';

class CustomChoiceChips<T extends IMenuItem> extends StatelessWidget {

  final List<T> items;
  final T selectedItem;
  final void Function(T item) onSelected;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsets paddings;

  const CustomChoiceChips({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.paddings = const EdgeInsets.symmetric(horizontal: 2)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: getItems(context),
      ),
    );
  }

  List<Widget> getItems(BuildContext context){
    final children = <Widget>[];
    for (var item in items) {
      children.add(getChild(context, item));
    }
    return children;
  }

  Widget getChild(BuildContext context,T item){
    return Padding(
      padding: paddings,
      child: ChoiceChip(
        label: Text(item.title),
        selected: selectedItem == item,
        onSelected: (isSelected){
          if(isSelected) onSelected(item);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
        ),
      ),
    );
  }

}
