

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/extensions/app_extension.dart';
import 'package:hadith/core/features/audio_setting/show_edit_audio_setting_dia.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_state.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/dialogs/show_get_number_dia.dart';
import 'package:hadith/core/presentation/dialogs/show_select_verse_ui_2x.dart';
import 'package:hadith/core/presentation/selections/dropdown_icon_menu.dart';
import 'package:hadith/features/verses/show_verse/domain/constants/verse_top_bar_menu_item.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/verse_shared_args.dart';
import '../verse_show_shared_page.dart';
import './show_select_point.dart';

extension VerseShowSharedPageHeaderExt on VerseSharedPageArgs{

  List<Widget> getActions(BuildContext context,{
    required SavePointDestination savePointDestination
  }){
    return [
      getTopBarAppearanceIcon(context),
      _getNavigatorIcon(context),
      getTopBarDropdownMenu(context,savePointDestination: savePointDestination)
    ];
  }


  Widget getTopBarDropdownMenu(BuildContext context, {
    required SavePointDestination savePointDestination
  }){
    return BlocSelector<PaginationBloc,PaginationState,VerseListModel?>(
        selector: (state)=>state.visibleMiddleItem.castOrNull<VerseListModel>(),
        builder: (context,visibleMiddleItem){

          return CustomDropdownIconMenu(
            items: VerseTopBarMenuItem.values,
            onSelected: (menuItem){
              switch(menuItem){
                case VerseTopBarMenuItem.fontSize:
                  showSelectFontSizeDia(context);
                  break;
                case VerseTopBarMenuItem.savePoint:
                  verseShowSelectSavePoint(
                    context,
                    savePointDestination: savePointDestination,
                    itemIndexPos: visibleMiddleItem?.rowNumber ?? 0,
                  );
                  break;
                case VerseTopBarMenuItem.selectEdition:
                  showEditAudioSettingDia(context);
                  break;
              }
            },
          );
        });
  }

  Widget getTopBarAppearanceIcon(BuildContext context){
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
        return prevState.visibleMiddleItem != nextState.visibleMiddleItem ||
            prevState.totalItems != nextState.totalItems;
      },
      builder: (context, state){
        final pagingBloc = context.read<PaginationBloc>();

        return IconButton(
            onPressed: () async {
              final visibleMiddleItem = state.visibleMiddleItem.castOrNull<VerseListModel>();
              if(visibleMiddleItem==null)return;

              showGetNumberDia(
                context,
                listener: (selected) {
                  pagingBloc.add(PaginationEventJumpToPos(pos: selected + 1));
                },
                currentIndex: visibleMiddleItem.rowNumber,
                limitIndex: state.totalItems - 1
              );
            },
            icon: const Icon(Icons.map)
        );
      },
    );
  }

}