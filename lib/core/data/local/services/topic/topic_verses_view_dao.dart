

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/views/topic_verses_view.dart';

@dao
abstract class TopicVersesViewDao{

  @Query("""
    select * from topicVersesView where sectionId = :sectionId
  """)
  Stream<List<TopicVersesView>> getStreamTopicVersesBySectionId(int sectionId);

  @Query("""
    select * from topicVersesView where sectionId = :sectionId and
     name like :querySearchFull order by 
     (case when lower(name)=:queryRaw then 1 when name like :queryOrderForLike 
     then 2 else 3 end )
  """)
  Stream<List<TopicVersesView>> getStreamTopicVersesBySectionIdAndQuery(
      int sectionId,
      String querySearchFull,
      String queryOrderForLike,
      String queryRaw,
  );


  @Query("""
    select TV.* from topicVersesView TV, sectionTopicsView ST
    where TV.sectionId = ST.id and ST.bookId = :bookId order by TV.id
  """)
  Stream<List<TopicVersesView>> getStreamTopicVersesByBookId(int bookId);


  @Query("""
    select TV.* from topicVersesView TV, sectionTopicsView ST
    where TV.sectionId = ST.id and ST.bookId = :bookId and
    TV.name like :querySearchFull order by 
    (case when lower(TV.name)=:queryRaw then 1 when TV.name like :queryOrderForLike 
    then 2 else 3 end ), TV.id
  """)
  Stream<List<TopicVersesView>> getStreamTopicVersesByBookIdAndQuery(
      int bookId,
      String querySearchFull,
      String queryOrderForLike,
      String queryRaw,
  );
}