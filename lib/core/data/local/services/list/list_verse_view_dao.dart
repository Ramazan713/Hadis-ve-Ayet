
import 'package:floor/floor.dart';
import 'package:hadith/core/data/local/views/list_verse_view.dart';

@dao
abstract class ListVerseViewDao{

  @Query("""
    select * from listVerseView where isArchive=:isArchive order by isRemovable asc,listPos desc
  """)
  Stream<List<ListVerseView>> getStreamListVerseViewByIsArchive(bool isArchive);

  @Query("""
    select * from listVerseView where isRemovable=1 order by isRemovable asc,listPos desc
  """)
  Stream<List<ListVerseView>> getStreamRemovableListVerseView();

  @Query("""
    select * from listVerseView where isRemovable=1 and isArchive=:isArchive order by isRemovable asc,listPos desc
  """)
  Stream<List<ListVerseView>> getStreamRemovableListVerseViewByIsArchive(bool isArchive);

  @Query("""select * from listVerseView where isArchive=:isArchive and
     name like :querySearchFull order by 
     (case when lower(name)=:queryRaw then 1 when name like :queryOrderForLike then 2 else 3 end ), isRemovable asc ,listPos desc""")
  Stream<List<ListVerseView>> getStreamListVersesViewByQueryAndIsArchive(
      String querySearchFull,
      String queryOrderForLike,
      String queryRaw,
      bool isArchive
  );
}