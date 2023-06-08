import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/paging/scroll_direction.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/enums/topic_save_point.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/core/features/save_point/show_save_point/show_select_save_point.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_state.dart';
import 'package:hadith/core/features/topic_save_point/components/topic_save_point_floating_action_button.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_appbar_searchable.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view.dart';
import 'package:hadith/core/presentation/components/navigation_icon.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/core/presentation/controllers/custom_scroll_controller.dart';
import 'package:hadith/core/presentation/components/custom_scrollable_positioned_list.dart';
import 'package:hadith/dialogs/show_get_number_bottom_dia.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/verse/common_components/audio_state_icon_item.dart';
import 'package:hadith/features/verses/shared/presentation/compoenents/verse_topic_item.dart';
import 'package:hadith/features/verses/surah/domain/enums/surah_save_point_menu_item.dart';
import 'package:hadith/models/shimmer/shimmer_widgets.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../domain/models/surah.dart';
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

    return BlocSelector<SurahBloc, SurahState, bool>(
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

                            return CustomScrollablePositionedList(
                              itemCount: items.length,
                              debouncerDelayMilliSeconds: 50,
                              onScroll: (scrollDirection){
                                _scrollController.setScrollDirection(scrollDirection);
                              },
                              itemScrollController: _itemScrollController,
                              itemBuilder: (context, index){
                                final item = items[index];
                                final hasSavePoint = currentTopicSavePoint?.pos == index;

                                return AudioStateIconItem<int?>(
                                  keyFuncAudio: (state)=>state.getAudio()?.surahId,
                                  keyFuncDownload: (state)=>state.getVoiceModel()?.surahId,
                                  value: item.id,
                                  builder: (bool isDownloadingActive,bool isAudioRunning){
                                    return VerseTopicItem(
                                      label: "${item.id}. ${item.name} ",
                                      isDownloadingActive: isDownloadingActive,
                                      isAudioRunning: isAudioRunning,
                                      hasSavePoint: !state.searchBarVisible && hasSavePoint,
                                      onTap: (){

                                      },
                                      onLongPress: state.searchBarVisible ? null : (){
                                        _handleBottomMenu(context, hasSavePoint, index);
                                      },
                                      iconData: FontAwesomeIcons.bookQuran,
                                    );
                                  });
                              },
                            );
                          });
                    },
                  )
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleBottomMenu(BuildContext context, bool hasSavePoint, int index){
    final topicSavePointBloc = context.read<TopicSavePointBloc>();
    showBottomMenuItems(
        context,
        items: SurahSavePointMenuItem.getMenuItems(hasSavePoint),
        onItemClick: (menuItem){
          switch(menuItem){
            case SurahSavePointMenuItem.goToLastSavePoint:
              break;
            case SurahSavePointMenuItem.signSavePoint:
              topicSavePointBloc.add(TopicSavePointEventInsertSavePoint(pos: index));
              break;
            case SurahSavePointMenuItem.unSignSavePoint:
              topicSavePointBloc.add(TopicSavePointEventDeleteSavePoint());
              break;
          }
          context.pop();
        }
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
              _itemScrollController.scrollTo(index: topicSavePoint.pos,
                  duration: const Duration(milliseconds: 300));
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
            showSelectSavePoints(context,
              shortTitle: "Surah",
              menuItems: SavePointTypeBarExt.getSavePointTypes(BookEnum.diyanetMeal),
              filter: SavePointType.surah,
            );
          },
          icon: const Icon(Icons.save),
          tooltip: "Kayıt Noktası",
        ),
        IconButton(
          onPressed: () {
            context.read<SurahBloc>()
                .add(SurahEventSetSearchBarVisibility(isSearchBarVisible: true));
          },
          icon: const Icon(Icons.search),
          tooltip: "Ara",
        ),
      ],
    );
  }

}
