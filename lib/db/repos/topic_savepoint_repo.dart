

import 'package:hadith/constants/enums/topic_savepoint_enum.dart';
import 'package:hadith/features/topic_savepoint/model/topic_savepoint.dart';
import 'package:hadith/db/services/topic_savepoint_dao.dart';

class TopicSavePointRepo{
  final TopicSavePointDao savePointDao;

  TopicSavePointRepo({required this.savePointDao});

  Future<int>insertTopicSavePoint(TopicSavePoint topicSavePoint)=>
      savePointDao.insertTopicSavePoint(topicSavePoint.toTopicSavePointEntity());

  Future<int>updateTopicSavePoint(TopicSavePoint topicSavePoint)=>
      savePointDao.updateTopicSavePoint(topicSavePoint.toTopicSavePointEntity());

  Future<int>deleteTopicSavePoint(TopicSavePoint topicSavePoint)=>
      savePointDao.deleteTopicSavePoint(topicSavePoint.toTopicSavePointEntity());

  Stream<TopicSavePoint?>getStreamTopicSavePointEntity(TopicSavePointEnum topicSavePointEnum,
      String parentKey)=>savePointDao.getStreamTopicSavePointEntity(topicSavePointEnum.type, parentKey).map((event) => event?.toTopicSavePoint());

  Future<TopicSavePoint?>getTopicSavePointEntity(TopicSavePointEnum topicSavePointEnum,
      String parentKey)async{
    return (await savePointDao.getTopicSavePointEntity(topicSavePointEnum.type, parentKey))?.toTopicSavePoint();
  }

}