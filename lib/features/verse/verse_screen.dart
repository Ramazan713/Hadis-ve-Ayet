import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/data_paging_status_enum.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/core/domain/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/dialogs/show_select_verse_ui_2x.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/constants/enums/sourcetype_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/constants/enums/verse_edit_enum.dart';
import 'package:hadith/constants/favori_list.dart';
import 'package:hadith/constants/menu_resources.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/dialogs/show_get_number_bottom_dia.dart';
import 'package:hadith/dialogs/show_select_font_size_bottom_dia.dart';
import 'package:hadith/features/paging/bloc/paging_bloc.dart';
import 'package:hadith/features/save_point/save_point_param.dart';
import 'package:hadith/features/add_to_list/model/edit_select_list_model.dart';
import 'package:hadith/features/add_to_list/bloc/list_bloc.dart';
import 'package:hadith/features/add_to_list/model/select_verse_list_loader.dart';
import 'package:hadith/features/display_page_state.dart';
import 'package:hadith/features/paging/i_paging_loader.dart';
import 'package:hadith/features/paging/paging_argument.dart';
import 'package:hadith/features/save_point/save_point_bloc/save_point_bloc.dart';
import 'package:hadith/features/save_point/save_point_bloc/save_point_state.dart';
import 'package:hadith/features/save_point/show_select_savepoint_bottom_dia.dart';
import 'package:hadith/features/verse/common_components/audio_player_widget.dart';
import 'package:hadith/features/verse/common_components/download_audio_info_item.dart';
import 'package:hadith/features/verse/common_components/verse_audios_connect.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_event.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_state.dart';
import 'package:hadith/models/menu_model.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:hadith/utils/share_utils.dart';
import 'package:hadith/features/share/show_preview_share_image_dia.dart';
import 'package:hadith/features/share/show_share_alert_dialog.dart';
import 'package:hadith/features/share/widget/list_tile_share_item.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_nested_scrollview.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';
import 'package:hadith/widgets/menu_button.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_constants.dart';
import '../paging/widgets/custom_scrolling_paging.dart';
import 'common_components/audio_info_item.dart';
import 'common_components/verse_item.dart';
import 'common_dialogs/show_select_edition.dart';
import '../../dialogs/show_select_verse_ui_3x.dart';
import 'common_dialogs/show_verse_bottom_menu.dart';
import 'common_models/verse_model.dart';

class VerseScreen extends StatefulWidget {
  static const id = "VerseScreen";
  const VerseScreen({Key? key}) : super(key: key);

  @override
  State<VerseScreen> createState() => _VerseScreenState();
}

class _VerseScreenState extends DisplayPageState<VerseScreen> with TickerProviderStateMixin {
  final SharedPreferences sharedPreferences = LocalStorage.sharedPreferences;
  late final bool useArchiveListFeatures;
  late final bool showListVerseIcons;

  ArabicVerseUI2X lastSelectedArabicUI = ArabicVerseUI2X.both;

  @override
  void initState() {
    super.initState();

    lastSelectedArabicUI = ArabicVerseUI2X.values[
        sharedPreferences.getInt(PrefConstants.arabicVerseAppearanceEnum.key) ??
            PrefConstants.arabicVerseAppearanceEnum.defaultValue];

    useArchiveListFeatures =
        sharedPreferences.getBool(PrefConstants.useArchiveListFeatures.key) ??
            PrefConstants.useArchiveListFeatures.defaultValue;

    showListVerseIcons =
        sharedPreferences.getBool(PrefConstants.showVerseListIcons.key) ??
            PrefConstants.showVerseListIcons.defaultValue;
  }

  void _showSavePointBottomDia(int itemIndex) {
    showSelectSavePointBottomDia(context,
        savePointParam: SavePointParam.fromPagingArgument(pagingArgument, itemIndex),
        changeLoaderListener: (savePoint) {
      setArgumentWithSavePoint(savePoint);
    });
  }

  void _execAppBarMenus(int selected) {
    switch (selected) {
      case MenuResources.fontSize:
        showSelectFontSizeBottomDia(context, listener: (fontSize) {
          customPagingController.setFontSizeEvent(fontSize.size);
        });
        break;
      case MenuResources.savePoint:
        _showSavePointBottomDia(lastIndex);
        break;
      case MenuResources.cleanSearchText:
        cleanableSearchText = null;
        rebuildItemNotifier.value = !rebuildItemNotifier.value;
        break;
      case MenuResources.showSelectEdition:
        showSelectEdition(context);
        break;
    }
  }

  List<Widget> getShareListItems(VerseModel item) {
    return [
      ListTileShareItem(
          title: "Resim Olarak Paylaş",
          onTap: () {
            final shareVerse =
                ShareUtils.shareImageExecutor(context, SourceTypeEnum.verse);
            showPreviewSharedImageDia(context,
                previewWidget: shareVerse.getPreviewWidget(context, item),
                onTap: () {
              shareVerse.snapshot(context, item);
            });
          },
          iconData: Icons.image),
      ListTileShareItem(
          title: "Yazı Olarak Paylaş",
          onTap: () {
            ShareUtils.shareText(item.item, SourceTypeEnum.verse);
          },
          iconData: Icons.text_format)
    ];
  }

