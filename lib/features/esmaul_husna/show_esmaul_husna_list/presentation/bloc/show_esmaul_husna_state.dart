

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran.dart';
import 'package:hadith/features/esmaul_husna/shared/domain/esmaul_husna.dart';

part 'show_esmaul_husna_state.freezed.dart';

@freezed
class ShowEsmaulHusnaState with _$ShowEsmaulHusnaState{

  const ShowEsmaulHusnaState._();

  const factory ShowEsmaulHusnaState({
    required List<EsmaulHusna> items,
    required bool isLoading,
    required FontModel fontModel,
    required String searchQuery,
    required SearchCriteriaEnum searchCriteria,
    required bool isSearchBarVisible,
    int? jumpToPos
  }) = _ShowEsmaulHusnaState;
  
  static ShowEsmaulHusnaState init(){
    return ShowEsmaulHusnaState(
      fontModel: FontModel.init(),
      items: [],
      isLoading: false,
      isSearchBarVisible: false,
      searchQuery: "",
      searchCriteria: SearchCriteriaEnum.defaultValue,
    );
  }

  SearchParam get searchParam => SearchParam(
      searchCriteria: searchCriteria,
      searchQuery: searchQuery
  );

}