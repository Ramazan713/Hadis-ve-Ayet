

import 'package:hadith/core/data/mapper/topic_save_point.dart';
import 'package:hadith/core/data/local/services/topic_save_point_dao.dart';
import 'package:hadith/core/domain/enums/topic_save_point.dart';

import 'package:hadith/core/domain/models/topic_save_point.dart';

import '../../domain/repo/topic_save_point_repo.dart';

class TopicSavePointRepoImpl extends TopicSavePointRepo{

  late final TopicSavePointDao _topicSavePointDao;

  TopicSavePointRepoImpl({required TopicSavePointDao topicSavePointDao}){
    _topicSavePointDao = topicSavePointDao;
  }

  @override
  Future<void> deleteTopicSavePoint(TopicSavePoint topicSavePoint) async{
    await _topicSavePointDao.deleteTopicSavePoint(topicSavePoint.toTopicSavePointEntity());
  }

  @override
  Stream<TopicSavePoint?> getStreamTopicSavePoint(TopicSavePointType topicType){
    return _topicSavePointDao.getStreamTopicSavePointEntity(topicType.getTypeId(), topicType.getSaveKey())
        .map((item) => item?.toTopicSavePoint());
  }

  @override
  Future<int> insertTopicSavePoint(TopicSavePoint topicSavePoint) async{
    return await _topicSavePointDao.insertTopicSavePoint(topicSavePoint.toTopicSavePointEntity());
  }

  @override
  Future<void> updateTopicSavePoint(TopicSavePoint topicSavePoint) async{
    await _topicSavePointDao.updateTopicSavePoint(topicSavePoint.toTopicSavePointEntity());
  }

  @override
  Future<TopicSavePoint?> getTopicSavePoint(TopicSavePointType topicType) async{
    return (await _topicSavePointDao.getTopicSavePointEntity(topicType.getTypeId(), topicType.getSaveKey()))
        ?.toTopicSavePoint();
  }

}