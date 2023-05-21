

import 'package:floor/floor.dart';

final migration4To5 = Migration(4, 5, (database)async{

  database.transaction((txn)async{

    txn.execute("""
       create view HadithInfoListView as select H.id hadithId,
        (select exists(select * from ListHadith LH, list L
          where LH.listId = L.id and L.isRemovable = 1 and LH.hadithId = H.id)) inAnyList,
        (select exists(select * from ListHadith LH, list L
          where LH.listId = L.id and L.isRemovable = 0 and LH.hadithId = H.id)) inFavorite 
        from Hadith H
    """);

    txn.execute("""
       create view VerseInfoListView as select V.id verseId,
        (select exists(select * from ListVerse LV, list L
          where LV.listId = L.id and L.isRemovable = 1 and LV.verseId = V.id)) inAnyList,
        (select exists(select * from ListVerse LV, list L
          where LV.listId = L.id and L.isRemovable = 0 and LV.verseId = V.id)) inFavorite 
        from verse V
    """);

  });
});