
import 'package:hadith/db/entities/verse_arabic.dart';
import 'package:hadith/db/services/verse_arabic_dao.dart';

class VerseArabicRepo{
  late final VerseArabicDao _verseArabicDao;
  VerseArabicRepo({required VerseArabicDao verseArabicDao}){
    _verseArabicDao=verseArabicDao;
  }

  Future<List<VerseArabic>> getNotDownloadedCuzVerses(String identifier,int cuzNo) =>
      _verseArabicDao.getNotDownloadedCuzVerses(identifier, cuzNo);

  Future<List<VerseArabic>> getNotDownloadedSurahVerses(String identifier,int surahId) =>
      _verseArabicDao.getNotDownloadedSurahVerses(identifier, surahId);


  Future<List<VerseArabic>> getNotDownloadedPageVerses(String identifier,int pageNo) =>
      _verseArabicDao.getNotDownloadedPageVerses(identifier, pageNo);

  Future<List<VerseArabic>> getNotDownloadedMealIdVerses(String identifier,int mealId) =>
      _verseArabicDao.getNotDownloadedMealIdVerses(identifier, mealId);

}