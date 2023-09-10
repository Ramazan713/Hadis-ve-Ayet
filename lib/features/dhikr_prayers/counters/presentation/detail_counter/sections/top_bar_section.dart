

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/core/presentation/components/selections/dropdown_icon_menu.dart';
import 'package:hadith/core/presentation/dialogs/show_select_verse_ui_4x.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_detail_top_bar_menu_item.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/bloc/detail_counter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/bloc/detail_counter_state.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/bloc/detail_detail_event.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/detail_counter_shared_content_page.dart';

extension DetailCounterSharedContentPageTopBarExt on DetailCounterSharedContentPage{

  List<Widget> getActions(BuildContext context){
    return [
      _getAppearanceAction(),
      _getDropdownMenuAction()
    ];
  }

  Widget _getAppearanceAction(){
    return BlocSelector<DetailCounterBloc,DetailCounterState,bool>(
      selector: (state) => state.hasAnyContent,
      builder: (context, hasAnyContent){
        if(!hasAnyContent) return const SizedBox();
        return IconButton(
          onPressed: () async{
            showSelectVerseUi4X(context,
              currentKPref: KPref.counterUi,
            );
          },
          icon: const Icon(Icons.view_agenda),
          tooltip: "Görünümü Değiştir",
        );
      },
    );
  }

  Widget _getDropdownMenuAction(){
    return BlocSelector<DetailCounterBloc,DetailCounterState, Counter?>(
      selector: (state) => state.currentCounter,
      builder: (context, currentCounter){
        return CustomDropdownIconMenu(
          items: CounterDetailTopBarMenuItems.getItems(hasCounter: hasCounter),
          onSelected: (menuItem){
            _handleDropdownMenu(context,
              menuItem: menuItem,
              currentCounter: currentCounter
            );
          },
        );
      },
    );
  }

  void _handleDropdownMenu(BuildContext context,{
    required CounterDetailTopBarMenuItems menuItem,
    required Counter? currentCounter
  }){
    switch(menuItem){
      case CounterDetailTopBarMenuItems.reset:
        showCustomAlertDia(context,
          title: "Sıfırlamak istediğinize emin misiniz?",
          btnApproved: (){
            context.read<DetailCounterBloc>().add(DetailCounterEventReset());
          }
        );
        break;
      case CounterDetailTopBarMenuItems.selectFontSize:
        showSelectFontSizeDia(context);
        break;
      case CounterDetailTopBarMenuItems.setting:
        CounterSettingRoute().push(context);
        break;
      case CounterDetailTopBarMenuItems.edit:
        if(currentCounter != null){
          ManageCounterRoute(counterId: currentCounter.id ??0).push(context);
        }
        break;
    }
  }

}