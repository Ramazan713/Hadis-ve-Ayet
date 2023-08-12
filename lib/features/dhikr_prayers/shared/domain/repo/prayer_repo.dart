

import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran.dart';

abstract class PrayerRepo{

  Future<List<PrayerInQuran>> getPrayerInQurans();

  Future<List<PrayerInQuran>> getSearchedPrayersInQuran(String query, SearchCriteriaEnum criteria);


  Future<List<PrayerDhikr>> getPrayerDhikrs();

  Future<PrayerDhikr?> getPrayerDhikrById(int id);


  Future<List<PrayerAndVerse>> getPrayerAndVerses();

  Future<PrayerAndVerse?> getPrayerAndVerseById(int id);


  Future<List<PrayerCustom>> getPrayerCustoms();

  Future<PrayerCustom?> getPrayerCustomById(int id);

  Future<void> insertPrayerCustom(PrayerCustom prayer);

  Future<void> updatePrayerCustom(PrayerCustom prayer);

  Future<void> deletePrayerCustom(PrayerCustom prayer);


}