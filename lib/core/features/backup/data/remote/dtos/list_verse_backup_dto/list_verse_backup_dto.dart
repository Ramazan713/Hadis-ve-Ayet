
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'list_verse_backup_dto.freezed.dart';
part 'list_verse_backup_dto.g.dart';

@freezed
class ListVerseBackupDto with _$ListVerseBackupDto{
  const factory ListVerseBackupDto({
    required int listId,
    required int verseId,
    required int pos
  }) = _ListVerseBackupDto;

  factory ListVerseBackupDto.fromJson(Map<String, Object?> json) => _$ListVerseBackupDtoFromJson(json);
}