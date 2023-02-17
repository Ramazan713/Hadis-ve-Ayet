
import 'package:floor/floor.dart';
import 'package:hadith/features/extra_features/quran_prayer/data/entity/quran_prayer_entity.dart';

@dao
abstract class QuranPrayerDao{

  @Query("select * from prayerQuran")
  Future<List<QuranPrayerEntity>> getQuranPrayers();
}