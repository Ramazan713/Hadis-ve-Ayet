

import 'package:hadith/core/data/local/entities/views/list_hadith_view.dart';
import 'package:hadith/core/data/local/entities/views/list_verse_view.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_model.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';

extension ListHadithViewMapperExt on ListHadithView{

  ListViewModel toListViewModel(){
    return ListViewModel(
      id: id,
      name: name,
      contentMaxPos: contentMaxPos,
      isArchive: isArchive,
      isRemovable: isRemovable,
      listPos: listPos,
      itemCounts: itemCounts,
      sourceType: SourceTypeEnumExt.fromSourceId(sourceId)
    );
  }

}


extension ListVerseViewMapperExt on ListVerseView {

  ListViewModel toListViewModel(){
    return ListViewModel(
        id: id,
        name: name,
        contentMaxPos: contentMaxPos,
        isArchive: isArchive,
        isRemovable: isRemovable,
        listPos: listPos,
        itemCounts: itemCounts,
        sourceType: SourceTypeEnumExt.fromSourceId(sourceId)
    );
  }
}

extension ListViewModelMapperExt on ListViewModel{

  ListModel toListModel(){
    return ListModel(
        id: id,
        name: name,
        isRemovable: isRemovable,
        isArchive: isArchive,
        sourceType: sourceType,
        pos: listPos,
    );
  }
}







