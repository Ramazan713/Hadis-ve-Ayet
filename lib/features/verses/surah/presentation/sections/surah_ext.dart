
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_type.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/features/select_edition/show_select_edition.dart';
import 'package:hadith/core/features/topic_save_point/presentation/components/topic_save_point_floating_action_button.dart';
import 'package:hadith/core/presentation/selections/dropdown_icon_menu.dart';
import 'package:hadith/features/verses/surah/domain/enums/surah_top_bar_menu_item.dart';
import 'package:hadith/features/verses/surah/presentation/bloc/surah_bloc.dart';
import 'package:hadith/features/verses/surah/presentation/bloc/surah_state.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../surah_page.dart';

extension SurahPageExt on SurahPageState{

  Widget getFab(){
    return BlocSelector<SurahBloc,SurahState,bool>(
        selector: (state) => !state.searchBarVisible,
        builder: (context, showFab){
          return TopicSavePointFloatingActionButton(
            controller: scrollController,
            showFab: showFab,
            onSavePointClick: (topicSavePoint){
              autoScrollController.scrollToIndex(
                  topicSavePoint.pos,
                  preferPosition: AutoScrollPosition.middle
              );
            },
          );
        }
    );
  }

  List<Widget> getActions(){
    return [
      _getDropdownMenu()
    ];
  }

  Widget _getDropdownMenu(){
    return CustomDropdownIconMenu(
      items: SurahTopBarMenuItem.values,
      onSelected: (menuItem){
        switch(menuItem){
          case SurahTopBarMenuItem.selectEdition:
            showSelectEdition(context);
            break;
          case SurahTopBarMenuItem.selectSavePoint:
            showSelectSavePoints(context,
              shortTitle: "Sure",
              savePointType: SavePointType.surah,
              bookScope: BookScopeEnum.diyanetMeal,
            );
            break;
        }
      },
    );
  }
}