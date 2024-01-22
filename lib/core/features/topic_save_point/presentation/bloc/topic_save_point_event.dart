
import 'package:hadith/core/features/topic_save_point/domain/enums/topic_save_point_type.dart';

abstract class ITopicSavePointEvent{}

class TopicSavePointEventLoadData extends ITopicSavePointEvent{
  final TopicSavePointType topicType;
  TopicSavePointEventLoadData({required this.topicType});
}

class TopicSavePointEventInsertSavePoint extends ITopicSavePointEvent{
  final int pos;
  TopicSavePointEventInsertSavePoint({required this.pos});
}

class TopicSavePointEventDeleteSavePoint extends ITopicSavePointEvent{}