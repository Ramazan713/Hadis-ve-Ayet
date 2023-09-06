
import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/prayer_entity.dart';

@dao
abstract class PrayerDao{

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertPrayer(PrayerEntity prayer);

  @transaction
  Future<int> insertPrayerWithOrder(PrayerEntity prayer)async{
    final maxPos = (await getMaxOrderWithTypeId(prayer.typeId)) ?? 0;
    final updatedPrayer = prayer.copyWith(orderItem: maxPos + 1);
    return insertPrayer(updatedPrayer);
  }

  @transaction
  Future<void> insertPrayerWithRelation(PrayerEntity childPrayer, PrayerEntity unAddedParentPrayer)async{
    final parentId = await insertPrayerWithOrder(unAddedParentPrayer);
    final updatedPrayer = childPrayer.copyWith(parentPrayerId: parentId);
    await updatePrayer(updatedPrayer);
  }

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updatePrayer(PrayerEntity prayer);

  @delete
  Future<void> deletePrayer(PrayerEntity prayer);

  @Query("select * from prayers where typeId = :typeId order by orderItem desc")
  Future<List<PrayerEntity>> getPrayersWithTypeId(int typeId);

  @Query("select * from prayers where typeId = :typeId order by orderItem desc")
  Stream<List<PrayerEntity>> getStreamPrayersWithTypeId(int typeId);

  @Query("select * from prayers where typeId = :typeId order by orderItem asc")
  Future<List<PrayerEntity>> getPrayersWithTypeIdOrderByAsc(int typeId);

  @Query("select * from prayers where typeId = :typeId order by orderItem asc")
  Stream<List<PrayerEntity>> getStreamPrayersWithTypeIdOrderByAsc(int typeId);


  @Query("select * from prayers where id = :id")
  Future<PrayerEntity?> getPrayersWithId(int id);

  @Query("select * from prayers where id = :id")
  Stream<PrayerEntity?> getStreamPrayersWithId(int id);

  @Query("""select ifnull(max(orderItem),0) from prayers where typeId = :typeId""")
  Future<int?> getMaxOrderWithTypeId(int typeId);

  @Query("""
    select * from prayers where typeId = :typeId and lower(meaningContent) Like lower(:query)
    order by orderItem desc
  """)
  Future<List<PrayerEntity>> getPrayersSearchedLikeWithTypeId(int typeId, String query);

  @Query("""
     select * from prayers where typeId = :typeId and lower(meaningContent) REGEXP lower(:regExp)
     order by orderItem desc
  """)
  Future<List<PrayerEntity>> getPrayersSearchedRegExWithTypeId(int typeId, String regExp);


  @Query("""
    select * from prayers where typeId = :typeId and 
    lower(meaningContent) Like lower(:querySearchFull) or lower(name) Like lower(:querySearchFull)
    or lower(pronunciationContent) Like lower(:querySearchFull)
    order by (case when lower(name)=:queryRaw then 1 when name like :queryOrderForLike then 2 else 3 end),
    (case when lower(pronunciationContent)=:queryRaw then 1 when pronunciationContent like :queryOrderForLike then 2 else 3 end),
    orderItem desc
  """)
  Stream<List<PrayerEntity>> getPrayersSearchedWithTypeIdAndTitle(
      int typeId,
      String querySearchFull,
      String queryOrderForLike,
      String queryRaw,
  );
}