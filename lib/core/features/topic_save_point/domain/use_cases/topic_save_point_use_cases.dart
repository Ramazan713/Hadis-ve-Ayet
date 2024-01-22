
import 'package:hadith/core/features/topic_save_point/domain/use_cases/delete_topic_save_point.dart';
import 'package:hadith/core/features/topic_save_point/domain/use_cases/get_topic_save_point.dart';
import 'package:hadith/core/features/topic_save_point/domain/use_cases/insert_topic_save_point.dart';

class TopicSavePointUseCases{
  final InsertTopicSavePoint insertSavePoint;
  final DeleteTopicSavePoint deleteSavePoint;
  final GetTopicSavePoint getSavePoint;

  TopicSavePointUseCases({required this.insertSavePoint, required this.deleteSavePoint,
    required this.getSavePoint});
}