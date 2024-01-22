
import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/counter_entity.dart';
import 'package:hadith/core/data/local/entities/esmaul_husna_entity.dart';
import 'package:hadith/core/data/local/entities/history_entity.dart';
import 'package:hadith/core/data/local/entities/list/list_entity.dart';
import 'package:hadith/core/data/local/entities/list/list_hadith_entity.dart';
import 'package:hadith/core/data/local/entities/list/list_verse_entity.dart';
import 'package:hadith/core/data/local/entities/prayer_entity.dart';
import 'package:hadith/core/data/local/entities/prayer_verse_entity.dart';
import 'package:hadith/core/data/local/entities/save_point_entity.dart';
import 'package:hadith/core/data/local/entities/topic_savepoint_entity.dart';
import 'package:hadith/core/features/backup/data/mapper/prayer_backup_mapper.dart';
import 'package:hadith/core/features/backup/data/mapper/prayer_verse_backup_mapper.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/prayer_backup_dto/prayer_backup_dto.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/enums/prayer_type_enum.dart';

@dao
abstract class BackupDao{

  @Query("""select * from histories""")
  Future<List<HistoryEntity>> getHistories();

  @Query("""select * from esmaulHusnas where counterId is not null""")
  Future<List<EsmaulHusnaEntity>> getEsmaulHusnas();

  @Query("""select * from lists""")
  Future<List<ListEntity>> getLists();

  @Query("""select * from listHadiths""")
  Future<List<ListHadithEntity>> getHadithListEntities();

  @Query("""select * from listVerses""")
  Future<List<ListVerseEntity>> getVerseListEntities();

  @Query("""select * from savePoints""")
  Future<List<SavePointEntity>> getSavePoints();

  @Query("""select * from topicSavePoints""")
  Future<List<TopicSavePointEntity>> getTopicSavePoints();

  @Query("""select * from counters""")
  Future<List<CounterEntity>> getCounterEntities();

  @Query("""select * from prayers where typeId = :typeId""")
  Future<List<PrayerEntity>> getPrayersWithTypeId(int typeId);

  @Query("""select * from prayers where isRemovable = 0""")
  Future<List<PrayerEntity>> getPrayersNonRemovable();

  @Query("""select * from prayerVerses where prayerId = :prayerId""")
  Future<List<PrayerVerseEntity>> getPrayerVersesByPrayerId(int prayerId);


  @transaction
  Future<List<PrayerBackupDto>> getPrayersBackupDto()async{
    final result = <PrayerBackupDto>[];
    final prayerEntities = await getPrayersWithTypeId(PrayerTypeEnum.custom.typeId);
    for(final prayer in prayerEntities){
      final prayerVerseEntities = await getPrayerVersesByPrayerId(prayer.id ?? 0);
      final prayerVerseDtos = prayerVerseEntities.map((e) => e.toPrayerVerseBackupDto()).toList();
      final prayerDto = prayer.toPrayerBackupDto(prayerVerseBackups: prayerVerseDtos);
      result.add(prayerDto);
    }
    return result;
  }

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertHistories(List<HistoryEntity> histories);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertLists(List<ListEntity> lists);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertHadithLists(List<ListHadithEntity> hadithLists);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertVerseLists(List<ListVerseEntity> verseLists);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSavePoints(List<SavePointEntity> savePointEntities);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTopicSavePoints(List<TopicSavePointEntity> topicSavePoints);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCounterEntities(List<CounterEntity> counterEntities);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPrayerVerseEntities(List<PrayerVerseEntity> prayerVerseEntities);


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertHistory(HistoryEntity history);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertList(ListEntity list);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertHadithList(ListHadithEntity hadithList);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertVerseList(ListVerseEntity verseList);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSavePoint(SavePointEntity savePoint);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTopicSavePoint(TopicSavePointEntity topicSavePointEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertCounterEntity(CounterEntity counterEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertPrayerEntity(PrayerEntity prayer);

  @Query("""
    update esmaulHusnas set counterId = :counterId where orderItem = :orderItem
  """)
  Future<void> updateEsmaulHusnaCounterId(int orderItem, int counterId);

  @Query("""
    update prayers set parentPrayerId = :parentPrayerId where orderItem = :orderItem and typeId = :typeId
  """)
  Future<void> updateNonRemovablePrayers(int orderItem, int typeId, int parentPrayerId);

  @Query("""
    update prayers set counterId = :counterId where id = :id
  """)
  Future<void> updatePrayerCounterId(int counterId, int id);


  @Query("""delete from histories""")
  Future<void> deleteHistories();

  @Query("""delete from lists where isRemovable=1""")
  Future<void> deleteLists();

  @Query("""delete from listHadiths""")
  Future<void> deleteHadithLists();

  @Query("""delete from listVerses""")
  Future<void> deleteVerseLists();

  @Query("""delete from savePoints""")
  Future<void> deleteSavePoints();

  @Query("""delete from topicSavePoints""")
  Future<void> deleteTopicSavePoints();

  @Query("""delete from counters""")
  Future<void> deleteCounterEntitiesWithQuery();

  @delete
  Future<void> deleteCounterEntities(List<CounterEntity>entities);

  @Query("""delete from prayers where typeId = :typeId""")
  Future<void> deletePrayersWithTypeId(int typeId);

  @transaction
  Future<void> deletePrayers()async{
    await deletePrayersWithTypeId(PrayerTypeEnum.custom.typeId);
  }



}