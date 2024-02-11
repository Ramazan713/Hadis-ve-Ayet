import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/features/adaptive/domain/utils/calculate_windows_size_class.dart';
import 'package:hadith/core/features/adaptive/presentation/list_detail_adaptive_layout_with_controller.dart';
import 'package:hadith/core/features/ads/ad_check_widget.dart';
import 'package:hadith/core/features/pagination/domain/models/paging_config.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/topic_save_point/domain/enums/topic_save_point_type.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_event.dart';
import 'package:hadith/core/features/verse_audio/domain/model/select_audio_option.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/features/hadiths/data/repo/hadith_topic_paging_repo.dart';
import 'package:hadith/features/hadiths/presentation/shared/hadith_shared_detail_page_content.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_bloc.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_event.dart';
import 'package:hadith/features/topics/presentation/topic_page/bloc/topic_state.dart';
import 'package:hadith/features/topics/presentation/topic_page/topic_list_page_content.dart';
import 'package:hadith/features/verses/show_verse/data/repo/verse_topic_paging_repo.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/verse_shared_detail_page_content.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TopicPage extends StatefulWidget {
  final BookEnum bookEnum;
  final int sectionId;
  final bool useBookAllSections;
  final String sectionTitle;
  final int? selectedTopicId;
  final int? initPos;

  const TopicPage({
    Key? key,
    required this.bookEnum,
    required this.sectionId,
    required this.useBookAllSections,
    required this.sectionTitle,
    this.selectedTopicId,
    this.initPos
  }) : super(key: key);

  @override
  State<TopicPage> createState() => TopicPageState();

  SourceTypeEnum get sourceType => bookEnum.sourceType;
}

class TopicPageState extends State<TopicPage> {

  CustomAutoScrollController? listContentScrollController;
  CustomScrollController? listScrollController = CustomScrollController();
  final TextEditingController listSearchTextController = TextEditingController();
  final detailScrollController = CustomScrollController();
  final CustomScrollController detailVerseCustomScrollController = CustomScrollController();
  final ItemScrollController detailVerseSinglePaneItemScrollController = ItemScrollController();
  final ItemScrollController detailVerseDualPaneItemScrollController = ItemScrollController();
  final ItemScrollController detailHadithSinglePaneItemScrollController = ItemScrollController();
  final ItemScrollController detailHadithDualPaneItemScrollController = ItemScrollController();

  var currentHadithDetailPos = 0;
  var currentVerseDetailPos = 0;
  var isInitPosUsed = false;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<TopicBloc>();
    final topicSavePointBloc = context.read<TopicSavePointBloc>();

