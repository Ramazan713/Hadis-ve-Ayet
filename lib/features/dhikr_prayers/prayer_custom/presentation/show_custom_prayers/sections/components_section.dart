import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/domain/enums/show_custom_prayers_select_menu.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/shared/show_prayer_share_dia.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_event.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_state.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/show_custom_prayers_page.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
import 'package:hadith/core/utils/toast_utils.dart';

extension ShowCustomPrayersPageComponentsExt on ShowCustomPrayersPage{

  void handleBottomMenu(BuildContext context,PrayerCustom prayer){
    final bloc = context.read<ShowCustomPrayersBloc>();
    showBottomMenuItems(
        context,
        title: "'${prayer.name}' adlı item için",
        items: ShowCustomPrayersSelectMenuEnum.getItems(prayer),
        onItemClick: (menuItem){
          Navigator.pop(context);
          switch(menuItem){
            case ShowCustomPrayersSelectMenuEnum.remove:
              showCustomAlertDia(
                  context,
                  title: "Silmek istediğinize emin misiniz",
                  content: "'${prayer.name}' silindiğinde geri alınamaz",
                  btnApproved: () {
                    bloc.add(ShowCustomPrayersEventDelete(prayer: prayer));
                  });
              break;
            case ShowCustomPrayersSelectMenuEnum.edit:
              UpdateCustomPrayerRoute(prayerId: prayer.id ?? 0).push(context);
              break;
            case ShowCustomPrayersSelectMenuEnum.addToDhikr:
              bloc.add(ShowCustomPrayersEventAddDhikr(prayer: prayer));
              break;
            case ShowCustomPrayersSelectMenuEnum.goToDhikr:
              final counterId = prayer.counterId;
              if(counterId!=null){
                DetailCounterRoute(id: counterId).push(context);
              }
              break;
            case ShowCustomPrayersSelectMenuEnum.updateToDhikr:
              bloc.add(ShowCustomPrayersEventUpdateDhikr(prayer: prayer));
              break;
            case ShowCustomPrayersSelectMenuEnum.share:
              showCustomPrayerShareDia(context,
                prayer: prayer,
              );
              break;
          }
        }
    );
  }

  Widget getListeners({required Widget child}){
    return BlocListener<ShowCustomPrayersBloc,ShowCustomPrayersState>(
      listenWhen: (prevState, nextState){
        return prevState.message != nextState.message;
      },
      listener: (context, state){
        final message = state.message;
        if(message!=null){
          ToastUtils.showLongToast(message);
          context.read<ShowCustomPrayersBloc>()
              .add(ShowCustomPrayersEventClearMessage());
        }
      },
      child: child,
    );
  }
}