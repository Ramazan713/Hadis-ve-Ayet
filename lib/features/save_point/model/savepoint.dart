

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:hadith/db/entities/save_point_entity.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/db/entities/book.dart';
import 'package:hadith/db/entities/savepoint_type_entity.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';


class SavePoint extends Equatable{
  final int? id;
  final int itemIndexPos;
  final String title;
  final SaveAutoType autoType;
  late final String modifiedDate;
  final OriginTag savePointType;
  final BookScopeEnum bookScope;
  final String parentName;
  final String parentKey;

  SavePoint({this.id,required this.itemIndexPos,required this.title,required this.autoType,
    String? modifiedDate,required this.savePointType, required this.bookScope,
    required this.parentKey,required this.parentName}){

    this.modifiedDate=modifiedDate??DateTime.now().toIso8601String();
  }

  SavePointEntity toSavePointEntity(){
    return SavePointEntity(
      id: id,
      itemIndexPos: itemIndexPos,
      title: title,
      autoType: autoType.index,
      modifiedDate: modifiedDate,
      savePointType: savePointType.savePointId,
      bookScope: bookScope.binaryId,
      parentName: parentName,
      parentKey: parentKey
    );
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

}