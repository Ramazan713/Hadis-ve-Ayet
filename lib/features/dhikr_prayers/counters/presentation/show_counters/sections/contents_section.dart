
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/bloc/counter_show_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/bloc/counter_show_state.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/components/counter_item.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/components/main_dhikrmatic_item.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/sections/components_section.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/show_counter_page.dart';


extension ShowCounterSectionsExt on ShowCounterPageState{

  Widget getDhikrmaticContent(int gridCount){
    return Padding(
        padding: const EdgeInsets.only(top: 3,bottom: 19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getSubTitleWidget("Zikir Türleri"),
            StaggeredGrid.count(
              crossAxisCount: gridCount,
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
          ],
        )
    );
  }

  Widget getDhikrListContent(int gridCount){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        getSubTitleWidget("Zikir Listesi"),
        BlocBuilder<CounterShowBloc, CounterShowState>(
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
            return AlignedGridView.count(
              crossAxisCount: gridCount,
              shrinkWrap: true,
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
                  onMenuClick: () {
                    handleBottomMenu(counter);
                  },
                );
              },
            );
          }
        )
      ],
    );
  }
}