  void _execShowBottomMenu(VerseModel item, ListBloc listBloc,
      List<VerseModel> items, VerseAudioBloc audioBloc) async {
    showVerseBottomMenu(context,
        isFavorite: item.isFavorite,
        verse: item.item,
        isAddListNotEmpty: item.isAddListNotEmpty,
        listener: (verseEditEnum) async {
      switch (verseEditEnum) {
        case VerseEditEnum.play:
          audioBloc.add(AudioEventRequestOption(verseModel: item,originTag: getArgument().originTag));
          Navigator.pop(context);
          break;
        case VerseEditEnum.share:
          showShareAlertDialog(context, listItems: getShareListItems(item));
          break;
        case VerseEditEnum.addList:
          Navigator.pop(context);
          final listParam = EditSelectListModel(
              context: context,
              listCommon: item,
              favoriteListId: FavoriteListIds.verse,
              loader: getLoader(),
              updateArea: () {
                rebuildItems();
              });
          editSelectedLists(
              listParam,
              SelectVerseListLoader(
                  context: context, verseId: item.item.id ?? 0),
              false,
              changeListener: showListVerseIcons == false
                  ? null
                  : (selectedLists) {
                      final anyArchive = selectedLists.any((e) => e.isArchive);
                      final isNotEmptyList = selectedLists.isNotEmpty;
                      var isRebuild = false;
                      if (useArchiveListFeatures &&
                          anyArchive != item.isArchiveAddedToList) {
                        item.isArchiveAddedToList = anyArchive;
                        isRebuild = true;
                      }
                      if (isNotEmptyList != item.isAddListNotEmpty) {
                        item.isAddListNotEmpty = isNotEmptyList;
                        isRebuild = true;
                      }
                      if (isRebuild) {
                        rebuildItems();
                      }
                    });
          break;
        case VerseEditEnum.copy:
          ShareUtils.copyVerseText(item.item);
          break;
        case VerseEditEnum.addFavorite:
          final listParam = EditSelectListModel(
              context: context,
              listCommon: item,
              favoriteListId: FavoriteListIds.verse,
              loader: getLoader(),
              updateArea: () {
                rebuildItems();
              });
          listBloc.setLoader(SelectVerseListLoader(
            context: context,
            verseId: item.item.id ?? 0,
          ));
          addOrRemoveFavoriteList(listParam, listBloc, !item.isFavorite,
              reloadPagingListener: () {
            Navigator.pop(context);
          });
          break;
        case VerseEditEnum.savePoint:
          Navigator.pop(context);
          _showSavePointBottomDia(item.rowNumber);
          break;
      }
    });
  }

