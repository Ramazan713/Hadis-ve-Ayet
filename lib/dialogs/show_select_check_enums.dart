

import 'package:flutter/material.dart';
import 'package:hadith/models/item_label_model.dart';

import '../widgets/buttons/custom_button_positive.dart';

void showSelectCheckEnums<T extends Enum>(BuildContext context,{
  required List<ItemLabelModel<T>> optionItems,
  List<ItemLabelModel<T>> selectedItemsParam = const [],
  required void Function(List<ItemLabelModel<T>> lastSelectedItems) closeListener
}){

  final ValueNotifier<List<ItemLabelModel<T>>> selectedItems = ValueNotifier(selectedItemsParam);

  void addOrRemove(ItemLabelModel<T> item){
    final items = selectedItems.value.toList();
    if(!items.contains(item)){
      items.add(item);
    }else{
      items.remove(item);
    }
    selectedItems.value = items;
  }

  List<Widget>getContent(List<ItemLabelModel<T>> checkedItems){
    final items = optionItems.map((e){
      return CheckboxListTile(
          value: checkedItems.contains(e),
          onChanged: (item){
            addOrRemove(e);
          },
          title: Text(e.label),
      );
    }).toList();
    return items;
  }


  showDialog(
      context: context,
      builder: (context){
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 19),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
              child: Column(
                children: [
                  ValueListenableBuilder<List<ItemLabelModel<T>>>(
                      valueListenable: selectedItems,
                      builder: (context,value,child){
                        return Column(
                          children: getContent(value),
                        );
                      },
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButtonPositive(
                        label: "Onayla",
                        onTap: (){
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
  ).then((value){
    closeListener.call(selectedItems.value);
  });


}
