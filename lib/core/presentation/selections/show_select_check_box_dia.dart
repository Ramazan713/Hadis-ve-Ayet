import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/presentation/components/shared_dia_buttons.dart';

void showSelectCheckBoxDia<T extends IMenuItem>(BuildContext context,{
  required List<T> items,
  required List<T> selectedItems,
  required String title,
  void Function(List<T> selectedItems)? onApprove,
  void Function()? onCancel,
  bool useRootNavigator = true
}){

  void navigateBack(){
    Navigator.of(context,rootNavigator: useRootNavigator).pop();
  }

  showDialog(
      context: context,
      useRootNavigator: useRootNavigator,
      useSafeArea: true,
      builder: (context){
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 7,vertical: 13),
          child: _DialogContent(
            items: items,
            selectedItems: selectedItems,
            title: title,
            onCancel: navigateBack,
            onSelected: (selecteds){
              onApprove?.call(selecteds);
              navigateBack();
            },
          ),
        );
      }
  );
}


class _DialogContent<T extends IMenuItem> extends StatelessWidget {

  final List<T> items;
  final List<T> selectedItems;
  final String title;
  final void Function(List<T> selectedItems)? onSelected;
  final void Function()? onCancel;

  _DialogContent({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.title,
    this.onSelected,
    this.onCancel,
  }) : super(key: key);

  final selectedItemsNotifier = ValueNotifier<List<T>>([]);


  @override
  Widget build(BuildContext context) {

    selectedItemsNotifier.value = selectedItems;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9,vertical: 13),
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4,),
                    getCheckBoxContents(),
                    const SizedBox(height: 16,),
                  ],
                ),
              ),
            ),
            getButtons()
          ],
        ),
      ),
    );
  }


  Widget getCheckBoxContents(){
    return ValueListenableBuilder<List<T>>(
        valueListenable: selectedItemsNotifier,
        builder: (context, selectedItems, child){
          return Column(
            children: items.map((element){
              return CheckboxListTile.adaptive(
                  value: selectedItems.contains(element),
                  title: Text(element.title),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)
                  ),
                  onChanged: (change){
                    addOrRemove(element);
                  }
              );
            }).toList(),
          );
        }
    );
  }


  Widget getButtons(){
    return SharedDiaButtons(
      onCancel: onCancel,
      onApprove: (){
        onSelected?.call(selectedItemsNotifier.value);
      },
    );
  }


  void addOrRemove(T item){
    final items = selectedItemsNotifier.value.toList();
    if(!items.contains(item)){
      items.add(item);
    }else{
      items.remove(item);
    }
    selectedItemsNotifier.value = items;
  }

}
