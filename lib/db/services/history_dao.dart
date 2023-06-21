

import 'package:floor/floor.dart';
import 'package:hadith/db/entities/history_entity.dart';

@dao
abstract class HistoryDaoOld{

  @Query("select * from history where originType=:originId order by modifiedDate desc")
  Stream<List<HistoryEntityOld>>getStreamHistoryWithOrigin(int originId);

  @Query("""select * from history where originType=:originId and name=:name""")
  Future<HistoryEntityOld?>getHistoryEntity(int originId,String name);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int>insertHistory(HistoryEntityOld historyEntity);

  @delete
  Future<int>deleteHistory(HistoryEntityOld historyEntity);

  @delete
  Future<int>deleteHistories(List<HistoryEntityOld>historyEntities);

  @update
  Future<int>updateHistory(HistoryEntityOld historyEntity);


}