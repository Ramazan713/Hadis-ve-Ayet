

import 'package:hadith/core/domain/enums/source_type_enum.dart';

class ItemListInfo{
  final int itemId;
  final SourceTypeEnum sourceType;
  final bool inAnyList;
  final bool inAnyArchiveList;
  final bool inFavorite;

  ItemListInfo({required this.itemId, required this.sourceType, required this.inAnyList,
    required this.inAnyArchiveList, required this.inFavorite
  });

  bool getInAnyListWithArchiveList(bool useArchiveListFeatures){
    return inAnyList || (useArchiveListFeatures && inAnyArchiveList);
  }

}