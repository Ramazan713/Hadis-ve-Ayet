

import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/domain/enums/font_family_arabic.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/core/domain/preferences/model/pref_key_enum.dart';

import '../preferences/model/pref_key.dart';

class KPref{

  static final PrefKey<double> fontSizeContent = PrefKey(key: "fontSizeContent", defaultValue: 20);
  static final PrefKey<double> fontSizeArabic = PrefKey(key: "fontSizeArabic", defaultValue: 35);
  static final PrefKey<bool> useArchiveListFeatures = PrefKey(key: "useArchiveListFeatures", defaultValue: false);
  static final PrefKey<bool> showVerseListIcons = PrefKey(key: "showVerseListIcons", defaultValue: false);
  static final PrefKey<double> audioPlayerSpeed = PrefKey(key: "audioPlayerSpeed", defaultValue: 1.0);
  static final PrefKey<bool> audioFollowWithText = PrefKey(key: "audioFollowWithText", defaultValue: true);
  static final PrefKey<bool> askListenAudioNotificationPermission = PrefKey(key: "askListenAudioNotificationPermission", defaultValue: true);
  static final PrefKey<bool> askDownloadAudioNotificationPermission = PrefKey(key: "askDownloadAudioNotificationPermission", defaultValue: true);



  static final PrefKeyEnum<FontFamilyArabicEnum> fontFamilyArabic = PrefKeyEnum(key: "fontFamilyArabic",
      defaultPrefEnum: FontFamilyArabicEnum.defaultValue, from: FontFamilyArabicEnum.from);

  static final PrefKeyEnum<ArabicVerseUI2X> verseAppearanceEnum = PrefKeyEnum(key: "arabicVerseAppearanceEnum",
      defaultPrefEnum: ArabicVerseUI2X.defaultValue, from: ArabicVerseUI2X.from);

  static final PrefKeyEnum<ArabicVerseUI2X> quranPrayerVerseUi = PrefKeyEnum(key: "quranPrayerVerseUi",
      defaultPrefEnum: ArabicVerseUI2X.onlyMeal, from: ArabicVerseUI2X.from);

  static final PrefKeyEnum<SearchCriteriaEnum> searchCriteriaEnum = PrefKeyEnum(key: "searchCriteriaEnum",
      defaultPrefEnum: SearchCriteriaEnum.defaultValue, from: SearchCriteriaEnum.from);

  static final PrefKeyEnum<SearchCriteriaEnum> prayerInQuranSearchCriteria = PrefKeyEnum(key: "prayerInQuranSearchCriteria",
      defaultPrefEnum: SearchCriteriaEnum.defaultValue, from: SearchCriteriaEnum.from);

  static final PrefKeyEnum<SearchCriteriaEnum> esmaulHusnaSearchCriteria = PrefKeyEnum(key: "esmaulHusnaSearchCriteria",
      defaultPrefEnum: SearchCriteriaEnum.defaultValue, from: SearchCriteriaEnum.from);

  static final PrefKeyEnum<AudioQualityEnum> audioQualityEnum = PrefKeyEnum(key: "audioQuality",
      defaultPrefEnum: AudioQualityEnum.defaultValue, from: AudioQualityEnum.from);

  static final prefValues = <PrefKey>[
    fontSizeContent, fontSizeArabic, useArchiveListFeatures, showVerseListIcons,audioPlayerSpeed,
    audioFollowWithText, askListenAudioNotificationPermission,askDownloadAudioNotificationPermission
  ];

  static final prefEnumValues = <PrefKeyEnum>[
    fontFamilyArabic,verseAppearanceEnum,searchCriteriaEnum,audioQualityEnum,quranPrayerVerseUi,
    prayerInQuranSearchCriteria, esmaulHusnaSearchCriteria
  ];

}