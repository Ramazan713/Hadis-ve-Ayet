


import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/presentation/components/icon_text_menu_item.dart';

void showBottomMenuItems<T extends IMenuItem>(BuildContext context, {
  required List<T> items,
  required Function(T) onItemClick,
  String? title,
  bool useRootNavigator = false
}){

  List<Widget>getChildren(){
    final widgets=<Widget>[];
    if(title!=null){
      widgets.add(const SizedBox(height: 13,));
      widgets.add(Text(title,style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,));
    }
    widgets.add(const SizedBox(height: 5,));
    widgets.addAll(items.map((e){
      return IconTextMenuItem(
          title: e.title,
          iconInfo: e.iconInfo,
          onTap: (){
            onItemClick(e);
          },
      );
    }));
    widgets.add(const SizedBox(height: 7,));
    return widgets;
  }

  showModalBottomSheet(
      useRootNavigator: useRootNavigator,
      isScrollControlled: true,
      context: context,
      builder: (context){
        return SingleChildScrollView(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: getChildren(),
            ),
          ),
        );
      }
  );
}