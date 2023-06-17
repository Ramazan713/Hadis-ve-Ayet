
import 'package:hadith/features/verses/surah/domain/models/surah.dart';

abstract class SurahRepo{

  Future<List<Surah>> getAllSurah();

  Future<List<Surah>>getSurahesWithQuery(String query);

  Future<Surah?>getSurah(int surahId);

  Future<String?> getSurahNameById(int surahId);
}