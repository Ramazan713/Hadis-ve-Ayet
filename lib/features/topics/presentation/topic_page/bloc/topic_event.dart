

import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/paging/scroll_direction.dart';
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

class TopicEventListenTopicSavePoint extends ITopicEvent{}

class TopicEventSetScrollDirection extends ITopicEvent{
  final ScrollDirection scrollDirection;
  TopicEventSetScrollDirection({required this.scrollDirection});
}

class TopicEventSetVisibleMiddlePos extends ITopicEvent{
  final int firstVisiblePos;
  final int lastVisiblePos;
  TopicEventSetVisibleMiddlePos({required this.firstVisiblePos, required this.lastVisiblePos});
}


class TopicEventInsertSavePoint extends ITopicEvent{
  final int pos;
  TopicEventInsertSavePoint({required this.pos});
}

class TopicEventDeleteSavePoint extends ITopicEvent{}