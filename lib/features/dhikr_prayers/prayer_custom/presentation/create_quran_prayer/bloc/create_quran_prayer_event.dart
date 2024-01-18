


import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';
import 'package:hadith/core/features/verses/domain/model/verse_number.dart';

abstract class ICreateQuranPrayerEvent{}

class CreateQuranPrayerEventClearMessage extends ICreateQuranPrayerEvent{}

class CreateQuranPrayerEventClearSetName extends ICreateQuranPrayerEvent{}

class CreateQuranPrayerEventCheckAutoGenerateName extends ICreateQuranPrayerEvent{
  final String text;
  CreateQuranPrayerEventCheckAutoGenerateName({required this.text});
}

class CreateQuranPrayerEventCheckAutoGenerateNameImmediately extends ICreateQuranPrayerEvent{
  final String text;
  CreateQuranPrayerEventCheckAutoGenerateNameImmediately({required this.text});
}

class CreateQuranPrayerEventAutoGenerateName extends ICreateQuranPrayerEvent{}


class CreateQuranPrayerEventInit extends ICreateQuranPrayerEvent{}

class CreateQuranPrayerEventSelectCuz extends ICreateQuranPrayerEvent{
  final Cuz cuz;
  CreateQuranPrayerEventSelectCuz({required this.cuz});
}

class CreateQuranPrayerEventSelectSurah extends ICreateQuranPrayerEvent{
  final Surah surah;
  CreateQuranPrayerEventSelectSurah({required this.surah});
}

class CreateQuranPrayerEventSelectVerse extends ICreateQuranPrayerEvent{
  final VerseNumber verseNumber;
  final bool isFirstField;
  CreateQuranPrayerEventSelectVerse({
    required this.verseNumber,
    required this.isFirstField
  });
}

class CreateQuranPrayerEventInsert extends ICreateQuranPrayerEvent{
  final String name;
  CreateQuranPrayerEventInsert({required this.name});
}

class CreateQuranPrayerEventClearNavigateBack extends ICreateQuranPrayerEvent{}

