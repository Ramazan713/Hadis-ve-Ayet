


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom.dart';
part 'custom_prayer_manage_state.freezed.dart';

@freezed
class CustomPrayerManageState with _$CustomPrayerManageState{
  const factory CustomPrayerManageState({
    required bool navigateBack,
    required bool isLoading,
    String? message,
    PrayerCustom? currentPrayer
  }) = _CustomPrayerManageState;

  static CustomPrayerManageState init(){
    return const CustomPrayerManageState(
      navigateBack: false,
      isLoading: false,
    );
  }
}