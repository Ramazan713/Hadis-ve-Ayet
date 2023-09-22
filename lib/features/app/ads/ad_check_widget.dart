import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hadith/features/premium/bloc/premium_bloc.dart';
import 'package:hadith/features/premium/bloc/premium_state.dart';
import 'package:hadith/core/utils/ad_util.dart';

class AdCheckWidget extends StatefulWidget {
  final Widget child;

  const AdCheckWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<AdCheckWidget> createState() => _AdCheckWidgetState();
}

class _AdCheckWidgetState extends State<AdCheckWidget> {
  InterstitialAd? _interstitialAd;

  Timer? _adTimer;



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PremiumBlocOld, PremiumState>(
      builder: (context, state) {
        // if (!state.isPremium) {
        //   _checkAdOpeningCounter();
        //   _checkAdStatus();
        // }
        return WillPopScope(
            onWillPop: () {
              if (!state.isPremium && _interstitialAd != null) {
                _interstitialAd?.show();
              }
              return Future.value(true);
            },
            child: widget.child,
        );
      },
    );
  }


  void _loadAd() {
    InterstitialAd.load(
        adUnitId: AdUtil.interstitialAdId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;

            _interstitialAd?.fullScreenContentCallback =
                FullScreenContentCallback(
                    onAdDismissedFullScreenContent: (InterstitialAd ad) {
                      ad.dispose();
                    }, onAdFailedToShowFullScreenContent:
                    (InterstitialAd ad, AdError error) {
                  ad.dispose();
                }, onAdShowedFullScreenContent: (ad) {
                  AdUtil.resetValues();
                });
          },
          onAdFailedToLoad: (LoadAdError error) {},
        ));
  }

  // void _checkAdStatus() {
  //   _adTimer?.cancel();
  //   _adTimer = Timer.periodic(const Duration(seconds: AdUtil.tickIntervalSeconds), (timer) {
  //     if (_interstitialAd == null) {
  //       if (AdUtil.increaseConsumeSeconds()) {
  //         _loadAd();
  //       }
  //     }
  //   });
  // }
  //
  // void _checkAdOpeningCounter() {
  //   if (_interstitialAd == null) {
  //     if (AdUtil.increaseOpeningCounter()) {
  //       _loadAd();
  //     }
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    _adTimer?.cancel();
  }
}
