
import 'package:hadith/core/domain/enums/font_family_arabic.dart';

abstract class ISelectFontSizeEvent{}

class SelectFontSizeEventInit extends ISelectFontSizeEvent{}

class SelectFontSizeEventSetContentSize extends ISelectFontSizeEvent{
  final double size;
  SelectFontSizeEventSetContentSize({required this.size});
}

class SelectFontSizeEventSetArabicSize extends ISelectFontSizeEvent{
  final double size;
  SelectFontSizeEventSetArabicSize({required this.size});
}

class SelectFontSizeEventSetArabicFamily extends ISelectFontSizeEvent{
  final FontFamilyArabicEnum fontFamilyArabic;
  SelectFontSizeEventSetArabicFamily({required this.fontFamilyArabic});
}

class SelectFontSizeEventSave extends ISelectFontSizeEvent{}

class SelectFontSizeEventReset extends ISelectFontSizeEvent{}

class SelectFontSizeEventClearMessage extends ISelectFontSizeEvent{}