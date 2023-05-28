

import 'package:hadith/core/data/local/entities/list/list_verse_entity.dart';
import 'package:hadith/core/domain/models/list/list_verse.dart';

extension ListVerseEntityExt on ListVerseEntity{

  ListVerse toListVerse(){
    return ListVerse(
        listId: listId,
        verseId: verseId,
        pos: pos
    );
  }
}


extension ListVerseExt on ListVerse{
  ListVerseEntity toListVerseEntity(){
    return ListVerseEntity(
        listId: listId,
        verseId: verseId,
        pos: pos
    );
  }
}