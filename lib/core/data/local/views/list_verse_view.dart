import 'package:floor/floor.dart';

@DatabaseView("""
    select L.id, L.name, L.isRemovable, L.isArchive, L.sourceId, count(LV.verseId)itemCounts,
    ifnull(max(LV.pos),0)contentMaxPos,L.pos listPos 
    from lists L left join listVerses LV on L.id=LV.listId where L.sourceId=2 group by L.id
  """,
  viewName: "ListVerseView")
class ListVerseView{

  @primaryKey
  final int id;
  final String name;
  final int itemCounts;
  final bool isRemovable;
  final int contentMaxPos;
  final bool isArchive;
  final int sourceId;
  final int listPos;

  ListVerseView({
    required this.id,
    required this.contentMaxPos,
    required this.name,
    required this.isArchive,
    required this.sourceId,
    required this.listPos,
    required this.itemCounts,
    required this.isRemovable
  });
}
