

import 'package:floor/floor.dart';

@DatabaseView(
  """
  select T.id,T.name,T.sectionId, count(VT.verseId)verseCount from 
  topic T,VerseTopic VT where T.id=VT.topicId group by T.id
  """,
  viewName: "TopicVersesView"
)
class TopicVersesView{
  final int id;
  final String name;
  final int sectionId;
  final int verseCount;

  TopicVersesView({required this.id, required this.name, required this.sectionId,
    required this.verseCount
  });
}