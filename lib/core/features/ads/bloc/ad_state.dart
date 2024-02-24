


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
part 'ad_state.freezed.dart';

@freezed
class AdState with _$AdState{

  const AdState._();

  const factory AdState({
    required bool showAd,
    required bool loadAd,
    required int counterOpening,
    required int totalConsumeSeconds,
    InterstitialAd? ad
  }) = _AdState;

  static AdState init(){
    return const AdState(
      showAd: false,
      loadAd: false,
      counterOpening: 0,
      totalConsumeSeconds: 0
    );
  }
}