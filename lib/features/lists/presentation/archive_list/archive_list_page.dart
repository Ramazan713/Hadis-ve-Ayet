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
import 'package:hadith/core/utils/toast_utils.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_list_paging_repo.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_detail_page_content.dart';
import 'package:hadith/features/lists/presentation/archive_list/archive_list_page_content.dart';
import 'package:hadith/features/verses/show_verse/data/repo/verse_list_paging_repo.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/verse_shared_detail_page_content.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'bloc/archive_list_bloc.dart';
import 'bloc/archive_list_event.dart';
import 'bloc/archive_list_state.dart';

class ArchiveListPage extends StatefulWidget {
  const ArchiveListPage({Key? key}) : super(key: key);

  @override
  State<ArchiveListPage> createState() => ArchiveListPageState();
}

class ArchiveListPageState extends State<ArchiveListPage> {

  CustomAutoScrollController? listContentScrollController;
  final listScrollController = CustomScrollController();
  final detailHadithScrollController = CustomScrollController();
  final CustomScrollController detailVerseCustomScrollController = CustomScrollController();
  final ItemScrollController detailVerseSinglePaneItemScrollController = ItemScrollController();
  final ItemScrollController detailVerseDualPaneItemScrollController = ItemScrollController();
  final ItemScrollController detailHadithSinglePaneItemScrollController = ItemScrollController();
  final ItemScrollController detailHadithDualPaneItemScrollController = ItemScrollController();


  var currentHadithDetailPos = 0;
  var currentVerseDetailPos = 0;

  @override
  Widget build(BuildContext context) {
    final listBloc = context.read<ArchiveListBloc>();

    return AdCheckWidget(
      child: Scaffold(
        body: SafeArea(
          child: getListeners(
            child: BlocBuilder<ArchiveListBloc, ArchiveListState>(
              buildWhen: (prevState, nextState){
                return prevState.isDetailOpen != nextState.isDetailOpen ||
                    prevState.selectedItem != nextState.selectedItem;
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
                    return ArchiveListPageContent(
                      scrollController: listScrollController,
                      contentScrollController: listContentScrollController!,
                      isSinglePane: isSinglePane,
                      onClickItem: (item){
                        currentHadithDetailPos = 0;
                        currentVerseDetailPos = 0;
                        listBloc.add(ArchiveListEventShowDetail(item: item));
                      },
                    );
                  },
                  onDetailWidget: (controller, isSinglePane){
                    final selectedItem = state.selectedItem;
                    if(selectedItem == null) {
                      return const SharedEmptyResult();
                    }
                    if(selectedItem.sourceType == SourceTypeEnum.verse){
                      return getVerseDetail(selectedItem, isSinglePane);
                    }
                    return getHadithDetail(selectedItem, isSinglePane);
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
    final bloc = context.read<ArchiveListBloc>();

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
      controller: detailHadithScrollController,
      onVisibleItemChanged: (firstPos, lastPos){
        currentHadithDetailPos = firstPos;
      },
      onClose: (){
        bloc.add(ArchiveListEventHideDetail());
      },
    );
  }

  Widget getVerseDetail(ListViewModel item, bool isSinglePane){
    final bloc = context.read<ArchiveListBloc>();

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
        bloc.add(ArchiveListEventHideDetail());
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

  Widget getListeners({
    required Widget child
  }){
    final listBloc = context.read<ArchiveListBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<ArchiveListBloc, ArchiveListState>(
          listener: (context, state) {
            if (state.message != null) {
              ToastUtils.showLongToast(state.message ?? "");
              listBloc.add(ArchiveListEventClearMessage());
            }
          }
        ),
        BlocListener<ArchiveListBloc, ArchiveListState>(
          listenWhen: (prevState, nextState){
            return prevState.selectedItem?.id != nextState.selectedItem?.id;
          },
          listener: (context, state){
            final selectedItem = state.selectedItem;
            if(selectedItem == null) return;
            final pagingBloc = context.read<PaginationBloc>();

            if(selectedItem.sourceType == SourceTypeEnum.verse){
              final listPagingRepo = context.read<VerseListPagingRepo>()
                  .init(listId: selectedItem.id);
              pagingBloc.add(PaginationEventInit(listPagingRepo,
                  config: PagingConfig(pageSize: K.versePageSize,preFetchDistance: K.versePagingPrefetchSize, currentPos: 0)
              ));
            }else{
              final listPagingRepo = context.read<HadithListPagingRepo>()
                  .init(selectedItem.id);
              pagingBloc.add(PaginationEventInit(listPagingRepo,
                  config: PagingConfig(pageSize: K.versePageSize,preFetchDistance: K.versePagingPrefetchSize, currentPos: 0)
              ));
            }
          },
        ),
      ],
      child: child,
    );
  }

  @override
  void dispose() {
    listContentScrollController?.dispose();
    listScrollController.dispose();
    detailVerseCustomScrollController.dispose();
    detailHadithScrollController.dispose();
    super.dispose();
  }
}
