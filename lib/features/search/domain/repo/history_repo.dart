

import 'package:hadith/features/search/domain/model/history.dart';

abstract class HistoryRepo{


  Stream<List<History>> getStreamHistories();

  Future<void> deleteHistory(History history);

  Future<void> deleteHistories(List<History> histories);

  Future<void> insertOrUpdateHistory(String searchText);

}