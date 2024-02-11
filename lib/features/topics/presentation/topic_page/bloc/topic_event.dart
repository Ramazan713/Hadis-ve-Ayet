

import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';

abstract class ITopicEvent{}

class TopicEventLoadData extends ITopicEvent{
  final BookEnum book;
  final bool useBookAllSections;
  final int sectionId;
  final int? selectedTopicId;

  TopicEventLoadData({
    required this.book,
    required this.sectionId,
    required this.useBookAllSections,
    this.selectedTopicId
  });
}

class TopicEventSetSearchBarVisibility extends ITopicEvent{
  final bool isSearchBarVisible;
  TopicEventSetSearchBarVisibility({required this.isSearchBarVisible});
}

class TopicEventSearch extends ITopicEvent{
  final String query;
  TopicEventSearch({required this.query});
}


class TopicEventHideDetail extends ITopicEvent{}

class TopicEventClearJumpToPos extends ITopicEvent{}


class TopicEventShowDetail extends ITopicEvent{
  final TopicViewModel item;
  TopicEventShowDetail({required this.item});
}