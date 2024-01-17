
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/verse_number.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';

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

