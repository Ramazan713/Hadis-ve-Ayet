
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/components/animated/custom_visibility_with_scrolling.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/features/app/ads/ad_check_widget.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/show_counter_add_action_enum.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_ready_counter/show_add_counter_dia.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/bloc/counter_show_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/bloc/counter_show_event.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/sections/components_section.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/show_counters/sections/contents_section.dart';

class ShowCounterPage extends StatefulWidget {

  const ShowCounterPage({Key? key}) : super(key: key);

  @override
  State<ShowCounterPage> createState() => _ShowCounterPageState();
}

class _ShowCounterPageState extends State<ShowCounterPage> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<CounterShowBloc>().add(CounterShowEventLoadData());
  }

  @override
  Widget build(BuildContext context) {

    return AdaptiveLayout(
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('ShowCounter Body Small'),
            builder: (_){
              return getPageContent(context,1);
            },
          ),
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('ShowCounter Body Medium'),
            builder: (_){
              return getPageContent(context, 2);
            }
          )
        },
      ),
    );
  }

  Widget getPageContent(BuildContext context, int gridCount){
    return widget.getListeners(
      child: Scaffold(
        body: SafeArea(
          child: CustomNestedViewAppBar(
            floating: true,
            snap: true,
            actions: widget.getActions(context),
            scrollController: CustomScrollController(
              controller: scrollController
            ),
            title: const Text("Sayaç"),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                child: Column(
                  children: [
                    widget.getDhikrmaticContent(context, gridCount),
                    widget.getDhikrListContent(context, gridCount)
                  ],
                ),
              ),
            ),
          )
        ),
        floatingActionButton: getFab(context)
      ),
    );
  }



  Widget getFab(BuildContext context){
    return CustomVisibilityWithScrolling(
      controller: scrollController,
      child: FloatingActionButton(
        onPressed: () {
          showBottomMenuItems(
            context,
            title: "Ekleme Yöntemleri",
            items: ShowCounterAddActionMenuEnum.values,
            onItemClick: (menuItem){
              Navigator.pop(context);
              switch(menuItem){
                case ShowCounterAddActionMenuEnum.addFromManuel:
                  AddNewCounterRoute().push(context);
                  break;
                case ShowCounterAddActionMenuEnum.addFromList:
                  showAddCounterDia(context);
                  break;
              }
            }
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}


