import 'package:floor/floor.dart';
import 'package:hadith/db/entities/save_point_entity.dart';
import 'package:hadith/db/entities/topic_savepoint_entity.dart';
import 'package:hadith/features/extra_features/counter/data/entity/counter_entity.dart';
import 'package:hadith/features/topic_savepoint/model/topic_savepoint.dart';
import '../entities/history_entity.dart';
import '../entities/list_entity.dart';
import '../entities/list_hadith_entity.dart';
import '../entities/list_verse_entity.dart';

@dao
abstract class BackupDaoOld{

  @Query("""select * from history""")
  Future<List<HistoryEntityOld>>getHistories();

  @Query("""select * from list where isRemovable=1""")
  Future<List<ListEntityOld>>getLists();

  @Query("""select * from ListHadith""")
  Future<List<ListHadithEntityOld>>getHadithListEntities();

  @Query("""select * from listVerse""")
  Future<List<ListVerseEntityOld>>getVerseListEntities();

  @Query("""select * from savepoint""")
  Future<List<SavePointEntityOld>>getSavePoints();

  @Query("""select * from topicSavePoint""")
  Future<List<TopicSavePointEntityOld>>getTopicSavePoints();

  @Query("""select * from counters where isRemovable=1""")
  Future<List<CounterEntityOld>>getCounterEntities();



  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void>insertHistories(List<HistoryEntityOld>histories);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void>insertLists(List<ListEntityOld>lists);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void>insertHadithLists(List<ListHadithEntityOld>hadithLists);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void>insertVerseLists(List<ListVerseEntityOld>verseLists);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void>insertSavePoints(List<SavePointEntityOld>savePointEntities);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void>insertTopicSavePoints(List<TopicSavePointEntityOld>topicSavePoints);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void>insertCounterEntities(List<CounterEntityOld>counterEntities);


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void>insertHistory(HistoryEntityOld history);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void>insertList(ListEntityOld list);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void>insertHadithList(ListHadithEntityOld hadithList);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void>insertVerseList(ListVerseEntityOld verseList);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void>insertSavePoint(SavePointEntityOld savePoint);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void>insertTopicSavePoint(TopicSavePointEntityOld topicSavePointEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void>insertCounterEntity(CounterEntityOld counterEntity);



  @Query("""delete from history""")
  Future<void> deleteHistories();

  @Query("""delete from list where isRemovable=1""")
  Future<void> deleteLists();

  @Query("""delete from ListHadith""")
  Future<void> deleteHadithLists();

  @Query("""delete from listVerse""")
  Future<void> deleteVerseLists();

  @Query("""delete from savepoint""")
  Future<void> deleteSavePoints();

  @Query("""delete from topicSavePoint""")
  Future<void> deleteTopicSavePoints();

  @Query("""delete from counters where isRemovable = 1""")
  Future<void> deleteCounterEntitiesWithQuery();

  @delete
  Future<void> deleteCounterEntities(List<CounterEntityOld>entities);
}