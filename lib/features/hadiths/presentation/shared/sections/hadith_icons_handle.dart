

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/paging/paging_invalidate_op.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/select_list/show_select_list_bottom_dia.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_event.dart';
import 'package:hadith/core/features/share/dialogs/show_preview_hadith_image.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/core/presentation/dialogs/show_share_alert_dia.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_share_menu_item.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_bloc.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_event.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_state.dart';

import '../hadith_shared_page.dart';

extension HadithSharedPageHadithIconsExt on HadithSharedPage{


  void handleShareMenus(
      BuildContext context,
    {
      required HadithListModel hadithListModel,
    }
  ){
    final shareBloc = context.read<ShareBloc>();
    final hadith = hadithListModel.hadith;

    showShareAlertDia(context,
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

  void handleFavoriteClick(
      BuildContext context,
  {
    required HadithListModel hadithListModel,
    required HadithSharedState state
  }
  ){
    final hadithSharedBloc = context.read<HadithSharedBloc>();
    final listFavAffected = state.favListId == listIdControlForSelectList;

    if(listFavAffected && hadithListModel.isInFavorite){
      showCustomAlertDia(
          context,
          title: "Favori listesinden kaldırmak istediğinize emin misiniz?",
          content: "Bulunduğunuz listeyi etkileyecektir",
          btnApproved: (){
            hadithSharedBloc.add(HadithSharedEventFavorite(item: hadithListModel, listFavAffected: listFavAffected));
          }
      );
    }else{
      hadithSharedBloc.add(HadithSharedEventFavorite(item: hadithListModel, listFavAffected: listFavAffected));
    }
  }

  void selectListMenu(
      BuildContext context,
  {
    required HadithListModel hadithListModel
  }
  ){
    final pagingBloc = context.read<PaginationBloc>();

    showSelectListBottomDia(
      context,
      listIdControl: listIdControlForSelectList,
      itemId: hadithListModel.hadith.id??0,
      sourceType: SourceTypeEnum.hadith,
      onDataChanged: (isListAffected){
        final op = isListAffected ? PagingInvalidateOp.unknown: PagingInvalidateOp.update;
        pagingBloc.add(PaginationEventInValidate(
            item: hadithListModel,
            op: op,
            pos: hadithListModel.rowNumber - 1)
        );
      },
    );
  }

}