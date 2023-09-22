import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/app_k.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/models/paging/paging_config.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/features/ads/ad_check_widget.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/paging_list_view.dart';
import 'package:hadith/core/features/save_point/edit_save_point/components/save_auto_save_point_with_paging.dart';
import 'package:hadith/core/features/save_point/edit_save_point/model/edit_save_point_handler.dart';
import 'package:hadith/core/features/verse_audio/domain/model/select_audio_option.dart';
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
import 'package:hadith/features/save_point/constants/save_auto_type.dart';
import 'package:hadith/features/verses/show_verse/domain/repo/verse_pagination_repo.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/follow_audio_wrapper.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/sections/header.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/sections/verse_bottom_menu_section.dart';

import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'bloc/verse_shared_bloc.dart';
import 'bloc/verse_shared_state.dart';
import 'components/paging_verse_connect.dart';
import 'components/verse_item/verse_item.dart';

abstract class VerseShareBasePage extends StatefulWidget {

  final EditSavePointHandler? editSavePointHandler;
  final int? listIdControlForSelectList;
  final bool showNavigateToActions;

  const VerseShareBasePage({
    super.key,
    required this.showNavigateToActions,
    this.editSavePointHandler,
    this.listIdControlForSelectList,
  });

  SelectAudioOption? get selectAudioOption;
}



class VerseShowSharedPage extends VerseShareBasePage {

  final VersePaginationRepo paginationRepo;
  final String title;
  final SearchParam? searchParam;
  final int pos;
  final SavePointDestination savePointDestination;

  @override
  final SelectAudioOption? selectAudioOption;


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
    this.selectAudioOption,
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
                    child: BlocSelector<ListenVerseAudioBloc,ListenVerseAudioState,int?>(
                      selector: (state) => state.audio?.mealId,
                      builder: (context, currentMealId){
                        return BlocBuilder<VerseSharedBloc, VerseSharedState>(
                          builder: (context, state){
                            return PagingListView<VerseListModel>(
                              itemScrollController: itemScrollController,
                              onScroll: (scrollDirection){
                                customScrollController.setScrollDirectionAndAnimateTopBar(scrollDirection);
                              },
                              itemBuilder: (context, item, index){
                                return VerseItem(
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
                      },
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

  @override
  void dispose() {
    super.dispose();
    customScrollController.dispose();
  }
}
