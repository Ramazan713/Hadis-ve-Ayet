import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/use_cases/font_model_use_case.dart';
import 'package:hadith/core/features/pagination/domain/enums/paging_invalidate_op.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/core/features/select_list/presentation/show_select_list_bottom_dia.dart';
import 'package:hadith/core/features/share/domain/enums/share_verse_content_menu_item.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_event.dart';
import 'package:hadith/core/features/share/presentation/dialogs/show_preview_share_image_handle_dia.dart';
import 'package:hadith/core/features/share/presentation/dialogs/show_share_alert_dia.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_bloc.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_event.dart';
import 'package:hadith/features/hadiths/presentation/shared/bloc/hadith_shared_state.dart';
import 'package:hadith/features/hadiths/presentation/shared/components/share/hadith_repaint_item.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_args_widget.dart';

import '../hadith_shared_page.dart';

extension HadithSharedPageHadithIconsExt on HadithSharedArgsWidget{


  void handleShareMenus(BuildContext context, {
    required HadithListModel hadithListModel,
  }){
    final shareBloc = context.read<ShareBloc>();
    final hadith = hadithListModel.hadith;
    final fontModel = context.read<FontModelUseCase>().call();
    final shareText = hadith.getShareText();

    showShareAlertDia(context,
        items: SharingCommonMenuItem.values,
        onSelected: (menuItem){
          switch(menuItem){
            case SharingCommonMenuItem.shareImage:
              showPreviewShareImageHandleDia(context,
                onImageWidget: (key){
                  return HadithRepaintItem(
                    hadith: hadith,
                    fontModel: fontModel,
                    repaintKey: key,
                  );
                },
                imageName: "${hadith.id}-Hadis.png"
              );
              break;
            case SharingCommonMenuItem.shareText:
              shareBloc.add(ShareEventShareText(text: shareText));
              break;
            case SharingCommonMenuItem.copyText:
              shareBloc.add(ShareEventCopyText(text: shareText));
              break;
          }
        }
    );
  }

  void handleFavoriteClick(BuildContext context, {
    required HadithListModel hadithListModel,
    required HadithSharedState state
  }){
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

  void selectListMenu(BuildContext context, {
    required HadithListModel hadithListModel
  }){
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