

import 'package:hadith/core/data/local/entities/list/list_entity.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_model.dart';

extension ListEntityMapperExt on ListEntity{

  ListModel toListModel(){
    return ListModel(
        id: id,
        isArchive: isArchive,
        name: name,
        isRemovable: isRemovable,
        sourceType: SourceTypeEnumExt.fromSourceId(sourceId),
        pos: pos
    );
  }
}


extension ListModelMapperExt on ListModel{
  ListEntity toListEntity(){
    return ListEntity(
      id: id,
      name: name,
      isArchive: isArchive,
      isRemovable: isRemovable,
      pos: pos,
      sourceId: sourceType.sourceId,
    );
  }
}
