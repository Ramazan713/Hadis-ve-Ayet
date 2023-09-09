
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/presentation/components/animated/custom_visibility_with_scrolling.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/bloc/show_custom_prayers_event.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/sections/components_section.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/show_custom_prayers/sections/top_bar_section.dart';

import 'bloc/show_custom_prayers_bloc.dart';
import 'bloc/show_custom_prayers_state.dart';
import 'components/custom_prayer_item.dart';

class ShowCustomPrayersPage extends StatelessWidget {
  ShowCustomPrayersPage({Key? key}) : super(key: key);

  final CustomScrollController _scrollController = CustomScrollController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShowCustomPrayersBloc>();
    bloc.add(ShowCustomPrayersEventLoadData());

    return getListeners(
      child: AdaptiveLayout(
        body: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.small: SlotLayout.from(
              key: const Key('ShowPrayers Body Small'),
              builder: (_){
                return getPageContent(context,1);
              },
            ),
            Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('ShowPrayers Body Medium'),
                builder: (_){
                  return getPageContent(context, 2);
                }
            )
          },
        ),
      ),
    );
  }

  Widget getPageContent(BuildContext context, int gridCount){
    final bloc = context.read<ShowCustomPrayersBloc>();
    return Scaffold(
        body: SafeArea(
          child: BlocSelector<ShowCustomPrayersBloc, ShowCustomPrayersState,bool>(
            selector: (state) => state.isSearchBarVisible,
            builder: (context, isSearchBarVisible){
              return CustomNestedSearchableAppBar(
                key: null,
                pinned: true,
                actions: getActions(context),
                appBarType: AppBarType.mediumBar,
                scrollController: _scrollController,
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
                  child: getListContent(context,gridCount),
                ),
              );
            },
          )
        ),
        floatingActionButton: getFab(context)
    );
  }

  Widget getListContent(BuildContext context, int gridCount){
    return BlocBuilder<ShowCustomPrayersBloc, ShowCustomPrayersState>(
      builder: (context, state) {
        final items = state.items;
        if(state.isLoading){
          return const SharedLoadingIndicator();
        }
        if (items.isEmpty) {
          return const SharedEmptyResult();
        }
        return SingleChildScrollView(
          child: AlignedGridView.count(
            crossAxisCount: gridCount,
            shrinkWrap: true,
            controller: ScrollController(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return CustomPrayerItem(
                item: item,
                showDetail: state.showDetailContents,
                onClick: () {
                  CustomPrayerDetailRoute(prayerId: item.id ?? 0).push(context);
                },
                onMenuClick: () {
                  handleBottomMenu(context,item);
                },
              );
            },
          ),
        );
      }
    );
  }

  Widget getFab(BuildContext context){
    return CustomVisibilityWithScrolling(
      controller: _scrollController.controller,
      child: FloatingActionButton(
        onPressed: (){
          AddCustomPrayerRoute().push(context);
        },
        child: const Icon(Icons.add),
      )
    );
  }

}
