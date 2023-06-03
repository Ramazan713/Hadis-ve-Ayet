

import 'package:hadith/core/data/local/entities/views/topic_hadiths_view.dart';
import 'package:hadith/core/data/local/entities/views/topic_verses_view.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/features/topics/domain/model/topic_view_model.dart';

extension TopicHadithsViewExt on TopicHadithsView{

  TopicViewModel toTopicViewModel(){
    return TopicViewModel(
        id: id,
        name: name,
        itemsCount: hadithCount,
        sectionId: sectionId,
        sourceTypeEnum: SourceTypeEnum.hadith
    );
  }
}

extension TopicVersesViewExt on TopicVersesView{

  TopicViewModel toTopicViewModel(){
    return TopicViewModel(
        id: id,
        name: name,
        itemsCount: verseCount,
        sectionId: sectionId,
        sourceTypeEnum: SourceTypeEnum.verse
    );
  }
}

