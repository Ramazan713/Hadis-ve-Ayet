import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/features/adaptive/presentation/list_detail_adaptive_layout_with_controller.dart';
import 'package:hadith/core/features/ads/ad_check_widget.dart';
import 'package:hadith/core/features/pagination/domain/models/paging_config.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/core/features/save_point/domain/enums/list_book_scope.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/verse_audio/domain/model/select_audio_option.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_list_paging_repo.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_detail_page_content.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_bloc.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_event.dart';
import 'package:hadith/features/lists/presentation/show_list/bloc/show_list_state.dart';
import 'package:hadith/features/lists/presentation/show_list/list_page_content.dart';
import 'package:hadith/features/verses/show_verse/data/repo/verse_list_paging_repo.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/verse_shared_detail_page_content.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ShowListPage extends StatefulWidget {
  const ShowListPage({Key? key}) : super(key: key);

  @override
  State<ShowListPage> createState() => ShowListPageState();
}

class ShowListPageState extends State<ShowListPage> with TickerProviderStateMixin {

  CustomAutoScrollController? listContentScrollController;
  final listScrollController = CustomScrollController();
  final listSearchTextController = TextEditingController();
  final detailScrollController = CustomScrollController();
  final CustomScrollController detailVerseCustomScrollController = CustomScrollController();
  final ItemScrollController detailVerseSinglePaneItemScrollController = ItemScrollController();
  final ItemScrollController detailVerseDualPaneItemScrollController = ItemScrollController();
  final ItemScrollController detailHadithSinglePaneItemScrollController = ItemScrollController();
  final ItemScrollController detailHadithDualPaneItemScrollController = ItemScrollController();
  late final TabController listTabController;

  var currentHadithDetailPos = 0;
  var currentVerseDetailPos = 0;

