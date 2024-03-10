


import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_load_config/select_quran_section_load_config.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/verse_number.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';

abstract class ISelectQuranSectionEvent{}

class SelectQuranSectionEventClearMessage extends ISelectQuranSectionEvent{}


class SelectQuranSectionEventInit extends ISelectQuranSectionEvent{}


class SelectQuranSectionEventLoadData extends ISelectQuranSectionEvent{
  final SelectQuranSectionLoadConfig loadConfig;
  final bool generateVerseContent;
  SelectQuranSectionEventLoadData({required this.generateVerseContent, required this.loadConfig});
}

class SelectQuranSectionEventSelectCuz extends ISelectQuranSectionEvent{
  final Cuz cuz;
  SelectQuranSectionEventSelectCuz({required this.cuz});
}

class SelectQuranSectionEventSelectSurah extends ISelectQuranSectionEvent{
  final Surah surah;
  SelectQuranSectionEventSelectSurah({required this.surah});
}

class SelectQuranSectionEventSelectVerse extends ISelectQuranSectionEvent{
  final VerseNumber verseNumber;
  final bool isFirstField;
  SelectQuranSectionEventSelectVerse({
    required this.verseNumber,
    required this.isFirstField
  });
}

class SelectQuranSectionEventCheckAutoGenerateName extends ISelectQuranSectionEvent{
  final String text;
  SelectQuranSectionEventCheckAutoGenerateName({required this.text});
}

class SelectQuranSectionEventCheckAutoGenerateNameImmediately extends ISelectQuranSectionEvent{
  final String text;
  SelectQuranSectionEventCheckAutoGenerateNameImmediately({required this.text});
}

class SelectQuranSectionEventAutoGenerateName extends ISelectQuranSectionEvent{}


class SelectQuranSectionEventSelectPage extends ISelectQuranSectionEvent{
  final String page;
  SelectQuranSectionEventSelectPage({required this.page});
}

class SelectQuranSectionEventSelectPageExecute extends ISelectQuranSectionEvent{
  final int page;
  SelectQuranSectionEventSelectPageExecute({required this.page});
}

class SelectVersePageEventClearMessage extends ISelectQuranSectionEvent{}

class SelectQuranSectionEventClearResult extends ISelectQuranSectionEvent{}

class SelectQuranSectionEventClearSetName extends ISelectQuranSectionEvent{}

class SelectQuranSectionEventSubmit extends ISelectQuranSectionEvent{
  final String name;
  final bool includeSelectedVerses;

  SelectQuranSectionEventSubmit({
    required this.name,
    required this.includeSelectedVerses,
  });
}




