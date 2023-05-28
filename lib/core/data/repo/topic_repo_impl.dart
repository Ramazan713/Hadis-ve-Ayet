

import 'package:hadith/core/data/local/services/topic_dao.dart';
import 'package:hadith/core/domain/repo/topic_repo.dart';

class TopicRepoImpl extends TopicRepo{

  late final TopicDao _topicDao;

  TopicRepoImpl({required TopicDao topicDao}){
    _topicDao = topicDao;
  }

  @override
  Future<List<String>> getTopicNamesByHadithId(int hadithId)async{
    return _topicDao.getTopicNamesByHadithId(hadithId);
  }
}