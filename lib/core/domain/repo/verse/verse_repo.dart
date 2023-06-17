

import 'package:hadith/core/domain/models/verse/verse.dart';
abstract class VerseRepo{

  Future<List<Verse>> getPagingVersesBySurahId(int surahId,int pageSize, int startIndex);

  Future<int> getVerseCountBySurahId(int surahId);

  Future<bool> getExistsVerseBySurahId(int surahId, int id);



  Future<List<Verse>> getPagingVersesByCuzNo(int cuzNo, int pageSize, int startIndex);

  Future<int> getVerseCountByCuzNo(int cuzNo);

  Future<bool> getExistsVerseByCuzNo(int cuzNo, int id);



  Future<List<Verse>> getPagingVersesByListId(int listId, int pageSize, int startIndex);

  Future<int> getVerseCountByListId(int listId);

  Future<bool> getExistsVerseByListId(int listId, int id);



  Future<List<Verse>> getPagingVersesByTopicId(int topicId, int pageSize, int startIndex);

  Future<int> getVerseCountByTopicId(int topicId);

  Future<bool> getExistsVerseByTopicId(int topicId, int id);




  Future<Verse?> getVerseById(int id);

  Future<int?> getPosById(int id);

  Future<List<Verse>> getVersesByListId(int listId);
}