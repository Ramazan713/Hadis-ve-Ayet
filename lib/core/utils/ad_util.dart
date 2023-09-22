

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hadith/core/constants/secrets.dart';

class AdUtil{
  
  static const interstitialAdId = Secrets.interstitialAdId;
  static const bannerAdId = Secrets.bannerAdId;

  static const tickIntervalSeconds = 5;
  static const int _thresholdConsumeSeconds = 210;//3m 30s
  static const _thresholdOpeningCounter = 19;

  static int _counterOpening = 0;
  static int _totalConsumeSeconds = 0;

  static InterstitialAd? _interstitialAd;
  static InterstitialAd? get interstitialAd => _interstitialAd;

  static void increaseConsumeSeconds(){
    if(_interstitialAd != null) return;
    _totalConsumeSeconds+=tickIntervalSeconds;
    _checkThreshold();
  }
  static void increaseOpeningCounter(){
    if(_interstitialAd != null) return;
    _counterOpening++;
    _checkThreshold();
  }

  static void _checkThreshold(){
    if(_counterOpening >= _thresholdOpeningCounter
        || _totalConsumeSeconds >= _thresholdConsumeSeconds){
      _loadAd();
    }
  }

  static resetValues(){
    _counterOpening = 0;
    _totalConsumeSeconds = 0;
  }

  static _loadAd(){
    if(interstitialAd != null) return;
    InterstitialAd.load(
      adUnitId: AdUtil.interstitialAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          _interstitialAd = ad;
          interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
              ad.dispose();
            },
            onAdShowedFullScreenContent: (ad) {
              AdUtil.resetValues();
              _interstitialAd = null;
            }
          );
        },
        onAdFailedToLoad: (LoadAdError error) {},
      ));
  }

}