import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:hadith/db/entities/source_type_entity.dart';

@Entity(tableName: "History", foreignKeys: [
  ForeignKey(
      childColumns: ["originType"],
      parentColumns: ["id"],
      entity: SourceTypeEntity)
])
class HistoryEntityOld {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final int originType;
  final String modifiedDate;

  HistoryEntityOld({this.id, required this.name, required this.originType,required this.modifiedDate});

  HistoryEntityOld copyWith({int? id,String? name,int? originType,String? modifiedDate}){
    return HistoryEntityOld(name: name??this.name, originType: originType??this.originType,
        modifiedDate: modifiedDate??this.modifiedDate,id: id??this.id);
  }

  String toJson(){
    return json.encode({"id":id,"name":name,"originType":originType,"modifiedDate":modifiedDate});
  }

  static HistoryEntityOld fromJson(String data){
    final map=json.decode(data);
    return HistoryEntityOld(id: map["id"], name: map["name"],originType:map["originType"],
        modifiedDate:map["modifiedDate"]);
  }


}
