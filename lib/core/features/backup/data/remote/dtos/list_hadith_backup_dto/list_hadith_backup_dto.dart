
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'list_hadith_backup_dto.freezed.dart';
part 'list_hadith_backup_dto.g.dart';

@freezed
class ListHadithBackupDto with _$ListHadithBackupDto{
  const factory ListHadithBackupDto({
    required int listId,
    required int hadithId,
    required int pos
  }) = _ListHadithBackupDto;

  factory ListHadithBackupDto.fromJson(Map<String, Object?> json) => _$ListHadithBackupDtoFromJson(json);
}