
import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/prayer_entity.dart';

@dao
abstract class PrayerDao{

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPrayer(PrayerEntity prayer);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updatePrayer(PrayerEntity prayer);

  @delete
  Future<void> deletePrayer(PrayerEntity prayer);

  @Query("select * from prayers where typeId = :typeId")
  Future<List<PrayerEntity>> getPrayersWithTypeId(int typeId);

  @Query("select * from prayers where typeId = :typeId and isRemovable = :isRemovable")
  Future<List<PrayerEntity>> getPrayersWithTypeIdAndIsRemovable(int typeId, bool isRemovable);

  @Query("select * from prayers where id = :id")
  Future<PrayerEntity?> getPrayersWithId(int id);

  @Query("""select max(orderItem) from prayers where typeId = :typeId""")
  Future<int?> getMaxOrderWithTypeId(int typeId);

  @Query("""
    select * from prayers where typeId = :typeId and lower(meaningContent) Like lower(:query)
  """)
  Future<List<PrayerEntity>> getPrayersSearchedLikeWithTypeId(int typeId, String query);

  @Query("""
     select * from prayers where typeId = :typeId and lower(meaningContent) REGEXP lower(:regExp)
  """)
  Future<List<PrayerEntity>> getPrayersSearchedRegExWithTypeId(int typeId, String regExp);

}