

import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/models/font_model.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';

class FontModelUseCase{

  late final AppPreferences _appPreferences;

  FontModelUseCase({
    required AppPreferences appPreferences
  }){
    _appPreferences = appPreferences;
  }

  FontModel call(){
    final contentFontSize = _appPreferences.getItem(KPref.fontSizeContent);
    final arabicFontSize = _appPreferences.getItem(KPref.fontSizeArabic);
    final fontFamilyArabic = _appPreferences.getEnumItem(KPref.fontFamilyArabic);

    return FontModel(
        contentFontSize: contentFontSize,
        arabicFontSize: arabicFontSize,
        arabicFontFamilyEnum: fontFamilyArabic
    );
  }
}