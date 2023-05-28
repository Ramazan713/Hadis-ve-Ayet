import 'package:floor/floor.dart';

@DatabaseView("""select V.id verseId,
        (select exists(select * from ListVerse LV, list L
          where LV.listId = L.id and L.isRemovable = 1 and L.isArchive = 0 and LV.verseId = V.id)) inAnyList,
		    (select exists(select * from ListVerse LV, list L
          where LV.listId = L.id and L.isRemovable = 1 and L.isArchive = 1 and LV.verseId = V.id)) inAnyArchiveList,  
        (select exists(select * from ListVerse LV, list L
          where LV.listId = L.id and L.isRemovable = 0 and LV.verseId = V.id)) inFavorite 
        from verse V""",
    viewName: "VerseInfoListView")
class VerseInfoListView{
  final int verseId;
  final bool inAnyList;
  final bool inAnyArchiveList;
  final bool inFavorite;

  VerseInfoListView({required this.verseId,required this.inAnyList,
    required this.inFavorite,required this.inAnyArchiveList});
}