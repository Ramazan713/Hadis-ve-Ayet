
import 'package:hadith/core/domain/enums/topic_save_point.dart';

class TopicSavePoint{
  final int? id;
  final int pos;
  final TopicSavePointType topicType;

  TopicSavePoint({this.id, required this.pos, required this.topicType});


  TopicSavePoint copyWith({int? id, bool setId = false, int? pos, TopicSavePointType? topicType}){
    return TopicSavePoint(
      id: setId ? id : this.id,
      pos: pos ?? this.pos,
      topicType: topicType ?? this.topicType
    );
  }

}