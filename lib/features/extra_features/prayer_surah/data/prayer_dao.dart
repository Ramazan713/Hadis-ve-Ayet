

import 'package:floor/floor.dart';
import 'package:hadith/features/extra_features/prayer_surah/data/entity/prayer_entity.dart';

@dao
abstract class PrayerDaoOld{
  
  @Query("select * from prayers")
  Future<List<PrayerEntityOld>> getPrayers();

  @Query("select * from prayers where id=:id")
  Future<PrayerEntityOld?> getPrayerWithId(int id);
  
}