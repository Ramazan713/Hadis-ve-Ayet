

import 'package:hadith/constants/enums/search_criteria_enum.dart';
import 'package:hadith/db/entities/hadith.dart';
import 'package:hadith/db/entities/helper/int_data.dart';
import 'package:hadith/db/entities/verse.dart';
import 'package:hadith/db/repos/hadith_repo.dart';
import 'package:hadith/db/repos/verse_repo.dart';
import 'package:hadith/utils/search_helper.dart';

class SearchManager{
  final HadithRepoOld hadithRepo;
  final VerseRepoOld verseRepo;

  SearchManager({required this.verseRepo,required this.hadithRepo});

  String _getDbQuery(String query,SearchCriteriaEnum criteria){
    if(SearchHelper.isRegEnum(criteria)){
      return SearchHelper.getRegExQueryWithCriteria(query, criteria);
    }
    return SearchHelper.getLikeQueryWithCriteria(query, criteria);
  }

  T _initInfo<T>(String query,Function(bool isRegEnum,String dbQuery) func){

    final criteria = SearchHelper.getCriteria();
    final isRegEx = SearchHelper.isRegEnum(criteria);
    final dbQuery = _getDbQuery(query, criteria);
    return func(isRegEx,dbQuery);
  }

  Future<IntData?> getSearchWithHadithCount(String query){
    return _initInfo(query, (isRegEnum,dbQuery)  {
      return isRegEnum?hadithRepo.getSearchWithHadithCountWithRegEx(dbQuery):
      hadithRepo.getSearchWithHadithCount(dbQuery);
    });
  }

  Future<List<Hadith>> getPagingSearchHadiths(int limit, int page, String query){
    return _initInfo(query, (isRegEnum,dbQuery)  {
      return isRegEnum?hadithRepo.getPagingSearchHadithsWithRegEx(limit,page,dbQuery):
      hadithRepo.getPagingSearchHadiths(limit,page,dbQuery);
    });
  }

  Future<IntData?> getSearchHadithCountWithBook(String query, int bookId){
    return _initInfo(query, (isRegEnum,dbQuery)  {
      return isRegEnum?hadithRepo.getSearchHadithCountWithBookAndRegEx(dbQuery,bookId):
      hadithRepo.getSearchHadithCountWithBook(dbQuery,bookId);
    });
  }

  Future<List<Hadith>> getPagingSearchHadithsWithBook(int limit, int page, int bookId, String query){
    return _initInfo(query, (isRegEnum,dbQuery)  {
      return isRegEnum?hadithRepo.getPagingSearchHadithsWithBookAndRegEx(limit,page,bookId,dbQuery):
      hadithRepo.getPagingSearchHadithsWithBook(limit,page,bookId,dbQuery);
    });
  }


  Future<IntData?> getSearchWithVerseCount(String query){
    return _initInfo(query, (isRegEnum,dbQuery)  {
      return isRegEnum?verseRepo.getSearchWithVerseCountWithRegEx(dbQuery):
      verseRepo.getSearchWithVerseCount(dbQuery);
    });
  }


  Future<List<Verse>>getPagingSearchVerses(int limit,int page,String query){
    return _initInfo(query, (isRegEnum,dbQuery)  {
      return isRegEnum?verseRepo.getPagingSearchVersesWithRegEx(limit,page,dbQuery):
      verseRepo.getPagingSearchVerses(limit,page,dbQuery);
    });
  }

}