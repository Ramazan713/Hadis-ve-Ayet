

import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';

abstract class SearchRepo{

  Future<int> getCountAllHadith(String query, SearchCriteriaEnum searchCriteria);

  Future<List<Hadith>> getAllHadiths(String query, SearchCriteriaEnum searchCriteria, int pageSize, int startIndex);



  Future<int> getCountHadithByBookId(String query, SearchCriteriaEnum searchCriteria,int bookId);

  Future<List<Hadith>> getHadithsByBookId(String query, SearchCriteriaEnum searchCriteria, int bookId,
      int pageSize, int startIndex);



  Future<int> getCountVerse(String query, SearchCriteriaEnum searchCriteria);

  Future<List<Verse>> getVerses(String query, SearchCriteriaEnum searchCriteria, int pageSize, int startIndex);
}