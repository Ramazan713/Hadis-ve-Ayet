
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_aligned_grid_view.dart';
import 'package:hadith/core/presentation/components/animated/custom_visibility_with_scrolling.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/selections/show_bottom_menu_items.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/domain/enums/custom_prayer_add_action_enum.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/create_quran_prayer/show_create_quran_prayer_dia.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_event.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_state.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/components/custom_prayer_item.dart';
import 'package:hadith/features/dhikr_prayers/shared/presentation/select_dhikr/show_select_dhikr_dia.dart';
import './sections/components_section.dart';
import './sections/top_bar_section.dart';

class ShowCustomPrayersPage extends StatefulWidget {
  const ShowCustomPrayersPage({Key? key}) : super(key: key);

  @override
  State<ShowCustomPrayersPage> createState() => ShowCustomPrayersPageState();
}

class ShowCustomPrayersPageState extends State<ShowCustomPrayersPage> {

  final CustomScrollController scrollController = CustomScrollController();
  final TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final bloc = context.read<ShowCustomPrayersBloc>();
    bloc.add(ShowCustomPrayersEventLoadData());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShowCustomPrayersBloc>();
    return getListeners(
      child: Scaffold(
        body: SafeArea(
          child: BlocSelector<ShowCustomPrayersBloc, ShowCustomPrayersState,bool>(
            selector: (state) => state.isSearchBarVisible,
            builder: (context, isSearchBarVisible){
              return DefaultNestedSearchableAppBar(
                textEditingController: searchTextController,
                pinned: true,
                actions: getActions(),
                appBarType: AppBarType.mediumBar,
                scrollController: scrollController,
                title: const Text("Eklediğim Dua ve Ayetler",overflow: TextOverflow.ellipsis,),
                onTextChanged: (newText){
                  bloc.add(ShowCustomPrayersEventSetQuery(query: newText));
                },
                searchBarVisible: isSearchBarVisible,
                onSearchVisibilityChanged: (changedSearchBarVisible){
                  bloc.add(ShowCustomPrayersEventSetSearchBarVisibility(isVisible: changedSearchBarVisible));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: getListContent(context),
                ),
              );
            },
          )
        ),
          floatingActionButton: getFab(context)
      )
    );
  }


  Widget getListContent(BuildContext context){
    return BlocBuilder<ShowCustomPrayersBloc, ShowCustomPrayersState>(
      builder: (context, state) {
        final items = state.items;
        if(state.isLoading){
          return const SharedLoadingIndicator();
        }
        if (items.isEmpty) {
          return const SharedEmptyResult();
        }
        return LazyAlignedGridView(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          shrinkWrap: true,
          itemCount: items.length,
          maxCrossAxisExtent: 600,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemBuilder: (context, index) {
            final item = items[index];
            return CustomPrayerItem(
              item: item,
              showDetail: state.showDetailContents,
              onClick: () {
                CustomPrayerDetailRoute(prayerId: item.id ?? 0).push(context);
              },
              onMenuClick: () {
                handleBottomMenu(item);
              },
            );
          },
        );
      }
    );
  }

  Widget getFab(BuildContext context){
    final bloc = context.read<ShowCustomPrayersBloc>();
    return CustomVisibilityWithScrolling(
      controller: scrollController.controller,
      child: FloatingActionButton(
        onPressed: (){
          showBottomMenuItems(
              context,
              title: "Ekleme Yöntemleri",
              items: CustomPrayerAddActionMenuEnum.values,
              onItemClick: (menuItem){
                Navigator.pop(context);
                switch(menuItem){
                  case CustomPrayerAddActionMenuEnum.addFromQuran:
                    showCreateQuranPrayerDia(context);
                    break;
                  case CustomPrayerAddActionMenuEnum.addFromManuel:
                    AddCustomPrayerRoute().push(context);
                    break;
                  case CustomPrayerAddActionMenuEnum.addFromList:
                    showSelectDhikrDia(context, onSelected: (selectedDhikr){
                      bloc.add(ShowCustomPrayersEventAddFromDhikr(prayer: selectedDhikr));
                    });
                    break;
                }
              }
          );
        },
        child: const Icon(Icons.add),
      )
    );
  }

  @override
  void dispose() {
    searchTextController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
