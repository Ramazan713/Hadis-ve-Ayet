
import 'package:floor/floor.dart';

@dao
abstract class TopicDao{

  @Query("""select T.name from topic T,HadithTopic HT
     where T.id=HT.topicId and HT.hadithId=:hadithId""")
  Future<List<String>> getTopicNamesByHadithId(int hadithId);
}