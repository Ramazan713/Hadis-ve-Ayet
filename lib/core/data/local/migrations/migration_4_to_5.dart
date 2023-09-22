

import 'package:floor/floor.dart';

final migration4To5 = Migration(4, 5, (database)async{

  database.transaction((txn)async{

    txn.execute("""
       CREATE VIEW HadithInfoListView as select H.id hadithId,
        (select exists(select * from ListHadith LH, list L
          where LH.listId = L.id and L.isRemovable = 1 and L.isArchive = 0 and LH.hadithId = H.id)) inAnyList,
		    (select exists(select * from ListHadith LH, list L
          where LH.listId = L.id and L.isRemovable = 1 and L.isArchive = 1 and LH.hadithId = H.id)) inAnyArchiveList,
        (select exists(select * from ListHadith LH, list L
          where LH.listId = L.id and L.isRemovable = 0 and LH.hadithId = H.id)) inFavorite 
        from Hadith H
    """);

    txn.execute("""
      CREATE VIEW VerseInfoListView as select V.id verseId,
        (select exists(select * from ListVerse LV, list L
          where LV.listId = L.id and L.isRemovable = 1 and L.isArchive = 0 and LV.verseId = V.id)) inAnyList,
		    (select exists(select * from ListVerse LV, list L
          where LV.listId = L.id and L.isRemovable = 1 and L.isArchive = 1 and LV.verseId = V.id)) inAnyArchiveList,  
        (select exists(select * from ListVerse LV, list L
          where LV.listId = L.id and L.isRemovable = 0 and LV.verseId = V.id)) inFavorite 
        from verse V
    """);

    txn.execute("""
      CREATE VIEW SectionTopicsView as select S.id, S.name, S.bookId, count(T.id)topicCount from section S,Topic T 
      where S.id=T.sectionId  group by S.id
    """);

    txn.execute("""
      CREATE VIEW TopicHadithsView as select T.id,T.name,T.sectionId, count(HT.hadithId)hadithCount from 
      topic T,HadithTopic HT where T.id=HT.topicId group by T.id
    """);

    txn.execute("""
      CREATE VIEW TopicVersesView as select T.id,T.name,T.sectionId, count(VT.verseId)verseCount from 
      topic T,VerseTopic VT where T.id=VT.topicId group by T.id
    """);

    txn.execute("alter table SavePoint RENAME to SavePoints");

  });
});