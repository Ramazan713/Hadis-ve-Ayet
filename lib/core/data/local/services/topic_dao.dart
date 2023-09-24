
import 'package:floor/floor.dart';

@dao
abstract class TopicDao{

  @Query("""
    select T.name from topics T, hadithTopics HT
    where T.id=HT.topicId and HT.hadithId=:hadithId
  """)
  Future<List<String>> getTopicNamesByHadithId(int hadithId);
}