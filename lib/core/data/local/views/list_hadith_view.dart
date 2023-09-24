import 'package:floor/floor.dart';

@DatabaseView("""
    select L.id, L.name, L.isRemovable, count(LH.hadithId)itemCounts, L.isArchive, L.sourceId,
    ifnull(max(LH.pos),0)contentMaxPos,L.pos listPos 
    from lists L left join listHadiths LH on L.id=LH.listId where L.sourceId=1 group by L.id
  """,
  viewName: "ListHadithView"
)
class ListHadithView{

  @primaryKey
  final int id;
  final String name;
  final int itemCounts;
  final bool isRemovable;
  final int contentMaxPos;
  final bool isArchive;
  final int sourceId;
  final int listPos;

  ListHadithView({
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