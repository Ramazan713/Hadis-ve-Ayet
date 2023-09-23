import 'dart:collection';

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
import 'package:hadith/core/data/mapper/backup/counter_backup_mapper.dart';
import 'package:hadith/core/data/mapper/backup/prayer_backup_mapper.dart';
import 'package:hadith/core/data/mapper/backup/prayer_verse_backup_mapper.dart';
import 'package:hadith/core/data/remote/backup_dtos/counter_backup_dto/counter_backup_dto.dart';
import 'package:hadith/core/data/remote/backup_dtos/esmaul_husna_info_dto/esmaul_husna_info_dto.dart';
import 'package:hadith/core/data/remote/backup_dtos/prayer_backup_dto/prayer_backup_dto.dart';
import 'package:hadith/core/data/remote/backup_dtos/prayer_backup_dto/prayer_backup_non_removable_dto.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/enums/prayer_type_enum.dart';

@dao
abstract class BackupDao{

  @Query("""select * from history""")
  Future<List<HistoryEntity>> getHistories();

  @Query("""select * from esmaulHusna where counterId is not null""")
  Future<List<EsmaulHusnaEntity>> getEsmaulHusnas();

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
    update esmaulHusna set counterId = :counterId where orderItem = :orderItem
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

  @delete
  Future<void> deleteCounterEntities(List<CounterEntity>entities);

  @Query("""delete from prayers where typeId = :typeId""")
  Future<void> deletePrayersWithTypeId(int typeId);

  @transaction
  Future<void> deletePrayers()async{
    await deletePrayersWithTypeId(PrayerTypeEnum.custom.typeId);
  }



}