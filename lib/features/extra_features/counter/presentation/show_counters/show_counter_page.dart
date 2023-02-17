import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/dialogs/show_bottom_select_menu_items_enum.dart';
import 'package:hadith/dialogs/show_custom_alert_bottom_dia.dart';
import 'package:hadith/features/app/ads/ad_check_widget.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/counter_detail_page.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/model/counter_detail_param.dart';
import 'package:hadith/features/extra_features/counter/presentation/show_counters/bloc/counter_show_bloc.dart';
import 'package:hadith/features/extra_features/counter/presentation/show_counters/bloc/counter_show_event.dart';
import 'package:hadith/features/extra_features/counter/presentation/show_counters/bloc/counter_show_state.dart';
import 'package:hadith/features/extra_features/counter/presentation/show_counters/components/counter_item.dart';
import 'package:hadith/features/extra_features/counter/presentation/show_counters/components/main_dhikrmatic_item.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_nested_scrollview.dart';
import 'package:hadith/widgets/menu_item_tile.dart';

import '../../domain/counter_type.dart';
import '../add_counter/add_counter_page.dart';
import '../manage_counter/manage_counter_page.dart';
import 'constant/counter_select_menu.dart';

class ShowCounterPage extends StatelessWidget {
  static const id = "ShowCounterPage";

  ShowCounterPage({Key? key}) : super(key: key);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final counterBloc = context.read<CounterShowBloc>();

    return AdCheckWidget(
      child: Scaffold(
        body: SafeArea(
          child: CustomSliverNestedView(context,
              isBottomNavAffected: false,
              scrollController: scrollController, headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const CustomSliverAppBar(
                title: Text("Sayaç"),
              )
            ];
          },
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
                              Navigator.pushNamed(context, CounterDetailPage.id,
                                  arguments: CounterDetailParam(
                                      type: CounterType.classic));
                            },
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          MainDhikrmaticItem(
                            title: "Zikirmatik (${CounterType.unlimited.description})",
                            onClick: () {
                              Navigator.pushNamed(context, CounterDetailPage.id,
                                  arguments: CounterDetailParam(
                                      type: CounterType.unlimited));
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
                    BlocSelector<CounterShowBloc, CounterShowState,
                            List<Counter>>(
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
                                  Navigator.pushNamed(
                                      context, CounterDetailPage.id,
                                      arguments: CounterDetailParam(
                                          type: counter.counterType,
                                          counter: counter));
                                },
                                onMenuClick: () {
                                  showSelectMenuItemDia(context,
                                      items:
                                          CounterSelectMenuEnum.values.map((e) {
                                        return IconTextItem(
                                          iconData: e.iconData,
                                          title: e.label,
                                          onTap: () {
                                            switch (e) {
                                              case CounterSelectMenuEnum.edit:
                                                Navigator.pop(context);
                                                Navigator.pushNamed(context,
                                                    ManageCounterPage.id,
                                                    arguments: counter);
                                                break;
                                              case CounterSelectMenuEnum.remove:
                                                Navigator.pop(context);
                                                showCustomAlertBottomDia(
                                                    context,
                                                    title:
                                                        "Silmek istediğinize emin misiniz",
                                                    content:
                                                        "'${counter.name}' silindiğinde geri alınamaz",
                                                    btnApproved: () {
                                                  counterBloc.add(
                                                      CounterShowEventDelete(
                                                          counter: counter));
                                                });
                                                break;
                                            }
                                          },
                                        );
                                      }).toList(),
                                      title:
                                          "'${counter.name}' adlı zikri için");
                                },
                              );
                            },
                          );
                        })
                  ],
                ),
              )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddCounterPage.id);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
