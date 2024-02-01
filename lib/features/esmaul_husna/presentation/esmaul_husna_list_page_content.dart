import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_aligned_grid_view.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/navigate_to_icon_auto.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/selections/dropdown_icon_menu.dart';
import 'package:hadith/features/esmaul_husna/domain/enums/show_esmaul_husna_top_bar_menu_item.dart';
import 'package:hadith/features/esmaul_husna/domain/models/esmaul_husna.dart';
import 'package:hadith/features/esmaul_husna/presentation/bloc/show_esmaul_husna_bloc.dart';
import 'package:hadith/features/esmaul_husna/presentation/bloc/show_esmaul_husna_event.dart';
import 'package:hadith/features/esmaul_husna/presentation/bloc/show_esmaul_husna_state.dart';
import 'package:hadith/features/esmaul_husna/presentation/components/esmaul_husna_item.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class EsmaulHusnaListPageContent extends StatelessWidget{
  final TextEditingController searchTextController;
  final CustomAutoScrollController customAutoScrollController;
  final void Function(int index) onIndexItemClick;
  final void Function(EsmaulHusna item) onShareClick;

  const EsmaulHusnaListPageContent({
    super.key,
    required this.searchTextController,
    required this.onIndexItemClick,
    required this.customAutoScrollController,
    required this.onShareClick
  });


  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShowEsmaulHusnaBloc>();

    return BlocSelector<ShowEsmaulHusnaBloc,ShowEsmaulHusnaState, bool>(
      selector: (state) => state.isSearchBarVisible,
      builder: (context, isSearchBarVisible){
        return DefaultNestedSearchableAppBar(
          textEditingController: searchTextController,
          onSearchVisibilityChanged: (isSearchVisible){
            bloc.add(ShowEsmaulHusnaEventSetSearchBarVisibility(isVisible: isSearchVisible));
          },
          scrollController: CustomScrollController(),
          contentScrollController: customAutoScrollController,
          searchBarVisible: isSearchBarVisible,
          onTextChanged: (text){
            bloc.add(ShowEsmaulHusnaEventSetQuery(query: text));
          },
          title: const Text("Esmaul Husna"),
          actions: getActions(context),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ShowEsmaulHusnaBloc,ShowEsmaulHusnaState>(
                  builder: (context, state){
                    if(state.isLoading){
                      return const SharedLoadingIndicator();
                    }
                    final items = state.items;

                    if(items.isEmpty){
                      return const SharedEmptyResult(
                        content: "herhangi bir sonuç bulunamadı",
                      );
                    }

                    return LazyAlignedGridView(
                      maxCrossAxisExtent: 600,
                      controller: customAutoScrollController.controller,
                      itemCount: items.length,
                      itemBuilder: (context, index){
                        final item = items[index];
                        return AutoScrollTag(
                          index: index,
                          key: ValueKey("${item.id}$index"),
                          controller: customAutoScrollController.controller,
                          child: EsmaulHusnaItem(
                            isSelected: state.selectedItem == item,
                            fontModel: state.fontModel,
                            esmaulHusna: item,
                            onClick: () async{
                              bloc.add(ShowEsmaulHusnaEventShowDetail(item: item));
                              onIndexItemClick(index);
                            },
                            onShareClick: (){
                              onShareClick(item);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List<Widget> getActions(BuildContext context){
    return [
      NavigateToIconAuto(
        autoScrollController: customAutoScrollController,
        onPosChanged: (selectedIndex){
          customAutoScrollController.scrollToIndex(selectedIndex, preferPosition: AutoScrollPosition.begin);
        },
      ),
      _topBarDropDownMenu(context)
    ];
  }

  Widget _topBarDropDownMenu(BuildContext context){
    return CustomDropdownIconMenu(
      items: ShowEsmaulHusnaTopBarMenuItem.values,
      onSelected: (menuItem){
        switch(menuItem){
          case ShowEsmaulHusnaTopBarMenuItem.fontSize:
            showSelectFontSizeDia(context);
            break;
        }
      },
    );
  }
}
