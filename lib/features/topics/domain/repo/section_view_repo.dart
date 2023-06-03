

import 'package:hadith/features/topics/domain/model/section_view_model.dart';

abstract class SectionViewRepo{

  Stream<List<SectionViewModel>> getSectionTopicsByBookId(int bookId);

  Stream<List<SectionViewModel>> getSectionTopicsByBookIdAndQuery(int bookId, String query);

  Future<int> getTopicsCountByBookId(int bookId);
}