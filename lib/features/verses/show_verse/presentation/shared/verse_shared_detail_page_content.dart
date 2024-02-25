import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/domain/utils/calculate_windows_size_class.dart';
import 'package:hadith/core/features/adaptive/presentation/get_card_adaptive_margin.dart';
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
import 'package:hadith/features/verses/show_verse/presentation/shared/bloc/verse_shared_bloc.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/bloc/verse_shared_state.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/follow_audio_wrapper.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/paging_verse_connect.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/verse_item/verse_item.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/sections/header.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/sections/verse_bottom_menu_section.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/verse_shared_args.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


class VerseSharedDetailPageContent extends VerseSharedBasePageStateless {

  final bool isFullPage;
  final void Function() onClose;
  final VersePaginationRepo paginationRepo;
  final String title;
  final SearchParam? searchParam;
  final int pos;
  final SavePointDestination savePointDestination;
  final Widget? trailingWidget;
  final void Function(int firstVisibleItemIndex, int lastVisibleItemIndex)? onVisibleItemChanged;
  final CustomScrollController customScrollController;
  final ItemScrollController itemScrollController;

  const VerseSharedDetailPageContent({
    super.key,
    required this.isFullPage,
    required this.onClose,
    required this.savePointDestination,
    required this.paginationRepo,
    required this.pos,
    required super.showNavigateToActions,
    required this.customScrollController,
    required this.itemScrollController,
    required this.title,
    this.onVisibleItemChanged,
    this.searchParam,
    super.listIdControlForSelectList,
    super.editSavePointHandler,
    super.selectAudioOption,
    this.trailingWidget,
    super.useWideScopeNaming
  });

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(itemScrollController.isAttached){
        itemScrollController.jumpTo(index: pos);
      }
    });

    return PopScope(
      canPop: !isFullPage,
      onPopInvoked: (canPop){
        if(!canPop) onClose();
      },
      child: FollowAudioWrapper(
        itemScrollController: itemScrollController,
        child: AudioConnect(
          child: PagingVerseConnect(
            child: SaveAutoSavePointWithPaging(
              destination: savePointDestination,
              autoType: SaveAutoType.general,
              child: Scaffold(
                body: SafeArea(
                  child: CustomNestedViewAppBar(
                    scrollController: customScrollController,
                    showNavigateBack: false,
                    leading: getNavigateBackIcon(context),
                    title: Text(title),
                    actions: getActions(context,savePointDestination: savePointDestination),
                    child: AudioInfoBodyWrapper(
                      destination: savePointDestination,
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

    var currentWindowSize = calculateWindowSize(context);
    //for in expanded, list-detail mode show so compact fine
    if(currentWindowSize == WindowSizeClass.Expanded){
      currentWindowSize = WindowSizeClass.Compact;
    }

    return BlocBuilder<VerseSharedBloc, VerseSharedState>(
      builder: (context, state){
        return PagingListView<VerseListModel>(
          onVisibleItemChanged: onVisibleItemChanged,
          trailingWidget: trailingWidget,
          itemScrollController: itemScrollController,
          itemPositionsListener: ItemPositionsListener.create(),
          onScroll: (scrollDirection){
            customScrollController.setScrollDirectionAndAnimateTopBar(scrollDirection);
          },
          itemBuilder: (context, item, index){
            return VerseItem(
              windowSizeClass: currentWindowSize,
              margin: getCardAdaptiveMargin(context, windowSizeClass: currentWindowSize),
              fontModel: state.fontModel,
              isSelected: item.pagingId == currentMealId,
              arabicVerseUIEnum: state.arabicVerseUIEnum,
              showListVerseIcons: state.showListVerseIcons,
              onLongPress: (){
                handleBottomMenu(
                  context,
                  verseListModel: item,
                  savePointDestination: savePointDestination,
                  state: state,
                );
              },
              onPress: (){
                context.read<ListenVerseAudioBloc>()
                    .add(ListenAudioEventToggleVisibilityAudioWidget());
              },
              verseListModel: item,
              searchParam: searchParam,
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

  Widget? getNavigateBackIcon(BuildContext context){
    if(!isFullPage) return null;
    return IconButton(
        onPressed: onClose,
        icon: const Icon(Icons.arrow_back)
    );
  }
}
