

import 'package:hadith/core/domain/models/hadith.dart';

abstract class HadithRepo{

  Future<int> getHadithCountByBookId(int bookId);

  Future<List<Hadith>> getPagingHadithsByBookId(int bookId, int pageSize, int startIndex);


  Future<int> getHadithCountByTopicId(int topicId);

  Future<List<Hadith>> getPagingHadithsByTopicId(int topicId, int pageSize, int startIndex);


  Future<int> getHadithCountByListId(int listId);

  Future<List<Hadith>> getPagingHadithsByListId(int listId, int pageSize, int startIndex);


  Future<int> getHadithCountByQuery(String query);

  Future<List<Hadith>> getPagingHadithsByQuery(String query, int pageSize, int startIndex);



  Future<Hadith?> getHadithById(int id);

  Future<int?> getPosById(int id);

  Future<List<Hadith>> getHadithsFromListId(int listId);

}
