import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/topic_savepoint_enum.dart';
import 'package:hadith/features/topic_savepoint/model/topic_savepoint.dart';

abstract class ITopicSavePointEvent{}

class TopicSavePointEventRequest extends ITopicSavePointEvent{
  final TopicSavePointEnum topicSavePointEnum;
  final String parentKey;
  TopicSavePointEventRequest({required this.topicSavePointEnum,required this.parentKey});
}

class TopicSavePointEventInsert extends ITopicSavePointEvent{
  final TopicSavePointEnum topicSavePointEnum;

  final TopicSavePoint topicSavePoint;
  TopicSavePointEventInsert({required this.topicSavePoint,required this.topicSavePointEnum});
}

class TopicSavePointEventDelete extends ITopicSavePointEvent{
  final TopicSavePoint topicSavePoint;
  TopicSavePointEventDelete({required this.topicSavePoint});
}
