
import 'package:hadith/features/verses/cuz/domain/models/cuz.dart';
import 'package:hadith/features/verses/shared/domain/models/verse_number.dart';
import 'package:hadith/features/verses/surah/domain/models/surah.dart';

abstract class ISelectVersePageEvent{}

class SelectVerseEventInitData extends ISelectVersePageEvent{}

class SelectVerseEventLoadData extends ISelectVersePageEvent{
  final int? startPage;
  SelectVerseEventLoadData({this.startPage});
}

class SelectVerseEventSelectCuz extends ISelectVersePageEvent{
  final Cuz cuz;
  SelectVerseEventSelectCuz({required this.cuz});
}

class SelectVerseEventSelectSurah extends ISelectVersePageEvent{
  final Surah surah;
  SelectVerseEventSelectSurah({required this.surah});
}

class SelectVerseEventSelectVerse extends ISelectVersePageEvent{
  final VerseNumber verseNumber;
  SelectVerseEventSelectVerse({required this.verseNumber});
}

class SelectVerseEventSelectPage extends ISelectVersePageEvent{
  final String page;
  SelectVerseEventSelectPage({required this.page});
}

class SelectVerseEventSelectPageExecute extends ISelectVersePageEvent{
  final int page;
  SelectVerseEventSelectPageExecute({required this.page});
}

class SelectVerseEventApprove extends ISelectVersePageEvent{}


class SelectVersePageEventClearMessage extends ISelectVersePageEvent{}

class SelectVerseEventClearResult extends ISelectVersePageEvent{}

