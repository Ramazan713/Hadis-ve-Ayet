

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/extensions/app_extension.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_state.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/features/verses/show_verse/domain/constants/verse_bottom_menu_item.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';

void showVerseBottomMenu(BuildContext context, {
  required VerseListModel verseListModel,
  required Function(VerseBottomMenuItem)onListener,
  required bool showNavigateToActions
}) {

  List<VerseBottomMenuItem> getItems(VerseListModel? currentLastModifiedItem){
    final validVerseListModel = currentLastModifiedItem?.pagingId == verseListModel.pagingId ?
        currentLastModifiedItem??verseListModel : verseListModel;

    final items = VerseBottomMenuItem.getItems(
      isInAnyList: validVerseListModel.isInAnyList,
      inInFavorite: validVerseListModel.isInFavorite,
      showNavigateToActions: showNavigateToActions
    );
    return items;
  }

  final verse = verseListModel.verse;
  final title = "${verse.surahName} ${verse.verseNumber}. Ayet";

  showCustomExtendBottomMenuItems(
    context,
    title: title,
    onItemClick: onListener,
    wrapper: ({
      required Widget Function(List<VerseBottomMenuItem> oldItems) updateItems
    }){
      return BlocSelector<PaginationBloc, PaginationState, VerseListModel?>(
        selector: (state) => state.lastModifiedItem?.item.castOrNull<VerseListModel>(),
        builder: (context, currentLastModifiedItem){
          return updateItems.call(getItems(currentLastModifiedItem));
        }
      );
    }
  );
}