

import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:hadith/features/extra_features/counter/domain/counter_type.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';

@Entity(tableName: "countersOld")
class CounterEntityOld{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String? content;
  final String? arabicContent;
  final String? meaning;
  final int orderItem;
  final int lastCounter;
  final int? goal;
  final int type;
  final bool isRemovable;

  CounterEntityOld({this.id,required this.name,this.content,this.arabicContent,required this.orderItem,
    this.goal,required this.type,required this.lastCounter,required this.isRemovable,this.meaning});

  Counter toCounter(){
    return Counter(
        id: id,
        name: name,
        content: content,
        arabicContent: arabicContent,
        meaning: meaning,
        order: orderItem,
        goal: goal,
        counterType: CounterTypeExt.fromInt(type),
        lastCounter: lastCounter,
        isRemovable: isRemovable
    );
  }

  String toJson(){
    return json.encode({
      "name":name,
      "content":content,
      "arabicContent":arabicContent,
      "meaning": meaning,
      "orderItem":orderItem,
      "lastCounter": lastCounter,
      "goal": goal,
      "type": type,
    });
  }

  static CounterEntityOld fromJson(String data){
    final map=json.decode(data);
    return CounterEntityOld(
      name: map["name"],
      content:map["content"],
      arabicContent:map["arabicContent"],
      meaning: map["meaning"],
      orderItem:map["orderItem"],
      lastCounter:map["lastCounter"],
      goal:map["goal"],
      type:map["type"],
      isRemovable:true,
    );
  }

}
