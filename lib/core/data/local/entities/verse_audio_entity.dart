


import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/audio_edition_entity.dart';
import 'package:hadith/core/data/local/entities/verse_entity.dart';

@Entity(tableName: "verseAudio",foreignKeys: [
  ForeignKey(
      childColumns: ["mealId"],
      parentColumns: ["id"],
      entity: VerseEntity
  ),
  ForeignKey(
      childColumns: ["identifier"],
      parentColumns: ["identifier"],
      entity: AudioEditionEntity
  ),
],primaryKeys: ["mealId","identifier"])
class VerseAudioEntity{
  final int mealId;
  final String identifier;
  final String? fileName;
  final bool hasEdited;

  const VerseAudioEntity({
    required this.mealId,
    required this.identifier,
    required this.fileName,
    required this.hasEdited
  });
}