
import 'package:hadith/core/domain/enums/font_size/font_family_arabic.dart';
import 'package:hadith/core/domain/enums/font_size/font_size.dart';

abstract class ISelectFontSizeEvent{}

class SelectFontSizeEventInit extends ISelectFontSizeEvent{}

class SelectFontSizeEventSetContentSize extends ISelectFontSizeEvent{
  final FontSizeEnum fontSize;
  SelectFontSizeEventSetContentSize({required this.fontSize});
}

class SelectFontSizeEventSetArabicSize extends ISelectFontSizeEvent{
  final FontSizeEnum fontSize;
  SelectFontSizeEventSetArabicSize({required this.fontSize});
}

class SelectFontSizeEventSetArabicFamily extends ISelectFontSizeEvent{
  final FontFamilyArabicEnum fontFamilyArabic;
  SelectFontSizeEventSetArabicFamily({required this.fontFamilyArabic});
}

class SelectFontSizeEventSave extends ISelectFontSizeEvent{}

class SelectFontSizeEventReset extends ISelectFontSizeEvent{}

class SelectFontSizeEventClearMessage extends ISelectFontSizeEvent{}