

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/features/select_font_size/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/core/presentation/components/dropdown_bar_menu.dart';
import 'package:hadith/core/presentation/components/navigation_icon.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/dialogs/show_select_verse_ui_2x.dart';
import 'package:hadith/core/presentation/dialogs/show_select_verse_ui_3x.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/domain/enums/prayer_in_quran_top_bar_menu_item.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/presentation/bloc/prayer_in_quran_event.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/presentation/components/prayer_in_quran_item.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'bloc/prayer_in_quran_bloc.dart';
import 'bloc/prayer_in_quran_state.dart';

class PrayerInQuranPage extends StatelessWidget {
  PrayerInQuranPage({Key? key}) : super(key: key);

  final CustomPositionController _positionController = CustomPositionController();
  final ItemScrollController _itemScrollController = ItemScrollController();
  final CustomScrollController _scrollController = CustomScrollController();


  @override
  Widget build(BuildContext context) {

    final bloc = context.read<PrayerInQuranBloc>();

    return Scaffold(
      body: SafeArea(
        child: BlocSelector<PrayerInQuranBloc,PrayerInQuranState,bool>(
          selector: (state) => state.isSearchBarVisible,
          builder: (context, isSearchBarVisible){

            return CustomNestedSearchableAppBar(
              scrollController: _scrollController,
              onTextChanged: (text){
                bloc.add(PrayerInQuranEventSetQuery(query: text));
              },
              onSearchVisibilityChanged: (isSearchVisible){
                bloc.add(PrayerInQuranEventSetSearchBarVisibility(isVisible: isSearchVisible));
              },
              searchBarVisible: isSearchBarVisible,
              actions: getActions(context),
              title: Text(""),
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<PrayerInQuranBloc,PrayerInQuranState>(
                      builder: (context, state){
                        final items = state.items;

                        return CustomScrollablePositionedList(
                          itemCount: items.length,
                          itemScrollController: _itemScrollController,
                          delayMilliSeconds: 50,
                          onScroll: (scrollDirection){
                            _scrollController.setScrollDirectionAndAnimateTopBar(scrollDirection);
                          },
                          onVisibleItemChanged: (min,max){
                            _positionController.setPositions(min, max,totalItems: state.items.length);
                          },
                          itemBuilder: (context, index){
                            final prayer = items[index];
                            return PrayerInQuranItem(
                                searchParam: state.searchParam,
                                prayer: prayer,
                                order: index + 1,
                                verseUIEnum: state.arabicVerseUI2X,
                                fontModel: state.fontModel
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> getActions(BuildContext context){
    return [
      NavigationIcon(
        positionController: _positionController,
        onPosChanged: (selectedIndex){
          _itemScrollController.jumpTo(index: selectedIndex);
        },
      ),
      _topBarDropDownMenu(context)
    ];
  }

  Widget _topBarDropDownMenu(BuildContext context){
    return CustomDropdownBarMenu(
      items: PrayerInQuranTopBarMenuItem.values,
      selectedFunc: (menuItem){
        switch(menuItem){
          case PrayerInQuranTopBarMenuItem.fontSize:
            showSelectFontSizeDia(context);
            break;
          case PrayerInQuranTopBarMenuItem.changeAppearance:
            showSelectVerseUi2X(context, pref: KPref.quranPrayerVerseUi);
            break;
        }
      },
    );
  }

}
