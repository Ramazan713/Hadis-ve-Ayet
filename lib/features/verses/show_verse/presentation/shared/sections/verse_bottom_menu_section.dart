

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/paging/paging_invalidate_op.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/save_point/edit_save_point/show_edit_save_point_dia.dart';
import 'package:hadith/core/features/select_list/show_select_list_bottom_dia.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_event.dart';
import 'package:hadith/core/features/share/dialogs/show_preview_verse_image.dart';
import 'package:hadith/core/presentation/bottom_sheets/showCustomAlertBottomDia.dart';
import 'package:hadith/core/presentation/dialogs/showShareAlertDialog.dart';
import 'package:hadith/features/verses/show_verse/domain/constants/verse_bottom_menu_item.dart';
import 'package:hadith/features/verses/show_verse/domain/constants/verse_share_menu_item.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';import 'package:hadith/features/verses/show_verse/presentation/shared/show_verse_bottom_menu.dart';

import '../bloc/verse_shared_bloc.dart';
import '../bloc/verse_shared_event.dart';
import '../bloc/verse_shared_state.dart';
import '../verse_show_shared_page.dart';

extension VerseShowSharedPageBottomBarExt on VerseShowSharedPage{


  void handleBottomMenu(BuildContext context,{
    required VerseListModel verseListModel,
    required VerseSharedState state,
  }){

    void navigateBack(){
      Navigator.pop(context);
    }

    showVerseBottomMenu(context,
        verseListModel: verseListModel,
        listener: (menuItem){
          switch(menuItem){
            case VerseBottomMenuItem.play:
              break;
            case VerseBottomMenuItem.share:
              _handleShareDia(context,verseListModel);
              break;
            case VerseBottomMenuItem.copy:
              context.read<ShareBloc>()
                  .add(ShareEventCopyVerseText(verse: verseListModel.verse));
              break;
            case VerseBottomMenuItem.addList:
              navigateBack();
              _showSelectList(context,verseListModel: verseListModel);
              break;
            case VerseBottomMenuItem.deleteList:
              navigateBack();
              _showSelectList(context,verseListModel: verseListModel);
              break;
            case VerseBottomMenuItem.addFavorite:
              _addOrDeleteFavoriteList(context,
                  deleteFavorite: false,
                  verseListModel: verseListModel,
                  favListId: state.favListId
              );
              break;
            case VerseBottomMenuItem.deleteFavorite:
              _addOrDeleteFavoriteList(context,
                  deleteFavorite: true,
                  verseListModel: verseListModel,
                  favListId: state.favListId
              );
              break;
            case VerseBottomMenuItem.savePoint:
              navigateBack();
              _showSelectSavePointDia(context,verseListModel);
              break;
          }
        }
    );
  }

  void _handleShareDia(BuildContext context, VerseListModel verseListModel){
    final shareBloc = context.read<ShareBloc>();

    showShareAlertDialog(context,
        menuItems: VerseShareMenuItem.values,
        onClick: (menuItem){
          switch(menuItem){
            case VerseShareMenuItem.shareImage:
              showPreviewAndShareVerseImage(context,
                verseListModel: verseListModel,
              );
              break;
            case VerseShareMenuItem.shareText:
              shareBloc.add(ShareEventShareVerseText(verse: verseListModel.verse));
              break;
          }
        }
    );
  }

  void _showSelectSavePointDia(BuildContext context, VerseListModel verseListModel){

    if(editSavePointHandler!=null){
      showEditSavePointsDiaAdvanced(context,
          destination: savePointDestination,
          itemIndexPos: verseListModel.rowNumber,
          onLoadSavePointClick: editSavePointHandler!.onLoadSavePointClick,
          onOverrideSavePointRequestHandler: editSavePointHandler!.onOverrideSavePointRequestHandler,
          onLoadSavePointRequestHandler: editSavePointHandler!.onLoadSavePointRequestHandler,
      );
    }else{
      showEditSavePointsDiaBasic(
          context,
          destination: savePointDestination,
          itemIndexPos: verseListModel.rowNumber,
          onLoadSavePointClick: (savePoint){
            context.read<PaginationBloc>()
                .add(PaginationEventJumpToPos(pos: savePoint.itemIndexPos));
          }
      );
    }
  }


  void _addOrDeleteFavoriteList(BuildContext context,{
    required bool deleteFavorite,
    required VerseListModel verseListModel,
    required int favListId
  }){
    final verseBloc = context.read<VerseSharedBloc>();

    final listFavAffected = favListId == listIdControlForSelectList;

    if(listFavAffected && deleteFavorite){
      showCustomAlertBottomDia(
          context,
          title: "Favori listesinden kaldırmak istediğinize emin misiniz?",
          content: "Bulunduğunuz listeyi etkileyecektir",
          btnApproved: (){
            verseBloc.add(VerseSharedEventAddFavorite(verseListModel: verseListModel,
                listFavAffected: listFavAffected));
          }
      );
    }else{
      verseBloc.add(VerseSharedEventAddFavorite(verseListModel: verseListModel,
          listFavAffected: listFavAffected));
    }
  }


  void _showSelectList(BuildContext context,{required VerseListModel verseListModel}){
    final pagingBloc = context.read<PaginationBloc>();

    showSelectListBottomDia(context,
        itemId: verseListModel.pagingId,
        sourceType: SourceTypeEnum.verse,
        listIdControl: listIdControlForSelectList,
        onDataChanged: (isListAffected){
          final op = isListAffected ? PagingInvalidateOp.unknown: PagingInvalidateOp.update;
          pagingBloc.add(PaginationEventInValidate(item: verseListModel, op: op));
        }
    );
  }
}