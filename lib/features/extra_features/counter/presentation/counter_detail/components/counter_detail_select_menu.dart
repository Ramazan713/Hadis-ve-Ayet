import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/dialogs/show_custom_alert_bottom_dia.dart';
import 'package:hadith/dialogs/show_select_font_size_bottom_dia.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/bloc/counter_detail_bloc.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/bloc/counter_detail_event.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/bloc/counter_detail_state.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/constant/counter_menu_enum.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail_setting/counter_detail_setting.dart';
import 'package:hadith/features/extra_features/counter/presentation/manage_counter/manage_counter_page.dart';
import 'package:hadith/models/menu_model.dart';
import 'package:hadith/utils/font_size_helper.dart';
import 'package:hadith/widgets/menu_button.dart';


class CounterDetailSelectMenu extends StatelessWidget{
  const CounterDetailSelectMenu({Key? key}) : super(key: key);

  List<MenuModel<CounterMenuEnum>> getMenuItems(CounterDetailState state){
    return CounterMenuEnum.values.where((element){
      if(element == CounterMenuEnum.edit){
        return state.hasSavedCounter();
      }
      if(element == CounterMenuEnum.save){
        return state.hasNotSavedCounter();
      }
      return true;
    }).map((e){
      return MenuModel(
          label: e.label,
          value: e,
          iconData: e.iconData
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final counterBloc = context.read<CounterDetailBloc>();

    return BlocBuilder<CounterDetailBloc,CounterDetailState>(
      buildWhen: (prevState,nextState){
        return prevState.counter!=nextState.counter;
      },
      builder: (context,state){
        return MenuButton<CounterMenuEnum>(
          items: getMenuItems(state),
          selectedFunc: (menuItem){
            switch(menuItem){
              case CounterMenuEnum.reset:
                showCustomAlertBottomDia(context,
                    title: "Sıfırlamak istediğinize emin misiniz?",
                    btnApproved: (){
                      counterBloc.add(CounterDetailEventReset());
                    }
                );
                break;
              case CounterMenuEnum.selectFontSize:
                showSelectFontSizeBottomDia(context);
                break;
              case CounterMenuEnum.setting:
                Navigator.pushNamed(context, CounterDetailSettingPage.id);
                break;
              case CounterMenuEnum.save:
                counterBloc.add(CounterDetailEventAddCounter());
                break;
              case CounterMenuEnum.edit:
                Navigator.pushNamed(context, ManageCounterPage.id,arguments: state.counter);
                break;
            }
          },
        );
      },
    );
  }

}
