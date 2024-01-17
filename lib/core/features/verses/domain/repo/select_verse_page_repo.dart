

import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';

abstract class SelectVersePageRepo{

  Future<List<Cuz>> getCuzs();

  Future<List<Surah>> getSurahes();

  Future<int> getMaxPage();

  Future<List<String>> getVerseNumbers(int surahId);

  Future<int?> getPagePos(int pageNo, String verseNumber, int surahId, int cuzNo);

  Future<Surah?> validateSurahByCuzNo(Surah? surah, int cuzNo);
  Future<Surah?> validateSurahByPageNo(Surah? surah, int pageNo);

  Future<Cuz?> validateCuzBySurah(Cuz? cuz, int surahId, String verseNumber);
  Future<Cuz?> validateCuzByPageNo(Cuz? cuz, int pageNo);

  Future<String?> validateVerseNumber(String verseNumber, int surahId, int cuzNo);
  Future<String?> validateVerseNumberWithPage(String verseNumber, int surahId, int cuzNo, int pageNo);

  Future<int?> validatePageBySurah(int pageNo, int surahId, String verseNumber);
  Future<int?> validatePageByCuzNo(int pageNo, int cuzNo);
}