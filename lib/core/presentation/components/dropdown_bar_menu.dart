import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';

class CustomDropdownBarMenu<T extends IMenuItem> extends StatelessWidget {
  final List<T> items;
  final Function(T) selectedFunc;

  const CustomDropdownBarMenu({Key? key, required this.items,required this.selectedFunc}) : super(key: key);

  PopupMenuItem<T> getMenuItem(T menuItem,TextStyle? textStyle) {
    return PopupMenuItem(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 20,
        value: menuItem,
        child: Row(
          children: [
            menuItem.iconInfo?.toIcon(color: textStyle?.color,useDefaultOrSet: true)
              ?? const SizedBox(),

            const SizedBox(
              width: 7,
            ),
            Text(menuItem.title,style: textStyle)
          ],
        ));
  }

  List<PopupMenuItem<T>> getPopupMenuItemsList(TextStyle? textStyle){
    List<PopupMenuItem<T>>popItems=[];
    for (var element in items) {
      popItems.add(getMenuItem(element,textStyle));
    }
    return popItems;
  }

  @override
  Widget build(BuildContext context) {

    final textStyle=Theme.of(context).textTheme.bodyText2?.copyWith(
        fontSize: (Theme.of(context).textTheme.bodyText2?.fontSize??15)+1
    );
    return PopupMenuButton<T>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      itemBuilder: (context) => getPopupMenuItemsList(textStyle),
      onSelected: selectedFunc,
    );
  }
}

