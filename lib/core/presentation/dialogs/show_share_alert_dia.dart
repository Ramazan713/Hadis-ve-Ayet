

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/presentation/components/share_item.dart';

void showShareAlertDia(BuildContext context,{
  required List<IMenuItem> menuItems,
  required void Function(IMenuItem) onClick,
  String title="Paylaşma Seçenekleri"
}){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text(title,style: Theme.of(context).textTheme.titleLarge,),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: menuItems.map((menuItem){
            return ShareItem(
              title: menuItem.title,
              onTap: (){
                onClick(menuItem);
              },
              iconInfo: menuItem.iconInfo,
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text("Iptal"),
        )
      ],
    );
  });
}