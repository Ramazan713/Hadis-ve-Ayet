import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/enums/prayer_type_enum.dart';

part 'prayer.freezed.dart';

@freezed
class Prayer with _$Prayer{
  const factory Prayer({
    int? id,
    String? name,
    String? arabicContent,
    String? meaningContent,
    String? pronunciationContent,
    String? source,
    required PrayerTypeEnum prayerType,
    required int orderItem,
  }) = _Prayer;
}