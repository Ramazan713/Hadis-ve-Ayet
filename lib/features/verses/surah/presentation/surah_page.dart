import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/domain/enums/topic_save_point.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_bloc.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_event.dart';
import 'package:hadith/core/features/manage_downloaded_audio/manage_downloaded_audio_listener.dart';
import 'package:hadith/core/features/save_point/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/load_save_point/bloc/load_save_point_event.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_state.dart';
import 'package:hadith/core/features/topic_save_point/components/topic_save_point_floating_action_button.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_appbar_searchable.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view.dart';
import 'package:hadith/core/presentation/components/dropdown_bar_menu.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/core/presentation/dialogs/show_select_edition.dart';
import 'package:hadith/dialogs/show_custom_alert_bottom_dia.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';
import 'package:hadith/features/verse/common_components/audio_state_icon_item.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verses/shared/domain/model/audio_info_result_model.dart';
import 'package:hadith/features/verses/shared/domain/model/verse_topic_model.dart';
import 'package:hadith/features/verses/shared/presentation/compoenents/audio_connect.dart';
import 'package:hadith/features/verses/shared/presentation/compoenents/verse_topic_item/verse_topic_audio_info.dart';
import 'package:hadith/features/verses/shared/presentation/compoenents/verse_topic_item/verse_topic_item.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_event.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/components/download_audio_info_item.dart';
import 'package:hadith/features/verses/shared/presentation/handlers/verse_topic_bottom_menu_handler.dart';
import 'package:hadith/features/verses/surah/domain/enums/surah_top_bar_menu_item.dart';
import 'package:hadith/models/shimmer/shimmer_widgets.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'bloc/surah_bloc.dart';
import 'bloc/surah_event.dart';
import 'bloc/surah_state.dart';

class SurahPage extends StatelessWidget {
  SurahPage({Key? key,}) : super(key: key);

  final ItemScrollController _itemScrollController = ItemScrollController();
  final CustomScrollController _scrollController = CustomScrollController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SurahBloc>();
    final topicSavePointBloc = context.read<TopicSavePointBloc>();

    topicSavePointBloc.add(TopicSavePointEventLoadData(topicType: TopicSavePointTypeSurah()));

