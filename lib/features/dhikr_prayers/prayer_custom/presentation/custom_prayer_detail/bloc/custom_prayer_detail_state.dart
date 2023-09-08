
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom.dart';
part 'custom_prayer_detail_state.freezed.dart';

@freezed
class CustomPrayerDetailState with _$CustomPrayerDetailState{

  const CustomPrayerDetailState._();

  const factory CustomPrayerDetailState({
    required FontModel fontModel,
    required bool isLoading,
    PrayerCustom? prayer,
    String? message
  }) = _CustomPrayerDetailState;

  static CustomPrayerDetailState init(){
    return CustomPrayerDetailState(
      fontModel: FontModel.init(),
      isLoading: false
    );
  }

  bool get hasArabicContent => prayer?.arabicContent != null &&
      (prayer?.arabicContent ?? "").isNotEmpty;

  bool get hasContent =>  prayer?.pronunciationContent != null &&
      (prayer?.pronunciationContent ?? "").isNotEmpty;

  bool get hasMeaning =>  prayer?.meaningContent != null &&
      (prayer?.meaningContent ?? "").isNotEmpty;

  bool get hasSource =>  prayer?.source != null &&
      (prayer?.source ?? "").isNotEmpty;

  bool get hasAnyData => hasArabicContent || hasContent || hasMeaning;
}