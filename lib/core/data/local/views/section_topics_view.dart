
import 'package:floor/floor.dart';

@DatabaseView("""
    select S.id, S.name, S.searchName, S.bookId, count(T.id)topicCount from sections S, topics T 
    where S.id = T.sectionId group by S.id
  """,
  viewName: "SectionTopicsView"
)
class SectionTopicsView{
  final int id;
  final String name;
  final String searchName;
  final int bookId;
  final int topicCount;

  SectionTopicsView({
    required this.id,
    required this.name,
    required this.searchName,
    required this.bookId,
    required this.topicCount
  });
}