

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/views/section_topics_view.dart';

@dao
abstract class SectionViewDao{

  @Query("""
    select * from sectionTopicsView where bookId = :bookId
  """)
  Stream<List<SectionTopicsView>> getSectionTopicsByBookId(int bookId);

  @Query("""
    select * from sectionTopicsView where bookId = :bookId and
     (name like :querySearchFull or searchName like :querySearchFull)
     order by 
     (case when lower(name)=:queryRaw then 1 
     when name like :queryOrderForLike then 2 
     when searchName like :queryOrderForLike then 3
     else 4 end)
  """)
  Stream<List<SectionTopicsView>> getSectionTopicsByBookIdAndQuery(
      int bookId,
      String querySearchFull,
      String queryOrderForLike,
      String queryRaw,
  );

  @Query("""
      select sum(topicCount) from sectionTopicsView where bookId = :bookId
  """)
  Future<int?> getTopicsCountByBookId(int bookId);

}