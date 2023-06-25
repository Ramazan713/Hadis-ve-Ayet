

import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/scrolling/scroll_direction.dart';
import 'package:hadith/core/domain/enums/topic_save_point.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';

class TopicSavePointState extends Equatable{

  final TopicSavePoint? topicSavePoint;
  final TopicSavePointType topicType;

  const TopicSavePointState({
    this.topicSavePoint,
    required this.topicType,
  });

  TopicSavePointState copyWith({
    TopicSavePoint? topicSavePoint, bool setTopicSavePoint = false,
    TopicSavePointType? topicType,
  }){
    return TopicSavePointState(

        topicSavePoint: setTopicSavePoint ? topicSavePoint : this.topicSavePoint,
        topicType: topicType ?? this.topicType,
    );
  }

  static TopicSavePointState init(){
    return TopicSavePointState(
        topicType: TopicSavePointTypeTopic(sectionId: 1),
    );
  }

  @override
  List<Object?> get props => [topicType, topicSavePoint,];
}