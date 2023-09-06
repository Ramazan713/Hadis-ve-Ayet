

import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran.dart';

abstract class PrayerRepo{

  Stream<List<PrayerInQuran>> getStreamPrayerInQurans();

  Stream<List<PrayerInQuran>> getSearchedPrayersInQuran(String query, SearchCriteriaEnum criteria);


  Future<List<PrayerDhikr>> getPrayerDhikrs();

  Future<PrayerDhikr?> getPrayerDhikrById(int id);


  Future<List<PrayerAndVerse>> getPrayerAndVerses();

  Stream<PrayerAndVerse?> getStreamPrayerAndVerseById(int id);

  Future<void> insertCustomPrayerWithRelationForPrayerVerse(PrayerAndVerse prayer);

  Future<void> insertCustomPrayerWithRelationForPrayerQuran(PrayerInQuran prayer);
}