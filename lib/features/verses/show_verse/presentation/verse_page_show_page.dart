import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import 'package:hadith/core/features/adaptive/domain/enums/adaptive_base_dialog_sheet_enum.dart';
import 'package:hadith/core/features/adaptive/presentation/adaptive_padding.dart';
import 'package:hadith/core/features/adaptive/presentation/get_card_adaptive_margin.dart';
import 'package:hadith/core/features/adaptive/presentation/single_adaptive_pane.dart';
import 'package:hadith/core/features/ads/ad_check_widget.dart';
import 'package:hadith/core/features/audio_setting/show_edit_audio_setting_dia.dart';
import 'package:hadith/core/features/pagination/domain/models/paging_config.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_event.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_state.dart';
import 'package:hadith/core/features/pagination/presentation/paging_list_view_by_page.dart';
import 'package:hadith/core/features/save_point/domain/enums/local_destination_scope.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_auto_type.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/core/features/save_point/domain/models/save_point.dart';
import 'package:hadith/core/features/save_point/presentation/edit_save_point/components/save_auto_save_point_with_paging.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_config/select_quran_section_config.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_load_config/select_quran_section_load_config.dart';
import 'package:hadith/core/features/select_quran_section/presentation/show_select_quran_section_dia.dart';
import 'package:hadith/core/features/verse_audio/domain/model/select_audio_option.dart';
import 'package:hadith/core/features/verse_audio/presentation/compoenents/audio_connect.dart';
import 'package:hadith/core/features/verse_audio/presentation/compoenents/audio_info_body_wrapper.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_state.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/shimmer/get_shimmer_items.dart';
import 'package:hadith/core/presentation/components/shimmer/samples/shimmer_verse_item.dart';
import 'package:hadith/core/presentation/controllers/custom_page_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/selections/dropdown_icon_menu.dart';
import 'package:hadith/features/verses/show_verse/data/repo/verse_page_paing_repo.dart';
import 'package:hadith/features/verses/show_verse/domain/constants/verse_top_bar_menu_item.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/bloc/verse_shared_bloc.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/bloc/verse_shared_state.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/follow_audio_wrapper_by_page.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/paging_verse_connect.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/verse_item/verse_item.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/sections/header.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/sections/show_select_point.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/sections/verse_bottom_menu_section.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/shared_providers.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/verse_shared_args.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


class VersePageShowPage extends StatelessWidget {
  final int startPageIndex;
  final int pagePos;

  const VersePageShowPage({
    super.key,
    this.pagePos = 0,
    required this.startPageIndex,
  }): super();

  @override
  Widget build(BuildContext context) {
    return VerseSharedProviders(
      child: _VersePageShowPageContent(
        startPageIndex: startPageIndex,
        showNavigateToActions: false,
        pagePos: pagePos,
      ),
    );
  }
}




class _VersePageShowPageContent extends VerseSharedBasePageStateful {

  final int startPageIndex;
  final int pagePos;

  const _VersePageShowPageContent({
    super.key,
    this.pagePos = 0,
    required this.startPageIndex,
    super.showNavigateToActions = false
  }): super();


  @override
  SelectAudioOption? get selectAudioOption => SelectAudioOption.cuz;

  @override
  State<_VersePageShowPageContent> createState() => _VersePageShowPageState();
}

class _VersePageShowPageState extends State<_VersePageShowPageContent> {

  final CustomScrollController customScrollController = CustomScrollController();
  final CustomPositionController positionController = CustomPositionController();
  late final CustomPageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = CustomPageController();

    final pagingBloc = context.read<PaginationBloc>();
    final paginationRepo = context.read<VersePagePagingRepo>();

    pagingBloc.add(PaginationEventInit(paginationRepo,
        config: PagingConfig(pageSize: 10,preFetchDistance: 3,currentPage: widget.startPageIndex + 1)
    ));

