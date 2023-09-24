

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/verse_entity.dart';

@Entity(
  tableName: "VerseArabics",
  foreignKeys: [
    ForeignKey(
      childColumns: ["mealId"],
      parentColumns: ["id"],
      entity: VerseEntity
    )
  ]
)
class VerseArabicEntity{
  @primaryKey
  final int? id;
  final int mealId;
  final String verse;
  final String verseNumber;
  final int verseNumberTr;

  const VerseArabicEntity({
    required this.id,
    required this.mealId,
    required this.verse,
    required this.verseNumber,
    required this.verseNumberTr,
  });
}