  @override
  void initState() {
    super.initState();
    initListTabController();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShowListBloc>();
    return AdCheckWidget(
      child: Scaffold(
        body: SafeArea(
          child: getListeners(
            child: BlocBuilder<ShowListBloc, ShowListState>(
              buildWhen: (prevState, nextState){
                return prevState.isDetailOpen != nextState.isDetailOpen ||
                    prevState.currentSelectedHadithItem != nextState.currentSelectedHadithItem ||
                    prevState.currentSelectedVerseItem != nextState.currentSelectedVerseItem;
              },
              builder: (context, state){
                return ListDetailAdaptiveLayoutWithController(
                  useAdaptivePadding: true,
                  showDetailInSinglePane: state.isDetailOpen,
                  onCreateListController: (offset){
                    return AutoScrollController(
                      initialScrollOffset: offset,
                      suggestedRowHeight: 60
                    );
                  },
                  onListWidget: (controller, isSinglePane){
                    listContentScrollController = controller != null ? CustomAutoScrollController(autoScrollController: controller as AutoScrollController) :
                        CustomAutoScrollController();
                    return ListPageContent(
                      contentScrollController: listContentScrollController!,
                      isSinglePane: isSinglePane,
                      scrollController: listScrollController,
                      searchTextController: listSearchTextController,
                      tabController: listTabController,
                      onClickItem: (item){
                        currentHadithDetailPos = 0;
                        currentVerseDetailPos = 0;
                        bloc.add(ShowListEventShowDetail(item: item));
                      },
                    );
                  },
                  onDetailWidget: (controller, isSinglePane){
                    final selectedVerseItem = state.currentSelectedVerseItem;
                    final selectedHadithItem = state.currentSelectedHadithItem;

                    if(selectedVerseItem != null){
                      return getVerseDetail(selectedVerseItem, isSinglePane);
                    }
                    if(selectedHadithItem != null){
                      return getHadithDetail(selectedHadithItem, isSinglePane);
                    }
                    return const SharedEmptyResult();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget getHadithDetail(ListViewModel selectedItem, bool isSinglePane){
    final bloc = context.read<ShowListBloc>();

    final listPagingRepo = context.read<HadithListPagingRepo>()
        .init(selectedItem.id);

    final savePointDestination = DestinationList(
        listId: selectedItem.id,
        listName: selectedItem.name,
        listBookScope: ListBookScope.hadith
    );

    final controller = isSinglePane ? detailHadithSinglePaneItemScrollController :
        detailHadithDualPaneItemScrollController;

    return HadithSharedDetailPageContent(
      itemScrollController: controller,
      savePointDestination: savePointDestination,
      paginationRepo: listPagingRepo,
      title: "${selectedItem.name} - ${ListBookScope.hadith.bookScopeEnum.sourceType.shortName}",
      pos: currentHadithDetailPos,
      listIdControlForSelectList: selectedItem.id,
      isFullPage: isSinglePane,
      controller: detailScrollController,
      onVisibleItemChanged: (firstPos, lastPos){
        currentHadithDetailPos = firstPos;
      },
      onClose: (){
        bloc.add(ShowListEventHideDetail());
      },
    );
  }

  Widget getVerseDetail(ListViewModel item, bool isSinglePane){
    final bloc = context.read<ShowListBloc>();

    final listPagingRepo = context.read<VerseListPagingRepo>()
        .init(listId: item.id);

    final destination = DestinationList(
        listId: item.id,
        listName: item.name,
        listBookScope: ListBookScope.verse
    );
    final controller = isSinglePane ? detailVerseSinglePaneItemScrollController :
        detailVerseDualPaneItemScrollController;

    return VerseSharedDetailPageContent(
      isFullPage: isSinglePane,
      onClose: (){
        bloc.add(ShowListEventHideDetail());
      },
      savePointDestination: destination,
      paginationRepo: listPagingRepo,
      listIdControlForSelectList: item.id,
      selectAudioOption: SelectAudioOption.verse,
      itemScrollController: controller,
      customScrollController: detailVerseCustomScrollController,
      onVisibleItemChanged: (firstPos, lastPos){
        currentVerseDetailPos = firstPos;
      },
      pos: currentVerseDetailPos,
      showNavigateToActions: true,
      title: "${item.name} - ${ListBookScope.verse.bookScopeEnum.sourceType.shortName}",
    );
  }


  void initListTabController(){
    final initIndex = context.read<ShowListBloc>().state.currentTab.index;
    listTabController = TabController(length: 2, vsync: this,initialIndex: initIndex);
    listTabController.addListener(listenTabChanges);
  }

  void listenTabChanges(){
    if(!listTabController.indexIsChanging){
      context.read<ShowListBloc>()
          .add(ShowListEventChangeTab(index: listTabController.index));
    }
  }

  Widget getListeners({
    required Widget child
  }){
    return MultiBlocListener(
      listeners: [
        BlocListener<ShowListBloc, ShowListState>(
          listenWhen: (prevState, nextState){
            return prevState.currentSelectedVerseItem?.id != nextState.currentSelectedVerseItem?.id;
          },
          listener: (context, state){
            final selectedItem = state.currentSelectedVerseItem;
            if(selectedItem == null) return;
            final pagingBloc = context.read<PaginationBloc>();

            final listPagingRepo = context.read<VerseListPagingRepo>()
                .init(listId: selectedItem.id);
            pagingBloc.add(PaginationEventInit(listPagingRepo,
                config: PagingConfig(pageSize: K.versePageSize,preFetchDistance: K.versePagingPrefetchSize, currentPos: currentVerseDetailPos)
            ));
          },
        ),
        BlocListener<ShowListBloc, ShowListState>(
          listenWhen: (prevState, nextState){
            return prevState.currentSelectedHadithItem?.id != nextState.currentSelectedHadithItem?.id;
          },
          listener: (context, state){
            final selectedItem = state.currentSelectedHadithItem;
            if(selectedItem == null) return;
            final pagingBloc = context.read<PaginationBloc>();

            final listPagingRepo = context.read<HadithListPagingRepo>()
                .init(selectedItem.id);
            pagingBloc.add(PaginationEventInit(listPagingRepo,
                config: PagingConfig(pageSize: K.versePageSize,preFetchDistance: K.versePagingPrefetchSize, currentPos: currentHadithDetailPos)
            ));
          },
        )
      ],
      child: child,
    );
  }

  @override
  void dispose() {
    listTabController.removeListener(listenTabChanges);

    listContentScrollController?.dispose();
    listScrollController.dispose();
    listSearchTextController.dispose();
    listTabController.dispose();
    detailVerseCustomScrollController.dispose();
    detailScrollController.dispose();
    super.dispose();
  }
}
