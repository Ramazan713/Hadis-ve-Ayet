

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/section_entity.dart';

@Entity(tableName: "topic",foreignKeys: [
  ForeignKey(
      childColumns: ["sectionId"],
      parentColumns: ["id"],
      entity: SectionEntity
  )
])
class TopicEntity{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String searchName;
  final int sectionId;

  TopicEntity({
    this.id,
    required this.name,
    required this.searchName,
    required this.sectionId
  });
}
