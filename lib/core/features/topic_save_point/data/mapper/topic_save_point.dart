

import 'package:hadith/core/data/local/entities/topic_savepoint_entity.dart';
import 'package:hadith/core/features/topic_save_point/domain/enums/topic_save_point_type.dart';
import 'package:hadith/core/features/topic_save_point/domain/models/topic_save_point.dart';

extension TopicSavePointEntityExt on TopicSavePointEntity{

  TopicSavePoint toTopicSavePoint(){
    return TopicSavePoint(
      id: id,
      pos: pos,
      topicType: TopicSavePointType.fromOrDefault(type, parentKey)
    );
  }
}

extension TopicSavePointExt on TopicSavePoint{

  TopicSavePointEntity toTopicSavePointEntity(){
    return TopicSavePointEntity(
        id: id,
        pos: pos,
        type: topicType.getTypeId(),
        parentKey: topicType.getSaveKey()
    );
  }
}
