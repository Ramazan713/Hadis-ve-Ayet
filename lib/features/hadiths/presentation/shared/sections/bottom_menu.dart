

import 'package:flutter/material.dart';
import 'package:hadith/core/features/save_point/edit_save_point/show_edit_save_point_dia.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_bottom_menu_item.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/features/hadiths/presentation/shared/sections/show_select_point.dart';

import '../hadith_shared_page.dart';

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