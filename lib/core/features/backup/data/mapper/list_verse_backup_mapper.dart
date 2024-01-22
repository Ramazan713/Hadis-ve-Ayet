
import 'package:hadith/core/data/local/entities/list/list_verse_entity.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/list_verse_backup_dto/list_verse_backup_dto.dart';

extension ListVerseEntityExt on ListVerseEntity{
  ListVerseBackupDto toListVerseBackupDto(){
    return ListVerseBackupDto(
      listId: listId,
      verseId: verseId,
      pos: pos
    );
  }
}


extension ListVerseBackupDtoExt on ListVerseBackupDto{
  ListVerseEntity toListVerseEntity(){
    return ListVerseEntity(
      listId: listId,
      verseId: verseId,
      pos: pos
    );
  }
}