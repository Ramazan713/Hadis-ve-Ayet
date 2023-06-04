

import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/entities/views/list_hadith_view.dart';

@dao
abstract class ListHadithViewDao{

  @Query("""
    select * from listHadithView where isArchive=:isArchive order by isRemovable asc,listPos desc
  """)
  Stream<List<ListHadithView>> getStreamListHadithViewsByIsArchive(bool isArchive);

  @Query("""
    select * from listHadithView where isRemovable=1 order by isRemovable asc,listPos desc
  """)
  Stream<List<ListHadithView>> getStreamRemovableListHadithViews();

  @Query("""
    select * from listHadithView where isRemovable=1 and isArchive=:isArchive order by isRemovable asc,listPos desc
  """)
  Stream<List<ListHadithView>> getStreamRemovableListHadithViewsByIsArchive(bool isArchive);

  @Query("""select * from listHadithView where isArchive=:isArchive and
     name like :querySearchFull order by 
     (case when lower(name)=:queryRaw then 1 when name like :queryOrderForLike then 2 else 3 end ),isRemovable asc ,listPos desc""")
  Stream<List<ListHadithView>> getStreamListHadithByQueryAndIsArchive(
      String querySearchFull,
      String queryOrderForLike,
      String queryRaw,
      bool isArchive
  );

}