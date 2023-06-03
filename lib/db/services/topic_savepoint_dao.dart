

import 'package:floor/floor.dart';
import 'package:hadith/db/entities/topic_savepoint_entity.dart';
import 'package:hadith/features/topic_savepoint/model/topic_savepoint.dart';

@dao
abstract class TopicSavePointDaoOld{

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int>insertTopicSavePoint(TopicSavePointEntityOld topicSavePointEntity);

  @Update()
  Future<int>updateTopicSavePoint(TopicSavePointEntityOld topicSavePointEntity);

  @delete
  Future<int>deleteTopicSavePoint(TopicSavePointEntityOld topicSavePointEntity);

  @Query("""select * from topicSavePoint where type=:type and parentKey=:parentKey
     order by id desc limit 1""")
  Stream<TopicSavePointEntityOld?> getStreamTopicSavePointEntity(int type,
      String parentKey);

  @Query("""select * from topicSavePoint where type=:type and parentKey=:parentKey
     order by id desc limit 1""")
  Future<TopicSavePointEntityOld?> getTopicSavePointEntity(int type,
      String parentKey);


}