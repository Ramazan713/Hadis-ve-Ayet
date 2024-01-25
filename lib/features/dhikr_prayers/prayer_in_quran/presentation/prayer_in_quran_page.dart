

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_aligned_grid_view.dart';
import 'package:hadith/core/features/adaptive/presentation/lazy_staggered_grid_view.dart';
import 'package:hadith/core/features/ads/ad_check_widget.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/presentation/load_save_point/bloc/load_save_point_event.dart';
import 'package:hadith/core/features/select_edition/show_select_edition.dart';
import 'package:hadith/core/features/share/presentation/dialogs/show_share_verse_content_dia.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_state.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/components/basic_audio_info_body_wrapper.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/core/presentation/components/navigate_to_icon.dart';
import 'package:hadith/core/presentation/components/navigate_to_icon_auto.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/dialogs/show_select_verse_ui_2x.dart';
import 'package:hadith/core/presentation/selections/dropdown_icon_menu.dart';
import 'package:hadith/core/utils/toast_utils.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/domain/enums/prayer_in_quran_bottom_menu_item.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/domain/enums/prayer_in_quran_top_bar_menu_item.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/presentation/bloc/prayer_in_quran_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/presentation/bloc/prayer_in_quran_event.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/presentation/bloc/prayer_in_quran_state.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/presentation/components/prayer_in_quran_item.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_in_quran_mapper.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PrayerInQuranPage extends StatefulWidget {
  const PrayerInQuranPage({Key? key}) : super(key: key);

  @override
  State<PrayerInQuranPage> createState() => _PrayerInQuranPageState();
}

class _PrayerInQuranPageState extends State<PrayerInQuranPage> {

  final CustomAutoScrollController autoScrollController = CustomAutoScrollController(
    suggestedRowHeight: 150
  );
  final CustomScrollController scrollController = CustomScrollController();
  final TextEditingController searchTextController = TextEditingController();


  @override
  void initState() {
    super.initState();
    context.read<PrayerInQuranBloc>()
        .add(PrayerInQuranEventLoadData());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PrayerInQuranBloc>();

    return AdCheckWidget(
      child: getListeners(
        child: Scaffold(
          body: SafeArea(
            child: BlocSelector<PrayerInQuranBloc,PrayerInQuranState,bool>(
              selector: (state) => state.isSearchBarVisible,
              builder: (context, isSearchBarVisible){
                return DefaultNestedSearchableAppBar(
                  textEditingController: searchTextController,
                  scrollController: scrollController,
                  contentScrollController: autoScrollController,
                  floatHeaderSlivers: true,
                  onTextChanged: (text){
                    bloc.add(PrayerInQuranEventSetQuery(query: text));
                  },
                  onSearchVisibilityChanged: (isSearchVisible){
                    bloc.add(PrayerInQuranEventSetSearchBarVisibility(isVisible: isSearchVisible));
                  },
                  searchBarVisible: isSearchBarVisible,
                  title: const Text("Dua Ayetleri",),
                  actions: getActions(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: BasicAudioInfoBodyWrapper(
                      child: getContent(context)
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget getContent(BuildContext context){
    final bloc = context.read<PrayerInQuranBloc>();

    return BlocSelector<BasicAudioBloc, BasicAudioState, String?>(
      selector: (state) => state.activeAudioTag,
      builder: (context, currentAudioTag){
        return BlocBuilder<PrayerInQuranBloc,PrayerInQuranState>(
          builder: (context, state){
            final items = state.items;

            if(state.isLoading){
              return const SharedLoadingIndicator();
            }
            if(items.isEmpty){
              return const SharedEmptyResult();
            }

            return LazyStaggeredGridView(
              maxCrossAxisExtent: 700,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemCount: items.length,
              shrinkWrap: false,
              controller: autoScrollController.controller,
              itemBuilder: (context, index){
                final prayerUnit = items[index];
                final prayer = prayerUnit.item;

                return AutoScrollTag(
                  index: index,
                  key: ValueKey(index.toString()),
                  controller: autoScrollController.controller,
                  child: PrayerInQuranItem(
                    key: Key(prayer.id.toString()),
                    searchParam: state.searchParam,
                    isSelected: currentAudioTag == prayer.id.toString(),
                    prayerUnit: prayerUnit,
                    order: index + 1,
                    verseUIEnum: state.arabicVerseUI2X,
                    fontModel: state.fontModel,
                    onMenuSelect: (menuItem){
                      switch(menuItem){
                        case PrayerInQuranBottomMenuItem.addToCustomPrayer:
                          bloc.add(PrayerInQuranEventAddCustomPrayer(prayerUnit: prayerUnit));
                          break;
                        case PrayerInQuranBottomMenuItem.goToCustomPrayer:
                          final parentId = prayer.parentPrayerId;
                          if(parentId!=null){
                            CustomPrayerDetailRoute(prayerId: parentId).push(context);
                          }
                          break;
                        case PrayerInQuranBottomMenuItem.listen:
                          context.read<BasicAudioBloc>().add(BasicAudioEventStartWithCustomVerseIds(
                              verseIds: prayerUnit.getVerseIds,
                              audioTag: prayer.id.toString()
                          ));
                          break;
                        case PrayerInQuranBottomMenuItem.share:
                          showShareVerseContentDia(
                              context,
                              item: prayer.toShareContent(),
                              imageName: "${prayer.source}.png"
                          );
                          break;
                        case PrayerInQuranBottomMenuItem.navToSurah:
                          final mealId = prayerUnit.getVerseIds.firstOrNull;
                          if(mealId == null) return;
                          context.read<LoadSavePointBloc>()
                              .add(LoadSavePointEventNavigateToSurahDestinationWithMealId(mealId: mealId));

                          break;
                      }
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  List<Widget> getActions(BuildContext context){
    return [
      NavigateToIconAuto(
        autoScrollController: autoScrollController,
        onPosChanged: (selectedIndex){
          autoScrollController.scrollToIndex(selectedIndex, preferPosition: AutoScrollPosition.begin);
        },
      ),
      _topBarDropDownMenu(context)
    ];
  }

  Widget _topBarDropDownMenu(BuildContext context){
    return CustomDropdownIconMenu(
      items: PrayerInQuranTopBarMenuItem.values,
      onSelected: (menuItem){
        switch(menuItem){
          case PrayerInQuranTopBarMenuItem.fontSize:
            showSelectFontSizeDia(context);
            break;
          case PrayerInQuranTopBarMenuItem.changeAppearance:
            showSelectVerseUi2X(context, pref: KPref.quranPrayerVerseUi);
            break;
          case PrayerInQuranTopBarMenuItem.selectEdition:
            showSelectEdition(context);
            break;
        }
      },
    );
  }

  Widget getListeners({required Widget child}){
    return MultiBlocListener(
        listeners: [
          BlocListener<PrayerInQuranBloc,PrayerInQuranState>(
            listenWhen: (prevState, nextState){
              return prevState.message != nextState.message;
            },
            listener: (context, state){
              final message = state.message;
              if(message!=null){
                ToastUtils.showLongToast(message);
                context.read<PrayerInQuranBloc>()
                    .add(PrayerInQuranEventClearMessage());
              }
            },
          ),
          BlocListener<PrayerInQuranBloc,PrayerInQuranState>(
            listenWhen: (prevState, nextState){
              return prevState.items.length != nextState.items.length;
            },
            listener: (context, state){
              autoScrollController.setTotalItems(totalItems: state.items.length);
            },
          )
        ],
        child: child
    );
  }

  @override
  void dispose() {
    searchTextController.dispose();
    autoScrollController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
