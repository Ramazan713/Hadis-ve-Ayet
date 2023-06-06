

import 'package:hadith/core/domain/models/hadith.dart';

abstract class HadithRepo{

  Future<int> getHadithCountByBookId(int bookId);

  Future<List<Hadith>> getPagingHadithsByBookId(int bookId, int pageSize, int startIndex);

  Future<bool> getExistsHadithByBookId(int bookId, int id);


  Future<int> getHadithCountByTopicId(int topicId);

  Future<List<Hadith>> getPagingHadithsByTopicId(int topicId, int pageSize, int startIndex);

  Future<String?> getTopicName(int topicId);


  Future<int> getHadithCountByListId(int listId);

  Future<List<Hadith>> getPagingHadithsByListId(int listId, int pageSize, int startIndex);

  Future<bool> getExistsHadithByTopicId(int topicId, int id);

  Future<String?> getListName(int listId);



  Future<int> getHadithCountByQuery(String query);

  Future<List<Hadith>> getPagingHadithsByQuery(String query, int pageSize, int startIndex);

  Future<bool> getExistsHadithByListId(int listId, int id);

  Future<Hadith?> getHadithById(int id);

  Future<int?> getPosById(int id);

  Future<List<Hadith>> getHadithsFromListId(int listId);

}
