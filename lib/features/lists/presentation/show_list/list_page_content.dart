import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_aligned_grid_view.dart';
import 'package:hadith/core/features/adaptive/presentation/select_adaptive_dropdown_menu.dart';
import 'package:hadith/core/presentation/components/animated/custom_visibility_with_content_scrolling.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/core/presentation/dialogs/show_edit_text_dia.dart';
import 'package:hadith/core/utils/toast_utils.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/lists/domain/list_tab_enum.dart';
import 'package:hadith/features/lists/domain/show_list_menu_enum.dart';
import 'package:hadith/features/lists/presentation/shared/components/list_item.dart';
import 'package:hadith/features/lists/presentation/shared/export_list_view.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_bloc.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_event.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_state.dart';
import 'package:scroll_to_index/scroll_to_index.dart';


class ListPageContent extends StatelessWidget {
  final CustomScrollController scrollController;
  final TextEditingController searchTextController;
  final TabController tabController;
  final void Function(ListViewModel) onClickItem;
  final bool isSinglePane;
  final CustomAutoScrollController contentScrollController;

  const ListPageContent({
    super.key,
    required this.onClickItem,
    required this.tabController,
    required this.scrollController,
    required this.searchTextController,
    required this.isSinglePane,
    required this.contentScrollController
  });

