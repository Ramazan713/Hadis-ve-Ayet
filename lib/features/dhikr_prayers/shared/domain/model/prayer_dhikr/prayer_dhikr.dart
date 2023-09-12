
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/models/icon_info.dart';

part 'prayer_dhikr.freezed.dart';

@freezed
class PrayerDhikr with _$PrayerDhikr{
  const factory PrayerDhikr({
    required int id,
    required String name,
    required String arabicContent,
    required String meaningContent,
    required String pronunciationContent,
    required int orderItem,
    int? counterId
  }) = _PrayerDhikr;
}