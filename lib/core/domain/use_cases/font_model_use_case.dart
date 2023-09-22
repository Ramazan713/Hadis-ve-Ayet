

import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';

class FontModelUseCase{

  late final AppPreferences _appPreferences;

  FontModelUseCase({
    required AppPreferences appPreferences
  }){
    _appPreferences = appPreferences;
  }

  FontModel call(){
    final contentFontSize = _appPreferences.getEnumItem(KPref.fontSizeContent);
    final arabicFontSize = _appPreferences.getEnumItem(KPref.fontSizeArabic);
    final fontFamilyArabic = _appPreferences.getEnumItem(KPref.fontFamilyArabic);

    return FontModel(
      contentFontSizeEnum: contentFontSize,
      arabicFontSizeEnum: arabicFontSize,
      arabicFontFamilyEnum: fontFamilyArabic
    );
  }
}