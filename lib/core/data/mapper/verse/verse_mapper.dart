
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/data/local/entities/verse_entity.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';

extension VerseEntityExt on VerseEntity{

  Verse toVerse({required String surahName}){
    return Verse(
      id: id,
      surahId: surahId,
      content: content,
      cuzNo: cuzNo,
      pageNo: pageNo,
      verseNumber: verseNumber,
      isProstrationVerse: isProstrationVerse,
      bookEnum: BookEnum.diyanetMeal,
      surahName: surahName
    );
  }
}




