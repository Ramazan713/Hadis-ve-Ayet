import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/core/domain/repo/topic_save_point_repo.dart';


class DeleteTopicSavePoint{
  late final TopicSavePointRepo _topicSavePointRepo;

  DeleteTopicSavePoint({required TopicSavePointRepo topicSavePointRepo}){
    _topicSavePointRepo = topicSavePointRepo;
  }

  Future<void> call(TopicSavePoint topicSavePoint) async{
      await _topicSavePointRepo.deleteTopicSavePoint(topicSavePoint);
  }
}