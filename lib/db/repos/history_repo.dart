

import 'package:hadith/db/entities/history_entity.dart';
import 'package:hadith/db/services/history_dao.dart';

class HistoryRepo{
  final HistoryDaoOld historyDao;

  HistoryRepo({required this.historyDao});

  Stream<List<HistoryEntityOld>>getStreamHistoryWithOrigin(int originId)=>
      historyDao.getStreamHistoryWithOrigin(originId);

  Future<HistoryEntityOld?>getHistoryEntity(int originId,String name)=>
      historyDao.getHistoryEntity(originId, name);

  Future<int>insertHistory(HistoryEntityOld historyEntity)=>
      historyDao.insertHistory(historyEntity);

  Future<int>deleteHistory(HistoryEntityOld historyEntity)=>
      historyDao.deleteHistory(historyEntity);

  Future<int>deleteHistories(List<HistoryEntityOld>historyEntities)=>
      historyDao.deleteHistories(historyEntities);

  Future<int>updateHistory(HistoryEntityOld historyEntity)=>
      historyDao.updateHistory(historyEntity);


}