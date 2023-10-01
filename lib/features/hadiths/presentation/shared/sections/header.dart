

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/extensions/app_extension.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_state.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/selections/dropdown_icon_menu.dart';
import 'package:hadith/core/presentation/dialogs/show_get_number_dia.dart';
import 'package:hadith/features/hadiths/domain/constants/hadith_top_bar_menu_item.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_page.dart';
import 'package:hadith/features/hadiths/presentation/shared/sections/show_select_point.dart';

extension HadithSharedPageHeaderExt on HadithSharedPage{


  List<Widget> getTopBarActions(BuildContext context){
    return [
      _getNavigatorIcon(context),
      _getDropdownMenu(context)
    ];
  }


  Widget _getDropdownMenu(BuildContext context){
    return BlocSelector<PaginationBloc,PaginationState,HadithListModel?>(
        selector: (state)=> state.visibleMiddleItem.castOrNull<HadithListModel>(),
        builder: (context, visibleMiddleItem){

          return CustomDropdownIconMenu(
              items: HadithTopBarMenuItem.values,
              onSelected: (menuItem){
                switch(menuItem){
                  case HadithTopBarMenuItem.fontSize:
                    showSelectFontSizeDia(context);
                    break;
                  case HadithTopBarMenuItem.savePoint:
                    hadithShowSelectSavePoint(
                      context,
                      itemIndexPos: visibleMiddleItem?.rowNumber ?? 0
                    );
                    break;
                }
              }
          );
        }
    );
  }

  Widget _getNavigatorIcon(BuildContext context){
    final pagingBloc = context.read<PaginationBloc>();

    return BlocBuilder<PaginationBloc, PaginationState>(
      buildWhen: (prevState,nextState){
        return prevState.visibleMiddleItem != nextState.visibleMiddleItem ||
            prevState.totalItems != nextState.totalItems;
      },
      builder: (context,state){

        return IconButton(onPressed: (){

          final item = state.visibleMiddleItem?.castOrNull<HadithListModel>();
          if(item == null) return;
          showGetNumberDia(context,
            listener: (newPos){
              pagingBloc.add(PaginationEventJumpToPos(pos: newPos + 1));
            },
            currentIndex: item.rowNumber,
            limitIndex: state.totalItems - 1
          );

        }, icon: const Icon(Icons.map));
      },
    );
  }

}