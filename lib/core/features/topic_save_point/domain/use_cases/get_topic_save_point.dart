
import 'package:hadith/core/features/topic_save_point/domain/enums/topic_save_point_type.dart';
import 'package:hadith/core/features/topic_save_point/domain/models/topic_save_point.dart';
import 'package:hadith/core/features/topic_save_point/domain/repo/topic_save_point_repo.dart';

class GetTopicSavePoint{
  late final TopicSavePointRepo _topicSavePointRepo;

  GetTopicSavePoint({required TopicSavePointRepo topicSavePointRepo}){
    _topicSavePointRepo = topicSavePointRepo;
  }

  Stream<TopicSavePoint?> call(TopicSavePointType topicType){
    return _topicSavePointRepo.getStreamTopicSavePoint(topicType);
  }
}