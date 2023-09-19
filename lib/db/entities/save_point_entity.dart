import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/db/entities/book.dart';
import 'package:hadith/db/entities/savepoint_type_entity.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';
import 'package:hadith/features/save_point/model/savepoint.dart';

@Entity(tableName: "savePoints",foreignKeys: [
  ForeignKey(
      childColumns: ["bookId"],
      parentColumns: ["id"],
      entity: Book)
])
class SavePointEntityOld{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int itemIndexPos;
  final String title;
  final int autoType;
  late final String modifiedDate;
  final int savePointType;

  final int bookScope;
  final String parentName;

  //parentId show different meaning accordingly savePointType,
  //for all=>bookId, topic=>topicId, list=>listId,cuz=>CuzNo...
  final String parentKey;

  SavePointEntityOld({this.id,required this.itemIndexPos,required this.title,required this.autoType,
    String? modifiedDate,required this.savePointType, required this.bookScope,
    required this.parentKey,required this.parentName}){

    this.modifiedDate=modifiedDate??DateTime.now().toIso8601String();
  }

  SavePoint toSavePoint(){
    return SavePoint(
      id: id,
      itemIndexPos: itemIndexPos,
      title: title,
      autoType: SaveAutoTypeExt.fromIndex(autoType),
      modifiedDate: modifiedDate,
      savePointType: OriginTagExt.fromSavePointId(savePointType),
      bookScope: BookScopeExt.fromBinaryId(bookScope),
      parentName: parentName,
      parentKey: parentKey
    );
  }


  String toJson(){
    return json.encode({"id":id,"title":title,"autoType":autoType,
      "savePointType":savePointType,
      "bookIdBinary":bookScope,"parentKey":parentKey,"parentName":parentName,
      "modifiedDate":modifiedDate,"itemIndexPos":itemIndexPos});
  }

  static SavePointEntityOld fromJson(String data){
    final map=json.decode(data);
    final bool? isAuto = map["isAuto"];
    final autoType = isAuto!=null ? isAuto?SaveAutoType.general:SaveAutoType.none : SaveAutoTypeExt.fromIndex(map["autoType"]);
    return SavePointEntityOld(id: map["id"], title: map["title"],autoType: autoType.index,
        savePointType:map["savePointType"],
        bookScope: map["bookIdBinary"],
        parentKey: map["parentKey"],
        parentName: map["parentName"],modifiedDate: map["modifiedDate"],itemIndexPos: map["itemIndexPos"]);
  }


}