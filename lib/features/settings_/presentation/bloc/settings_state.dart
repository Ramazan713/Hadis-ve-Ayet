


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/features/settings_/domain/models/user_info_model.dart';
part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState{
  const factory SettingsState({
    required String packageInfo,
    required SearchCriteriaEnum searchCriteria,
    required ArabicVerseUI2X verseUI,
    required FontModel fontModel,
    required bool showSelectedListVerseIcons,
    required bool useArchiveAsSelectList,
    UserInfoModel? currentUserInfo,
    String?message
  }) = _SettingsState;

  static SettingsState init(){
    return SettingsState(
      packageInfo: "",
      fontModel: FontModel.init(),
      searchCriteria: KPref.searchCriteriaEnum.defaultPrefEnum,
      verseUI: KPref.verseAppearanceEnum.defaultPrefEnum,
      showSelectedListVerseIcons: KPref.showVerseListIcons.defaultValue,
      useArchiveAsSelectList: KPref.useArchiveListFeatures.defaultValue,
    );
  }

}