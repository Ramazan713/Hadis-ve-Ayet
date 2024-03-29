
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_aligned_grid_view.dart';
import 'package:hadith/core/features/adaptive/presentation/select_adaptive_dropdown_menu.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/show_counter_select_menu.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/bloc/counter_show_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/bloc/counter_show_state.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/components/counter_item.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/components/main_dhikrmatic_item.dart';
import '../show_counter_page.dart';
import './components_section.dart';

extension ShowCounterSectionsExt on ShowCounterPageState{

  Widget getDhikrmaticContent(){
    return Padding(
        padding: const EdgeInsets.only(top: 3,bottom: 19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            getSubTitleWidget("Zikir Türleri"),
            Flexible(
              child: StaggeredGrid.extent(
                maxCrossAxisExtent: 500,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  MainDhikrmaticItem(
                    title: "Zikirmatik (Klasik)",
                    onClick: () {
                      DetailCounterEmptyRoute(counterTypeId: CounterType.classic.typeId).push(context);
                    },
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
          ],
        )
    );
  }

  Widget getDhikrListContent(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        getSubTitleWidget("Zikir Listesi"),
        Flexible(
          child: BlocBuilder<CounterShowBloc, CounterShowState>(
            builder: (context, state) {
              final counters = state.counters;
              if (counters.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: SharedEmptyResult(
                    content: "Eklenmiş zikir bulunmamaktadır",
                  )
                );
              }
              return LazyAlignedGridView(
                maxCrossAxisExtent: 700,
                shrinkWrap: true,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                padding: K.defaultLazyListPadding,
                controller: ScrollController(),
                itemCount: counters.length,
                itemBuilder: (context, index) {
                  final counter = counters[index];
                  return CounterItem(
                    item: counter,
                    showDetail: state.showDetailContents,
                    onClick: () {
                      DetailCounterRoute(id: counter.id??0).push(context);
                    },
                    trailing: SelectAdaptiveDropdownMenu(
                      items: ShowCounterSelectMenuEnum.getItems(counter),
                      title: "'${counter.name}' adlı zikri için",
                      popWhenItemSelect: true,
                      onItemClick: (selected, type){
                        handleMenuItem(menuItem: selected, counter: counter);
                      },
                    ),
                  );
                },
              );
            }
          ),
        )
      ],
    );
  }
}