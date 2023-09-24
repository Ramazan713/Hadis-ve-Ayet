import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/verse_entity.dart';

import 'prayer_entity.dart';

@Entity(
  tableName: "PrayerVerses",
  foreignKeys: [
    ForeignKey(
      childColumns: ["verseId"],
      parentColumns: ["id"],
      entity: VerseEntity
    ),
    ForeignKey(
      childColumns: ["prayerId"],
      parentColumns: ["id"],
      entity: PrayerEntity,
      onDelete: ForeignKeyAction.cascade,
    ),
  ]
)
class PrayerVerseEntity{
  @primaryKey
  final int? id;
  final int verseId;
  final int prayerId;
  final int orderItem;

  PrayerVerseEntity({
    required this.id,
    required this.verseId,
    required this.prayerId,
    required this.orderItem
  });
}