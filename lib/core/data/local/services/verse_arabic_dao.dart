

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/verse_arabic_entity.dart';

@dao
abstract class VerseArabicDao{

  @Query("""select * from verseArabic where mealId=:mealId""")
  Future<List<VerseArabicEntity>> getArabicVersesByMealId(int mealId);

}