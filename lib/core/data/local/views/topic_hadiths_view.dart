

import 'package:floor/floor.dart';

@DatabaseView("""
    select T.id,T.name, T.searchName, T.sectionId, count(HT.hadithId)hadithCount from 
    topics T, hadithTopics HT where T.id = HT.topicId group by T.id
  """,
  viewName: "TopicHadithsView"
)
class TopicHadithsView{
  final int id;
  final String name;
  final String searchName;
  final int sectionId;
  final int hadithCount;

  TopicHadithsView({
    required this.id,
    required this.name,
    required this.searchName,
    required this.sectionId,
    required this.hadithCount
  });
}