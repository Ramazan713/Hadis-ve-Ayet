

import 'package:flutter/material.dart';
import 'package:hadith/core/features/adaptive/presentation/select_adaptive_menu_items.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_bottom_menu_item.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_args_widget.dart';
import '../hadith_shared_page.dart';
import './show_select_point.dart';

extension HadithSharedPageBottomMenuExt on HadithSharedPageArgs{

  void handleBottomMenu(BuildContext context,{
    required HadithListModel hadithListModel
  }){
    selectAdaptiveMenuItems(context,
      items: HadithBottomMenuItem.values,
      title: "Hadis ${hadithListModel.rowNumber}",
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