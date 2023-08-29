

import 'package:hadith/core/data/local/entities/history_entity.dart';
import 'package:hadith/core/data/local/services/history_dao.dart';
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/features/search/data/mapper/search_mapper.dart';
import 'package:hadith/features/search/domain/model/history.dart';
import 'package:hadith/features/search/domain/repo/history_repo.dart';

class HistoryRepoImpl extends HistoryRepo{

  late final HistoryDao _historyDao;

  HistoryRepoImpl({required HistoryDao historyDao}){
    _historyDao = historyDao;
  }

  @override
  Future<void> deleteHistories(List<History> histories) async{
    await _historyDao.deleteHistories(histories.map((e) => e.toHistoryEntity()).toList());
  }

  @override
  Future<void> deleteHistory(History history) async{
    await _historyDao.deleteHistory(history.toHistoryEntity());
  }

  @override
  Stream<List<History>> getStreamHistories() {
    return _historyDao.getStreamHistories()
        .map((items) => items.map((e) => e.toHistory()).toList());
  }

  @override
  Future<void> insertOrUpdateHistory(String searchText) async{
    final historyEntity = await _historyDao.getHistoryEntity(searchText);
    final modifiedDate = DateTime.now().toIso8601String();

    final updatedHistory = HistoryEntity(
        name: searchText,
        originType: historyEntity?.originType ?? SavePointType.search.typeId,
        modifiedDate: modifiedDate,
        id: historyEntity?.id
    );
    _historyDao.insertHistory(updatedHistory);
  }

}