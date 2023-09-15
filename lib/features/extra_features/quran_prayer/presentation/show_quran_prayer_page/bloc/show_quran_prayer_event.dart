

import 'package:hadith/core/domain/enums/verse_arabic_ui_2x_enum.dart';

abstract class IShowQuranPrayerEvent{}

class ShowQuranPrayerEventInit extends IShowQuranPrayerEvent{}

class ShowQuranPrayerEventSetUi extends IShowQuranPrayerEvent{
  final ArabicVerseUI2X verseUIEnum;
  ShowQuranPrayerEventSetUi({required this.verseUIEnum});
}
