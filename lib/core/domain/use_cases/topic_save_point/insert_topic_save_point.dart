

import 'package:hadith/core/domain/enums/topic_save_point.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/core/domain/repo/topic_save_point_repo.dart';

class InsertTopicSavePoint{
  late final TopicSavePointRepo _topicSavePointRepo;

  InsertTopicSavePoint({required TopicSavePointRepo topicSavePointRepo}){
    _topicSavePointRepo = topicSavePointRepo;
  }

  Future<void> call(int pos, TopicSavePointType topicType) async{
    final existTopicSavePoint = await _topicSavePointRepo.getTopicSavePoint(topicType);
    if(existTopicSavePoint != null){
      final updatedTopicSavePoint = existTopicSavePoint.copyWith(pos: pos);
      await _topicSavePointRepo.updateTopicSavePoint(updatedTopicSavePoint);
    }else{
      final topicSavePoint = TopicSavePoint(pos: pos, topicType: topicType);
      await _topicSavePointRepo.insertTopicSavePoint(topicSavePoint);
    }
  }
}