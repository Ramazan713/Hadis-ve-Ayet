import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_aligned_grid_view.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_staggered_grid_view.dart';
import 'package:hadith/core/features/adaptive/presentation/select_adaptive_dropdown_menu.dart';
import 'package:hadith/core/presentation/components/animated/custom_visibility_with_scrolling.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/dialogs/show_edit_text_dia.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/lists/domain/show_list_menu_enum.dart';
import 'package:hadith/features/lists/presentation/shared/components/list_item.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_bloc.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_event.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_state.dart';
import './sections/top_bar_section.dart';
import './sections/handle_bottom_menu_section.dart';
import './sections/components_section.dart';

class ShowListPage extends StatefulWidget {
  const ShowListPage({Key? key}) : super(key: key);

  @override
  State<ShowListPage> createState() => ShowListPageState();
}

class ShowListPageState extends State<ShowListPage> with TickerProviderStateMixin {

  final scrollController = ScrollController();
  final searchTextController = TextEditingController();
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    final initIndex = context.read<ShowListBloc>().state.currentTab.index;
    tabController = TabController(length: 2, vsync: this,initialIndex: initIndex);
    tabController.addListener(listenTabChanges);
  }

  @override
  Widget build(BuildContext context) {
    final listBloc = context.read<ShowListBloc>();

    return getListeners(
      child: BlocSelector<ShowListBloc, ShowListState,bool>(
        selector: (state)=> state.searchBarVisible,
        builder: (context, searchBarVisible) {
          return Scaffold(
            floatingActionButton: getFab(context),
            body: SafeArea(
              child: DefaultNestedSearchableAppBar(
                textEditingController: searchTextController,
                pinned: true,
                snap: true,
                floating: true,
                searchBarVisible: searchBarVisible,
                scrollController: CustomScrollController(
                    controller: scrollController
                ),
                onTextChanged: (newText){
                  listBloc.add(ShowListEventSearch(query: newText));
                },
                onSearchVisibilityChanged: (newSearchBarVisible){
                  listBloc.add(ShowListEventSetVisibilitySearchBar(searchBarVisible: newSearchBarVisible));
                },
                actions: getActions(),
                title: const Text("Listeler"),
                appBarBottom: getTopTabBar(),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    BlocSelector<ShowListBloc,ShowListState,List<ListViewModel>>(
                      selector: (state)=>state.listHadiths,
                      builder: (context,listHadiths){
                        return getListItems(
                            items: listHadiths,
                            sourceType: SourceTypeEnum.hadith,
                            useSecondary: true
                        );
                      },
                    ),
                    BlocSelector<ShowListBloc,ShowListState,List<ListViewModel>>(
                      selector: (state)=>state.listVerses,
                      builder: (context,listVerses){
                        return getListItems(
                          items: listVerses,
                          sourceType: SourceTypeEnum.verse,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget getListItems({
    required List<ListViewModel>items,
    required SourceTypeEnum sourceType,
    bool useSecondary = false
  }){

    if(items.isEmpty){
      return const SharedEmptyResult();
    }

    return LazyAlignedGridView(
      itemCount: items.length,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      itemBuilder: (BuildContext context, int index) {
        var item = items[index];

        return SharedListItem(
          subTitleTag: sourceType.shortName,
          listViewModel: item,
          useSecondary: useSecondary,
          leading: sourceType.getListIcon(context, item.isRemovable),
          trailing: SelectAdaptiveDropdownMenu(
            icon: const Icon(Icons.more_vert,size: 30,),
            popWhenItemSelect: true,
            items: ShowListMenuEnum.getMenuItems(item.isRemovable),
              title: "'${item.name}' listesi için",
              onItemClick: (selected, type){
                manageBottomMenuItem(
                    item: item,
                    menuItem: selected,
                    sourceType: sourceType,
                );
              },
          ),
          onClick: (){
            switch(sourceType){
              case SourceTypeEnum.hadith:
                HadithListRoute(
                  listId: item.id,
                  sourceId: item.sourceType.sourceId,
                ).push(context);
                break;
              case SourceTypeEnum.verse:
                VerseShowListRoute(
                    listId: item.id,
                    sourceId: item.sourceType.sourceId
                ).push(context);
                break;
            }
          },
        );
      },
    );
  }


  Widget getFab(BuildContext context){
    final bloc = context.read<ShowListBloc>();
    return CustomVisibilityWithScrolling(
      controller: scrollController,
      child: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          showEditTextDia(context, (text) {
            bloc.add(ShowListEventAddNewList(listName: text));
          },title: "Başlık Girin");
        },
      )
    );
  }

  void listenTabChanges(){
    if(!tabController.indexIsChanging){
      context.read<ShowListBloc>()
          .add(ShowListEventChangeTab(index: tabController.index));
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchTextController.dispose();
    tabController.removeListener(listenTabChanges);
    tabController.dispose();
    super.dispose();
  }
}
