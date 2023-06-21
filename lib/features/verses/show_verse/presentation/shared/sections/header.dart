

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/extensions/app_extension.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_state.dart';
import 'package:hadith/core/features/save_point/edit_save_point/show_edit_save_point_dia.dart';
import 'package:hadith/core/features/select_font_size/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/dropdown_bar_menu.dart';
import 'package:hadith/core/presentation/dialogs/show_select_verse_ui_2x.dart';
import 'package:hadith/dialogs/show_get_number_bottom_dia.dart';
import 'package:hadith/features/verse/common_dialogs/show_select_edition.dart';
import 'package:hadith/features/verses/show_verse/domain/constants/verse_top_bar_menu_item.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/sections/show_select_point.dart';
import '../verse_show_shared_page.dart';

extension VerseShowSharedPageHeaderExt on VerseShowSharedPage{

  List<Widget> getTopBarActions(BuildContext context){
    return [
      _getAppearanceIcon(context),
      _getNavigatorIcon(context),
      _getDropdownMenu(context)
    ];
  }


  Widget _getDropdownMenu(BuildContext context){
    return BlocSelector<PaginationBloc,PaginationState,VerseListModel?>(
        selector: (state)=>state.visibleMiddleItem.castOrNull<VerseListModel>(),
        builder: (context,visibleMiddleItem){

          return CustomDropdownBarMenu(
            items: VerseTopBarMenuItem.values,
            selectedFunc: (menuItem){
              switch(menuItem){
                case VerseTopBarMenuItem.fontSize:
                  showSelectFontSizeDia(context);
                  break;
                case VerseTopBarMenuItem.savePoint:
                  verseShowSelectSavePoint(context, itemIndexPos: visibleMiddleItem?.rowNumber ?? 0);
                  break;
                case VerseTopBarMenuItem.selectEdition:
                  showSelectEdition(context);
                  break;
              }
            },
          );
        });
  }

  Widget _getAppearanceIcon(BuildContext context){
    return IconButton(
      onPressed: () async{
        showSelectVerseUi2X(context, pref: KPref.verseAppearanceEnum);
      },
      icon: const Icon(Icons.view_agenda),
      tooltip: "Görünümü Değiştir",
    );
  }

  Widget _getNavigatorIcon(BuildContext context){

    return BlocBuilder<PaginationBloc,PaginationState>(
      buildWhen: (prevState, nextState){
        return prevState.visibleMinPos != nextState.visibleMinPos;
      },
      builder: (context, state){
        final pagingBloc = context.read<PaginationBloc>();

        return IconButton(
            onPressed: () async {
              showGetNumberBottomDia(
                  context, (selected) {
                    pagingBloc.add(PaginationEventJumpToPos(pos: selected));
                  },
                  currentIndex: state.visibleMiddlePos,
                  limitIndex: state.totalItems - 1
              );
            },
            icon: const Icon(Icons.map)
        );
      },
    );
  }

}