

import 'package:hadith/core/data/local/entities/list/list_hadith_entity.dart';
import 'package:hadith/core/domain/models/list/list_hadith.dart';

extension ListHadithEntityExt on ListHadithEntity{

  ListHadith toListHadith(){
    return ListHadith(
      listId: listId,
      hadithId: hadithId,
      pos: pos
    );
  }
}


extension ListHadithExt on ListHadith{
  ListHadithEntity toListHadithEntity(){
    return ListHadithEntity(
        listId: listId,
        hadithId: hadithId,
        pos: pos,
    );
  }
}