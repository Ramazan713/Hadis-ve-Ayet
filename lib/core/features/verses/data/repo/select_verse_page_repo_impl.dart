
import 'package:hadith/core/data/local/services/select_verse_page_dao.dart';
import 'package:hadith/core/features/verses/data/mapper/cuz_mapper.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/repo/select_verse_page_repo.dart';
import 'package:hadith/core/features/verses/data/mapper/surah_mapper.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';

class SelectVersePageRepoImpl extends SelectVersePageRepo{

  late final SelectVersePageDao _selectVersePageDao;

  SelectVersePageRepoImpl({
    required SelectVersePageDao selectVersePageDao
  }){
    _selectVersePageDao = selectVersePageDao;
  }

  @override
  Future<List<Cuz>> getCuzs() async{
    return (await _selectVersePageDao.getCuzs()).map((e) => e.toCuz()).toList();
  }

  @override
  Future<List<String>> getVerseNumbers(int surahId){
    return _selectVersePageDao.getVerseNumbers(surahId);
  }

  @override
  Future<List<Surah>> getSurahes() async{
    return (await _selectVersePageDao.getSurahes()).map((e) => e.toSurah()).toList();
  }

  @override
  Future<int> getMaxPage() async{
    return (await _selectVersePageDao.getMaxPage()) ?? 0;
  }

  @override
  Future<int?> getPagePos(int pageNo, String verseNumber, int surahId, int cuzNo) async{
    final verseId = await _selectVersePageDao.getVerseId(surahId, cuzNo, verseNumber);
    if(verseId == null) return null;

    return _selectVersePageDao.getPagePosition(verseId, pageNo, surahId, cuzNo);
  }


  @override
  Future<Surah?> validateSurahByCuzNo(Surah? surah, int cuzNo)async{
    final isValid = (await _selectVersePageDao.existsSurahByCuzNo(surah?.id ?? 0, cuzNo));

    if(isValid ?? false) return surah;
    return (await _selectVersePageDao.getFirstSurahByCuzNo(cuzNo))?.toSurah();
  }

  @override
  Future<Surah?> validateSurahByPageNo(Surah? surah, int pageNo)async{
    final isValid = (await _selectVersePageDao.existsPageBySurahId(pageNo,surah?.id ?? 0));

    if(isValid ?? false) return surah;
    return (await _selectVersePageDao.getFirstSurahByPageNo(pageNo))?.toSurah();
  }

  @override
  Future<Cuz?> validateCuzBySurah(Cuz? cuz, int surahId, String verseNumber)async{
    final isValid = (await _selectVersePageDao.existsCuzBySurah(cuz?.no ?? 0, surahId, verseNumber));

    if(isValid ?? false) return cuz;
    final currentCuz = (await _selectVersePageDao.getFirstCuzBySurah(surahId,verseNumber))?.toCuz();
    return currentCuz ?? (await _selectVersePageDao.getFirstCuzBySurahId(surahId))?.toCuz();
  }

  @override
  Future<Cuz?> validateCuzByPageNo(Cuz? cuz, int pageNo)async{
    final isValid = (await _selectVersePageDao.existsPageByCuzNo(pageNo, cuz?.no ?? 0));

    if(isValid ?? false) return cuz;
    return (await _selectVersePageDao.getFirstCuzByPageNo(pageNo))?.toCuz();
  }

  @override
  Future<int?> validatePageByCuzNo(int pageNo, int cuzNo) async{
    final isValid = (await _selectVersePageDao.existsPageByCuzNo(pageNo, cuzNo));

    if(isValid ?? false) return pageNo;
    return _selectVersePageDao.getFirstPageByCuzNo(cuzNo);
  }

  @override
  Future<int?> validatePageBySurah(int pageNo, int surahId, String verseNumber) async{
    final isValid = (await _selectVersePageDao.existsPageBySurah(pageNo, surahId, verseNumber));

    if(isValid ?? false) return pageNo;
    return _selectVersePageDao.getFirstPageBySurah(surahId, verseNumber);
  }


  @override
  Future<String?> validateVerseNumber(String verseNumber, int surahId, int cuzNo) async{
    final isValid = (await _selectVersePageDao.existsVerseNumber(verseNumber, surahId, cuzNo));

    if(isValid ?? false) return verseNumber;
    return _selectVersePageDao.getFirstVerseNumber(surahId, cuzNo);
  }

  @override
  Future<String?> validateVerseNumberWithPage(String verseNumber, int surahId, int cuzNo, int pageNo) async{
    final isValid = (await _selectVersePageDao.existsVerseNumberWithPageNo(verseNumber, surahId, cuzNo, pageNo));

    if(isValid ?? false) return verseNumber;
    return _selectVersePageDao.getFirstVerseNumberWithPageNo(surahId, cuzNo, pageNo);
  }

}