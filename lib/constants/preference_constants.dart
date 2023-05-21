

import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/constants/enums/search_criteria_enum.dart';
import 'package:hadith/constants/enums/theme_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/features/verse/common_constants/audio_quality_enum.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/key_type_model.dart';
import '../features/save_point/constants/scope_filter_enum.dart';
import 'enums/verse_arabic_ui_2x_enum.dart';

class PrefConstants{

  static KeyTypeModel fontSize=KeyTypeModel<int>( key: "fontSize",defaultValue: FontSize.medium.index);
  static KeyTypeModel searchCriteriaEnum=KeyTypeModel<int>( key: "searchCriteriaEnum",defaultValue: SearchCriteriaEnum.multipleKeys.index);
  static KeyTypeModel scopeFilterEnum=KeyTypeModel<int>(key: "scopeFilterEnum",defaultValue: ScopeFilterEnum.scope.index);
  static KeyTypeModel themeTypeEnum=KeyTypeModel<int>( key: "themeTypeEnum",defaultValue: ThemeTypesEnum.system.index);
  static KeyTypeModel counterBackupDate=const KeyTypeModel<String>( key: "counterBackupDate",defaultValue: "");
  static KeyTypeModel useArchiveListFeatures=const KeyTypeModel<bool>(key: "useArchiveListFeatures",defaultValue: false);
  static KeyTypeModel showVerseListIcons=const KeyTypeModel<bool>(key: "showVerseListIcons",defaultValue: false);
  static KeyTypeModel askNotificationPermission=const KeyTypeModel<bool>(key: "askNotificationPermission",defaultValue: true);
  static KeyTypeModel audioPlayerSpeed=const KeyTypeModel<double>(key: "audioPlayerSpeed",defaultValue: 1.0);
  static KeyTypeModel audioQuality = KeyTypeModel<int>(key: "audioQuality",defaultValue: AudioQualityEnum.q64.quality);
  static KeyTypeModel audioFollowWithText = const KeyTypeModel<bool>(key: "audioFollowWithText",defaultValue: true);
  static KeyTypeModel eachDhikrVibration = const KeyTypeModel<bool>(key: "eachDhikrVibration",defaultValue: false);
  static KeyTypeModel eachEndOfTourVibration = const KeyTypeModel<bool>(key: "eachEndOfTourVibration",defaultValue: true);
  static KeyTypeModel defaultLastCounter = const KeyTypeModel<int>(key: "defaultLastCounter",defaultValue: 0);
  static KeyTypeModel counterUi = KeyTypeModel<int>(key: "counterUi",defaultValue: ArabicVerseUI3X.arabicPronunciation.index);

  static KeyTypeModel showDownloadDiaInLogin=const KeyTypeModel<bool>(key: "showDownloadDiaInLogin", defaultValue: true);
  static KeyTypeModel arabicVerseAppearanceEnum=KeyTypeModel<int>(key: "arabicVerseAppearanceEnum", defaultValue: ArabicVerseUI2X.both.index);
  static KeyTypeModel quranPrayerVerseUi=KeyTypeModel<int>(key: "quranPrayerVerseUi", defaultValue: ArabicVerseUI2X.both.index);



  static List<KeyTypeModel>values()=>[fontSize,searchCriteriaEnum,useArchiveListFeatures,showVerseListIcons,
    scopeFilterEnum,themeTypeEnum,counterBackupDate,showDownloadDiaInLogin,arabicVerseAppearanceEnum,
    audioPlayerSpeed,audioQuality,audioFollowWithText,askNotificationPermission,eachDhikrVibration,
    eachEndOfTourVibration,counterUi,quranPrayerVerseUi
  ];


  static Future<void>setDefaultValues()async{
    final SharedPreferences sharedPref=LocalStorage.sharedPreferences;

    for(var item in values()){
      switch(item.type){
        case int:
          await sharedPref.setInt(item.key, item.defaultValue);
          break;
        case String:
          await sharedPref.setString(item.key, item.defaultValue);
          break;
        case bool:
          await sharedPref.setBool(item.key, item.defaultValue);
          break;
        case double:
          await sharedPref.setDouble(item.key, item.defaultValue);
          break;
        case const (List<String>):
          await sharedPref.setStringList(item.key, item.defaultValue);
          break;
      }
    }

  }

}