
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/presentation/default_adaptive_layout.dart';
import 'package:hadith/core/features/ads/ad_check_widget.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_event.dart';
import 'package:hadith/core/features/select_edition/show_select_edition.dart';
import 'package:hadith/core/features/share/presentation/dialogs/show_share_verse_content_dia.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/components/basic_audio_info_body_wrapper.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_scrollable_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/components/stack_second_content.dart';
import 'package:hadith/core/presentation/components/title_section_item.dart';
import 'package:hadith/core/presentation/components/verses/arabic_content_item.dart';
import 'package:hadith/core/presentation/selections/dropdown_icon_menu.dart';
import 'package:hadith/core/utils/toast_utils.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/domain/prayer_and_verse_top_bar_menu.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_detail/bloc/prayer_and_verse_detail_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_detail/bloc/prayer_and_verse_detail_event.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_detail/bloc/prayer_and_verse_detail_state.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_and_verse_mapper.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse/prayer_and_verse.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_unit.dart';

class PrayerAndVerseDetailPage extends StatelessWidget {

  final int prayerId;

  const PrayerAndVerseDetailPage({
    Key? key,
    required this.prayerId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    context.read<PrayerAndVerseDetailBloc>()
        .add(PrayerAndVerseDetailEventLoadData(prayerId: prayerId));

    return AdCheckWidget(
      child: getListeners(
        child: Scaffold(
          body: SafeArea(
            child: DefaultNestedScrollableAppBar(
              title: getTitle(),
              pinned: true,
              actions: getActions(context),
              appBarType: AppBarType.mediumBar,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: BasicAudioInfoBodyWrapper(
                  child: BlocBuilder<PrayerAndVerseDetailBloc,PrayerAndVerseDetailState>(
                    builder: (context,state){
                      final prayerUnit = state.prayerUnit;
                      final fontModel = state.fontModel;
                      final prayer = prayerUnit?.item;

                      return DefaultAdaptiveLayout(
                        builder: (context, windowSizeClass){
                          return StackSecondContent(
                            showStackChild: false,
                            getSecondChild: (){
                              return getLoadingOrEmptyResult(context,state);
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  getListenItem(context,prayerUnit),
                                  getContent(context,
                                      windowSizeClass: windowSizeClass,
                                      prayer: prayer,
                                      fontModel: fontModel
                                  )
                                ],
                              ),
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
    );
  }

  Widget getContent(BuildContext context,{
    required WindowSizeClass windowSizeClass,
    required PrayerAndVerse? prayer,
    required FontModel fontModel
  }){
    final axisCount = windowSizeClass.isExpanded ? 2 : 1;
    return StaggeredGrid.count(
      crossAxisCount: axisCount,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      children: [
        getArabicContentItem(prayer: prayer, fontModel: fontModel),
        getPronunciationContentItem(prayer: prayer, fontModel: fontModel),
        getMeaningContentItem(prayer: prayer, fontModel: fontModel),
      ],
    );
  }


  Widget? getLoadingOrEmptyResult(BuildContext context, PrayerAndVerseDetailState state){
    final prayer = state.prayerUnit;
    if(state.isLoading){
      return const SharedLoadingIndicator();
    }
    if(prayer == null){
      return const SharedEmptyResult();
    }
    return null;
  }


  Widget getTitle(){
    return BlocBuilder<PrayerAndVerseDetailBloc,PrayerAndVerseDetailState>(
      buildWhen: (prevState, nextState){
        return prevState.prayerUnit != nextState.prayerUnit;
      },
      builder: (context,state){
        return Text(
          state.prayerUnit?.item.name ?? "",
          overflow: TextOverflow.ellipsis,
        );
      }
    );
  }

  Widget getListenItem(BuildContext context, PrayerUnit<PrayerAndVerse>? prayerUnit){
    final verseIds = prayerUnit?.getVerseIds;
    if(verseIds == null || verseIds.isEmpty) return const SizedBox.shrink();
    final audioBloc = context.read<BasicAudioBloc>();
    return Padding(
      padding: const EdgeInsets.only(right: 4,top: 2,bottom: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: FilledButton(
          onPressed: (){
            audioBloc.add(BasicAudioEventStartWithCustomVerseIds(verseIds: verseIds));
          },
          child: const Text("Dinle"),
        ),
      ),
    );
  }

  Widget getArabicContentItem({
    required PrayerAndVerse? prayer,
    required FontModel fontModel
  }){
    return TitleSectionChild(
        title: "Arapça İçerik",
        expandable: true,
        initExpand: true,
        useDefaultColor: true,
        contentFontSize: fontModel.contentFontSize,
        elevation: 3,
        content: ArabicContentItem(
          content: prayer?.arabicContent ?? "",
          fontSize: fontModel.arabicFontSize,
          fontFamily: fontModel.arabicFontFamilyEnum,
        )
    );
  }

  Widget getPronunciationContentItem({
    required PrayerAndVerse? prayer,
    required FontModel fontModel
  }){
    if(prayer?.pronunciationContent == null) {
      return const SizedBox();
    }
    return TitleSectionItem(
        title: "Okunuşu",
        expandable: true,
        initExpand: true,
        useDefaultColor: true,
        contentFontSize: fontModel.contentFontSize,
        elevation: 3,
        content: prayer?.pronunciationContent ?? ""
    );
  }

  Widget getMeaningContentItem({
    required PrayerAndVerse? prayer,
    required FontModel fontModel
  }){
    return TitleSectionItem(
        title: "Anlamı",
        expandable: true,
        initExpand: true,
        useDefaultColor: true,
        contentFontSize: fontModel.contentFontSize,
        elevation: 3,
        content: prayer?.meaningContent ?? ""
    );
  }


  List<Widget> getActions(BuildContext context){
    return [
      BlocSelector<PrayerAndVerseDetailBloc,PrayerAndVerseDetailState, PrayerAndVerse?>(
        selector: (state) => state.prayerUnit?.item,
        builder: (context, currentPrayer){
          final prayer = currentPrayer;
          if(prayer == null) return const SizedBox.shrink();
          return IconButton(
            onPressed: (){
              showShareVerseContentDia(context,
                item: prayer.toShareContent(),
                imageName: "${prayer.name}.png"
              );
            },
            icon: const Icon(Icons.share),
          );
        },
      ),
      _getTopBarIconDropdownMenu(context)
    ];
  }

  Widget _getTopBarIconDropdownMenu(BuildContext context){
    final bloc = context.read<PrayerAndVerseDetailBloc>();
    final audioBloc = context.read<BasicAudioBloc>();
    final loadSavePointBloc = context.read<LoadSavePointBloc>();
    return BlocSelector<PrayerAndVerseDetailBloc,PrayerAndVerseDetailState, PrayerUnit<PrayerAndVerse>?>(
      selector: (state) => state.prayerUnit,
      builder: (context, currentPrayerUnit){
        return CustomDropdownIconMenu(
          items: PrayerAndVerseTopBarMenuItems.getItems(currentPrayerUnit),
          onSelected: (menuItem){
            switch(menuItem){
              case PrayerAndVerseTopBarMenuItems.selectFontSize:
                showSelectFontSizeDia(context);
                break;
              case PrayerAndVerseTopBarMenuItems.addToCustomPrayer:
                bloc.add(PrayerAndVerseDetailEventAddToCustomPrayer());
                break;
              case PrayerAndVerseTopBarMenuItems.goToCustomPrayer:
                final parentId = currentPrayerUnit?.item.parentPrayerId;
                if(parentId!=null){
                  CustomPrayerDetailRoute(prayerId: parentId).push(context);
                }
                break;
              case PrayerAndVerseTopBarMenuItems.selectEdition:
                audioBloc.add(BasicAudioEventCancel());
                showSelectEdition(context);
                break;
              case PrayerAndVerseTopBarMenuItems.navToSurah:
                final mealId = currentPrayerUnit?.getVerseIds.firstOrNull;
                if(mealId == null) return;
                loadSavePointBloc.add(LoadSavePointEventNavigateToSurahDestinationWithMealId(mealId: mealId));
                break;
            }
          }
        );
      },
    );
  }
  
  
  Widget getListeners({required Widget child}){
    return BlocListener<PrayerAndVerseDetailBloc,PrayerAndVerseDetailState>(
      listenWhen: (prevState, nextState){
        return prevState.message != nextState.message;
      },
      listener: (context, state){
        final message = state.message;
        if(message!=null){
          ToastUtils.showLongToast(message);
          context.read<PrayerAndVerseDetailBloc>()
              .add(PrayerAndVerseDetailEventClearMessage());
        }
      },
      child: child,
    );
  }

}
