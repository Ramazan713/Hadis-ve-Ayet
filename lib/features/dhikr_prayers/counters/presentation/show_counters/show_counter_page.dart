import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/features/app/ads/ad_check_widget.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/show_counter_select_menu.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/detail_counter_empty_page.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/bloc/counter_show_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/bloc/counter_show_event.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/bloc/counter_show_state.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/components/counter_item.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/components/main_dhikrmatic_item.dart';

class ShowCounterPage extends StatelessWidget {

  ShowCounterPage({Key? key}) : super(key: key);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    return AdCheckWidget(
      child: Scaffold(
        body: SafeArea(
          child: CustomNestedViewAppBar(
            title: Text("Sayaç"),
            child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 29),
                        child: Column(
                          children: [
                            MainDhikrmaticItem(
                              title: "Zikirmatik (Klasik)",
                              onClick: () {
                                DetailCounterEmptyRoute(counterTypeId: CounterType.classic.typeId).push(context);
                              },
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            MainDhikrmaticItem(
                              title: "Zikirmatik (${CounterType.unlimited.title})",
                              onClick: () {
                                DetailCounterEmptyRoute(counterTypeId: CounterType.unlimited.typeId).push(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 5),
                        child: Text(
                          "Zikir Listesi",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      BlocSelector<CounterShowBloc, CounterShowState,List<Counter>>(
                          selector: (state) => state.counters,
                          builder: (context, counters) {
                            if (counters.isEmpty) {
                              return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 30),
                                  child: Center(
                                    child: Text("Eklenmiş zikir bulunmamaktadır"),
                                  ));
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              clipBehavior: Clip.hardEdge,
                              controller: scrollController,
                              itemCount: counters.length,
                              itemBuilder: (context, index) {
                                final counter = counters[index];
                                return CounterItem(
                                  counter: counter,
                                  onClick: () {
                                    DetailCounterRoute(id: counter.id??0).push(context);
                                  },
                                  onMenuClick: () {
                                    _handleBottomMenu(context,counter);
                                  },
                                );
                              },
                            );
                          })
                    ],
                  ),
                ),
          )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AddCounterRoute().push(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }


  void _handleBottomMenu(BuildContext context,Counter counter){

    showBottomMenuItems(
        context,
        title: "'${counter.name}' adlı zikri için",
        items: ShowCounterSelectMenuEnum.values,
        onItemClick: (menuItem){
          Navigator.pop(context);
          switch(menuItem){
            case ShowCounterSelectMenuEnum.remove:
              showCustomAlertDia(
                  context,
                  title: "Silmek istediğinize emin misiniz",
                  content: "'${counter.name}' silindiğinde geri alınamaz",
                  btnApproved: () {
                   context.read<CounterShowBloc>()
                      .add(CounterShowEventDelete(counter: counter));
                  });
              break;
            case ShowCounterSelectMenuEnum.edit:
              ManageCounterRoute(counterId: counter.id ?? 0).push(context);
              break;
          }
        }
    );
  }

}
