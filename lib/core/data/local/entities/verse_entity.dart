


import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/book_entity.dart';
import 'package:hadith/core/data/local/entities/cuz_entity.dart';
import 'package:hadith/core/data/local/entities/surah_entity.dart';

@Entity(tableName: "verse",foreignKeys: [
  ForeignKey(
      childColumns: ["cuzNo"],
      parentColumns: ["cuzNo"],
      entity: CuzEntity
  ),
  ForeignKey(
      childColumns: ["surahId"],
      parentColumns: ["id"],
      entity: SurahEntity
  ),
  ForeignKey(
      childColumns: ["bookId"],
      parentColumns: ["id"],
      entity: BookEntity
  )
])
class VerseEntity{

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int bookId;
  final int surahId;
  final int cuzNo;
  final int pageNo;
  final String verseNumber;
  final String content;
  final bool isProstrationVerse;

  const VerseEntity({
    this.id,
    required this.surahId,
    required this.cuzNo,
    required this.pageNo,
    required this.verseNumber,
    required this.content,
    required this.isProstrationVerse,
    required this.bookId
  });
}