
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/features/adaptive/domain/enums/adaptive_base_dialog_sheet_enum.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_padding.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_aligned_grid_view.dart';
import 'package:hadith/core/features/adaptive/presentation/select_adaptive_dropdown_menu.dart';
import 'package:hadith/core/features/adaptive/presentation/select_adaptive_menu_items.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_config/select_quran_section_config.dart';
import 'package:hadith/core/features/select_quran_section/presentation/show_select_quran_section_dia.dart';
import 'package:hadith/core/presentation/components/animated/custom_visibility_with_scrolling.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/domain/enums/custom_prayer_add_action_enum.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/domain/enums/show_custom_prayers_select_menu.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_event.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_state.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/components/custom_prayer_item.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
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
          child: AdaptivePadding(
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
                  child: getListContent(context),
                );
              },
            ),
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
          shrinkWrap: true,
          itemCount: items.length,
          padding: K.defaultLazyListPadding,
          maxCrossAxisExtent: 600,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemBuilder: (context, index) {
            final prayer = items[index];
            return CustomPrayerItem(
              item: prayer,
              showDetail: state.showDetailContents,
              onClick: () {
                CustomPrayerDetailRoute(prayerId: prayer.id ?? 0).push(context);
              },
              trailing: SelectAdaptiveDropdownMenu(
                title: "'${prayer.name}' adlı item için",
                items: ShowCustomPrayersSelectMenuEnum.getItems(prayer),
                onItemClick: (selected, type){
                  handleMenuItem(menuItem: selected,prayer: prayer);
                },
                popWhenItemSelect: true,
              ),
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
          selectAdaptiveMenuItems(
              context,
              title: "Ekleme Yöntemleri",
              items: CustomPrayerAddActionMenuEnum.values,
              onItemClick: (menuItem){
                Navigator.pop(context);
                switch(menuItem){
                  case CustomPrayerAddActionMenuEnum.addFromQuran:
                    showSelectQuranSectionDia(
                      context: context,
                      baseType: AdaptiveBaseDialogSheetEnum.adaptiveDialogSheet,
                      config: const SelectQuranSectionConfig(
                        title: "Kurandan Ekle",
                        btnName: "Oluştur",
                        showSelectPage: false,
                        includeSelectedVerses: true
                      ),
                      onSubmit: (data){
                        bloc.add(ShowCustomPrayersEventAddPrayerFromQuran(data: data));
                      }
                    );
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
