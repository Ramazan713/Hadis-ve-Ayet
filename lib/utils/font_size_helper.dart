

import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:rxdart/rxdart.dart';

class FontSizeHelper{


  static final _controller = BehaviorSubject<FontSize>.seeded(getFontSize());
  static final streamFontSize = _controller.stream;

  static FontSize getFontSize(){
    final index = LocalStorage.sharedPreferences.getInt(PrefConstants.fontSize.key)??PrefConstants.fontSize.defaultValue;
    return FontSize.values[index];
  }

  static Future<void> setFontSize(FontSize fontSize){
    _controller.add(fontSize);
    return LocalStorage.sharedPreferences.setInt(PrefConstants.fontSize.key, fontSize.index);
  }
}