
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:hadith/constants/enums/topic_savepoint_enum.dart';
import 'package:hadith/db/entities/topic_savepoint_entity.dart';

class TopicSavePoint extends Equatable{
  final int? id;
  final int pos;
  final TopicSavePointEnum type;
  final String parentKey;

  const TopicSavePoint({this.id,required this.pos,required this.type,required this.parentKey});

  TopicSavePoint copyWith({int? id,required bool keepOldId,int? pos,TopicSavePointEnum? type,String? parentKey}){
    return TopicSavePoint(pos: pos??this.pos, type: type??this.type,
        parentKey: parentKey??this.parentKey,id: keepOldId?id??this.id:id);
  }

  TopicSavePointEntityOld toTopicSavePointEntity(){
    return TopicSavePointEntityOld(id: id,pos: pos, type: type.type, parentKey: parentKey);
  }

  @override
  List<Object?> get props => [id,pos,type,parentKey];

}