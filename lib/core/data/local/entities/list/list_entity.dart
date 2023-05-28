import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:hadith/db/entities/source_type_entity.dart';


@Entity(tableName: "list",foreignKeys: [
  ForeignKey(
      childColumns: ["sourceId"],
      parentColumns: ["id"],
      entity: SourceTypeEntity
  )
])
class ListEntity{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final bool isRemovable;
  final int sourceId;
  final bool isArchive;
  final int pos;

  const ListEntity({this.id,required this.name,this.isArchive=false,
    required this.isRemovable,required this.sourceId,required this.pos});
}