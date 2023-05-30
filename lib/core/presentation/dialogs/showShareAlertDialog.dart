

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/presentation/components/share_item.dart';

void showShareAlertDialog(BuildContext context,{
  required List<IMenuItem> menuItems,
  required void Function(IMenuItem) onClick,
  String title="Paylaşma Seçenekleri"
}){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text(title,style: Theme.of(context).textTheme.headline6,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: menuItems.map((menuItem){
          return ShareItem(
              title: menuItem.title,
              onTap: (){
                Navigator.pop(context);
                onClick(menuItem);
              },
              iconInfo: menuItem.iconInfo,
          );
        }).toList(),
      ),

    );
  });
}