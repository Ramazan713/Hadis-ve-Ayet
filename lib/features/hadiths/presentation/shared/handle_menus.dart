

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/core/features/save_point/edit_save_point/show_edit_save_point_dia.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_event.dart';
import 'package:hadith/core/features/share/dialogs/show_preview_hadith_image.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/dialogs/showShareAlertDialog.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_bottom_menu_item.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_share_menu_item.dart';

import 'hadith_shared_scope_widget.dart';

extension SharedHadithScopeHandleMenuExt on HadithSharedScopeWidget{


  void handleShareMenus(BuildContext context, Hadith hadith){
    final shareBloc = context.read<ShareBloc>();

    showShareAlertDialog(context,
        menuItems: HadithShareMenuItem.values,
        onClick: (menuItem){
          switch(menuItem){
            case HadithShareMenuItem.shareImage:
              showPreviewAndShareHadithImage(context,
                hadithContent: hadith.content,
                hadithSource: hadith.source,
                hadithId: hadith.id??0,
              );
              break;
            case HadithShareMenuItem.shareText:
              shareBloc.add(ShareEventShareHadithText(hadith: hadith));
              break;
            case HadithShareMenuItem.copyText:
              shareBloc.add(ShareEventCopyHadithText(hadith: hadith));
              break;
          }
        }
    );
  }


  void handleLongClickHadith(
      BuildContext context,
  {
    required int rowNumber,
    required SavePointDestination savePointDestination
  }){

    showBottomMenuItems(context,
      items: HadithBottomMenuItem.values,
      onItemClick: (menuItem){
        switch(menuItem){
          case HadithBottomMenuItem.savePoint:
            Navigator.pop(context);
            showEditSavePointsDiaBasic(context,
              destination: savePointDestination,
              itemIndexPos: rowNumber,
            );
            break;
        }
      },
    );
  }

}