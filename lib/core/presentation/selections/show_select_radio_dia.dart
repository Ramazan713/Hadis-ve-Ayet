import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/presentation/components/shared_dia_buttons.dart';

void showSelectRadioDia<T extends IMenuItem>(BuildContext context,{
  required List<T> items,
  required T? currentItem,
  required String title,
  IconData? iconData,
  void Function(T selected)? onSelected,
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
          currentItem: currentItem,
          title: title,
          iconData: iconData,
          onCancel: navigateBack,
          onSelected: (selected){
            onSelected?.call(selected);
            navigateBack();
          },
        ),
      );
    }
  );
}


class _DialogContent<T extends IMenuItem> extends StatelessWidget {

  final List<T> items;
  final T? currentItem;
  final String title;
  final IconData? iconData;
  final void Function(T selected)? onSelected;
  final void Function()? onCancel;

  _DialogContent({
    Key? key,
    required this.items,
    required this.currentItem,
    required this.title,
    this.iconData,
    this.onSelected,
    this.onCancel,
  }) : super(key: key);

  final selectedNotifier = ValueNotifier<T?>(null);


  @override
  Widget build(BuildContext context) {

    selectedNotifier.value = currentItem;

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
                   Icon(iconData),
                   const SizedBox(height: 16,),
                   Text(
                     title,
                     style: Theme.of(context).textTheme.titleLarge,
                   ),
                   const SizedBox(height: 4,),
                   getRadioContents(),
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


  Widget getRadioContents(){
    return ValueListenableBuilder<T?>(
      valueListenable: selectedNotifier,
      builder: (context, currentSelected, child){
        return Column(
          children: items.map((element){
            return RadioListTile.adaptive(
                value: element,
                groupValue: currentSelected,
                title: Text(element.title),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)
                ),
                onChanged: (selected){
                  selectedNotifier.value = selected;
                }
            );
          }).toList(),
        );
      }
    );
  }


  Widget getButtons(){
    return ValueListenableBuilder<T?>(
      valueListenable: selectedNotifier,
      builder: (context, currentSelected, child){
        return  SharedDiaButtons(
          onCancel: onCancel,
          onApprove: currentSelected == null ? null : (){
            final selected = selectedNotifier.value;
            if(selected!=null){
              onSelected?.call(selected);
            }
          },
        );
      }
    );
  }


}
