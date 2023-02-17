

import 'package:floor/floor.dart';
import 'package:hadith/features/extra_features/prayer_surah/data/entity/prayer_entity.dart';

@dao
abstract class PrayerDao{
  
  @Query("select * from prayers")
  Future<List<PrayerEntity>> getPrayers();

  @Query("select * from prayers where id=:id")
  Future<PrayerEntity?> getPrayerWithId(int id);
  
}