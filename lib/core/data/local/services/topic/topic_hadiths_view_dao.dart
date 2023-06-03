

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/views/topic_hadiths_view.dart';

@dao
abstract class TopicHadithViewDao{

  @Query("""
    select * from topicHadithsView where sectionId = :sectionId
  """)
  Stream<List<TopicHadithsView>> getStreamTopicHadithsBySectionId(int sectionId);

  @Query("""
    select * from topicHadithsView where sectionId = :sectionId and
     name like :querySearchFull order by 
     (case when lower(name)=:queryRaw then 1 when name like :queryOrderForLike 
     then 2 else 3 end )
  """)
  Stream<List<TopicHadithsView>> getStreamTopicHadithsBySectionIdAndQuery(
      int sectionId,
      String querySearchFull,
      String queryOrderForLike,
      String queryRaw,
  );


  @Query("""
    select TH.* from topicHadithsView TH, sectionTopicsView ST
    where TH.sectionId = ST.id and ST.bookId = :bookId
  """)
  Stream<List<TopicHadithsView>> getStreamTopicHadithsByBookId(int bookId);


  @Query("""
    select TH.* from topicHadithsView TH, sectionTopicsView ST
    where TH.sectionId = ST.id and ST.bookId = :bookId and
    TH.name like :querySearchFull order by 
    (case when lower(TH.name)=:queryRaw then 1 when TH.name like :queryOrderForLike 
    then 2 else 3 end )
  """)
  Stream<List<TopicHadithsView>> getStreamTopicHadithsByBookIdAndQuery(
      int bookId,
      String querySearchFull,
      String queryOrderForLike,
      String queryRaw,
  );
}