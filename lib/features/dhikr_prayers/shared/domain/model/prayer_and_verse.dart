
import 'package:freezed_annotation/freezed_annotation.dart';

part 'prayer_and_verse.freezed.dart';

@freezed
class PrayerAndVerse with _$PrayerAndVerse{

  const PrayerAndVerse._();

  const factory PrayerAndVerse({
    required int id,
    required String name,
    required String arabicContent,
    required String meaningContent,
    String? pronunciationContent,
    required int orderItem,
    int? counterId,
    int? parentPrayerId
  }) = _PrayerAndVerse;
}