
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_unit.dart';
abstract class PrayerCustomRepo{

  Future<void> insertPrayerCustom(PrayerCustom prayer);

  Future<void> updatePrayerCustom(PrayerCustom prayer);

  Future<void> deletePrayerCustom(PrayerCustom prayer);

  Future<void> addToCounter(PrayerCustom prayer);

  Future<void> updateToCounter(PrayerCustom prayer);

  Future<List<PrayerCustom>> getPrayerCustoms();

  Stream<List<PrayerCustom>> getStreamPrayerCustoms();

  Future<PrayerCustom?> getPrayerCustomById(int id);

  Stream<PrayerUnit<PrayerCustom>?> getStreamPrayerCustomUnitById(int id);

  Stream<List<PrayerCustom>> getStreamSearchedCustomPrayers(String query);
}