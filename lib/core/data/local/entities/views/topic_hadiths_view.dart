

import 'package:floor/floor.dart';

@DatabaseView(
  """
    select T.id,T.name,T.sectionId, count(HT.hadithId)hadithCount from 
    topic T,HadithTopic HT where T.id=HT.topicId group by T.id
  """,
  viewName: "TopicHadithsView"
)
class TopicHadithsView{
  final int id;
  final String name;
  final int sectionId;
  final int hadithCount;

  TopicHadithsView({required this.id, required this.name, required this.sectionId,
    required this.hadithCount});
}