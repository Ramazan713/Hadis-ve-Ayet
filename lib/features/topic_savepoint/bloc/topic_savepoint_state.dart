import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/features/topic_savepoint/model/topic_savepoint.dart';

class TopicSavePointState extends Equatable{
  final DataStatus status;
  final TopicSavePoint? topicSavePointEntity;

  const TopicSavePointState({required this.status,required this.topicSavePointEntity});

  TopicSavePointState copyWith({DataStatus? status,required bool keepOldSavePoint,
    TopicSavePoint? topicSavePointEntity}){
    return TopicSavePointState(status: status??this.status,
        topicSavePointEntity: keepOldSavePoint?topicSavePointEntity??this.topicSavePointEntity:topicSavePointEntity);
  }

  @override
  List<Object?> get props => [status,topicSavePointEntity];

}