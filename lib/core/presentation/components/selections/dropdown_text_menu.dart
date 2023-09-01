import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';

class CustomDropdownTextMenu<T extends IMenuItem> extends StatelessWidget {

  final List<T> items;
  final T? selectedItem;
  final Function(T?) onSelected;
  final bool addEmptyItem;
  final String? label;

  const CustomDropdownTextMenu({
    Key? key,
    required this.items,
    required this.selectedItem,
    this.addEmptyItem = false,
    this.label,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DropdownMenu<T?>(
      dropdownMenuEntries: getMenuItems(),
      textStyle: Theme.of(context).textTheme.bodyLarge,
      initialSelection: selectedItem,
      onSelected: onSelected,
      label: label != null ? Text(label!) : null,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        isDense: false,

      ),
    );
  }

  List<DropdownMenuEntry<T?>> getMenuItems(){
    final children = <DropdownMenuEntry<T?>>[];

    if(addEmptyItem){
      children.add( DropdownMenuEntry(
        value: null,
        label: "Seçilmedi",
        style: getButtonStyle()
      ));
    }

    for (var e in items) {
      children.add(DropdownMenuEntry(
        label: e.title,
        value: e,
        style: getButtonStyle()
      ));
    }
   return children;
  }

  ButtonStyle getButtonStyle(){
    return ButtonStyle(
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ))
    );
  }

}
