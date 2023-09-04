

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';

void showSelectExtendedItemsDia<T extends IDetailItem>(BuildContext context,{
  required List<T> items,
  T? selectedItem,
  String? title,
  required void Function(T item) onSelectedItem,
  void Function()? onCancel
}){

  showDialog(
    context: context,
    useSafeArea: true,
    builder: (context){
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 7),
        child: _DialogContent(
          items: items,
          onSelectedItem: onSelectedItem,
          onCancel: onCancel ?? (){
            Navigator.of(context,rootNavigator: true).pop();
          },
        ),
      );
    }
  );

}


class _DialogContent<T extends IDetailItem> extends StatelessWidget {

  final List<T> items;
  final T? selectedItem;
  final String? title;
  final void Function(T item) onSelectedItem;
  final void Function() onCancel;

  const _DialogContent({
    Key? key,
    required this.items,
    this.selectedItem,
    this.title,
    required this.onSelectedItem,
    required this.onCancel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }
}

