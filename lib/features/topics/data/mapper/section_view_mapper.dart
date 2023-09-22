import 'package:hadith/core/data/local/entities/views/section_topics_view.dart';
import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/features/topics/domain/model/section_view_model.dart';

extension SectionTopicsViewExt on SectionTopicsView{

  SectionViewModel toSectionViewModel(){
    return SectionViewModel(
      id: id,
      name: name,
      topicsCount: topicCount,
      book: BookEnum.from(bookId)
    );
  }

}