    return AudioConnect(
      child: ManageDownloadedAudioListener(
        child: BlocSelector<SurahBloc, SurahState, bool>(
          selector: (state)=>state.searchBarVisible,
          builder: (context,isSearchBarVisible){
            return WillPopScope(
              onWillPop: (){
                if(isSearchBarVisible){
                  bloc.add(SurahEventSetSearchBarVisibility(isSearchBarVisible: false));
                  return Future.value(false);
                }
                return Future.value(true);
              },
              child: Scaffold(
                floatingActionButton: _getFloatingActionWidget(),
                body: SafeArea(
                  child: CustomNestedView(
                      scrollController: _scrollController,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return [
                          _getAppBar()
                        ];
                      },
                      child: Column(
                        children: [
                          const DownloadAudioInfoItem(),
                          Expanded(
                            child: BlocBuilder<SurahBloc, SurahState>(
                              buildWhen: (prevState, nextState){
                                return prevState.items != nextState.items ||
                                    prevState.searchBarVisible != nextState.searchBarVisible;
                              },
                              builder: (context, state){
                                final items = state.items;

                                return BlocSelector<TopicSavePointBloc,TopicSavePointState, TopicSavePoint?>(
                                    selector: (state)=>state.topicSavePoint,
                                    builder: (context, currentTopicSavePoint){

                                      if(state.isLoading){
                                        return ListView.builder(itemBuilder: (context, index) {
                                          return getTopicShimmer(context);
                                        },itemCount: 19,);
                                      }

                                      return VerseTopicAudioInfo(
                                        selectListenState: (state) => state?.surahId,
                                        selectDownloadState: (state) => state?.surahId,
                                        builder: (info){
                                          return CustomScrollablePositionedList(
                                            itemCount: items.length,
                                            delayMilliSeconds: 200,
                                            onScroll: (scrollDirection){
                                              _scrollController.setScrollDirection(scrollDirection);
                                            },
                                            itemScrollController: _itemScrollController,
                                            itemBuilder: (context, index){
                                              final item = items[index];
                                              final surah = item.data;
                                              final hasSavePoint = currentTopicSavePoint?.pos == index;

                                              return VerseTopicItem(
                                                label: "${surah.id}. ${surah.name} ",
                                                itemId: surah.id,
                                                downloadedAudioView: item.audioViewModel,
                                                infoResult: info,
                                                hasSavePoint: !state.searchBarVisible && hasSavePoint,
                                                onTap: (){
                                                  VerseShowSurahRoute(surahId: surah.id)
                                                      .push(context);
                                                },
                                                onLongPress: state.searchBarVisible ? null : (){
                                                  verseTopicBottomMenuSharedHandler(context,
                                                    itemId: surah.id,
                                                    hasSavePoint: hasSavePoint,
                                                    topicModel: item,
                                                    audioResult: info,
                                                    index: index,
                                                    audioOption: QuranAudioOption.surah,
                                                    onGoToLastSavePoint: (){
                                                      context.read<LoadSavePointBloc>().add(LoadSavePointEventLoadLastOrDefault(
                                                          destination: DestinationSurah(
                                                              surahName: surah.name,
                                                              surahId: surah.id
                                                          ),
                                                          autoType: SaveAutoType.none
                                                      ));
                                                    }
                                                  );
                                                },
                                                iconData: FontAwesomeIcons.bookQuran,
                                              );
                                            },
                                          );
                                        },
                                      );
                                    });
                              },
                            ),
                          )
                        ],
                      )
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getFloatingActionWidget(){
    return BlocSelector<SurahBloc,SurahState,bool>(
        selector: (state) => !state.searchBarVisible,
        builder: (context, showFab){
          return TopicSavePointFloatingActionButton(
            controller: _scrollController,
            showFab: showFab,
            onSavePointClick: (topicSavePoint){
              _itemScrollController.scrollTo(
                  index: topicSavePoint.pos,
                  duration: const Duration(milliseconds: 300),
                  alignment: 0.5
              );
            },
          );
        }
    );
  }
}

extension TopicPageTopBarExt on SurahPage{

  Widget _getAppBar(){
    return BlocSelector<SurahBloc, SurahState, bool>(
      selector: (state)=>state.searchBarVisible,
      builder: (context, searchBarVisible){
        return CustomAppBarSearchable(
          searchBarVisible: searchBarVisible,
          onChanged: (text){
            context.read<SurahBloc>().add(SurahEventSearch(query: text));
          },
          onClosed: (){
            context.read<SurahBloc>()
                .add(SurahEventSetSearchBarVisibility(isSearchBarVisible: false));
          },
          sliverAppBar: _sliverAppBar(context),
        );
      },
    );
  }

  CustomSliverAppBar _sliverAppBar(BuildContext context){
    return CustomSliverAppBar(
      title: const Text("Sure"),
      snap: true,
      floating: true,
      actions: [
        IconButton(
          onPressed: () {
            context.read<SurahBloc>()
                .add(SurahEventSetSearchBarVisibility(isSearchBarVisible: true));
          },
          icon: const Icon(Icons.search),
          tooltip: "Ara",
        ),
        _getDropdownMenu(context)
      ],
    );
  }

  Widget _getDropdownMenu(BuildContext context){
    return CustomDropdownBarMenu(
      items: SurahTopBarMenuItem.values,
      selectedFunc: (menuItem){
        switch(menuItem){
          case SurahTopBarMenuItem.selectEdition:
            showSelectEdition(context);
            break;
          case SurahTopBarMenuItem.selectSavePoint:
            showSelectSavePoints(context,
              shortTitle: "Surah",
              savePointType:  SavePointType.surah,
              bookScope: BookScopeEnum.diyanetMeal,
            );
            break;
        }
      },
    );
  }

}
