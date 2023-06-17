

import 'package:hadith/core/data/local/entities/verse_arabic_entity.dart';
import 'package:hadith/core/domain/models/verse/verse_arabic.dart';

extension VerseArabicEntityExt on VerseArabicEntity{

  VerseArabic toVerseArabic(){
    return VerseArabic(
        id: id,
        verseNumber: verseNumber,
        verse: verse,
        mealId: mealId,
        verseNumberTr: verseNumberTr
    );
  }
}