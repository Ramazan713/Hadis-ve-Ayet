
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'counter_backup_dto.freezed.dart';
part 'counter_backup_dto.g.dart';

@freezed
class CounterBackupDto with _$CounterBackupDto{
  const factory CounterBackupDto({
    int? id,
    String? content,
    String? arabicContent,
    String? meaning,
    String? description,
    int? goal,
    int? prayerId,
    required String name,
    required int orderItem,
    required int lastCounter,
    required int type
  }) = _CounterBackupDto;

  factory CounterBackupDto.fromJson(Map<String, Object?> json) => _$CounterBackupDtoFromJson(json);
}