

import 'package:hadith/core/domain/models/list/list_hadith.dart';

abstract class ListHadithRepo{

  Future<int> insertListHadith(ListHadith listHadith);

  Future<List<int>> insertListHadiths(List<ListHadith> listHadiths);

  Future<int> updateListHadith(ListHadith listHadith);

  Future<int> deleteListHadith(ListHadith listHadith);

  Future<int> deleteListHadiths(List<ListHadith> listHadiths);


  Future<List<ListHadith>> getListHadithsWithListId(int listId);

  Future<ListHadith?> getListHadith(int hadithId, int listId);

  Future<int> getMaxPos();

  Future<List<int>> getListIdsFromHadithId(int hadithId);
}