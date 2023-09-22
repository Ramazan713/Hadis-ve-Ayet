

import 'package:hadith/core/domain/enums/book_enum.dart';

class Verse{
  final int? id;
  final BookEnum bookEnum;
  final int surahId;
  final int cuzNo;
  final int pageNo;
  final String verseNumber;
  final String content;
  final bool isProstrationVerse;
  final String surahName;

  const Verse({
    this.id,
    required this.surahId,
    required this.cuzNo,
    required this.pageNo,
    required this.verseNumber,
    required this.content,
    required this.surahName,
    required this.isProstrationVerse,
    this.bookEnum = BookEnum.diyanetMeal
  });

  String getShareText(){
    return "$surahId/$surahName\n\n$verseNumber - $content\n";
  }
  
}