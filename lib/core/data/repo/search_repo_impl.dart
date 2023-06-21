

import 'package:hadith/core/data/local/entities/hadith_entity.dart';
import 'package:hadith/core/data/local/entities/verse_entity.dart';
import 'package:hadith/core/data/local/mapper/hadith_mapper.dart';
import 'package:hadith/core/data/local/services/search_dao.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/core/domain/repo/search_repo.dart';

import 'verse/get_verses.dart';

class SearchRepoImpl extends SearchRepo{

  late final SearchDao _searchDao;
  late final GetVerses _getVerses;

  SearchRepoImpl({
    required SearchDao searchDao,
    required GetVerses getVerses
  }){
    _searchDao = searchDao;
    _getVerses = getVerses;
  }


  @override
  Future<int> getCountAllHadith(String query, SearchCriteriaEnum searchCriteria) async{
    final queryExp = searchCriteria.getQuery(query);

    if(searchCriteria.isRegex){
      return (await _searchDao.getCountAllHadithByRegex(queryExp)) ?? 0;
    }
    return (await _searchDao.getCountAllHadithByLike(queryExp)) ?? 0;
  }

  @override
  Future<List<Hadith>> getAllHadiths(String query, SearchCriteriaEnum searchCriteria, int pageSize, int startIndex) async{
    final queryExp = searchCriteria.getQuery(query);
    final List<HadithEntity> hadithEntities;
    if(searchCriteria.isRegex){
      hadithEntities = await _searchDao.getAllHadithByRegex(queryExp, pageSize, startIndex);
    }else{
      hadithEntities = await _searchDao.getAllHadithsByLike(queryExp, pageSize, startIndex);
    }
    return hadithEntities.map((e) => e.toHadith()).toList();
  }




  @override
  Future<int> getCountHadithByBookId(String query, SearchCriteriaEnum searchCriteria, int bookId) async{
    final queryExp = searchCriteria.getQuery(query);

    if(searchCriteria.isRegex){
      return (await _searchDao.getCountHadithByRegexAndBookId(bookId, queryExp)) ?? 0;
    }
    return (await _searchDao.getCountHadithByLikeAndBookId(bookId, queryExp)) ?? 0;
  }

  @override
  Future<List<Hadith>> getHadithsByBookId(
      String query,
      SearchCriteriaEnum searchCriteria,
      int bookId,
      int pageSize,
      int startIndex
  ) async{
    final queryExp = searchCriteria.getQuery(query);
    final List<HadithEntity> hadithEntities;

    if(searchCriteria.isRegex){
      hadithEntities = await _searchDao.getHadithsByRegexAndBookId(bookId, queryExp, pageSize, startIndex);
    }else{
      hadithEntities = await _searchDao.getHadithsByLikeAndBookId(bookId, queryExp, pageSize, startIndex);
    }
    return hadithEntities.map((e) => e.toHadith()).toList();
  }




  @override
  Future<int> getCountVerse(String query, SearchCriteriaEnum searchCriteria) async{
    final queryExp = searchCriteria.getQuery(query);

    if(searchCriteria.isRegex){
      return (await _searchDao.getCountVerseByRegex(queryExp)) ?? 0;
    }
    return (await _searchDao.getCountVerseByLike(queryExp)) ?? 0;
  }

  @override
  Future<List<Verse>> getVerses(String query, SearchCriteriaEnum searchCriteria, int pageSize, int startIndex) async{
    final queryExp = searchCriteria.getQuery(query);
    final List<VerseEntity> verseEntities;

    if(searchCriteria.isRegex){
      verseEntities = await _searchDao.getVersesByRegex(queryExp, pageSize, startIndex);
    }else{
      verseEntities = await _searchDao.getVersesByLike(queryExp, pageSize, startIndex);
    }
    return _getVerses(verseEntities);
  }

}