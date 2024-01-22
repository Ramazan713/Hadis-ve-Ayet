

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/features/share/presentation/components/share_item.dart';

void showShareAlertDia<T extends IMenuItem>(BuildContext context,{
  required List<T> items,
  required void Function(T) onSelected,
  bool navigateBackWhenItemClick = true,
  String title="Paylaşma Seçenekleri"
}){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text(title,style: Theme.of(context).textTheme.titleLarge,),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: items.map((menuItem){
            return ShareItem(
              title: menuItem.title,
              onTap: (){
                if(navigateBackWhenItemClick){
                  Navigator.pop(context);
                }
                onSelected(menuItem);
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