  void onContentTap(VerseAudioBloc audioBloc) {
    audioBloc.add(AudioEventChangeVisibilityAudioWidget());
  }

  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget buildPage(BuildContext context) {
    final audioBloc = context.read<VerseAudioBloc>();

    if (pagingArgument.originTag == OriginTag.search &&
        lastSelectedArabicUI == ArabicVerseUI2X.onlyArabic) {
      lastSelectedArabicUI = ArabicVerseUI2X.onlyMeal;
    }

    return VerseAudiosConnect(
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => CustomPagingBloc())],
        child: Scaffold(
            bottomSheet: getBottomSheet(context),
            resizeToAvoidBottomInset: kResizeToAvoidBottomInset,
            backgroundColor: Theme.of(context).primaryColor,
            body: SafeArea(
              child: CustomSliverNestedView(
                context,
                scrollController: nestedViewScrollController,
                isBottomNavAffected: false,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    CustomSliverAppBar(
                      title: ValueListenableBuilder(
                        valueListenable: changeBarTitleNotifier,
                        builder: (context, value, child) {
                          return Text(pagingArgument.title);
                        },
                      ),
                      actions: [
                        IconButton(
                          onPressed: () async{
                            showSelectVerseUi2X(context, callback: (selected) {
                              lastSelectedArabicUI = selected;
                              rebuildItems();
                            });
                          },
                          icon: const Icon(Icons.view_agenda),
                          tooltip: "Görünümü Değiştir",
                        ),
                        IconButton(
                            onPressed: () async {
                              showGetNumberBottomDia(context, (selected) {
                                customPagingController.setPageEvent(
                                    limitNumber: limitCount,
                                    itemIndex: selected);
                              },
                                  currentIndex: lastIndex,
                                  limitIndex: itemCount - 1);
                            },
                            icon: const Icon(Icons.map)),
                        ValueListenableBuilder(
                            valueListenable: rebuildItemNotifier,
                            builder: (context, value, child) {
                              return MenuButton<int>(
                                  items: getPopUpMenus()
                                    ..add(MenuModel(label: "Kıraat Seç", value: MenuResources.showSelectEdition,
                                        iconData: Icons.record_voice_over)),
                                  selectedFunc: (selected) {
                                    _execAppBarMenus(selected);
                                  });
                            }),
                      ],
                    )
                  ];
                },
                child: BlocListener<SavePointBloc, SavePointState>(
                  listener: (context, state) {
                    if (state.status == DataStatus.success) {
                      final itemIndex = (state.savePoint?.itemIndexPos) ?? 0;
                      customPagingController.setPageEventWhenReady(
                          limitNumber: limitCount, itemIndex: itemIndex);
                    }
                  },
                  child: GestureDetector(
                    onTap: (){onContentTap(audioBloc);},
                    child:  Column(
                      children: [
                        const DownloadAudioInfoItem(),
                        const AudioInfoItem(),
                        Expanded(
                          child: CustomScrollingPaging(
                              itemScrollController: itemScrollController,
                              customPagingController: customPagingController,
                              loader: getLoader(),
                              buildWhen: (prevState, nextState) {
                                if (nextState.status ==
                                    DataPagingStatus.setPagingSuccess) {
                                  itemCount = nextState.itemCount;
                                }
                                return true;
                              },
                              itemBuilder: (context, index, item, state) {
                                if (item is VerseModel) {
                                  return BlocConsumer<VerseAudioBloc, VerseAudioState>(
                                    listenWhen:(prevState, nextState) {
                                      return prevState.currentAudio?.audio?.mealId !=
                                          nextState.currentAudio?.audio?.mealId && nextState.isActive();
                                    },
                                    listener: (context,audioState){
                                      if(audioState.followAudioText){
                                        final index = state.items.indexWhere((element) => element.item.id == audioState.getAudio()?.mealId);
                                        if(index!=-1){
                                          itemScrollController.scrollTo(
                                              index: index,
                                              alignment: 0.2,
                                              duration: const Duration(milliseconds: 300));
                                        }
                                      }
                                    },
                                    buildWhen: (prevState, nextState) {
                                      return prevState.currentAudio?.audio?.mealId !=
                                          nextState.currentAudio?.audio?.mealId || prevState.isActive()!=nextState.isActive();
                                    },
                                    builder: (context, audioState) {
                                      return ValueListenableBuilder(
                                          valueListenable: rebuildItemNotifier,
                                          builder: (context, value, child) {
                                            return VerseItem(
                                              key: ObjectKey(value),
                                              isSelected: audioState.isActive() &&
                                                  item.item.id == audioState.currentAudio?.audio?.mealId,
                                              rowNumber: item.rowNumber,
                                              arabicVerseUIEnum:
                                              lastSelectedArabicUI,
                                              verseModel: item,
                                              searchKey: cleanableSearchText,
                                              fontSize: state.fontSize,
                                              showListVerseIcons:
                                              showListVerseIcons,
                                              searchCriteriaEnum:
                                              searchCriteriaEnum,
                                              onLongPress: () {
                                                _execShowBottomMenu(item, listBloc,
                                                    state.items.map((e) => e as VerseModel).toList(), audioBloc);
                                              },
                                              onPress: () {
                                                onContentTap(audioBloc);
                                              },
                                            );
                                          });
                                    },
                                  );
                                }
                                return const Text("");
                              },
                              page: 1,
                              isPlaceHolderActive: true,
                              limitNumber: limitCount,
                              prevLoadingPlaceHolderCount: 1,
                              forwardValue: 3,
                              minMaxListener: (minPos, maxPos, state) {
                                lastIndex =
                                    state?.items[(minPos + maxPos) ~/ 2]?.rowNumber;
                                checkAppBarVisibilityForTop(minPos);
                              },
                              scrollListener: (isScrollUp, state) {
                                appBarVisibility(isScrollUp, state);
                              },
                              isItemLoadingWidgetPlaceHolder: true,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }


  Widget getBottomSheet(BuildContext context){
    return BlocSelector<VerseAudioBloc,VerseAudioState,int?>(
        selector: (state)=>state.currentSavePointId(),
        builder: (context,currentSavepointId){
          return AudioPlayerWidget(onBookmarkClick: (){
            showSelectSavePointBottomDia(context,
                title: "Kayıt Noktası Seç",
                description: "Dinleme sonrasında otomatik olarak kaydedilmesi için bir kayıt noktası seçiniz",
                defaultSelectedSavePointId: currentSavepointId,
                savePointParam: SavePointParam.fromPagingArgument(pagingArgument, 0),
                customBottomButtons: (savePoint){
                  return CustomButtonPositive(onTap: () {
                    context.read<VerseAudioBloc>()
                        .add(AudioEventSetSavePointId(savepointId: savePoint?.id));
                    Navigator.pop(context);
                  },);
                }
            );
          });
        }
    );
  }

  @override
  PagingArgument getArgument() => pagingArgument;

  @override
  IPagingLoader getLoader() => pagingArgument.loader;

  @override
  void setArgument(PagingArgument newArgument) {
    pagingArgument = newArgument;
  }
}
