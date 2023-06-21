


import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/source_type_entity.dart';

@Entity(
    tableName: "History",
    foreignKeys: [
      ForeignKey(
        childColumns: ["originType"],
        parentColumns: ["id"],
        entity: SourceTypeEntity
      )
    ]
)
class HistoryEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final int originType;
  final String modifiedDate;

  const HistoryEntity({this.id, required this.name, required this.originType,required this.modifiedDate});
}