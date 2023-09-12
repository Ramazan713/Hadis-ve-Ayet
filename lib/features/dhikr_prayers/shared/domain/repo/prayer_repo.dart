

import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse/prayer_and_verse.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr/prayer_dhikr.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran/prayer_in_quran.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_unit.dart';

abstract class PrayerRepo{

  Stream<List<PrayerUnit<PrayerInQuran>>> getStreamPrayerInQuranUnits();

  Stream<List<PrayerUnit<PrayerInQuran>>> getSearchedPrayerInQuranUnits(String query, SearchCriteriaEnum criteria);


  Future<List<PrayerDhikr>> getPrayerDhikrs();

  Future<PrayerDhikr?> getPrayerDhikrById(int id);


  Future<List<PrayerAndVerse>> getPrayerAndVerses();

  Stream<PrayerUnit<PrayerAndVerse>?> getStreamPrayerAndVerseUnitById(int id);

  Future<void> insertCustomPrayerWithRelationForPrayerVerse(PrayerUnit<PrayerAndVerse> prayerUnit);

  Future<void> insertCustomPrayerWithRelationForPrayerQuran(PrayerUnit<PrayerInQuran> prayerUnit);
}