

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/source_type_entity.dart';

@Entity(
  tableName: "Books",
  foreignKeys:[
    ForeignKey(
      childColumns: ["sourceId"],
      parentColumns: ["id"],
      entity: SourceTypeEntity
    )
  ]
)
class BookEntity{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final int sourceId;

  BookEntity({this.id,required this.name,required this.sourceId});
}