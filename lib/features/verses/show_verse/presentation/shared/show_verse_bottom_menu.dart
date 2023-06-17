

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/extensions/app_extension.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_state.dart';
import 'package:hadith/core/presentation/components/icon_text_menu_item.dart';
import 'package:hadith/features/verses/show_verse/domain/constants/verse_bottom_menu_item.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';

void showVerseBottomMenu(
    BuildContext context,
    {
      required VerseListModel verseListModel,
      required Function(VerseBottomMenuItem)listener,
    }
) {

  final verse = verseListModel.verse;

  List<IconTextMenuItem> getMenuItemsContent(VerseListModel verseListModel){

    return VerseBottomMenuItem.getItems(
        isInAnyList: verseListModel.isInAnyList,
        inInFavorite: verseListModel.isInFavorite
    ).map((e){
      return IconTextMenuItem(
          title: e.title,
          iconInfo: e.iconInfo,
          onTap: (){
            listener.call(e);
          });
    }).toList();
  }

  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {

        return BlocSelector<PaginationBloc, PaginationState, VerseListModel?>(
            selector: (state) => state.lastModifiedItem?.item.castOrNull<VerseListModel>(),
            builder: (context, currentLastModifiedItem){
              final validVerseListModel = currentLastModifiedItem?.pagingId == verseListModel.pagingId ?
                  currentLastModifiedItem??verseListModel : verseListModel;

              return SingleChildScrollView(
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 7,),
                        Text("${verse.surahName} ${verse.verseNumber}. Ayet",textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,),
                        const SizedBox(height: 5,),

                        ...getMenuItemsContent(
                            validVerseListModel
                        ),
                      ],
                    ),
                  )
              );
            }
        );
      });
}