    WidgetsBinding.instance.addPostFrameCallback((_){
       pageController.animateToPage(pageIndex: widget.startPageIndex,pos: widget.pagePos);
    });
  }

  DestinationPage get savePointDestination => DestinationPage(pageNo: pageController.currentPageIndex + 1);

  @override
  Widget build(BuildContext context) {

    return AdCheckWidget(
      child: FollowAudioWrapperByPage(
        pageController: pageController,
        child: AudioConnect(
          child: PagingVerseConnect(
            child: SaveAutoSavePointWithPaging(
              destination: savePointDestination,
              autoType: SaveAutoType.general,
              child: Scaffold(
                body: SafeArea(
                  child: CustomNestedViewAppBar(
                    scrollController: customScrollController,
                    floating: true,
                    snap: true,
                    title: const Text("Kuran"),
                    actions: getActions(context),
                    child: SingleAdaptivePane(
                      useAdaptivePadding: true,
                      child: AudioInfoBodyWrapper(
                        destination: savePointDestination,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            getPageInfo(context),
                            Flexible(
                              child: BlocSelector<ListenVerseAudioBloc,ListenVerseAudioState,int?>(
                                selector: (state) => state.audio?.mealId,
                                builder: (context, currentMealId){
                                  return BlocBuilder<VerseSharedBloc, VerseSharedState>(
                                    builder: (context, state){
                                      return PagingListViewByPage<VerseListModel>(
                                        pageController: pageController,
                                        customScrollController: customScrollController,
                                        itemPositionsListener: ItemPositionsListener.create(),
                                        positionController: positionController,
                                        loadingItem: const GetShimmerItems(
                                          itemCount: 13,
                                          shimmerItem: ShimmerVerseItem()
                                        ),
                                        itemBuilder: (context, item, index){
                                          return VerseItem(
                                            key: Key(item.pagingId.toString()),
                                            margin: getCardAdaptiveMargin(context),
                                            fontModel: state.fontModel,
                                            isSelected: item.pagingId == currentMealId,
                                            arabicVerseUIEnum: state.arabicVerseUIEnum,
                                            showListVerseIcons: state.showListVerseIcons,
                                            onLongPress: (){
                                              widget.handleBottomMenu(
                                                  context,
                                                  verseListModel: item,
                                                  itemIndexPos: index + 1,
                                                  state: state,
                                                  savePointDestination: savePointDestination,
                                                  initScope: LocalDestinationScope.wide,
                                                  onLoadSavePointClick: (savePoint){
                                                    onLoadSavePointClick(context,savePoint);
                                                  }
                                              );
                                            },
                                            onPress: (){
                                              context.read<ListenVerseAudioBloc>()
                                                  .add(ListenAudioEventToggleVisibilityAudioWidget());
                                            },
                                            verseListModel: item,
                                          );
                                        },
                                        trailingWidget: getNextPrevButton(context),
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        ),
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

  Widget getNextPrevButton(BuildContext context){
    return BlocBuilder<PaginationBloc,PaginationState>(
      buildWhen: (prevState, nextState){
        return prevState.totalStaticItems != nextState.totalStaticItems;
      },
      builder: (context, state){
        return ListenableBuilder(
            listenable: pageController,
            builder: (context, child){
              final nextEnabled = state.totalStaticItems - 1 != pageController.currentPageIndex;
              final prevEnabled = pageController.currentPageIndex != 0;
              return Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: !prevEnabled ? null : (){
                          pageController.animateToPreviousPage();
                        },
                        child: const Text("Önceki")
                    ),
                  ),
                  const SizedBox(width: 4,),
                  Expanded(
                    child: TextButton(
                        onPressed: !nextEnabled ? null : (){
                          pageController.animateToNextPage();
                        },
                        child: const Text("Sonraki")
                    ),
                  )
                ],
              );
            });
      },
    );
  }

  Widget getPageInfo(BuildContext context){
    return ListenableBuilder(
      listenable: pageController,
      builder: (context, child){
        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Text(
              "${pageController.currentPageIndex + 1}. Sayfa",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  List<Widget> getActions(BuildContext context){
    return [
      widget.getTopBarAppearanceIcon(context),
      IconButton(
        onPressed: (){
          showSelectQuranSectionDia(
            context: context,
            baseType: AdaptiveBaseDialogSheetEnum.adaptiveDialog,
            config: const SelectQuranSectionConfig(
              title: "Pozisyon Seç",
              btnName: "Onayla",
              selectFirstVerseTitle: "Ayet Seç",
              showSelectJuz: true,
              showSelectSurah: true,
              showSelectFirstVerseNumber: true,
              showSelectPage: true
            ),
            loadConfig: SelectQuranSectionLoadConfig(
              page: pageController.currentPageIndex + 1
            ),
            onSubmit: (data){
              pageController.animateToPage(pageIndex: data.pageNo - 1, pos: data.pagePos);
            }
          );
        },
        icon: const Icon(Icons.map),
      ),
      topBarDropdownMenu(context)
    ];
  }

  Widget topBarDropdownMenu(BuildContext context){
    return ListenableBuilder(
      listenable: positionController,
      builder: (context, child){
        return CustomDropdownIconMenu(
          items: VerseTopBarMenuItem.values,
          onSelected: (menuItem){
            switch(menuItem){
              case VerseTopBarMenuItem.fontSize:
                showSelectFontSizeDia(context);
                break;
              case VerseTopBarMenuItem.savePoint:
                widget.verseShowSelectSavePoint(
                    context,
                    itemIndexPos: positionController.middleVisiblePos,
                    savePointDestination: savePointDestination,
                    initScope: LocalDestinationScope.wide,
                    onLoadSavePointClick: (savePoint){
                      onLoadSavePointClick(context, savePoint);
                    }
                );
                break;
              case VerseTopBarMenuItem.selectEdition:
                showEditAudioSettingDia(context);
                break;
            }
          },
        );
      },
    );
  }

  void onLoadSavePointClick(BuildContext context,SavePoint savePoint){
    final destination = savePoint.destination;
    if(destination is DestinationPage){
      Navigator.pop(context);
      pageController.animateToPage(pageIndex: destination.pageNo - 1, pos: savePoint.itemPos);
    }
  }

  @override
  void dispose() {
    customScrollController.dispose();
    pageController.dispose();
    positionController.dispose();
    super.dispose();
  }
}
