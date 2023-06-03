

import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/paging/scroll_direction.dart';
import 'package:hadith/core/domain/enums/topic_save_point.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';

class TopicState extends Equatable{

  final bool searchBarVisible;
  final List<TopicViewModel> items;
  final TopicSavePoint? topicSavePoint;
  final TopicSavePointType topicType;
  final ScrollDirection scrollDirection;
  final int middleVisiblePos;

  const TopicState({
    required this.searchBarVisible,
    required this.items,
    this.topicSavePoint,
    required this.topicType,
    required this.scrollDirection,
    required this.middleVisiblePos
  });

  TopicState copyWith({
    bool? searchBarVisible,
    List<TopicViewModel>? items,
    TopicSavePoint? topicSavePoint, bool setTopicSavePoint = false,
    TopicSavePointType? topicType,
    ScrollDirection? scrollDirection,
    int? middleVisiblePos
  }){
    return TopicState(
        searchBarVisible: searchBarVisible ?? this.searchBarVisible,
        items: items ?? this.items,
        topicSavePoint: setTopicSavePoint ? topicSavePoint : this.topicSavePoint,
        topicType: topicType ?? this.topicType,
        scrollDirection: scrollDirection ?? this.scrollDirection,
        middleVisiblePos: middleVisiblePos ?? this.middleVisiblePos

    );
  }

  static TopicState init(){
    return TopicState(
        searchBarVisible: false,
        items: const [],
        topicType: TopicSavePointTypeTopic(sectionId: 1),
        scrollDirection: ScrollDirection.up,
        middleVisiblePos: 0
    );
  }

  @override
  List<Object?> get props => [searchBarVisible, items, topicType, topicSavePoint, middleVisiblePos,
    scrollDirection];
}