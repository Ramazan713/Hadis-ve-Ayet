

import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';

abstract class TopicViewRepo{

  Stream<List<TopicViewModel>> getTopicViewsBySectionId(int sectionId, SourceTypeEnum sourceType);

  Stream<List<TopicViewModel>> getTopicViewsBySectionIdAndQuery(int sectionId,
      String query, SourceTypeEnum sourceType);

  Stream<List<TopicViewModel>> getTopicViewsByBookId(int bookId, SourceTypeEnum sourceType);

  Stream<List<TopicViewModel>> getTopicViewsByBookIdAndQuery(int bookId,
      String query, SourceTypeEnum sourceType);
}