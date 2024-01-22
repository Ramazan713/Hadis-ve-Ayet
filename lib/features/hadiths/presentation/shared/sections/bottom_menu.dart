

import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/selections/show_bottom_menu_items.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_bottom_menu_item.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import '../hadith_shared_page.dart';
import './show_select_point.dart';

extension HadithSharedPageBottomMenuExt on HadithSharedPage{

  void handleBottomMenu(BuildContext context,{
    required HadithListModel hadithListModel
  }){
    showBottomMenuItems(context,
      items: HadithBottomMenuItem.values,
      onItemClick: (menuItem){
        switch(menuItem){
          case HadithBottomMenuItem.savePoint:
            Navigator.pop(context);
            hadithShowSelectSavePoint(
                context,
                itemIndexPos: hadithListModel.rowNumber
            );
            break;
        }
      },
    );
  }
}