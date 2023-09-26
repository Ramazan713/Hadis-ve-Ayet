

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/paging/paging_invalidate_op.dart';
import 'package:hadith/core/domain/enums/save_point/local_destination_scope.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/save_point/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/load_save_point/bloc/load_save_point_event.dart';
import 'package:hadith/core/features/select_list/show_select_list_bottom_dia.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_event.dart';
import 'package:hadith/core/features/share/dialogs/show_preview_share_image_handle_dia.dart';
import 'package:hadith/core/features/share/enums/share_verse_content_menu_item.dart';
import 'package:hadith/core/features/verse_audio/presentation/download_verse_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/download_verse_audio/bloc/download_audio_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_event.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/core/presentation/dialogs/show_share_alert_dia.dart';
import 'package:hadith/features/verses/show_verse/domain/constants/verse_bottom_menu_item.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/share/verse_repaint_item.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/sections/show_select_point.dart';import 'package:hadith/features/verses/show_verse/presentation/shared/show_verse_bottom_menu.dart';

import '../bloc/verse_shared_bloc.dart';
import '../bloc/verse_shared_event.dart';
import '../bloc/verse_shared_state.dart';
import '../verse_show_shared_page.dart';

extension VerseShowSharedPageBottomBarExt on VerseShareBasePage{


  void handleBottomMenu(BuildContext context,{
    required VerseListModel verseListModel,
    required VerseSharedState state,
    required SavePointDestination savePointDestination,
    int? itemIndexPos,
    LocalDestinationScope? initScope,
    void Function(SavePoint)? onLoadSavePointClick,
  }){

    void navigateBack(){
      Navigator.pop(context);
    }

    final verse = verseListModel.verse;

    showVerseBottomMenu(context,
        verseListModel: verseListModel,
        showNavigateToActions: showNavigateToActions,
        bloc: context.read<PaginationBloc>(),
        onListener: (menuItem){
          switch(menuItem){
            case VerseBottomMenuItem.download:
              navigateBack();
              context.read<DownloadAudioBloc>().add(DownloadAudioEventStartDownloadingWithVerse(
                verse: verse,
                selectAudioOption: selectAudioOption
              ));
              break;
            case VerseBottomMenuItem.play:
              navigateBack();
              context.read<ListenVerseAudioBloc>().add(ListenAudioEventStartListeningWithVerse(
                verse: verse,
                selectAudioOption: selectAudioOption
              ));
              break;
            case VerseBottomMenuItem.share:
              navigateBack();
              _handleShareDia(context,verseListModel);
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
              verseShowSelectSavePoint(
                context,
                itemIndexPos: itemIndexPos ?? verseListModel.rowNumber,
                savePointDestination: savePointDestination,
                initScope: initScope,
                onLoadSavePointClick: onLoadSavePointClick
              );
              break;
            case VerseBottomMenuItem.navToSurah:
              navigateBack();
              final surahDestination = DestinationSurah(surahId: verse.surahId, surahName: verse.surahName);
              context.read<LoadSavePointBloc>().add(LoadSavePointEventNavigateWithSurahDestination(
                destination: surahDestination,
                mealId: verse.id ?? 0
              ));
              break;
          }
        }
    );
  }

  void _handleShareDia(BuildContext context, VerseListModel verseListModel){
    final shareBloc = context.read<ShareBloc>();
    final shareText = verseListModel.verse.getShareText();

    showShareAlertDia(context,
        items: SharingCommonMenuItem.values,
        onSelected: (menuItem){
          switch(menuItem){
            case SharingCommonMenuItem.shareImage:
              showPreviewShareImageHandleDia(context,
                onImageWidget: (key){
                  return VerseRepaintItem(
                    repaintKey: key,
                    verseListModel: verseListModel,
                  );
                },
                imageName: "${verseListModel.verse.surahName}-${verseListModel.verse.verseNumber}-Ayet.png"
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

  void _addOrDeleteFavoriteList(BuildContext context,{
    required bool deleteFavorite,
    required VerseListModel verseListModel,
    required int favListId
  }){
    final verseBloc = context.read<VerseSharedBloc>();

    final listFavAffected = favListId == listIdControlForSelectList;

    if(listFavAffected && deleteFavorite){
      showCustomAlertDia(
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