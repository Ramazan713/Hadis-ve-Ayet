import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import 'package:hadith/core/features/adaptive/presentation/single_adaptive_pane.dart';
import 'package:hadith/core/features/ads/ad_check_widget.dart';
import 'package:hadith/core/features/pagination/domain/models/paging_config.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/presentation/paging_list_view.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/components/save_auto_save_point_with_paging.dart';
import 'package:hadith/core/features/verse_audio/presentation/compoenents/audio_connect.dart';
import 'package:hadith/core/features/verse_audio/presentation/compoenents/audio_info_body_wrapper.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_state.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shimmer/get_shimmer_items.dart';
import 'package:hadith/core/presentation/components/shimmer/samples/shimmer_verse_item.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/features/verses/show_verse/domain/repo/verse_pagination_repo.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/follow_audio_wrapper.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/verse_shared_args.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/verse_show_shared_page.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import './sections/header.dart';
import './sections/verse_bottom_menu_section.dart';
import 'bloc/verse_shared_bloc.dart';
import 'bloc/verse_shared_state.dart';
import 'components/paging_verse_connect.dart';
import 'components/verse_item/verse_item.dart';

class VerseShowSharedPage extends VerseShareBasePageStateful {

  final VersePaginationRepo paginationRepo;
  final String title;
  final SearchParam? searchParam;
  final int pos;
  final SavePointDestination savePointDestination;
  final Widget? trailingWidget;

  const VerseShowSharedPage({
    Key? key,
    required this.savePointDestination,
    required this.paginationRepo,
    required this.pos,
    required super.showNavigateToActions,
    required this.title,
    this.searchParam,
    super.listIdControlForSelectList,
    super.editSavePointHandler,
    super.selectAudioOption,
    this.trailingWidget,
    super.useWideScopeNaming
  }) : super(key: key);

  @override
  State<VerseShowSharedPage> createState() => _VerseShowSharedPageState();
}

class _VerseShowSharedPageState extends State<VerseShowSharedPage> {

  final CustomScrollController customScrollController = CustomScrollController();
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();

    final pagingBloc = context.read<PaginationBloc>();
    pagingBloc.add(PaginationEventInit(widget.paginationRepo,
        config: PagingConfig(pageSize: K.versePageSize,preFetchDistance: K.versePagingPrefetchSize,currentPos: widget.pos)
    ));
  }

  @override
  Widget build(BuildContext context) {

    return AdCheckWidget(
      child: FollowAudioWrapper(
        itemScrollController: itemScrollController,
        child: AudioConnect(
          child: PagingVerseConnect(
            child: SaveAutoSavePointWithPaging(
              destination: widget.savePointDestination,
              autoType: SaveAutoType.general,
              child: Scaffold(
                body: CustomNestedViewAppBar(
                  scrollController: customScrollController,
                  title: Text(widget.title),
                  actions: widget.getActions(context,savePointDestination: widget.savePointDestination),
                  child: AudioInfoBodyWrapper(
                    destination: widget.savePointDestination,
                    child: SingleAdaptivePane(
                      useAdaptivePadding: true,
                      child: BlocSelector<ListenVerseAudioBloc,ListenVerseAudioState,int?>(
                        selector: (state) => state.audio?.mealId,
                        builder: (context, currentMealId){
                          return getContent(context,
                              currentMealId: currentMealId
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget getContent(BuildContext context,{int? currentMealId}){
    return BlocBuilder<VerseSharedBloc, VerseSharedState>(
      builder: (context, state){
        return PagingListView<VerseListModel>(
          trailingWidget: widget.trailingWidget,
          itemScrollController: itemScrollController,
          onScroll: (scrollDirection){
            customScrollController.setScrollDirectionAndAnimateTopBar(scrollDirection);
          },
          itemBuilder: (context, item, index){
            return VerseItem(
              margin: const EdgeInsets.symmetric(vertical: 4),
              fontModel: state.fontModel,
              isSelected: item.pagingId == currentMealId,
              arabicVerseUIEnum: state.arabicVerseUIEnum,
              showListVerseIcons: state.showListVerseIcons,
              onLongPress: (){
                widget.handleBottomMenu(
                  context,
                  verseListModel: item,
                  savePointDestination: widget.savePointDestination,
                  state: state,
                );
              },
              onPress: (){
                context.read<ListenVerseAudioBloc>()
                    .add(ListenAudioEventToggleVisibilityAudioWidget());
              },
              verseListModel: item,
              searchParam: widget.searchParam,
            );
          },
          loadingItem: const GetShimmerItems(
              itemCount: 13,
              shimmerItem: ShimmerVerseItem()
          ),
          emptyResultChild: const SharedEmptyResult(
            content: "Herhangi bir ayet bulunamadı",
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    customScrollController.dispose();
    super.dispose();
  }
}
