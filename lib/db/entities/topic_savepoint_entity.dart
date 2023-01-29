

import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:hadith/constants/enums/topic_savepoint_enum.dart';
import 'package:hadith/features/topic_savepoint/model/topic_savepoint.dart';

@Entity(tableName: "topicSavePoint")
class TopicSavePointEntity{

  @primaryKey
  final int? id;
  final int pos;
  final int type;
  final String parentKey;


  TopicSavePointEntity({this.id,required this.pos,required this.type,required this.parentKey});


  TopicSavePoint toTopicSavePoint(){
    return TopicSavePoint(
      id: id,
      pos: pos,
      type: TopicSavePointExt.fromType(type),
      parentKey: parentKey
    );
  }


  String toJson(){
    return json.encode({"id":id,"type":type,"parentKey":parentKey,"pos":pos});
  }
  static TopicSavePointEntity fromJson(String data){
    final map=json.decode(data);
    return TopicSavePointEntity(id: map["id"], type: map["type"],parentKey:map["parentKey"],
        pos:map["pos"]);
  }


}