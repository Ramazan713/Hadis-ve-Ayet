import 'package:floor/floor.dart';

@DatabaseView(""" select H.id hadithId,
        (select exists(select * from ListHadith LH, list L
          where LH.listId = L.id and L.isRemovable = 1 and LH.hadithId = H.id)) inAnyList,
        (select exists(select * from ListHadith LH, list L
          where LH.listId = L.id and L.isRemovable = 0 and LH.hadithId = H.id)) inFavorite 
        from Hadith H""",
    viewName: "HadithInfoListView")
class HadithInfoListView{
  final int hadithId;
  final bool inAnyList;
  final bool inFavorite;

  HadithInfoListView({required this.hadithId,required this.inAnyList,required this.inFavorite});
}