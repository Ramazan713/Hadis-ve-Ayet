

import '../models/hadith.dart';

abstract class HadithRepo{

  Future<int?> getHadithCountByBookId(int bookId);

  Future<List<Hadith>> getPagingHadithsByBookId(int bookId, int pageSize, int startIndex);

  Future<Hadith?> getHadithById(int id);

  Future<int?> getPosById(int id);

}
