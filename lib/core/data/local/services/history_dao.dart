

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/history_entity.dart';

@dao
abstract class HistoryDao{

  @Query("select * from histories order by modifiedDate desc")
  Stream<List<HistoryEntity>> getStreamHistories();

  @Query("""select * from histories where lower(name) = lower(:name)""")
  Future<HistoryEntity?> getHistoryEntity(String name);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertHistory(HistoryEntity historyEntity);

  @delete
  Future<void> deleteHistory(HistoryEntity historyEntity);

  @delete
  Future<void> deleteHistories(List<HistoryEntity>historyEntities);

  @update
  Future<void> updateHistory(HistoryEntity historyEntity);

}