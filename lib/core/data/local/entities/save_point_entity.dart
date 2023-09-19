

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/book_entity.dart';
import 'package:hadith/core/data/local/entities/savepoint_type_entity.dart';

@Entity(tableName: "savePoints",foreignKeys: [
  ForeignKey(
      childColumns: ["bookId"],
      parentColumns: ["id"],
      entity: BookEntity)
])
class SavePointEntity{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int itemIndexPos;
  final String title;
  final int autoType;
  final String modifiedDate;
  final int savePointType;

  final int bookScope;
  final String parentName;

  //parentId show different meaning accordingly savePointType,
  //for all=>bookId, topic=>topicId, list=>listId,cuz=>CuzNo...
  final String parentKey;

  SavePointEntity({this.id,required this.itemIndexPos,required this.title,required this.autoType,
    required this.modifiedDate,required this.savePointType, required this.bookScope,
    required this.parentKey,required this.parentName});

}