import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';

class CustomDropdownIconMenu<T extends IMenuItem> extends StatelessWidget {
  final List<T> items;
  final Function(T) onSelected;
  final Icon? icon;
  final bool enabled;

  const CustomDropdownIconMenu({
    Key? key,
    required this.items,
    required this.onSelected,
    this.enabled = true,
    this.icon
  }) : super(key: key);

  List<Widget> getMenuItems(BuildContext context){
    return items.map((e){
      return MenuItemButton(
        onPressed: (){
          onSelected.call(e);
        },
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            ))
        ),
        leadingIcon: e.iconInfo?.toIcon(),
        child: Text(e.title),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: getMenuItems(context),
      builder: (context, menuController, widget){
        return IconButton(
          onPressed: !enabled ? null : (){
            if(menuController.isOpen){
              menuController.close();
            }else{
              menuController.open();
            }
          },
          icon: icon ?? const Icon(Icons.more_vert),
        );
      },
    );
  }
}

