
import 'package:hadith/core/domain/enums/topic_save_point.dart';

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