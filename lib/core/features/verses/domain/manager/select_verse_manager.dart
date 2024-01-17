
import 'package:hadith/core/features/verses/domain/model/select_verse_init_model/select_verse_init_model.dart';

import '../model/cuz.dart';
import '../model/surah.dart';
import '../model/select_verse_model/select_verse_model.dart';
import '../model/verse_number.dart';

abstract class SelectVerseManager{

  Future<SelectVerseInitModel> getInitModel();

  Future<SelectVerseModel> selectCuz({
    required Cuz currentCuz,
    int? currentPage,
    Surah? currentSurah,
    VerseNumber? currentVerseNumber
  });

  Future<SelectVerseModel> selectSurah({
    required Surah currentSurah,
    Cuz? currentCuz,
    int? currentPage,
    VerseNumber? currentVerseNumber
  });

  Future<SelectVerseModel> selectVerse({
    required VerseNumber currentVerseNumber,
    Surah? currentSurah,
    Cuz? currentCuz,
    int? currentPage,
  });

  Future<SelectVerseModel> selectPage({
    required int currentPage,
    VerseNumber? currentVerseNumber,
    Surah? currentSurah,
    Cuz? currentCuz,
  });
}