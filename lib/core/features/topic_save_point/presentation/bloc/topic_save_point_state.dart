import 'package:equatable/equatable.dart';
import 'package:hadith/core/features/topic_save_point/domain/enums/topic_save_point_type.dart';
import 'package:hadith/core/features/topic_save_point/domain/models/topic_save_point.dart';

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