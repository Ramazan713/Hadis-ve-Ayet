
import 'package:floor/floor.dart';

@DatabaseView(
  """
    select S.id, S.name, S.bookId, count(T.id)topicCount from section S,Topic T 
    where S.id=T.sectionId  group by S.id
  """,
  viewName: "SectionTopicsView"
)
class SectionTopicsView{
  final int id;
  final String name;
  final int bookId;
  final int topicCount;

  SectionTopicsView({required this.id, required this.name, required this.bookId,
    required this.topicCount
  });
}