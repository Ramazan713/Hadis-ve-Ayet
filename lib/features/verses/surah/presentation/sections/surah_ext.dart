
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/features/topic_save_point/components/topic_save_point_floating_action_button.dart';
import 'package:hadith/core/presentation/components/selections/dropdown_icon_menu.dart';
import 'package:hadith/core/presentation/dialogs/show_select_edition.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/verses/surah/domain/enums/surah_top_bar_menu_item.dart';
import 'package:hadith/features/verses/surah/presentation/bloc/surah_bloc.dart';
import 'package:hadith/features/verses/surah/presentation/bloc/surah_state.dart';
import 'package:hadith/features/verses/surah/presentation/surah_page.dart';
import 'package:flutter/material.dart';

extension SurahPageExt on SurahPage{

  Widget getFab(){
    return BlocSelector<SurahBloc,SurahState,bool>(
        selector: (state) => !state.searchBarVisible,
        builder: (context, showFab){
          return TopicSavePointFloatingActionButton(
            controller: scrollController,
            showFab: showFab,
            onSavePointClick: (topicSavePoint){
              itemScrollController.scrollTo(
                  index: topicSavePoint.pos,
                  duration: const Duration(milliseconds: 300),
                  alignment: 0.5
              );
            },
          );
        }
    );
  }

  List<Widget> getActions(BuildContext context){
    return [
      _getDropdownMenu(context)
    ];
  }

  Widget _getDropdownMenu(BuildContext context){
    return CustomDropdownIconMenu(
      items: SurahTopBarMenuItem.values,
      onSelected: (menuItem){
        switch(menuItem){
          case SurahTopBarMenuItem.selectEdition:
            showSelectEdition(context);
            break;
          case SurahTopBarMenuItem.selectSavePoint:
            showSelectSavePoints(context,
              shortTitle: "Surah",
              savePointType: SavePointType.surah,
              bookScope: BookScopeEnum.diyanetMeal,
            );
            break;
        }
      },
    );
  }
}