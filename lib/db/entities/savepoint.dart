

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:hadith/constants/enums/sourcetype_enum.dart';
import 'package:hadith/db/converter/saveauto_converter.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/constants/extensions.dart';
import 'package:hadith/db/converter/origintag_converter.dart';
import 'package:hadith/db/entities/book.dart';
import 'package:hadith/db/entities/savepoint_type_entity.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';
import 'package:hadith/features/save_point/constants/save_point_constant.dart';
import 'package:hadith/features/save_point/save_point_param.dart';
import 'package:hadith/utils/sourcetype_helper.dart';

@Entity(tableName: "savePoint",foreignKeys: [
  ForeignKey(
      childColumns: ["savePointType"],
      parentColumns: ["id"],
      entity: SavePointTypeEntity),
  ForeignKey(
      childColumns: ["bookId"],
      parentColumns: ["id"],
      entity: Book)
])
class SavePoint extends Equatable{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int itemIndexPos;
  final String title;
  final SaveAutoType autoType;
  late final String modifiedDate;
  final OriginTag savePointType;

  final BookScopeEnum bookScope;
  final String parentName;

  //parentId show different meaning accordingly savePointType,
  //for all=>bookId, topic=>topicId, list=>listId,cuz=>CuzNo...
  final String parentKey;

  SavePoint({this.id,required this.itemIndexPos,required this.title,required this.autoType,
    String? modifiedDate,required this.savePointType, required this.bookScope,
    required this.parentKey,required this.parentName}){

    this.modifiedDate=modifiedDate??DateTime.now().toIso8601String();
  }

  SavePoint copyWith({int? id,int? itemIndexPos,String? title,SaveAutoType? autoType,String? modifiedDate,
    OriginTag? savePointType,BookScopeEnum? bookScope,String? parentKey,String? parentName}){
    return SavePoint(itemIndexPos: itemIndexPos??this.itemIndexPos,
        title: title??this.title,autoType: autoType??this.autoType,
        savePointType: savePointType??this.savePointType,id: id??this.id,
        bookScope: bookScope??this.bookScope, parentKey: parentKey??this.parentKey,
        parentName: parentName??this.parentName);
  }

  @override
  List<Object?> get props => [id,parentName,itemIndexPos,title,autoType,modifiedDate,savePointType,bookScope,parentKey];


  String toJson(){
    return json.encode({"id":id,"title":title,"autoType":SaveAutoTypeConverter().encode(autoType),
        "savePointType":OriginTagConverter().encode(savePointType),
        "bookIdBinary":bookScope.binaryId,"parentKey":parentKey,"parentName":parentName,
        "modifiedDate":modifiedDate,"itemIndexPos":itemIndexPos});
  }

  static SavePoint fromJson(String data){
    final map=json.decode(data);
    final bool? isAuto = map["isAuto"];
    final autoType = isAuto!=null ? isAuto?SaveAutoType.general:SaveAutoType.none : SaveAutoTypeConverter().decode(map["autoType"]);
    return SavePoint(id: map["id"], title: map["title"],autoType: autoType,
        savePointType:OriginTagConverter().decode(map["savePointType"]),
        bookScope: SourceTypeHelper.getBookScopeFromBookBinaryId(map["bookIdBinary"]),
        parentKey: map["parentKey"],
        parentName: map["parentName"],modifiedDate: map["modifiedDate"],itemIndexPos: map["itemIndexPos"]);
  }


}