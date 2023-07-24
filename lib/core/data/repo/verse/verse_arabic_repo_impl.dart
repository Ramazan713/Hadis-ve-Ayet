

import 'package:hadith/core/data/local/services/verse/verse_arabic_dao.dart';
import 'package:hadith/core/data/local/mapper/verse/verse_arabic_mapper.dart';
import 'package:hadith/core/domain/models/verse/verse_arabic.dart';
import 'package:hadith/core/domain/repo/verse/verse_arabic_repo.dart';

class VerseArabicRepoImpl extends VerseArabicRepo{

  late final VerseArabicDao _verseArabicDao;

  VerseArabicRepoImpl({required VerseArabicDao verseArabicDao}){
    _verseArabicDao = verseArabicDao;
  }

  @override
  Future<List<VerseArabic>> getArabicVersesByMealId(int mealId) async{
    return (await _verseArabicDao.getArabicVersesByMealId(mealId))
        .map((e) => e.toVerseArabic()).toList();
  }

}