
import 'package:hadith/core/features/topic_save_point/domain/enums/topic_save_point_type.dart';
import 'package:hadith/core/features/topic_save_point/domain/models/topic_save_point.dart';

abstract class TopicSavePointRepo{

  Future<int> insertTopicSavePoint(TopicSavePoint topicSavePoint);

  Future<void> updateTopicSavePoint(TopicSavePoint topicSavePoint);

  Future<void> deleteTopicSavePoint(TopicSavePoint topicSavePoint);

  Stream<TopicSavePoint?> getStreamTopicSavePoint(TopicSavePointType topicType);

  Future<TopicSavePoint?> getTopicSavePoint(TopicSavePointType topicType);
}