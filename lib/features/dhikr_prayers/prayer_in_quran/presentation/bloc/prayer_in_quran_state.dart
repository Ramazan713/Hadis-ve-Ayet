

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/core/domain/models/font_model.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran.dart';

part 'prayer_in_quran_state.freezed.dart';

@freezed
class PrayerInQuranState with _$PrayerInQuranState{

  const PrayerInQuranState._();

  const factory PrayerInQuranState({
    required List<PrayerInQuran> items,
    required bool isLoading,
    required ArabicVerseUI2X arabicVerseUI2X,
    required FontModel fontModel,
    required String searchQuery,
    required SearchCriteriaEnum searchCriteria,
    required bool isSearchBarVisible,
    String? message
  }) = _PrayerInQuranState;
  
  static PrayerInQuranState init(){
    return PrayerInQuranState(
      fontModel: FontModel.init(),
      items: [],
      isLoading: false,
      isSearchBarVisible: false,
      searchQuery: "",
      searchCriteria: SearchCriteriaEnum.defaultValue,
      arabicVerseUI2X: KPref.quranPrayerVerseUi.defaultPrefEnum,
    );
  }

  SearchParam get searchParam => SearchParam(
    searchCriteria: searchCriteria,
    searchQuery: searchQuery
  );

}