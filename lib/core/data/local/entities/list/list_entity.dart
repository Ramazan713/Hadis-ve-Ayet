
import 'package:floor/floor.dart';

@Entity(tableName: "list")
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