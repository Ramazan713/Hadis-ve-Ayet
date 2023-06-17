

import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/scroll_direction.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';

abstract class ITopicEvent{}

class TopicEventLoadData extends ITopicEvent{
  final BookEnum book;
  final bool useBookAllSections;
  final int sectionId;
  TopicEventLoadData({required this.book, required this.sectionId, required this.useBookAllSections});
}

class TopicEventSetSearchBarVisibility extends ITopicEvent{
  final bool isSearchBarVisible;
  TopicEventSetSearchBarVisibility({required this.isSearchBarVisible});
}

class TopicEventSearch extends ITopicEvent{
  final String query;
  TopicEventSearch({required this.query});
}