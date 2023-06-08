

import 'package:hadith/db/entities/surah.dart';
import 'package:hadith/db/services/surah_dao.dart';

class SurahRepoOld{
  final SurahDaoOld surahDao;

  SurahRepoOld({required this.surahDao});

  Future<List<Surah>> getAllSurah()=>surahDao.getAllSurah();

  Future<List<Surah>>getSearchedSurahes(String query)=>
      surahDao.getSearchedSurahes( "%$query%", query, "$query%", "%$query");
}