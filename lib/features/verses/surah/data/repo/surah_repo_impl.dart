

import 'package:hadith/core/data/local/services/surah_dao.dart';
import 'package:hadith/core/domain/use_cases/query_ext_use_case.dart';
import 'package:hadith/features/verses/surah/data/mapper/surah_mapper.dart';
import 'package:hadith/features/verses/surah/domain/models/surah.dart';
import 'package:hadith/features/verses/surah/domain/repo/surah_repo.dart';

class SurahRepoImpl extends SurahRepo{
  late final SurahDao _surahDao;
  late final QueryExtUseCase _queryExtUseCase;


  SurahRepoImpl({
    required SurahDao surahDao,
    required QueryExtUseCase queryExtUseCase,
  }){
    _surahDao = surahDao;
    _queryExtUseCase = queryExtUseCase;
  }

  @override
  Future<List<Surah>> getAllSurah() async{
    return (await _surahDao.getAllSurah())
        .map((e) => e.toSurah()).toList();
  }

  @override
  Future<Surah?> getSurah(int surahId) async{
    return (await _surahDao.getSurah(surahId))
        ?.toSurah();
  }

  @override
  Future<List<Surah>> getSurahesWithQuery(String query) async{
    final queryRs = _queryExtUseCase.call(query);

    return (await _surahDao.getSurahesWithQuery(
        queryRs.queryLikeForSearch,
        queryRs.queryLikeForOrder,
        queryRs.queryRaw
    )).map((e) => e.toSurah()).toList();
  }

  @override
  Future<String?> getSurahNameById(int surahId) {
    return _surahDao.getSurahNameById(surahId);
  }

}