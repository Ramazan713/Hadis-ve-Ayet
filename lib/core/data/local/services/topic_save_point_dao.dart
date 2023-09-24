

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/topic_savepoint_entity.dart';

@dao
abstract class TopicSavePointDao{

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertTopicSavePoint(TopicSavePointEntity topicSavePointEntity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateTopicSavePoint(TopicSavePointEntity topicSavePointEntity);

  @delete
  Future<void> deleteTopicSavePoint(TopicSavePointEntity topicSavePointEntity);

  @Query("""select * from topicSavePoints where type=:type and parentKey=:parentKey
     order by id desc limit 1""")
  Stream<TopicSavePointEntity?> getStreamTopicSavePointEntity(int type, String parentKey);

  @Query("""select * from topicSavePoints where type=:type and parentKey=:parentKey
     order by id desc limit 1""")
  Future<TopicSavePointEntity?> getTopicSavePointEntity(int type, String parentKey);
}