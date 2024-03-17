

import 'package:hadith/core/domain/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/enums/font_size/font_family_arabic.dart';
import 'package:hadith/core/domain/enums/font_size/font_size.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/enums/verse_ui_4x_enum.dart';
import 'package:hadith/core/domain/preferences/model/pref_key_enum.dart';
import 'package:hadith/core/features/theme/domain/enums/theme_type_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/audio_quality_enum.dart';

import '../domain/preferences/model/pref_key.dart';

class KPref{

  static final PrefKey<bool> useDynamicColors = PrefKey(key: "useDynamicColors", defaultValue: true);
  static final PrefKey<bool> useArchiveListFeatures = PrefKey(key: "useArchiveListFeatures", defaultValue: false);
  static final PrefKey<bool> showVerseListIcons = PrefKey(key: "showVerseListIcons", defaultValue: true);
  static final PrefKey<double> audioPlayerSpeed = PrefKey(key: "audioPlayerSpeed", defaultValue: 1.0);
  static final PrefKey<bool> audioFollowWithText = PrefKey(key: "audioFollowWithText", defaultValue: true);
  static final PrefKey<bool> askListenAudioNotificationPermission = PrefKey(key: "askListenAudioNotificationPermission", defaultValue: true);
  static final PrefKey<bool> askDownloadAudioNotificationPermission = PrefKey(key: "askDownloadAudioNotificationPermission", defaultValue: true);
  static final PrefKey<int> defaultLastCounter = PrefKey(key: "defaultLastCounter", defaultValue: 0);
  static final PrefKey<bool> eachDhikrVibration = PrefKey(key: "eachDhikrVibration", defaultValue: false);
  static final PrefKey<bool> eachEndOfTourVibration = PrefKey(key: "eachEndOfTourVibration", defaultValue: true);
  static final PrefKey<bool> showDownloadDiaInLogin= PrefKey<bool>(key: "showDownloadDiaInLogin", defaultValue: true);
  static final PrefKey<bool> showCounterDetailContents = PrefKey<bool>(key: "showCounterDetailContents", defaultValue: true);
  static final PrefKey<String> counterBackupDate = PrefKey<String>( key: "counterBackupDate",defaultValue: "");
  static final PrefKey<bool> selectDhikrShowDetails = PrefKey<bool>( key: "addCounterShowDetails",defaultValue: false);
  static final PrefKey<bool> showCustomPrayersShowDetailContents = PrefKey<bool>(key: "showCustomPrayersShowDetailContents", defaultValue: true);

  static final PrefKey<int> selectEditionAudioSurahId = PrefKey<int>(key: "selectEditionAudioSurahId", defaultValue: 1);
  static final PrefKey<String> selectEditionAudioStartVerseId = PrefKey<String>(key: "selectEditionAudioStartVerseId", defaultValue: "1");
  static final PrefKey<String> selectEditionAudioEndVerseId = PrefKey<String>(key: "selectEditionAudioEndVerseId", defaultValue: "1");
  static final PrefKey<String> selectEditionAudioSource = PrefKey<String>(key: "selectEditionAudioSource", defaultValue: "Fatiha 1");
  static final PrefKey<List<String>> favoriteEditionsList = PrefKey<List<String>>(key: "favoriteEditionsList", defaultValue: const []);



  static final PrefKeyEnum<FontFamilyArabicEnum> fontFamilyArabic = PrefKeyEnum(key: "fontFamilyArabic",
      defaultPrefEnum: FontFamilyArabicEnum.defaultValue, from: FontFamilyArabicEnum.from);

  static final PrefKeyEnum<FontSizeEnum> fontSizeContent = PrefKeyEnum(key: "fontSizeEnumContent",
      defaultPrefEnum: FontSizeEnum.defaultValue, from: FontSizeEnum.from);

  static final PrefKeyEnum<FontSizeEnum> fontSizeArabic = PrefKeyEnum(key: "fontSizeEnumArabic",
      defaultPrefEnum: FontSizeEnum.defaultValue, from: FontSizeEnum.from);

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

  static final PrefKeyEnum<ThemeTypeEnum> themeTypeEnum = PrefKeyEnum(key: "themeTypeEnum",
      defaultPrefEnum: ThemeTypeEnum.defaultValue, from: ThemeTypeEnum.from);

  static final PrefKeyEnum<VerseUi4XEnum> counterUi = PrefKeyEnum(key: "counterUi",
      defaultPrefEnum: VerseUi4XEnum.defaultValue, from: VerseUi4XEnum.from);

  static final prefValues = <PrefKey<dynamic>>[
    useArchiveListFeatures, showVerseListIcons,audioPlayerSpeed,
    audioFollowWithText, askListenAudioNotificationPermission,askDownloadAudioNotificationPermission,
    defaultLastCounter, eachDhikrVibration, eachEndOfTourVibration, showDownloadDiaInLogin,useDynamicColors,
    counterBackupDate, showCounterDetailContents, selectDhikrShowDetails, showCustomPrayersShowDetailContents,
    selectEditionAudioSurahId, selectEditionAudioStartVerseId, selectEditionAudioEndVerseId, selectEditionAudioSource,
    favoriteEditionsList
  ];

  static final prefEnumValues = <PrefKeyEnum>[
    fontFamilyArabic,verseAppearanceEnum,searchCriteriaEnum,audioQualityEnum,quranPrayerVerseUi,
    prayerInQuranSearchCriteria, esmaulHusnaSearchCriteria, themeTypeEnum,
    fontSizeContent, fontSizeArabic, counterUi
  ];

}