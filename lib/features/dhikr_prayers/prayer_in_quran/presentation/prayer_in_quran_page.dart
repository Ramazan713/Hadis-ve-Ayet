

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/app_bar_type.dart';
import 'package:hadith/core/features/ads/ad_check_widget.dart';
import 'package:hadith/core/features/share/dialogs/show_share_verse_content_dia.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_state.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/components/basic_audio_info_body_wrapper.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_edition.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_searchable_app_bar.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/core/presentation/components/selections/dropdown_icon_menu.dart';
import 'package:hadith/core/presentation/components/navigate_to_icon.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/dialogs/show_select_verse_ui_2x.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_detail/bloc/prayer_and_verse_detail_bloc.dart';
import 'package:hadith/features/dhikr_prayers/prayer_and_verse/presentation/prayer_and_verse_detail/bloc/prayer_and_verse_detail_state.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/domain/enums/prayer_in_quran_bottom_menu_item.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/domain/enums/prayer_in_quran_top_bar_menu_item.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/presentation/bloc/prayer_in_quran_event.dart';
import 'package:hadith/features/dhikr_prayers/prayer_in_quran/presentation/components/prayer_in_quran_item.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_entity_mapper.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_in_quran_mapper.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse/prayer_and_verse.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'bloc/prayer_in_quran_bloc.dart';
import 'bloc/prayer_in_quran_state.dart';

class PrayerInQuranPage extends StatefulWidget {
  const PrayerInQuranPage({Key? key}) : super(key: key);

  @override
  State<PrayerInQuranPage> createState() => _PrayerInQuranPageState();
}

class _PrayerInQuranPageState extends State<PrayerInQuranPage> {

  final CustomPositionController positionController = CustomPositionController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final CustomScrollController scrollController = CustomScrollController();
  final TextEditingController searchTextController = TextEditingController();

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
                return CustomNestedSearchableAppBar(
                  textEditingController: searchTextController,
                  scrollController: scrollController,
                  onTextChanged: (text){
                    bloc.add(PrayerInQuranEventSetQuery(query: text));
                  },
                  onSearchVisibilityChanged: (isSearchVisible){
                    bloc.add(PrayerInQuranEventSetSearchBarVisibility(isVisible: isSearchVisible));
                  },
                  searchBarVisible: isSearchBarVisible,
                  floating: true,
                  snap: true,
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

            return CustomScrollablePositionedList(
              itemCount: items.length,
              shrinkWrap: true,
              itemScrollController: itemScrollController,
              delayMilliSeconds: 50,
              onScroll: (scrollDirection){
                scrollController.setScrollDirectionAndAnimateTopBar(scrollDirection);
              },
              onVisibleItemChanged: (min,max){
                positionController.setPositions(min, max,totalItems: state.items.length);
              },
              itemBuilder: (context, index){
                final prayerUnit = items[index];
                final prayer = prayerUnit.item;
                return PrayerInQuranItem(
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
                    }
                  },
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
      NavigateToIcon(
        positionController: positionController,
        onPosChanged: (selectedIndex){
          itemScrollController.jumpTo(index: selectedIndex);
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
    return BlocListener<PrayerInQuranBloc,PrayerInQuranState>(
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
      child: child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchTextController.dispose();
    positionController.dispose();
    scrollController.dispose();
  }
}
