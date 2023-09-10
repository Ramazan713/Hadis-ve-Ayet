
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/core/domain/enums/verse_ui_4x_enum.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/model/counter.dart';
part 'detail_counter_state.freezed.dart';

@freezed
class DetailCounterState with _$DetailCounterState{
  const DetailCounterState._();

  const factory DetailCounterState({
    required int counterClassic,
    required int counterSubClassic,
    required int counterUnLimited,
    required bool hasCompletedGoal,
    required bool hasVibrate,
    required FontModel fontModel,
    required VerseUi4XEnum verseUi,
    required CounterType counterType,
    required bool enabledEachDhikrVibration,
    required bool enabledEachEndOfTourVibration,
    Counter? currentCounter,
    String? message,
  }) = _DetailCounterState;

  static DetailCounterState init(){
    return DetailCounterState(
      fontModel: FontModel.init(),
      verseUi: KPref.counterUi.defaultPrefEnum,
      counterType: CounterType.classic,
      counterClassic: 0,
      counterSubClassic: 0,
      counterUnLimited: 0,
      hasCompletedGoal: false,
      hasVibrate: false,
      enabledEachDhikrVibration: KPref.eachDhikrVibration.defaultValue,
      enabledEachEndOfTourVibration: KPref.eachEndOfTourVibration.defaultValue
    );
  }

  int? get getGoal => currentCounter?.goal;

  bool get hasNotSavedCounter => currentCounter!=null && currentCounter?.id == null;
  bool get hasSavedCounter => currentCounter!=null && currentCounter?.id != null;
  bool get hasAnyContent => (currentCounter?.arabicContent?.isNotEmpty??false) ||
      (currentCounter?.content?.isNotEmpty??false) || (currentCounter?.meaning?.isNotEmpty??false) ||
      (currentCounter?.description?.isNotEmpty??false);

  bool get eachDhikrVibration => enabledEachDhikrVibration && hasVibrate;
  bool get eachEndOfTourVibration => enabledEachEndOfTourVibration && hasVibrate;

  bool get hasArabicContent => verseUi.arabicVisible && currentCounter?.arabicContent != null &&currentCounter?.arabicContent!="";
  bool get hasPronunciation => verseUi.pronunciationVisible && currentCounter?.content != null &&currentCounter?.content!="";
  bool get hasMeaning => verseUi.mealVisible && currentCounter?.meaning != null &&currentCounter?.meaning!="";
  bool get hasDescription => verseUi.commentVisible && currentCounter?.description != null &&currentCounter?.description!="";


}