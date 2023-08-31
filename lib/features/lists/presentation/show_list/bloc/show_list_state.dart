
import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/features/lists/domain/list_tab_enum.dart';



import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'show_list_state.freezed.dart';

@freezed
class ShowListState with _$ShowListState{
  const factory ShowListState({
    required ListTabEnum currentTab,
    required bool searchBarVisible,
    required List<ListViewModel> listHadiths,
    required List<ListViewModel> listVerses,
    String? message,
  }) = _ShowListState;

  static ShowListState init(){
    return ShowListState(
      currentTab: ListTabEnumExt.defaultTab,
      searchBarVisible: false,
      listHadiths: const [],
      listVerses: const []
    );
  }

}