    bloc.add(TopicEventLoadData(
      book: widget.bookEnum,
      sectionId: widget.sectionId,
      useBookAllSections: widget.useBookAllSections,
      selectedTopicId: widget.selectedTopicId
    ));
    topicSavePointBloc.add(TopicSavePointEventLoadData(topicType: getTopicType()));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TopicBloc>();
    return AdCheckWidget(
      child: Scaffold(
        body: SafeArea(
          child: getListeners(
            child: BlocBuilder<TopicBloc, TopicState>(
              buildWhen: (prevState, nextState){
                return prevState.isDetailOpen != nextState.isDetailOpen ||
                    prevState.selectedItem != nextState.selectedItem;
              },
              builder: (context, state){
                return ListDetailAdaptiveLayoutWithController(
                  useAdaptivePadding: true,
                  showDetailInSinglePane: state.isDetailOpen,
                  useDetailOffset: false,
                  onCreateListController: (offset){
                    return AutoScrollController(
                      initialScrollOffset: offset,
                      suggestedRowHeight: 60
                    );
                  },
                  onListWidget: (controller, isSinglePane){
                    return TopicListPageContent(
                      isSinglePane: isSinglePane,
                      scrollController: listScrollController! ,
                      searchTextController: listSearchTextController,
                      autoScrollController: _setAndGetController(controller),
                      bookEnum: widget.bookEnum,
                      sectionId: widget.sectionId,
                      sectionTitle: widget.sectionTitle,
                      useBookAllSections: widget.useBookAllSections,
                      onClickItem: (item){
                        currentHadithDetailPos = 0;
                        currentVerseDetailPos = 0;
                        bloc.add(TopicEventShowDetail(item: item));
                      },
                    );
                  },
                  onDetailWidget: (controller, isSinglePane){
                    final selectedItem = state.selectedItem;
                    if(selectedItem == null){
                      return const SharedEmptyResult();
                    }
                    if(selectedItem.sourceTypeEnum == SourceTypeEnum.verse){
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

  Widget getHadithDetail(TopicViewModel selectedItem, bool isSinglePane){
    final bloc = context.read<TopicBloc>();

    final savePointDestination = DestinationTopic(
        topicId: selectedItem.id,
        topicName: selectedItem.name,
        bookEnum: widget.bookEnum
    );

    final hadithTopicPagingRepo = context.read<HadithTopicPagingRepo>()
        .init(selectedItem.id);

    final controller = isSinglePane ? detailHadithSinglePaneItemScrollController :
        detailHadithDualPaneItemScrollController;

    return HadithSharedDetailPageContent(
      savePointDestination: savePointDestination,
      itemScrollController: controller,
      paginationRepo: hadithTopicPagingRepo,
      title: "${selectedItem.name} - ${widget.bookEnum.sourceType.shortName}",
      pos: currentHadithDetailPos,
      listIdControlForSelectList: selectedItem.id,
      isFullPage: isSinglePane,
      controller: detailScrollController,
      onVisibleItemChanged: (firstPos, lastPos){
        currentHadithDetailPos = firstPos;
      },
      onClose: (){
        bloc.add(TopicEventHideDetail());
      },
    );
  }

  Widget getVerseDetail(TopicViewModel selectedItem, bool isSinglePane){
    final bloc = context.read<TopicBloc>();

    final topicPagingRepo = context.read<VerseTopicPagingRepo>()
        .init(topicId: selectedItem.id);

    final destination = DestinationTopic(
        topicId: selectedItem.id,
        topicName: selectedItem.name,
        bookEnum: widget.bookEnum
    );

    final controller = isSinglePane ? detailVerseSinglePaneItemScrollController :
        detailVerseDualPaneItemScrollController;

    return VerseSharedDetailPageContent(
      isFullPage: isSinglePane,
      onClose: (){
        bloc.add(TopicEventHideDetail());
      },
      savePointDestination: destination,
      paginationRepo: topicPagingRepo,
      selectAudioOption: SelectAudioOption.verse,
      itemScrollController: controller,
      customScrollController: detailVerseCustomScrollController,
      onVisibleItemChanged: (firstPos, lastPos){
        currentVerseDetailPos = firstPos;
      },
      pos: currentVerseDetailPos,
      showNavigateToActions: true,
      title: "${selectedItem.name} - ${widget.bookEnum.sourceType.shortName}",
    );
  }


  Widget getListeners({
    required Widget child
  }){
    final bloc = context.read<TopicBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<TopicBloc, TopicState>(
          listenWhen: (prevState, nextState){
            return prevState.selectedItem?.id != nextState.selectedItem?.id;
          },
          listener: (context, state){
            final selectedItem = state.selectedItem;
            if(selectedItem == null) return;
            final pagingBloc = context.read<PaginationBloc>();
            _checkInitPosBeforeLoadingData();

            if(selectedItem.sourceTypeEnum == SourceTypeEnum.verse){
              final topicPagingRepo = context.read<VerseTopicPagingRepo>()
                  .init(topicId: selectedItem.id);
              pagingBloc.add(PaginationEventInit(topicPagingRepo,
                  config: PagingConfig(pageSize: K.versePageSize,preFetchDistance: K.versePagingPrefetchSize, currentPos: currentVerseDetailPos)
              ));
            }else{
              final hadithTopicPagingRepo = context.read<HadithTopicPagingRepo>()
                  .init(selectedItem.id);
              pagingBloc.add(PaginationEventInit(hadithTopicPagingRepo, config: PagingConfig(
                  pageSize: K.hadithPageSize,currentPos: currentHadithDetailPos, preFetchDistance: K.hadithPagingPrefetchSize
              )));
            }
          },
        ),
        BlocListener<TopicBloc, TopicState>(
          listenWhen: (prevState, nextState){
            return prevState.jumpToPos != nextState.jumpToPos ||
                prevState.isDetailOpen != nextState.isDetailOpen;
          },
          listener: (context, state){
            final jumpToPos = state.jumpToPos;
            if(jumpToPos != null){
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                final sizeClass = calculateWindowSize(context);
                if(!state.isDetailOpen || sizeClass.isExpanded){
                  bloc.add(TopicEventClearJumpToPos());
                  listContentScrollController?.scrollToIndex(jumpToPos,preferPosition: AutoScrollPosition.begin);
                }
              });
            }
          },
        ),
      ],
      child: child,
    );
  }

  void _checkInitPosBeforeLoadingData(){
    if(isInitPosUsed)return;
    isInitPosUsed = true;
    if(widget.bookEnum.sourceType == SourceTypeEnum.verse){
      currentVerseDetailPos = widget.initPos ?? currentVerseDetailPos;
    }else{
      currentHadithDetailPos = widget.initPos ?? currentHadithDetailPos;
    }
  }

  CustomAutoScrollController _setAndGetController(ScrollController? controller){
    listContentScrollController = controller == null ? CustomAutoScrollController() :
        CustomAutoScrollController(autoScrollController: controller as AutoScrollController);
    final itemCount = context.read<TopicBloc>().state.items.length;
    listContentScrollController!.setTotalItems(totalItems: itemCount);
    return listContentScrollController!;
  }

  TopicSavePointType getTopicType(){
    if(widget.useBookAllSections){
      return TopicSavePointTypeTopicUsesAllBook(bookEnum: widget.bookEnum);
    }
    return TopicSavePointTypeTopic(sectionId: widget.sectionId);
  }


  @override
  void dispose() {
    listSearchTextController.dispose();
    listScrollController?.dispose();
    listContentScrollController?.dispose();
    detailVerseCustomScrollController.dispose();
    detailScrollController.dispose();
    super.dispose();
  }
}