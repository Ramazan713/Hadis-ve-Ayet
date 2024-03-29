
import 'package:hadith/core/features/verses/domain/model/surah.dart';

abstract class SurahRepo{

  Future<List<Surah>> getAllSurah();

  Future<List<Surah>>getSurahesWithQuery(String query);

  Future<Surah?>getSurah(int surahId);

  Future<String?> getSurahNameById(int surahId);

  Future<Surah?> getSurahFromMealId(int mealId);
}