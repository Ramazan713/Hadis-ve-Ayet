

import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/enums/font_family_arabic.dart';
import 'package:hadith/core/domain/preferences/model/pref_key_enum.dart';

import '../preferences/model/pref_key.dart';

class KPref{

  static final PrefKey<double> fontSizeContent = PrefKey(key: "fontSizeContent", defaultValue: 20);
  static final PrefKey<double> fontSizeArabic = PrefKey(key: "fontSizeArabic", defaultValue: 35);
  static final PrefKey<bool> useArchiveListFeatures = PrefKey(key: "useArchiveListFeatures", defaultValue: false);
  static final PrefKey<bool> showVerseListIcons = PrefKey(key: "showVerseListIcons", defaultValue: false);


  static final PrefKeyEnum<FontFamilyArabicEnum> fontFamilyArabic = PrefKeyEnum(key: "fontFamilyArabic",
      defaultPrefEnum: FontFamilyArabicEnum.defaultValue, from: FontFamilyArabicEnum.from);

  static final PrefKeyEnum<ArabicVerseUI2X> verseAppearanceEnum = PrefKeyEnum(key: "arabicVerseAppearanceEnum",
      defaultPrefEnum: ArabicVerseUI2X.defaultValue, from: ArabicVerseUI2X.from);


  static final prefValues = <PrefKey>[fontSizeContent, fontSizeArabic,
    useArchiveListFeatures, showVerseListIcons];
  static final prefEnumValues = <PrefKeyEnum>[fontFamilyArabic,verseAppearanceEnum];

}