
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/share/dialogs/show_share_verse_content_dia.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/counters/data/mapper/counter_mapper.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/show_counter_select_menu.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/bloc/counter_show_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/bloc/counter_show_event.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/bloc/counter_show_state.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/show_counter_page.dart';
import 'package:hadith/core/utils/toast_utils.dart';

extension ShowCounterComponentsExt on ShowCounterPage{

  
  List<Widget> getActions(BuildContext context){
    return [
      _getViewIcon(context)
    ];
  }

  Widget _getViewIcon(BuildContext context){
    final bloc = context.read<CounterShowBloc>();
    return BlocSelector<CounterShowBloc,CounterShowState,bool>(
      selector: (state)=>state.showDetailContents,
      builder: (context, showDetailContents){
        if(showDetailContents){
          return IconButton(
            onPressed: (){
              bloc.add(CounterShowEventSetDetailView(showDetail: false));
            },
            icon: const Icon(Icons.table_rows),
            tooltip: "Liste olarak göster",
          );
        }
        return IconButton(
          onPressed: (){
            bloc.add(CounterShowEventSetDetailView(showDetail: true));
          },
          icon: const Icon(Icons.view_agenda),
          tooltip: "Detaylı göster",
        );
      },
    );
  }

  
  Widget getSubTitleWidget(BuildContext context, String title){
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }


  void handleBottomMenu(BuildContext context,Counter counter){
    final bloc = context.read<CounterShowBloc>();
    showBottomMenuItems(
        context,
        title: "'${counter.name}' adlı zikri için",
        items: ShowCounterSelectMenuEnum.getItems(counter),
        onItemClick: (menuItem){
          Navigator.pop(context);
          switch(menuItem){
            case ShowCounterSelectMenuEnum.remove:
              showCustomAlertDia(
                context,
                title: "Silmek istediğinize emin misiniz",
                content: "'${counter.name}' silindiğinde geri alınamaz",
                btnApproved: () {
                  bloc.add(CounterShowEventDelete(counter: counter));
                });
              break;
            case ShowCounterSelectMenuEnum.edit:
              ManageCounterRoute(counterId: counter.id ?? 0).push(context);
              break;
            case ShowCounterSelectMenuEnum.addToCustomPrayer:
              bloc.add(CounterShowEventAddToCustomPrayer(counter: counter));
              break;
            case ShowCounterSelectMenuEnum.goToCustomPrayer:
              final prayerId = counter.prayerId;
              if(prayerId != null){
                CustomPrayerDetailRoute(prayerId: prayerId).push(context); 
              }
              break;
            case ShowCounterSelectMenuEnum.share:
              showShareVerseContentDia(context,
                item: counter.toShareContent(),
                imageName: "${counter.name}_counter.png"
              );
              break;
          }
        }
    );
  }

  Widget getListeners({required Widget child}){
    return BlocListener<CounterShowBloc,CounterShowState>(
      listenWhen: (prevState, nextState){
        return prevState.message != nextState.message;
      },
      listener: (context, state){
        final message = state.message;
        if(message!=null){
          ToastUtils.showLongToast(message);
          context.read<CounterShowBloc>()
              .add(CounterShowEventClearMessage());
        }
      },
      child: child,
    );
  }

}