
import 'package:collection/collection.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/features/lists/domain/list_tab_enum.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'show_list_state.freezed.dart';

@freezed
class ShowListState with _$ShowListState{

  const ShowListState._();

  const factory ShowListState({
    required ListTabEnum currentTab,
    required bool searchBarVisible,
    required List<ListViewModel> listHadiths,
    required List<ListViewModel> listVerses,
    required bool isDetailOpen,
    ListViewModel? selectedItem,
    String? message,
    int? jumpToPos
  }) = _ShowListState;

  ListViewModel? get currentSelectedVerseItem => listVerses.firstWhereOrNull((element) => element.id == (selectedItem?.id ?? 0));
  ListViewModel? get currentSelectedHadithItem => listHadiths.firstWhereOrNull((element) => element.id == (selectedItem?.id ?? 0));


  static ShowListState init(){
    return ShowListState(
      isDetailOpen: false,
      currentTab: ListTabEnumExt.defaultTab,
      searchBarVisible: false,
      listHadiths: const [],
      listVerses: const [],
    );
  }

}