  @override
  Widget build(BuildContext context) {
    final listBloc = context.read<ShowListBloc>();

    return Scaffold(
      floatingActionButton: getFab(context),
      body: SafeArea(
        child: getListeners(
          child: BlocSelector<ShowListBloc, ShowListState,bool>(
            selector: (state)=> state.searchBarVisible,
            builder: (context, searchBarVisible) {
              return DefaultNestedSearchableAppBar(
                textEditingController: searchTextController,
                pinned: true,
                snap: true,
                floating: true,
                searchBarVisible: searchBarVisible,
                scrollController: scrollController,
                contentScrollController: contentScrollController,
                onTextChanged: (newText){
                  listBloc.add(ShowListEventSearch(query: newText));
                },
                onSearchVisibilityChanged: (newSearchBarVisible){
                  listBloc.add(ShowListEventSetVisibilitySearchBar(searchBarVisible: newSearchBarVisible));
                },
                actions: getActions(context),
                title: const Text("Listeler"),
                appBarBottom: getTopTabBar(),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    BlocBuilder<ShowListBloc,ShowListState>(
                      buildWhen: (prevState,nextState){
                        return prevState.listHadiths != nextState.listHadiths ||
                          prevState.currentSelectedHadithItem?.id != nextState.currentSelectedHadithItem?.id ||
                          prevState.isHadithLoading != nextState.isHadithLoading;
                      },
                      builder: (context,state){
                        return getListItems(
                          items: state.listHadiths,
                          sourceType: SourceTypeEnum.hadith,
                          useSecondary: true,
                          selectedItem: state.currentSelectedHadithItem,
                          isLoading: state.isHadithLoading
                        );
                      },
                    ),
                    BlocBuilder<ShowListBloc,ShowListState>(
                      buildWhen: (prevState,nextState){
                        return prevState.listVerses != nextState.listVerses ||
                            prevState.currentSelectedVerseItem?.id != nextState.currentSelectedVerseItem?.id ||
                            prevState.isVerseLoading != nextState.isVerseLoading;
                      },
                      builder: (context,state){
                        return getListItems(
                          items: state.listVerses,
                          sourceType: SourceTypeEnum.verse,
                          useSecondary: false,
                          selectedItem: state.currentSelectedVerseItem,
                          isLoading: state.isVerseLoading
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }





  Widget getListItems({
    required List<ListViewModel>items,
    required SourceTypeEnum sourceType,
    required bool isLoading,
    bool useSecondary = false,
    ListViewModel? selectedItem
  }){

    if(isLoading){
      return const SharedLoadingIndicator();
    }

    if(items.isEmpty){
      return const SharedEmptyResult();
    }
    return LazyAlignedGridView(
      itemCount: items.length,
      padding: K.defaultLazyListPadding,
      controller: contentScrollController.controller,
      itemBuilder: (BuildContext context, int index) {
        var item = items[index];
        return AutoScrollTag(
          controller: contentScrollController.controller,
          index: index,
          key: ValueKey(item.id),
          child: SharedListItem(
            subTitleTag: sourceType.shortName,
            listViewModel: item,
            isSelected: selectedItem?.id == item.id && !isSinglePane,
            useSecondary: useSecondary,
            leading: sourceType.getListIcon(context, item.isRemovable),
            trailing: SelectAdaptiveDropdownMenu(
              icon: const Icon(Icons.more_vert,size: 30,),
              popWhenItemSelect: true,
              items: ShowListMenuEnum.getMenuItems(item.isRemovable),
              title: "'${item.name}' listesi için",
              onItemClick: (selected, type){
                manageBottomMenuItem(
                  context: context,
                  item: item,
                  menuItem: selected,
                  sourceType: sourceType,
                );
              },
            ),
            onClick: (){
              onClickItem(item);
            },
          ),
        );
      },
    );
  }


  Widget getFab(BuildContext context){
    final bloc = context.read<ShowListBloc>();
    return CustomVisibilityWithContentScrolling(
        controller: contentScrollController,
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
}



extension ShowListComponentsSectionExt on ListPageContent{


  Widget getListeners({required Widget child}){
    return BlocListener<ShowListBloc, ShowListState>(
      listener: (context,state){
        final message = state.message;
        if(message != null){
          ToastUtils.showLongToast(message);
          context.read<ShowListBloc>()
              .add(ShowListEventClearMessage());
        }
      },
      child: child,
    );
  }


}

extension HandleBottomMenuExt on ListPageContent{

  void manageBottomMenuItem({
    required BuildContext context,
    required ShowListMenuEnum menuItem,
    required SourceTypeEnum sourceType,
    required ListViewModel item
  }){
    switch(menuItem){
      case ShowListMenuEnum.rename:
        _rename(context, item);
        break;
      case ShowListMenuEnum.remove:
        _remove(context, item);
        break;
      case ShowListMenuEnum.archive:
        _archive(context, item);
        break;
      case ShowListMenuEnum.removeItems:
        _removeItems(context, item, sourceType);
        break;
      case ShowListMenuEnum.newCopy:
        _copy(context, item);
        break;
      case ShowListMenuEnum.exportAs:
        exportListViewModel(context, item);
        break;
    }
  }

  void _rename(BuildContext context, ListViewModel item){
    final bloc = context.read<ShowListBloc>();
    showEditTextDia(context, (newText) {
      bloc.add(ShowListEventRename(listViewModel: item, newTitle: newText));
    }, title: "Yeniden İsimlendir", content: item.name,useRootNavigator: true);
  }

  void _remove(BuildContext context, ListViewModel item){
    final bloc = context.read<ShowListBloc>();
    showCustomAlertDia(
        context,
        useRootNavigator: true,
        title: "Silmek istediğinize emin misiniz?",
        content: "Bu işlem geri alınamaz",
        btnApproved: () {
          bloc.add(ShowListEventRemove(listViewModel: item));
        }
    );
  }

  void _archive(BuildContext context, ListViewModel item){
    final bloc = context.read<ShowListBloc>();
    showCustomAlertDia(
        context,
        title: "Arşivlemek istediğinize emin misiniz?",
        useRootNavigator: true,
        content: "Arşivlenen listeler yalnızca arşiv kısmında kullanılabilir",
        btnApproved: () {
          bloc.add(ShowListEventArchive(listViewModel: item));
        });
  }

  void _removeItems(BuildContext context, ListViewModel item, SourceTypeEnum sourceType){
    final key= sourceType==SourceTypeEnum.hadith?"hadisleri":"ayetleri";
    final bloc = context.read<ShowListBloc>();
    showCustomAlertDia(
        context,
        title: "Listedeki $key silmek istediğinize emin misiniz?",
        content: "Bu işlem geri alınamaz",
        useRootNavigator: true,
        btnApproved: (){
          bloc.add(ShowListEventRemoveItems(listViewModel: item));
        });
  }

  void _copy(BuildContext context, ListViewModel item){
    final bloc = context.read<ShowListBloc>();
    showCustomAlertDia(context,useRootNavigator: true,
        title: "Yeni bir kopya oluştumak istediğinize emin misiniz",
        btnApproved: () {
          bloc.add(ShowListEventCopy(listViewModel: item));
        });
  }
}

extension ShowListTopBarExt on ListPageContent{


  List<Widget> getActions(BuildContext context){
    return [
      IconButton(
        onPressed: () {
          ArchiveListRoute().push(context);
        },
        icon: const Icon(Icons.archive),
        tooltip: "Arşiv",
      ),
      IconButton(
        onPressed: () {
          SettingsRoute().push(context);
        },
        icon: const Icon(Icons.settings),
        tooltip: "Ayarlar",
      )
    ];
  }

  TabBar getTopTabBar(){
    return TabBar(
      controller: tabController,
      tabs: [
        Tab(
          text: ListTabEnum.hadith.sourceType.shortName,
        ),
        Tab(
          text: ListTabEnum.verse.sourceType.shortName,
        ),
      ],
    );
  }
}