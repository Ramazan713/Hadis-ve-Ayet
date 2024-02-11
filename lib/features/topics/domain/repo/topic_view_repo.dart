

import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';

abstract class TopicViewRepo{

  Stream<List<TopicViewModel>> getStreamTopicViewsBySectionId(int sectionId, SourceTypeEnum sourceType);

  Future<List<TopicViewModel>> getTopicViewsBySectionId(int sectionId, SourceTypeEnum sourceType);


  Stream<List<TopicViewModel>> getStreamTopicViewsBySectionIdAndQuery(int sectionId,
      String query, SourceTypeEnum sourceType);

  Stream<List<TopicViewModel>> getStreamTopicViewsByBookId(int bookId, SourceTypeEnum sourceType);

  Future<List<TopicViewModel>> getTopicViewsByBookId(int bookId, SourceTypeEnum sourceType);


  Stream<List<TopicViewModel>> getStreamTopicViewsByBookIdAndQuery(int bookId,
      String query, SourceTypeEnum sourceType);
}