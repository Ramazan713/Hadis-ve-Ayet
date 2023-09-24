


import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/verse_entity.dart';

@Entity(
  tableName: "ListVerses",
  foreignKeys: [
    ForeignKey(
      childColumns: ["listId"],
      parentColumns: ["id"],
      entity: List
    ),
    ForeignKey(
      childColumns: ["verseId"],
      parentColumns: ["id"],
      entity: VerseEntity
    )
  ],
  primaryKeys: ["listId","verseId"]
)
class ListVerseEntity{
  final int listId;
  final int verseId;
  final int pos;

  const ListVerseEntity({
    required this.listId,
    required this.verseId,
    required this.pos
  });
}