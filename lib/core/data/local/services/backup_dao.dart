import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/counter_entity.dart';
import 'package:hadith/core/data/local/entities/history_entity.dart';
import 'package:hadith/core/data/local/entities/list/list_entity.dart';
import 'package:hadith/core/data/local/entities/list/list_hadith_entity.dart';
import 'package:hadith/core/data/local/entities/list/list_verse_entity.dart';
import 'package:hadith/core/data/local/entities/prayer_entity.dart';
import 'package:hadith/core/data/local/entities/save_point_entity.dart';
import 'package:hadith/core/data/local/entities/topic_savepoint_entity.dart';

@dao
abstract class BackupDao{

  @Query("""select * from history""")
  Future<List<HistoryEntity>> getHistories();

  @Query("""select * from list""")
  Future<List<ListEntity>> getLists();

  @Query("""select * from ListHadith""")
  Future<List<ListHadithEntity>> getHadithListEntities();

  @Query("""select * from listVerse""")
  Future<List<ListVerseEntity>> getVerseListEntities();

  @Query("""select * from savePoints""")
  Future<List<SavePointEntity>> getSavePoints();

  @Query("""select * from topicSavePoint""")
  Future<List<TopicSavePointEntity>> getTopicSavePoints();

  @Query("""select * from counters""")
  Future<List<CounterEntity>> getCounterEntities();

  @Query("""select * from prayers where typeId = :typeId""")
  Future<List<PrayerEntity>> getPrayersWithTypeId(int typeId);



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
  Future<void> insertPrayerEntities(List<PrayerEntity> prayers);


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
  Future<void> insertCounterEntity(CounterEntity counterEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPrayerEntity(PrayerEntity prayer);



  @Query("""delete from history""")
  Future<void> deleteHistories();

  @Query("""delete from list where isRemovable=1""")
  Future<void> deleteLists();

  @Query("""delete from ListHadith""")
  Future<void> deleteHadithLists();

  @Query("""delete from listVerse""")
  Future<void> deleteVerseLists();

  @Query("""delete from savepoints""")
  Future<void> deleteSavePoints();

  @Query("""delete from topicSavePoint""")
  Future<void> deleteTopicSavePoints();

  @Query("""delete from counters""")
  Future<void> deleteCounterEntitiesWithQuery();

  @Query("""delete from prayers where typeId = :typeId""")
  Future<void> deletePrayersWithTypeId(int typeId);

  @delete
  Future<void> deleteCounterEntities(List<CounterEntity>entities);
}