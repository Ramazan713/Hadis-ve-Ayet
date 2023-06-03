

import 'package:hadith/core/domain/use_cases/topic_save_point/delete_topic_save_point.dart';
import 'package:hadith/core/domain/use_cases/topic_save_point/get_topic_save_point.dart';
import 'package:hadith/core/domain/use_cases/topic_save_point/insert_topic_save_point.dart';

class TopicSavePointUseCases{
  final InsertTopicSavePoint insertSavePoint;
  final DeleteTopicSavePoint deleteSavePoint;
  final GetTopicSavePoint getSavePoint;

  TopicSavePointUseCases({required this.insertSavePoint, required this.deleteSavePoint,
    required this.getSavePoint});
}